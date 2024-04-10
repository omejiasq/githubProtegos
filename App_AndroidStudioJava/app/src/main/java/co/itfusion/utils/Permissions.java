package co.itfusion.utils;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Build;
import android.os.Parcel;
import android.os.PowerManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.LocationSettingsStatusCodes;
import com.google.android.gms.location.Priority;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;

import java.util.Arrays;

import co.itfusion.dima.BuildConfig;

public class Permissions {
    public static boolean isSdk29orUp() { return Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q; }

    public static boolean isSdk30orUp() { return Build.VERSION.SDK_INT > Build.VERSION_CODES.Q; }

    public static boolean isSdk31orUp() { return Build.VERSION.SDK_INT > Build.VERSION_CODES.R; }

    public static boolean isSdk29() { return Build.VERSION.SDK_INT == Build.VERSION_CODES.Q; }

    public static boolean isSdk28orLess() { return Build.VERSION.SDK_INT < Build.VERSION_CODES.Q; }

    public static int getActualSdk() { return Build.VERSION.SDK_INT; }


    public static boolean checkIsPermissionMissing(@NonNull Context context, @NonNull String... permissions)
    {
        return Arrays.stream(permissions).anyMatch(permission -> PackageManager.PERMISSION_GRANTED != ActivityCompat.checkSelfPermission(context, permission));
    }

    public static boolean checkIsPermissionMissing(@NonNull Context context, @NonNull String permission) {
        return ActivityCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED;
    }

    public static void requestCameraPermissionForAPI29OrAbove(Activity activity)
    {
        ActivityCompat.requestPermissions(activity, PERMISSION_CAMERA_AND_LOCATION_API_29_AND_ABOVE, REQUEST_PERMISSION_CAMERA_API_29_OR_ABOVE);
    }

    public static void requestCameraPermissionForAPI28OrBelow(Activity activity)
    {
        ActivityCompat.requestPermissions(activity, PERMISSION_CAMERA_AND_LOCATION_API_28_AND_BELOW, REQUEST_PERMISSION_CAMERA_API_28_OR_BELOW);
    }

    public static void requestStoragePermissionForAPI28OrBelow(Activity activity)
    {
        ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE_API_28_OR_BELOW, REQUEST_PERMISSIONS_STORAGE_API_28_OR_BELOW);
    }

    public static void requestStoragePermissionsForAPI29(Activity activity)
    {
        ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE_API_29, REQUEST_PERMISSIONS_STORAGE_API_29);
    }

    public static void requestStoragePermissionForAPI30OrAbove(Activity activity) {
        ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE_API_30_OR_ABOVE, REQUEST_PERMISSIONS_STORAGE_API_30_OR_BELOW);
    }

    public static boolean checkIfStoragePermissionsAreRequiredAPI28OrBelow(Context context)
    {
        return checkIsPermissionMissing(context, PERMISSIONS_STORAGE_API_28_OR_BELOW);
    }

    public static boolean checkIfStoragePermissionAreRequiredAPI29(Context context)
    {
        return checkIsPermissionMissing(context, PERMISSIONS_STORAGE_API_29);
    }

    public static boolean checkIfStoragePermissionAreRequiredAPI30OrAbove(Context context) {
        return checkIsPermissionMissing(context, PERMISSIONS_STORAGE_API_30_OR_ABOVE);
    }

    public static boolean checkIfLocationAdapterIsActive(Context context)
    {
        boolean locationEnabled = false;
        LocationManager locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
        try { locationEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER); } catch (Exception ignored) { }
        try { locationEnabled |= locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER); } catch (Exception ignored) { }

        return locationEnabled;
    }

    public static boolean checkIfBluetoothPermissionsAreRequired(@NonNull Context context)
    {
        if(isSdk31orUp())
            return checkIsPermissionMissing(context, PERMISSIONS_BLE_API_31_AND_ABOVE);
        else
            return false;
    }

    @SuppressLint("MissingPermission")
    public static void requestActivateBluetoothAdapter(@NonNull Context context)
    {
        if(BluetoothAdapter.getDefaultAdapter() != null && !BluetoothAdapter.getDefaultAdapter().isEnabled()) //El dispositivo tiene modulo bluetooth ¿si?
        {
            Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE); //Si posee modulo bluetooth se procede a realizar un intento de activacion por parte del usuario.
            ((Activity) context).startActivityForResult(intent, ACTIVATE_BLUETOOTH_REQUEST_CODE);
        }
    }

    public static void requestLocationPermissions(@NonNull Activity activity) {
        ActivityCompat.requestPermissions(activity, PERMISSION_LOCATION, REQUEST_PERMISSIONS_LOCATION);
    }

    public static void requestPostNotificationPermission(@NonNull Activity activity) {
        ActivityCompat.requestPermissions(activity, PERMISSION_POST_NOTIFICATION, REQUEST_PERMISSION_POST_NOTIFICATION);
    }

    public static void requestLocationBackgroundPermission(@NonNull Activity activity) {
        ActivityCompat.requestPermissions(activity, PERMISSION_LOCATION_BACKGROUND, REQUEST_PERMISSION_LOCATION_BACKGROUND);
    }

    public static void requestBluetoothPermissions(@NonNull Activity activity) {
        ActivityCompat.requestPermissions(activity, PERMISSIONS_BLE_API_31_AND_ABOVE, REQUEST_PERMISSIONS_BLUETOOTH_API_31_AND_ABOVE);
    }

    public static boolean checkIfPostNotificationPermissionIsRequired(Context context) {
        return checkIsPermissionMissing(context, PERMISSION_POST_NOTIFICATION);
    }

    public static boolean checkIfLocationBackgroundPermissionIsRequired(Context context) {
        return checkIsPermissionMissing(context, PERMISSION_LOCATION_BACKGROUND);
    }

    public static boolean checkIfLocationPermissionsAreRequired(@NonNull Context context) {
        return checkIsPermissionMissing(context, PERMISSION_LOCATION);
    }

    public static boolean checkIfBluetoothAdapterActive() {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        return bluetoothAdapter != null && BluetoothAdapter.getDefaultAdapter().isEnabled();
    }

    public static boolean checkIfIsIgnoringBatteryOptimization(Activity activity) {
        PowerManager powerManager = (PowerManager)  activity.getSystemService(Context.POWER_SERVICE);
        return powerManager.isIgnoringBatteryOptimizations(activity.getPackageName());
    }



    @SuppressLint("InlinedApi")
    public static void requestActivateLocationAdapter(@NonNull Context context, @NonNull Activity activity)
    {
        LocationRequest builder = new LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, 1000)
                .setWaitForAccurateLocation(false)
                .setMinUpdateIntervalMillis(500)
                .setMaxUpdateDelayMillis(1000)
                .build();


        LocationSettingsRequest.Builder settingsBuilder = new LocationSettingsRequest.Builder()
                .addLocationRequest(builder);
        settingsBuilder.setAlwaysShow(true);

        Task<LocationSettingsResponse> result = LocationServices.getSettingsClient(context)
                .checkLocationSettings(settingsBuilder.build());

        result.addOnCompleteListener(new OnCompleteListener<LocationSettingsResponse>() {
            @Override
            public void onComplete(@NonNull Task<LocationSettingsResponse> task) {
                try
                {
                    LocationSettingsResponse response =
                            task.getResult(ApiException.class);
                }
                catch (ApiException ex)
                {
                    int statusCode = ex.getStatusCode();
                    if (statusCode == LocationSettingsStatusCodes.RESOLUTION_REQUIRED)
                    {
                        try
                        {
                            ResolvableApiException resolvableApiException = (ResolvableApiException) ex;
                            resolvableApiException.startResolutionForResult(activity, ACTIVATE_LOCATION_REQUEST_CODE);
                        } catch (IntentSender.SendIntentException ignored) { }
                    }
                }
            }
        });
    }

    public static final String INTENT_ACTION_DISCONNECT = BuildConfig.APPLICATION_ID + ".Disconnect";
    public static final String NOTIFICATION_CHANNEL = BuildConfig.APPLICATION_ID + ".Channel";
    public static final String INTENT_CLASS_MAIN_ACTIVITY = BuildConfig.APPLICATION_ID + ".MainActivity";

    public static final int ACTIVATE_BLUETOOTH_REQUEST_CODE = 1000;
    public static final int REQUEST_PERMISSIONS_LOCATION = 1001;
    public static final int ACTIVATE_LOCATION_REQUEST_CODE = 1002;
    public static final int REQUEST_PERMISSION_LOCATION_BACKGROUND = 1003;
    public static final int REQUEST_PERMISSION_POST_NOTIFICATION = 1004;


    public static final int CODIGO_OBTENER_ARCHIVO = 1003;
    public static final int SOLICITUD_PERMISOS_TODOS = 1004;
    public static final int REQUEST_PERMISSIONS_STORAGE_API_29 = 1005;
    public static final int REQUEST_PERMISSIONS_STORAGE_API_28_OR_BELOW = 1006;
    public static final int REQUEST_PERMISSIONS_STORAGE_API_30_OR_BELOW = 1007;
    public static final int SOLICIUD_PERMISOS_ALMACENAMIENTO = 1008;
    public static final int SOLICITUD_ABRIR_DIRECTORIO = 1009;
    public static final int REQUEST_GET_DOCUMENT = 1010;
    public static final int REQUEST_SHARE_DOCUMENT = 1011;
    public static final int REQUEST_PERMISSIONS_BLUETOOTH_API_31_AND_ABOVE = 1012;
    public static final int REQUEST_PERMISSIONS_BLUETOOTH_API_30_AND_BELOW = 1013;
    public static final int REQUEST_PERMISSION_CAMERA_API_28_OR_BELOW = 1014;
    public static final int REQUEST_PERMISSION_CAMERA_API_29_OR_ABOVE = 1015;

    public static final String[] ALL_PERMISSIONS_API_28 =
            {
                    Manifest.permission.CAMERA,
                    Manifest.permission.INTERNET,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE
            };

    public static final String[] ALL_PERMISSIONS_API_29 =
            {
                    Manifest.permission.CAMERA,
                    Manifest.permission.INTERNET,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.READ_EXTERNAL_STORAGE
            };

    public static final String[] ALL_PERMISSIONS_API_30_AND_ABOVE =
            {
                    Manifest.permission.CAMERA,
                    Manifest.permission.INTERNET,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
                    Manifest.permission.READ_EXTERNAL_STORAGE
            };

    @SuppressLint("InlinedApi")
    public static final String[] PERMISSIONS_BLE_API_31_AND_ABOVE =
            {
                    Manifest.permission.BLUETOOTH,
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT
            };

    public static final String[] PERMISSIONS_STORAGE_API_28_OR_BELOW =
            {
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.READ_EXTERNAL_STORAGE
            };

    public static final String[] PERMISSIONS_STORAGE_API_29 =
            {
                    Manifest.permission.READ_EXTERNAL_STORAGE
            };

    @SuppressLint("InlinedApi")
    public static final String[] PERMISSIONS_STORAGE_API_30_OR_ABOVE =
            {
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.MANAGE_EXTERNAL_STORAGE
            };

    public static final String[] PERMISSION_LOCATION =
            {
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
            };

    @SuppressLint("InlinedApi")
    public static final String[] PERMISSION_POST_NOTIFICATION =
            {
                Manifest.permission.POST_NOTIFICATIONS
            };

    @SuppressLint("InlinedApi")
    public static final String[] PERMISSION_LOCATION_BACKGROUND =
            {
                    Manifest.permission.ACCESS_BACKGROUND_LOCATION
            };

    public static final String[] PERMISSION_CAMERA_AND_LOCATION_API_28_AND_BELOW =
            {
                    Manifest.permission.CAMERA,
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
            };

    public static final String[] PERMISSION_CAMERA_AND_LOCATION_API_29_AND_ABOVE =
            {
                    Manifest.permission.CAMERA,
                    Manifest.permission.READ_EXTERNAL_STORAGE,
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION,
            };
}
