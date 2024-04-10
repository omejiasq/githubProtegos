package co.itfusion.services;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationAvailability;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.Priority;
import com.google.android.gms.location.SettingsClient;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import java.util.Objects;

import co.itfusion.utils.Constants;

public class LocationManager {

    private static final int REQUEST_CHECK_SETTINGS = 1000;
    private static LocationManager instance = null;
    private Context context;
    private FusedLocationProviderClient fusedLocationProviderClient;
    private LocationRequest locationRequest;
    private LocationCallback locationCallback;

    public LocationManager() {

    }

    public static LocationManager getInstance(Context context) {
        if(instance == null) {
            instance = new LocationManager();
        }
        instance.init(context);
        return instance;
    }

    protected void init(Context context) {
        this.context = context;
        this.fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context);
        Intent intent = new Intent(Constants.Values.LOCATION_WORK);
        StringBuilder stringBuilder = new StringBuilder();

        locationCallback = new LocationCallback() {
            @Override
            public void onLocationResult(@NonNull LocationResult locationResult) {
                Log.d(Constants.TAG, String.format("location from new logic: %s", Objects.requireNonNull(locationResult.getLastLocation()).toString()));
                intent.putExtra(Constants.Values.LOCATION_WORK, locationResult);
                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
            }
        };
    }

    protected void createLocationRequest() {
        locationRequest = new LocationRequest
                .Builder(150)
                .setIntervalMillis(1000)
                .setMinUpdateDistanceMeters(10)
                .setPriority(Priority.PRIORITY_HIGH_ACCURACY).build();

        LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder()
                .addLocationRequest(locationRequest);
        SettingsClient client = LocationServices.getSettingsClient(context);

        Task<LocationSettingsResponse> task = client.checkLocationSettings(builder.build());

        task.addOnSuccessListener(locationSettingsResponse -> {
            Log.d(Constants.TAG, "task success");
        });
        task.addOnFailureListener(e -> {
            Log.d(Constants.TAG, "task failed");
        });
    }

    @SuppressLint("MissingPermission")
    public void startLocationUpdates() {
        fusedLocationProviderClient.requestLocationUpdates(locationRequest, locationCallback, Looper.getMainLooper());
    }

}
