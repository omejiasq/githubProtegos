package co.itfusion.ui.dashboard;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.Priority;

import java.util.Locale;

import co.itfusion.data.Control;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.FragmentDashboardBinding;
import co.itfusion.interfaces.ISetup;
import co.itfusion.models.endpoint.user.RootUser;
import co.itfusion.services.ServiceMainDiadem;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Permissions;
import co.itfusion.utils.SerialUtils;

public class DashboardFragment extends Fragment implements ISetup {

    private Context context;
    private Activity activity;
    private FragmentDashboardBinding binding;
    private RootUser user;
    private SerialUtils.ServiceStatus serviceStatus = SerialUtils.ServiceStatus.None;
    private final Handler handler = new Handler();
    private FusedLocationProviderClient fusedLocationProviderClient;
    private LocationCallback locationCallback;
    private Location lastKnownLocation = null;
    private ServiceMainDiadem serviceConnected = null;


    public DashboardFragment() {
        this.user = null;
    }

    public DashboardFragment(RootUser user) {
        this.user = user;
    }

    public DashboardFragment(RootUser user, ServiceMainDiadem service) {
        this.user = user;
        this.serviceConnected = service;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        context = getContext();
        activity = getActivity();

        Log.d(Constants.TAG, "created");

        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(statusBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_STATUS));
        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(dataBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_DATA_RECEIVED));
    }

    @Override
    public void onResume() {
        super.onResume();

        if(user != null) {
            binding.banner.tvItemSubtitle.setText(String.format("%s %s", user.data.getFirstName(), user.data.getLastName()));
        } else {
            binding.banner.tvItemSubtitle.setText(Constants.Characters.EMPTY);
        }

        if(!Permissions.checkIsPermissionMissing(context, Permissions.PERMISSION_LOCATION))
            startLocationUpdates();

        updateUI();
        resetAllDataShow();
    }

    @Override
    public void onPause() {
        super.onPause();
        try { fusedLocationProviderClient.removeLocationUpdates(locationCallback); }
        catch (Exception ignored) { /*NOP*/ }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.d(Constants.TAG, "dashboard destroyed");
        LocalBroadcastManager.getInstance(context).unregisterReceiver(statusBleBroadcastReceiver);
        LocalBroadcastManager.getInstance(context).unregisterReceiver(dataBleBroadcastReceiver);
        try { fusedLocationProviderClient.removeLocationUpdates(locationCallback); }
        catch (Exception ignored) { /*NOP*/ }
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        binding = FragmentDashboardBinding.inflate(inflater, container, false);
        setDependencies();
        return binding.getRoot();
    }

    @Override
    public void setDependencies() {

        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context);

        binding.tvStatus.setVisibility(View.VISIBLE);
        binding.data.getRoot().setVisibility(View.GONE);

        binding.banner.tvItemTitle.setText(context.getString(R.string.welcome));

    }


    private void updateUI() {
        serviceStatus = Control.getServiceStatus(activity);
        binding.tvStatus.setVisibility(View.INVISIBLE);
        binding.data.getRoot().setVisibility(View.VISIBLE);
//
//        if(serviceStatus == SerialUtils.ServiceStatus.Connected) {
//            binding.tvStatus.setVisibility(View.INVISIBLE);
//            binding.data.getRoot().setVisibility(View.VISIBLE);
//        } else {
//            binding.tvStatus.setVisibility(View.VISIBLE);
//            binding.data.getRoot().setVisibility(View.INVISIBLE);
//        }
    }

    private void resetAllDataShow() {
        String loading = context.getString(R.string.unavailable);

        binding.data.sensor.tvValue1.setText(loading);
        binding.data.sensor.tvValue2.setText(loading);
        binding.data.sensor.tvValue3.setText(loading);

        binding.data.temperature.tvValue1.setText(loading);
        binding.data.temperature.tvValue2.setText(loading);

        binding.data.battery.tvValue1.setText(loading);

        binding.data.speed.tvValue1.setText(loading);

    }

    @SuppressLint("MissingPermission")
    private void startLocationUpdates() {

        LocationRequest.Builder builder = new LocationRequest
                .Builder(150)
                .setMinUpdateDistanceMeters(10)
                .setPriority(Priority.PRIORITY_HIGH_ACCURACY);

        locationCallback = new LocationCallback() {
            @SuppressLint("DefaultLocale")
            @Override
            public void onLocationResult(@NonNull LocationResult locationResult) {
                super.onLocationResult(locationResult);

                Location locationUpdate = locationResult.getLastLocation();

                if(locationUpdate != null) {

                    Log.d(Constants.TAG, String.format("last location speed %s", locationUpdate.getSpeed()));
                    binding.tvSpeedTest.setText(String.format("speed: %s", locationUpdate.getSpeed()));

                    Locale.setDefault(Locale.US);
                    String speed = "";
                    speed = String.format("%.0f \n km/h", locationUpdate.getSpeed());
                    binding.data.speed.tvValue1.setText(speed);


//
//                    if(locationUpdate.getSpeed() > 5) {
//                        speed = String.format("%.1f \n km/h", locationUpdate.getSpeed());
//                        Log.d(Constants.TAG, String.format("actual speed: %s", speed));
//                    } else {
//                        speed = "0 \n km/h";
//                    }
//
//                    binding.data.speed.tvValue1.setText(speed);
                }
            }
        };

        fusedLocationProviderClient.requestLocationUpdates(builder.build(), locationCallback, Looper.getMainLooper());
    }

    private final BroadcastReceiver statusBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            if(bundle != null) {
                SerialUtils.ServiceStatus serviceStatus = (SerialUtils.ServiceStatus) bundle.get(SerialUtils.EXTRA_SERIAL_1);
                if(serviceStatus != null) {
                    Log.d(Constants.TAG, String.format("code in Dashboard: [%s] ", serviceStatus));
                }
            }
        }
    };

    private final BroadcastReceiver dataBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            String received = (bundle != null)  ?
                    (String) intent.getExtras().get(SerialUtils.EXTRA_SERIAL_1) :
                    null;

//            Log.d(Constants.TAG, String.format("received in main [%s]", received));

            if (received != null) {

                String stream = "", data = "";
                SerialUtils.StreamType streamType = SerialUtils.StreamType.UNKNOWN;

                stream = SerialUtils.getStream(received);
//                Log.d(Constants.TAG, String.format("stream obtained: %s", stream));
                if(stream != null) {
                    data = SerialUtils.getStreamData(stream);
//                    Log.d(Constants.TAG, String.format("data from stream obtained: %s", data));

                    streamType = SerialUtils.getStreamType(stream);
//                    Log.d(Constants.TAG, String.format("streamType obtained: %s", streamType));

                    if(streamType != null && !data.isEmpty()) {

                        switch (streamType) {
                            case TEMP_ALC:
                                binding.data.temperature.tvValue2
                                        .setText(String.format("%s °C", SerialUtils.getValue(data)));
                                break;
                            case STAT_ALC:
                                String status =
                                        (SerialUtils.getFlag(data)) ?
                                                context.getString(R.string.on):
                                                context.getString(R.string.off);
                                binding.data.sensor.tvValue3.setText(status);
                                break;
                            case TEMP_ACC:
                                binding.data.temperature.tvValue1
                                    .setText(String.format("%s °C", SerialUtils.getValue(data)));
                                break;
                            case STAT_BAT:
                                binding.data.battery.tvValue1
                                    .setText(String.format("%s %s", SerialUtils.getValue(data), context.getString(R.string.percentage)));
                                break;
                            case VAL_ALC:
                            case FLAG_ALC:
                                String level = SerialUtils.getBreathLevelFromFlag(data);
                                String value = SerialUtils.getBreathValueFromFlag(data);
                                binding.data.sensor.tvValue2.setText(level);
//                                binding.data.sensor.tvValue1.setText(String.format("%s \n %s", value, context.getString(R.string.breathalyzer_unit)));
                                binding.data.sensor.tvValue1.setText(value);
//                                if(serviceConnected != null && !serviceConnected.isWarmingSensor()) {
//                                } else {
//                                    binding.data.sensor.tvValue2
//                                            .setText(context.getString(R.string.warming_up));
//                                    binding.data.sensor.tvValue1
//                                            .setText(context.getString(R.string.warming_up));
//                                }
                                break;
                            case SEC_TEMP_ALC:
                            case SEC_TEMP_ACC:
                            case SEC_LOW_BAT:
                            default:
                                break;
                        }
                    }
                }

            }
        }
    };

}
