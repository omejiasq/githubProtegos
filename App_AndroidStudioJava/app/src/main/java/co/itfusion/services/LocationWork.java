package co.itfusion.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.work.ForegroundInfo;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.google.android.gms.location.LocationResult;

import co.itfusion.models.endpoint.location.Location;
import co.itfusion.utils.Constants;

public class LocationWork extends Worker {

    private NotificationManager notificationManager;
    private Context context;
    private String progress = "Starting Work...";
    int NOTIFICATION_ID = 1;
    private LocationManager locationManager;
    private IntentFilter localBroadcastIntentFilter;

    public LocationWork(@NonNull Context context, @NonNull WorkerParameters workerParameters) {
        super (context, workerParameters);
        this.context = context;
        notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        locationManager = LocationManager.getInstance(context);

        Log.d(Constants.TAG, "location work invoked");

        localBroadcastIntentFilter = new IntentFilter();
        localBroadcastIntentFilter.addAction(Constants.Values.LOCATION_WORK);
        LocalBroadcastManager.getInstance(context).registerReceiver(localBroadcastReceiver, localBroadcastIntentFilter);
    }

    @NonNull
    @Override
    public Result doWork() {
//        setForegroundAsync(showNotification(progress));
        Log.d(Constants.TAG, "working launched");
        while (true) {
            locationManager.startLocationUpdates();
            Log.d(Constants.TAG, "location updates performed");
            try {
                Log.d(Constants.TAG, "waiting 5 secs");
                Thread.sleep(5000);
            } catch (Exception e) {
                Log.d(Constants.TAG, String.format("exception sleeping %s", e.getMessage()));
            }
        }
//        return Result.success();
    }

//    private ForegroundInfo showNotification(String progress) {
//        return new ForegroundInfo(NOTIFICATION_ID, createNotification(progress));
//    }

//    private Notification createNotification(String progress) {
//        String CHANNEL_ID = "100";
//        String title = "Foreground Work";
//        String cancel = "Cancel";
//
//        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
//        notificationManager.createNotificationChannel(new NotificationChannel(CHANNEL_ID, title, NotificationManager.IMPORTANCE_HIGH));
//
////        Notification notification = new NotificationCompat().Builder(context, CHANNEL_ID)
//    }

    private final BroadcastReceiver localBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            if(bundle != null) {
                LocationResult locationResult = (LocationResult) bundle.get(Constants.Values.LOCATION_WORK);
                if(locationResult != null) {
                    Log.d(Constants.TAG, "location update received");
                }
            }
        }
    };
}
