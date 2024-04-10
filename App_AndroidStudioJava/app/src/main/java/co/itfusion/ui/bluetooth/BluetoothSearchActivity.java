package co.itfusion.ui.bluetooth;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.BluetoothLeScanner;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanResult;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;
import android.view.View;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import co.itfusion.adapters.list.DeviceBleListAdapter;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.ActivityBluetoothDiscoveryBinding;
import co.itfusion.interfaces.IBlockUI;
import co.itfusion.interfaces.ISerialListener;
import co.itfusion.interfaces.ISetup;
import co.itfusion.serial.SerialSocketDiadem;
import co.itfusion.services.SerialServiceDiadem;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Permissions;
import co.itfusion.utils.SerialUtils;
import co.itfusion.utils.Utils;

public class BluetoothSearchActivity extends AppCompatActivity implements ServiceConnection, ISerialListener, ISetup , IBlockUI {

    private final Context context = this;
    private final Activity activity = this;

    private ActivityBluetoothDiscoveryBinding binding;

    private SerialUtils.ScanStatus scanStatus = SerialUtils.ScanStatus.None;
    private SerialUtils.ConnectionStatus connectionStatus = SerialUtils.ConnectionStatus.None;
    private SerialUtils.BleConnection bleConnection = SerialUtils.BleConnection.None;

    private final Handler leScanStopHandler = new Handler();
    private BluetoothAdapter.LeScanCallback leScanCallback;

    private ScanCallback scanCallback;

    private BluetoothAdapter bluetoothAdapter;
    private BluetoothDevice bluetoothDevice;
    private DeviceBleListAdapter deviceBleListAdapter;
    private ArrayList<BluetoothDevice> bluetoothDeviceArrayList;

    private SerialServiceDiadem serialServiceDiadem;

    private IntentFilter intentFilter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityBluetoothDiscoveryBinding.inflate(activity.getLayoutInflater());
        setContentView(binding.getRoot());
        setDependencies();
    }

    @Override
    protected void onResume() {
        super.onResume();
        LocalBroadcastManager.getInstance(context).registerReceiver(diademStatusReceiver, new IntentFilter(SerialUtils.FILTER_STATUS));
    }

    @Override
    protected void onPause() {
        super.onPause();
        stopBleSearch();
        try {
            LocalBroadcastManager.getInstance(context).unregisterReceiver(diademStatusReceiver);
        } catch (Exception ignored) { }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        hideBlockUI();
        if(connectionStatus != SerialUtils.ConnectionStatus.False) {
            stopBleSearch();
            try { unbindService((ServiceConnection) context); }
            catch (Exception ignored) {}
        }
    }

    @Override
    public void setDependencies() {
        bluetoothDeviceArrayList = new ArrayList<>();
        deviceBleListAdapter = new DeviceBleListAdapter(context, R.layout.device_ble_list_adapter, bluetoothDeviceArrayList);

        intentFilter = new IntentFilter();
        intentFilter.addAction(BluetoothDevice.ACTION_FOUND);
        intentFilter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);

        if(this.getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH))
            bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        else
            bluetoothAdapter = null;

        leScanCallback = (device, rssi, scanRecord) -> {
            if(device != null) {
                runOnUiThread(() -> updateListedDevices(device));
            }
        };

        scanCallback = new ScanCallback() {
            @Override
            public void onScanResult(int callbackType, ScanResult result) {
                super.onScanResult(callbackType, result);
                Log.d(Constants.TAG, "result: " + result.getDevice());
                updateListedDevices(result.getDevice());
            }

            @Override
            public void onBatchScanResults(List<ScanResult> results) {
                super.onBatchScanResults(results);
                Log.d(Constants.TAG, "batchScanResult: " + results.stream());
            }

            @Override
            public void onScanFailed(int errorCode) {
                super.onScanFailed(errorCode);
                Log.d(Constants.TAG, "error code: " + errorCode);
            }
        };

        binding.lvBleDevicesFound.setAdapter(deviceBleListAdapter);

        setClickEvents();
    }

    @Override
    public void setClickEvents() {

        binding.btnSearchBleDevices.setOnClickListener((view) -> {
            if(Permissions.checkIfBluetoothPermissionsAreRequired(context))
                Permissions.requestBluetoothPermissions(activity);
            else if(!Permissions.checkIfBluetoothAdapterActive())
                Permissions.requestActivateBluetoothAdapter(context);
            else if(Permissions.checkIfLocationPermissionsAreRequired(context))
                Permissions.requestLocationPermissions(activity);
            else if(!Permissions.checkIfLocationAdapterIsActive(context))
                Permissions.requestActivateLocationAdapter(context, activity);
            else
                beginBleSearch();
        });

        binding.lvBleDevicesFound.setOnItemClickListener((adapterView, view, i, l) -> {
            bluetoothDevice = bluetoothDeviceArrayList.get(i);
            if(bluetoothDevice != null) {
                stopBleSearch();
                if(connectionStatus == SerialUtils.ConnectionStatus.False) return;

                try {
                    //Intent intent = new Intent(context, SerialServiceDiadem.class);
                    bindService(new Intent(context, SerialServiceDiadem.class), (ServiceConnection) context, Context.BIND_AUTO_CREATE);
                    startService(new Intent(context, SerialServiceDiadem.class));
                    showBlockUI(null);
                } catch (Exception e) {
                    Log.d(Constants.TAG, String.format("error on click item list: %s", e.getMessage()));
                    Utils.showToastMessage(context, String.valueOf(R.string.error_starting_connection_ble));
                    hideBlockUI();
                }
            }
        });

    }



    @Override
    public void showBlockUI(@Nullable String message) {
        binding.block.getRoot().setVisibility(View.VISIBLE);
        binding.btnSearchBleDevices.setEnabled(false);
    }

    @Override
    public void hideBlockUI() {
        binding.block.getRoot().setVisibility(View.GONE);
        binding.btnSearchBleDevices.setEnabled(true);
    }

    @Override
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        Log.d(Constants.TAG, "Service connected, starting binder"); //TODO: DELETE

        serialServiceDiadem = ((SerialServiceDiadem.SerialBinder) iBinder).getService();
        serialServiceDiadem.attach(this);

        runOnUiThread(this::connectService);
    }

    @Override
    public void onServiceDisconnected(ComponentName componentName) {
        Log.d(Constants.TAG, "Service is disconnected"); //TODO: DELETE
        serialServiceDiadem = null;
    }


    @Override
    public void onSerialConnect() {
        Log.d(Constants.TAG, "serial connect performed"); //TODO: DELETE
        connectionStatus = SerialUtils.ConnectionStatus.True;
        hideBlockUI();
    }

    @Override
    public void onSerialConnectError(Exception e) {
        Log.d(Constants.TAG, String.format("Serial connection error: %s", e.getMessage())); //TODO: DELETE
        disconnectService();
        hideBlockUI();
    }

    @Override
    public void onSerialRead(byte[] data) {
        String dataRead = new String(data, StandardCharsets.UTF_8);
        Log.d(Constants.TAG, String.format("data received: %s", dataRead)); //TODO: DELETE
    }

    @Override
    public void onSerialIoError(Exception e) {
        Log.d(Constants.TAG, String.format("serial IO Error %s" , e.getMessage())); //TODO: DELETE
    }

    /***
     * Update devices to be showed on the listview
     * @param bluetoothDevice bluetooth device found
     */
    @SuppressLint("MissingPermission")
    private void updateListedDevices(BluetoothDevice bluetoothDevice) {
        if (scanStatus.equals(SerialUtils.ScanStatus.None)) return;
        if(!bluetoothDeviceArrayList.contains(bluetoothDevice)) {
            bluetoothDeviceArrayList.add(bluetoothDevice);
            deviceBleListAdapter.notifyDataSetChanged();
        }
    }

    /***
     * Begins the search for ble devices nearby
     */
    @SuppressLint({"StaticFieldLeak", "MissingPermission"}) // AsyncTask needs reference to this fragment
    private void beginBleSearch()
    {
        /*
         * Si el estado del escaneo es diferente a NONE entonces
         * significa que esta realizandose alguna otra tarea, por lo que no debe ejecutarse
         * alguna accion adicional.
         */
        if (!scanStatus.equals(SerialUtils.ScanStatus.None))
            return;

        LocalBroadcastManager.getInstance(this).registerReceiver(findBleDevicesBroadcastReceiver, intentFilter); //se registra el broadcast para determinar los eventos con lso filtros definidos
        scanStatus = SerialUtils.ScanStatus.LeScan; //Se establece el objeto en modo LESCAN que permite la busqueda de dispositivos BLe

        bluetoothDeviceArrayList.clear();
        deviceBleListAdapter.notifyDataSetChanged();

        Utils.showToastMessage(context, "Buscando BLE"); //TODO ELIMINAR TEXTO HARDCODED

        leScanStopHandler.postDelayed(this::stopBleSearch, SerialUtils.LESCAN_PERIOD);

        runOnUiThread(() -> {
            BluetoothLeScanner scanner =  bluetoothAdapter.getBluetoothLeScanner();
            //scanner.startScan((ScanCallback) leScanCallback);
            scanner.startScan(scanCallback);
        });
    }

    /***
     * Provide control over search bluetooth ble devices on the current menu
     */
    @SuppressLint("MissingPermission")
    private void stopBleSearch() {
        try {
            LocalBroadcastManager.getInstance(this).unregisterReceiver(findBleDevicesBroadcastReceiver);
        } catch (Exception ignored) { }

        if (scanStatus.equals(SerialUtils.ScanStatus.None)) return;
        switch (scanStatus) {
            case LeScan:
                leScanStopHandler.removeCallbacks(this::stopBleSearch);
                BluetoothLeScanner scanner = bluetoothAdapter.getBluetoothLeScanner();
                //scanner.stopScan((ScanCallback) leScanCallback);
                scanner.stopScan(scanCallback);
                break;
            case Discovery:
                bluetoothAdapter.cancelDiscovery();
                break;
            default:
        }
        scanStatus = SerialUtils.ScanStatus.None;
    }

    /***
     * Broadcast to receive, analyze and use data from devices ble found nearby
     */
    @SuppressLint("MissingPermission")
    private final BroadcastReceiver findBleDevicesBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if(intent == null || intent.getAction() == null) return;

            if (intent.getAction().equals(BluetoothDevice.ACTION_FOUND)) {
                BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                if (device != null && device.getType() != BluetoothDevice.DEVICE_TYPE_CLASSIC) {
                    runOnUiThread(() -> updateListedDevices(device));
                }
            }
            if (intent.getAction().equals((BluetoothAdapter.ACTION_DISCOVERY_FINISHED))) {
                scanStatus = SerialUtils.ScanStatus.DiscoveryFinished;
                stopBleSearch();
            }
        }
    };


    BroadcastReceiver diademStatusReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if(intent == null || intent.getExtras() == null) return;
            int code = (int) intent.getExtras().get(SerialUtils.EXTRA_CASE);
            String message = (String) intent.getExtras().get(SerialUtils.EXTRA_MESSAGE);
            Log.d(Constants.TAG, String.format("code received: [%s] with message [%s]", code, message));
        }
    };


    /*
     * Serial + UI
     */
    @SuppressLint("NewApi")
    private void connectService() {
        Log.d(Constants.TAG, "connecting to service"); //TODO: DELETE
        try {
            connectionStatus = SerialUtils.ConnectionStatus.Pending;
            SerialSocketDiadem socket = new SerialSocketDiadem(getApplicationContext(), bluetoothDevice);
            serialServiceDiadem.connect(socket);
            Log.d(Constants.TAG, "Starting connection socket");
        } catch (Exception e) { onSerialConnectError(e); }
    }

    private void disconnectService() {
        connectionStatus = SerialUtils.ConnectionStatus.False;
        serialServiceDiadem.disconnect();
        Log.d(Constants.TAG, "Service disconnected");
    }

}