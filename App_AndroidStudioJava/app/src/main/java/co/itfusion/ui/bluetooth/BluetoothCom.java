package co.itfusion.ui.bluetooth;

import androidx.appcompat.app.AppCompatActivity;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.InputType;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.PopupMenu;

import org.apache.commons.io.FileUtils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import co.itfusion.adapters.list.ConsoleListAdapter;
import co.itfusion.adapters.list.ConsoleRecyclerAdapter;
import co.itfusion.data.Control;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.ActivityBluetoothComBinding;
import co.itfusion.interfaces.ISetup;
import co.itfusion.models.endpoint.location.RootReport;
import co.itfusion.models.main.ConsoleStream;
import co.itfusion.models.main.Event;
import co.itfusion.services.SerialServiceDiadem;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Permissions;
import co.itfusion.utils.SerialUtils;
import co.itfusion.utils.Utils;
import okhttp3.internal.Util;

public class BluetoothCom extends AppCompatActivity implements ISetup {

    private final Context context = this;
    private final Activity activity = this;
    private ActivityBluetoothComBinding binding;

    private SerialServiceDiadem serialServiceDiadem;

    private List<String> dataReceivedList;
    private ArrayAdapter<String> normalArrayAdapter;
    private ContentResolver contentResolver;

    private ConsoleListAdapter consoleListAdapter;
    private ConsoleRecyclerAdapter consoleRecyclerAdapter;
    private List<ConsoleStream> consoleStreamList;

    private String streamReceived = "", streamRejected = "";
    private boolean autoScrollEnabled = true;
    private LinearLayoutManager linearLayoutManager;
    private String ROOT_DIRECTORY_FILES = "";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityBluetoothComBinding.inflate(activity.getLayoutInflater());
        setContentView(binding.getRoot());

        contentResolver = context.getContentResolver();

        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(statusBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_STATUS));
        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(dataDiscardedBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_DATA_RECEIVED_V2));
        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(dataBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_DATA_RECEIVED));

        setDependencies();
    }

    @Override
    public void setDependencies() {
        if(getSupportActionBar() != null)
            getSupportActionBar().hide();

        Utils.UI.setupStatusBar(activity, context);

        binding.header.tvTitle.setVisibility(View.INVISIBLE);
        binding.header.tvSubtitle.setVisibility(View.INVISIBLE);

        consoleStreamList = new ArrayList<>();
        consoleListAdapter = new ConsoleListAdapter(context, R.layout.list_item_console, consoleStreamList);
        binding.lvBluetoothData.setAdapter(consoleListAdapter);

        binding.lvBluetoothData.setTranscriptMode(ListView.TRANSCRIPT_MODE_ALWAYS_SCROLL);
        binding.lvBluetoothData.setStackFromBottom(true);


        binding.header.btnBack.setOnClickListener(view -> finish());
        binding.header.btnOption.setOnClickListener(view -> showMenu(view, R.menu.menu_console_options));
    }

    private void fileExport() {
        String path = "";
        Instant instant = Instant.now();
        String[] timestamp = instant.toString().split("\\.");
        ByteArrayOutputStream byteArrayOutputStream = createTextFile();


        if(byteArrayOutputStream != null)
            path = createFile(byteArrayOutputStream.toByteArray(), timestamp[0]);

        Log.d(Constants.TAG, "path has: " + path);
    }


    private String createFile(byte[] bytes, String fileName) {
        if (Permissions.isSdk29orUp()) {
            Uri storeUri, documentUri;
            ContentValues contentValues = new ContentValues();

            storeUri = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY);
            contentValues.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);

            Log.d(Constants.TAG, "storeUri: " + storeUri.getPath());

            contentValues.put(MediaStore.MediaColumns.MIME_TYPE, "application/text");
            contentValues.put(MediaStore.MediaColumns.DISPLAY_NAME, fileName.concat(Constants.Directories.EXTENSION_TXT));

            try {
                documentUri = contentResolver.insert(storeUri, contentValues);
                if(documentUri == null)
                {
                    Log.d(Constants.TAG, "Document uri NULL");
                    return null;
                }
                contentResolver.openOutputStream(documentUri).write(bytes);
                Cursor cursor = contentResolver.query(documentUri, new String[] {MediaStore.DownloadColumns.DATA} , null, null, null);
                cursor.moveToFirst();
                String path = cursor.getString(0);
                cursor.close();
                return  path;
            }
            catch (Exception e)
            {
                Log.d(Constants.TAG, String.format("Exception: %s", e.getMessage()));
                return null;
            }
        }
        else
        {
            if(!checkIfDirectoryExists())
                createDirectoryFiles();

            String storagePath = ROOT_DIRECTORY_FILES.concat(Constants.Directories.DIRECTORY_NAME).concat("/");

            File file = new File(storagePath, fileName.concat(Constants.Directories.EXTENSION_TXT));
            try {
                FileUtils.writeByteArrayToFile(file, bytes);
                return file.getPath();
            } catch (IOException e) {
                Log.d(Constants.TAG, String.format("Exception creando file API 28: %s", e.getMessage()));
                return null;
            }
        }
    }

    private ByteArrayOutputStream createTextFile() {
        AtomicReference<String> dataToExport = new AtomicReference<>();
        consoleStreamList.forEach(consoleStream -> {
            String item = String.format("%s%n%s%n%s", consoleStream.getTimeStamp(), consoleStream.getData(), consoleStream.getStream());
            String actual = dataToExport.get();
            String newItem = String.format("%s%n------%n%s", actual, item);
            dataToExport.set(newItem);
        });
        byte[] bytes = dataToExport.toString().getBytes();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            baos.write(bytes);
            baos.close();
            return baos;
        } catch (IOException e) {
            Log.d(Constants.TAG, String.format("error trying to export bytes %s", e.getMessage()));
            return null;
        }
    }

    private boolean checkIfDirectoryExists() {
        File file = new File(ROOT_DIRECTORY_FILES.concat(Constants.Directories.DIRECTORY_NAME));
        return file.exists();
    }

    private void createDirectoryFiles() {
        File file = new File(ROOT_DIRECTORY_FILES.concat(Constants.Directories.DIRECTORY_NAME));
        if (!file.exists())
        {
            if(!file.mkdir())
                Utils.showToastMessage(context, "Error creando carpeta de almacenamiento"); //TODO: Delete
        }
    }


    @SuppressLint("NonConstantResourceId")
    private void showMenu(View view, int menuRes) {
        PopupMenu popupMenu = new PopupMenu(context, view);
        popupMenu.getMenuInflater().inflate(menuRes, popupMenu.getMenu());

        MenuItem item = popupMenu.getMenu().findItem(R.id.menu_item_auto_scroll);
        item.setChecked(autoScrollEnabled);

        popupMenu.setOnMenuItemClickListener(menuItem -> {
            if(menuItem.getItemId() == R.id.menu_item_clear_log) {
                consoleStreamList.clear();
                consoleListAdapter.notifyDataSetChanged();
                Utils.showToastMessage(context, "Log cleared");
            } else if(menuItem.getItemId() == R.id.menu_item_save_log) {
                fileExport();
            } else if(menuItem.getItemId() == R.id.menu_item_auto_scroll) {
                if(autoScrollEnabled) {
                    autoScrollEnabled = false;
                    menuItem.setChecked(false);
                    binding.lvBluetoothData.setTranscriptMode(ListView.TRANSCRIPT_MODE_NORMAL);
                } else {
                    autoScrollEnabled = true;
                    menuItem.setChecked(true);
                    binding.lvBluetoothData.smoothScrollToPosition(consoleStreamList.size());
                    binding.lvBluetoothData.setTranscriptMode(ListView.TRANSCRIPT_MODE_ALWAYS_SCROLL);
                }
            }
            return true;
        });

        popupMenu.setOnDismissListener(popupMenu1 -> { /*Not implemented*/ });
        popupMenu.show();
    }

    private final BroadcastReceiver statusBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if(intent == null || intent.getExtras() == null) return;
            try {
                int code = (int) intent.getExtras().get(SerialUtils.EXTRA_SERIAL_1);
                Log.d(Constants.TAG, String.format("code received: [%s] ", code));
            } catch (Exception e) {
                Log.d(Constants.TAG, String.format("exception %s", e.getMessage()));
            }
        }
    };


    private final BroadcastReceiver dataDiscardedBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if(intent == null || intent.getExtras() == null) return;
            String data = (String) intent.getExtras().get(SerialUtils.EXTRA_SERIAL_1);

            if(data != null && !data.isEmpty()) {
                streamRejected = data;
                Instant now = Instant.now();
                String timeStamp = Utils.getFormattedDate(now.toString());
                String receivedInfo = context.getString(R.string.discarded);
                ConsoleStream consoleStream = new ConsoleStream(timeStamp, streamRejected, receivedInfo);
                consoleStreamList.add(consoleStream);
                consoleListAdapter.notifyDataSetChanged();
            }

        }
    };

    private final BroadcastReceiver dataBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {

            if(intent == null || intent.getExtras() == null) return;
            String broadcast = (String) intent.getExtras().get(SerialUtils.EXTRA_SERIAL_1);
            Log.d(Constants.TAG, String.format("code message [%s]", broadcast));

            if(broadcast != null && !broadcast.isEmpty()) {
                Instant now = Instant.now();
                String timeStamp = Utils.getFormattedDate(now.toString());
//                String timeStamp = now.toString();

                String stream = "", data = "", receivedInfo = "";
                SerialUtils.StreamType streamType = SerialUtils.StreamType.UNKNOWN;
                ConsoleStream consoleStream = null;

                stream = SerialUtils.getStream(broadcast);

                if(stream != null) {
                    data = SerialUtils.getStreamData(stream);
                    streamType = SerialUtils.getStreamType(stream);
                    if (streamType != null && !data.isEmpty()) {
                        switch (streamType) {
                            case FLAG_ALC:
                                String level = SerialUtils.getBreathLevelFromFlag(data);
                                receivedInfo = String.format("Grado Alcoholemia: %s", level);
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case STAT_BAT:
                                double batteryLevel = SerialUtils.convertBatteryLevel(SerialUtils.getValue(data));
                                receivedInfo = String.format("Nivel Bateria: %s", batteryLevel);
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case VAL_COL:
                                receivedInfo = "Colision detectada";
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case VAL_FALL:
                                receivedInfo = "Caida detectada";
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case FLAG_FALL:
                                receivedInfo = "Bandera Caida";
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case FLAG_COL:
                                receivedInfo = "Bandera Colision";
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case TEMP_ALC:
                                receivedInfo = String.format("Temperatura Alcoholimetro: %s", SerialUtils.getTemperatureValue(data));
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case TEMP_ACC:
                                receivedInfo = String.format("Temperatura Nucleo: %s", SerialUtils.getTemperatureValue(data));
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                            case STAT_ALC:
                                String status =
                                        (SerialUtils.getFlag(data)) ?
                                                context.getString(R.string.on):
                                                context.getString(R.string.off);
                                receivedInfo = String.format("Estado Alcoholimetro: %s", status);
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                            case REPORT_FALL:
                            case REPORT_COL:
                            case SEC_TEMP_ALC:
                            case SEC_TEMP_ACC:
                            case SEC_LOW_BAT:
                            case UNKNOWN:
                            default:
                                receivedInfo = "Accion no encontrada";
                                consoleStream = new ConsoleStream(timeStamp, broadcast, receivedInfo);
                                break;
                        }
                    }
                    if (consoleStream != null) {
                        consoleStreamList.add(consoleStream);
                        consoleListAdapter.notifyDataSetChanged();
                    }
                }
            }
        }
    };
}