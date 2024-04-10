package co.itfusion.services;

import android.annotation.SuppressLint;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.location.Location;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.Priority;
import com.google.gson.Gson;

import java.io.IOException;

import co.itfusion.data.Control;
import co.itfusion.data.EndPoint;
import co.itfusion.dima.R;
import co.itfusion.interfaces.ISerialListener;
import co.itfusion.models.endpoint.location.RootReport;
import co.itfusion.models.endpoint.user.RootUser;
import co.itfusion.models.main.Breath;
import co.itfusion.models.main.Event;
import co.itfusion.models.main.Reports;
import co.itfusion.serial.SerialSocketDiadem;
import co.itfusion.ui.home.HomeActivity;
import co.itfusion.utils.Constants;
import co.itfusion.utils.SerialUtils;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class ServiceMainDiadem extends Service implements ServiceConnection, ISerialListener {

    ///region SINGLETON
    @SuppressLint("StaticFieldLeak")
    public static ServiceMainDiadem instance;
    ///endregion

    ///region CLASS MEMBERS
    private Context context;
    private static IBinder binder;
    private final Handler uploadHandler = new Handler();
    private final Handler flagHandler = new Handler();
    private final Handler warmingHandler = new Handler();
    private final Handler reconnectHandler = new Handler();

    private Event eventBreath = null, eventReport = null;
    private Breath breathEvents = new Breath();
    private Reports reportsEvents = new Reports();
    private RootUser user;
    private Location lastKnownLocation = null;
    private LocationCallback locationCallback;
    private FusedLocationProviderClient fusedLocationProviderClient;
    private String breathLevel = "";
    private double batteryLevel = 0.00;
    private boolean isCollisionDetected = false, isFallDetected = false;
    private UploadStatus uploadStatus = UploadStatus.NONE;
    private String channel_id_1 = "1001";
    private String channel_id_2 = "1002";
    private Intent intent;
    private boolean warmingSensor = true;
    private boolean bluetoothConnected = false;
    private static final int WARMING_TIME_DEFAULT = 60 * 10;
    private int warmingTimeLeft = WARMING_TIME_DEFAULT;
    private BluetoothDevice bluetoothDevice;
    private SerialServiceDiadem serialServiceDiadem;
    private int countdownToReconnect = 20;
    private NotificationManager notificationManager;

    private SerialUtils.ServiceStatus serviceStatus = SerialUtils.ServiceStatus.None;

    private enum UploadStatus {
        NONE,
        UPLOADING,
        UPLOADED

    }
    ///endregion

    ///region SERVICE LIFE CYCLE
    @SuppressLint("NewApi")
    public ServiceMainDiadem() {
        if(instance == null)
            instance = this;
        binder = new ServiceMainDiadem.SerialBinder();
    }

    public class SerialBinder extends Binder {
        public ServiceMainDiadem getService() {
            return ServiceMainDiadem.this;
        }
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }

    @SuppressLint("MissingPermission")
    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(Constants.TAG, "service created");

        context = getApplicationContext();

        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(dataBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_DATA_RECEIVED));

        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(statusBleBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_STATUS));

        user = Control.getSavedProfile(context);
    }

    @SuppressLint("MissingPermission")
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(Constants.TAG, "service started");

        this.intent = intent;

        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context);

        CharSequence notificationNameLocation = "location";
        CharSequence notificationNameBTStatus = "status";

        String descriptionNotificationLocation = "notification to keep track of location status";
        String descriptionNotificationStatus = "notification to keep track of bluetooth device connection";

        int importance = NotificationManager.IMPORTANCE_DEFAULT;

        NotificationChannel channelLocation = new NotificationChannel(channel_id_1, notificationNameLocation, importance);
        channelLocation.setDescription(descriptionNotificationLocation);

        NotificationChannel channelStatus = new NotificationChannel(channel_id_2, notificationNameBTStatus, importance);
        channelStatus.setDescription(descriptionNotificationStatus);

        notificationManager = this.getSystemService(NotificationManager.class);
        notificationManager.createNotificationChannel(channelLocation);
        notificationManager.createNotificationChannel(channelStatus);

        launchLocationNotification();
        launchDisconnectedBTNotification();

        startLocationUpdates();
        startUploadThread();



        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        stopLocationUpdates();
        stopUploadThread();

        try {
            notificationManager.cancelAll();
            notificationManager.deleteNotificationChannelGroup(channel_id_1);
            notificationManager.deleteNotificationChannelGroup(channel_id_2);
        }
        catch (Exception ignored) { /*NOP*/ }

        SerialUtils.actionsScaleBleService(context, SerialUtils.ServiceAction.Disconnect);

        try { disconnectService(); }
        catch (Exception e) { /*NOP*/ }

        try { unbindService(this); }
        catch (Exception ignored) { /*NOP*/ }


        try { stopForeground(true); }
        catch (Exception ignored) { /**/ }
        try { stopSelf(); }
        catch (Exception ignored) { /**/ }
        try { stopService(intent); }
        catch (Exception ignored) { /**/ }


    }
    ///endregion


    ///region SERVICE BLUETOOTH RECONNECT

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        Log.d(Constants.TAG, "service connected");
        serialServiceDiadem = ((SerialServiceDiadem.SerialBinder) service).getService();
        serialServiceDiadem.attach(this);
        Handler handler = new Handler();
        handler.post(this::connectService);
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        Log.d(Constants.TAG, "service disconnected");
        serialServiceDiadem.disconnect();
    }

    @SuppressLint("NewApi")
    private void connectService() {
        Log.d(Constants.TAG, "connecting to service"); //TODO: DELETE
        try {
            SerialSocketDiadem socket = new SerialSocketDiadem(getApplicationContext(), bluetoothDevice);
            serialServiceDiadem.connect(socket);
            Log.d(Constants.TAG, "Starting connection socket");
        } catch (Exception e) { onSerialConnectError(e); }
    }

    private void disconnectService() {
        serialServiceDiadem.disconnect();
        Log.d(Constants.TAG, "Service disconnected");
    }

    @Override
    public void onSerialConnect() {
        Log.d(Constants.TAG, "serial connected");
    }

    @Override
    public void onSerialConnectError(Exception e) {
        Log.d(Constants.TAG, "serial connect error");
        try {
            disconnectService();
            unbindService(this);
        } catch (Exception ignored) {
            /*NOP*/
        }
    }

    @Override
    public void onSerialRead(byte[] data) {

    }

    @Override
    public void onSerialIoError(Exception e) {
        Log.d(Constants.TAG, "serial connect error io");
        try {
            disconnectService();
            unbindService(this);
        } catch (Exception ignored) {
            /*NOP*/
        }
    }

    ///endregion

    ///region PUBLIC PROCEDURES & FUNCTIONS

    public boolean isBluetoothConnected() {
        return bluetoothConnected;
    }

    public boolean isWarmingSensor() {
        return warmingSensor;
    }


    ///endregion


    ///region NOTIFICATIONS

    private void launchLocationNotification() {
        Notification notification = createNotification(channel_id_1, context.getString(R.string.message_app_notification_location), context.getString(R.string.message_app_notification_location_desc));
        startForeground(1, notification);
        notificationManager.notify(1, notification);
    }

    private void launchDisconnectedBTNotification() {
        Notification notification = createNotification(channel_id_2, context.getString(R.string.message_app_notification_bt_disconnected), context.getString(R.string.message_app_notification_bt_desc));
        notificationManager.notify(2, notification);
    }

    private void launchConnectedBTNotification() {
        Notification notification = createNotification(channel_id_2, context.getString(R.string.message_app_notification_bt_connected), context.getString(R.string.message_app_notification_bt_desc));
        notificationManager.notify(2, notification);
    }

    private void launchReconnectionBTNotification() {
        Notification notification = createNotification(channel_id_2, context.getString(R.string.message_app_notification_bt_reconnecting), context.getString(R.string.message_app_notification_bt_desc));
        notificationManager.notify(2, notification);
    }

    private void saveLastBluetoothDeviceConnected(BluetoothDevice bluetoothDevice) {
        this.bluetoothDevice = bluetoothDevice;
    }

    private Notification createNotification(String channel, String title, String description) {
        Intent notificationIntent = new Intent(context, HomeActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE);
        Bitmap largeIcon = BitmapFactory.decodeResource(context.getResources(), R.drawable.app_icon);

        return new NotificationCompat.Builder(context, channel)
                .setContentTitle(title)
                .setSubText(description)
                .setSmallIcon(R.mipmap.ic_launcher_round)
                .setLargeIcon(largeIcon)
                .setContentIntent(pendingIntent)
                .build();
    }

    ///endregion

    ///region PRIVATE PROCEDURES & FUNCTIONS


    @SuppressLint("MissingPermission")
    private void startLocationUpdates() {
        LocationRequest.Builder builder = new LocationRequest
                .Builder(150)
                .setMinUpdateDistanceMeters(10)
                .setPriority(Priority.PRIORITY_HIGH_ACCURACY);

        locationCallback = new LocationCallback() {
            @Override
            public void onLocationResult(@NonNull LocationResult locationResult) {
                super.onLocationResult(locationResult);

                lastKnownLocation = locationResult.getLastLocation();
                uploadLocationUpdate(lastKnownLocation);

            }
        };

        fusedLocationProviderClient.requestLocationUpdates(builder.build(), locationCallback, Looper.getMainLooper());
    }

    private void stopLocationUpdates() {
        try { fusedLocationProviderClient.removeLocationUpdates(locationCallback); }
        catch (Exception ignored) { /*NOP*/ }
    }

    private void uploadLocationUpdate(Location locationUpdate) {

        RootReport rootReport = Control.getRootReportBase(locationUpdate, user, batteryLevel);

        Gson gson = new Gson();
        String json = gson.toJson(rootReport);

        if(!json.isEmpty()) {
            Log.d(Constants.TAG, "sending location to end point");

            OkHttpClient client = new OkHttpClient().newBuilder().build();
            MediaType mediaType = MediaType.parse(EndPoint.Type.JSON);
            RequestBody body = RequestBody.create(mediaType, json);

            Request request = new Request.Builder()
                    .url(EndPoint.Location2.URL_LOCATION)
                    .method(EndPoint.Request.POST, body)
                    .addHeader(EndPoint.Type.CONTENT_TYPE, EndPoint.Type.JSON)
                    .build();

            client.newCall(request).enqueue(callback);
        }
    }

    ///endregion

    ///region END POINT CALLBACK
    private final Callback callback = new Callback() {
        @Override
        public void onFailure(Call call, @NonNull IOException ioe) {
            eventBreath = null;
            eventReport = null;
            uploadStatus = UploadStatus.NONE;
            startUploadThread();
            call.cancel();
        }

        @Override
        public void onResponse(@NonNull Call call, Response response) throws IOException {
            assert response.body() != null;
            final String endPointResponse = response.body().string();
            Log.d(Constants.TAG, "end point response: " + endPointResponse);
            if(endPointResponse.contains(EndPoint.Responses.SUCCESS)
                    && endPointResponse.contains(EndPoint.Responses.TRUE)) {
                Log.d(Constants.TAG, "response is success true");

                if(eventBreath != null) {
                    boolean updatePerformed = breathEvents.getBreathList().stream().anyMatch(event -> {
                        String timeEvent = event.getReport().getLocation().getTimestamp();
                        String timeEventUploaded = eventBreath.getReport().getLocation().getTimestamp();
                        if(timeEventUploaded.equals(timeEvent)) {
                            event.setSync(true);
                            return true;
                        } else return false;
                    });

                    if(updatePerformed) {
                        Log.d(Constants.TAG, "update performed and item updated");
                        eventBreath = null;
                        Control.saveBreaths(context, breathEvents);
                    } else {
                        Log.d(Constants.TAG, "update was not performed");
                    }
                }
                else if(eventReport != null) {
                    boolean updatePerformed = reportsEvents.getReportList().stream().anyMatch(event -> {
                        try {
                            String timeEvent = event.getReport().getLocation().getTimestamp();
                            String timeEventUploaded = eventReport.getReport().getLocation().getTimestamp();
                            if(timeEventUploaded.equals(timeEvent)) {
                                event.setSync(true);
                                return true;
                            } else return false;
                        } catch (Exception e) {
                            Log.d(Constants.TAG, String.format("error with report %s", e.getMessage()));
                            return false;
                        }
                    });

                    if(updatePerformed) {
                        Log.d(Constants.TAG, "update performed and item updated");
                        eventReport = null;
                        Control.saveReports(context, reportsEvents);
                    } else {
                        Log.d(Constants.TAG, "update was not performed");
                    }
                } else {
                    Log.d(Constants.TAG, "upload of other data performed");
                }
            }
            else {
                Log.d(Constants.TAG, String.format("server reject upload, response was: %s", endPointResponse));
            }

            uploadStatus = UploadStatus.NONE;
            startUploadThread();
        }
    };
    ///endregion

    ///region UPLOAD-ENDPOINT THREAD

    private void startUploadThread() {
        stopUploadThread();
        uploadHandler.postDelayed(uploadThread, Constants.DELAYS.ONE_SEC * 5L);
    }

    private void stopUploadThread() {
        uploadHandler.removeCallbacks(uploadThread);
    }

    private final Runnable uploadThread = new Runnable() {
        @Override
        public void run() {
            if(lastKnownLocation == null) {
                startUploadThread();
                Log.d(Constants.TAG, "waiting for location");
            }
            else {
                breathEvents = Control.getBreathSaved(context);
                reportsEvents = Control.getReports(context);

                String json = "";
                Gson gson = new Gson();

                if(uploadStatus == UploadStatus.NONE) {
                    if(breathEvents != null && breathEvents.getBreathList().stream().anyMatch(event -> !event.isSync())) {

                        Log.d(Constants.TAG, "breath event de-sync found");
                        eventBreath = breathEvents.getBreathList().stream().filter(event -> !event.isSync()).findAny().orElse(null);
                        if(eventBreath != null)
                            json = gson.toJson(eventBreath.getReport());

                    }
                    else if (reportsEvents != null && reportsEvents.getReportList().stream().anyMatch(event -> !event.isSync())) {

                        Log.d(Constants.TAG, "report event de-sync found");
                        eventReport = reportsEvents.getReportList().stream().filter(event -> !event.isSync()).findAny().orElse(null);
                        if(eventReport != null)
                            json = gson.toJson(eventReport);

                    }

                    if(!json.isEmpty()) {

                        uploadStatus = UploadStatus.UPLOADING;

                        OkHttpClient client = new OkHttpClient().newBuilder().build();
                        MediaType mediaType = MediaType.parse(EndPoint.Type.JSON);
                        RequestBody body = RequestBody.create(mediaType, json);

                        Request request = new Request.Builder()
                                .url(EndPoint.Location2.URL_LOCATION)
                                .method(EndPoint.Request.POST, body)
                                .addHeader(EndPoint.Type.CONTENT_TYPE, EndPoint.Type.JSON)
                                .build();

                        client.newCall(request).enqueue(callback);
                    } else {

                        Log.d(Constants.TAG, "nothing to upload yet");
                        startUploadThread();

                    }
                }
            }
        }
    };
    ///endregion

    ///region FLAGS THREAD

    private void startClearFlagThread() {
        flagHandler.removeCallbacks(clearFlagsThread);
        flagHandler.postDelayed(clearFlagsThread, Constants.DELAYS.ONE_SEC * 300L);
    }

    private final Runnable clearFlagsThread = () -> {
        if(isCollisionDetected) isCollisionDetected = false;
        if(isFallDetected) isFallDetected = false;
    };

    ///endregion

    ///region WARMING THREAD

    private void startWarmingThread() {
        stopWarmingThread();
        warmingHandler.post(warmingThread);
    }

    private void startWarmingThread(int millis) {
        warmingHandler.postDelayed(warmingThread, millis);
    }

    private void stopWarmingThread() {
        warmingHandler.removeCallbacks(warmingThread);
    }

    private final Runnable warmingThread = () -> {
        if(warmingTimeLeft > 0) {
            warmingTimeLeft--;
            warmingSensor = true;
            startWarmingThread(Constants.DELAYS.ONE_SEC);
        } else {
            Log.d(Constants.TAG, "warming done");
            warmingTimeLeft = WARMING_TIME_DEFAULT;
            warmingSensor = false;
            stopWarmingThread();
        }
    };

    ///endregion

    ///region RECONNECT BLUETOOTH THREAD

    private void startReconnectionThread() {
        reconnectHandler.removeCallbacks(reconnectionThread);
        reconnectHandler.postDelayed(reconnectionThread, Constants.DELAYS.ONE_SEC * 5L);
    }

//    private void startReconnectionThread(int millis) {
//        reconnectHandler.postDelayed(reconnectionThread, millis);
//    }

    private void stopReconnectionThread() {
        reconnectHandler.removeCallbacks(reconnectionThread);
    }

    private final Runnable reconnectionThread = () -> {

        bindService(new Intent(this, SerialServiceDiadem.class), this, Context.BIND_AUTO_CREATE);
        startService(new Intent(this, SerialServiceDiadem.class));
        stopReconnectionThread();
//
//        if(countdownToReconnect > 0) {
//            countdownToReconnect--;
//            startReconnectionThread(1000);
//            Log.d(Constants.TAG, String.format("countdown to reconnect %s", countdownToReconnect));
//        } else {
//
//            bindService(new Intent(this, SerialServiceDiadem.class), this, Context.BIND_AUTO_CREATE);
//            startService(new Intent(this, SerialServiceDiadem.class));
//            stopReconnectionThread();
//
//            countdownToReconnect = 20;
//        }
    };

    ///endregion

    ///region SERIAL BLUETOOTH BROADCAST - STATUS

    private final BroadcastReceiver statusBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            if(bundle != null) {
                SerialUtils.ServiceStatus serviceStatus
                        = (SerialUtils.ServiceStatus) bundle.get(SerialUtils.EXTRA_SERIAL_1);
                if(serviceStatus != null) {
                    switch (serviceStatus) {
                        case Connected:
                            Log.d(Constants.TAG, "Bluetooth now is connected");
                            try {
//                                launchConnectedBTNotification();
                                BluetoothDevice bt = (BluetoothDevice) bundle.get(SerialUtils.EXTRA_SERIAL_2);
                                if(bt != null)
                                    saveLastBluetoothDeviceConnected(bt);
                            } catch (Exception e) {
                                Log.d(Constants.TAG, String.format("exception in connected bluetooth: %s", e.getMessage()));
                            }
//                            bluetoothConnected = true;
//                            startWarmingThread();
                            break;
                        case Listening:
                            break;
                        case ErrorIO:
                        case Error:
//                            launchReconnectionBTNotification();
                            startReconnectionThread();
                            break;
                        case Connecting:
                        case Disconnecting:
                        case Disconnected:
                        case None:
                        default:
                            Log.d(Constants.TAG, String.format("Status changed: %s", serviceStatus.name()));
                            bluetoothConnected = false;
                            stopWarmingThread();
                    }
                }
            }
        }
    };


    ///endregion

    ///region SERIAL BLUETOOTH BROADCAST - DATA

    private final BroadcastReceiver dataBleBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {

            Bundle bundle = intent.getExtras();
            String received = (bundle != null)  ?
                    (String) intent.getExtras().get(SerialUtils.EXTRA_SERIAL_1) :
                    null;

            if(received != null) {
                String stream = "", data = "";
                SerialUtils.StreamType streamType = SerialUtils.StreamType.UNKNOWN;

                stream = SerialUtils.getStream(received);
                if(stream != null) {
                    data = SerialUtils.getStreamData(stream);
                    streamType = SerialUtils.getStreamType(stream);
                    if(streamType != null && !data.isEmpty()) {
                        RootReport rootReport = Control.getRootReportBase(lastKnownLocation, user, batteryLevel);
                        switch (streamType) {
                            case FLAG_ALC:
                                String level = SerialUtils.getBreathLevelFromFlag(data);
                                rootReport.getLocation().getExtras().setCon_alcoholemia(SerialUtils.ONE);
                                rootReport.getLocation().getExtras().setGrado_alcohol(level);

                                Log.d(Constants.TAG, String.format("level received %s - level saved %s", level, breathLevel));

                                if(breathLevel.isEmpty() || !breathLevel.equals(level)) {
                                    Control.saveBreathEvent(context, new Event(rootReport));
                                    breathLevel = level;
                                }

                                break;
                            case STAT_BAT:
                                batteryLevel = SerialUtils.convertBatteryLevel(SerialUtils.getValue(data));
                                break;
                            case VAL_COL:
                                Log.d(Constants.TAG, String.format("collision received: %s", data));
                                if(!isCollisionDetected) {
                                    isCollisionDetected = true;
                                    Log.d(Constants.TAG, "Collision is being saved");
                                    rootReport.getLocation().getExtras().setColision("1");
                                    rootReport.getLocation().getExtras().setX1(SerialUtils.getAxisX(data));
                                    rootReport.getLocation().getExtras().setY1(SerialUtils.getAxisY(data));
                                    rootReport.getLocation().getExtras().setZ1(SerialUtils.getAxisZ(data));
                                    rootReport.getLocation().getExtras().setM1(SerialUtils.getMagnitude(data));
                                    Control.saveReportEvent(context, new Event(rootReport));
                                    startClearFlagThread();
                                }
                                break;
                            case VAL_FALL:
                                Log.d(Constants.TAG, String.format("fall received: %s", data));
                                if(!isFallDetected) {
                                    isFallDetected = true;
                                    Log.d(Constants.TAG, "Falling is being saved");
                                    rootReport.getLocation().getExtras().setCaida("1");
                                    rootReport.getLocation().getExtras().setX1(SerialUtils.getAxisX(data));
                                    rootReport.getLocation().getExtras().setY1(SerialUtils.getAxisY(data));
                                    rootReport.getLocation().getExtras().setZ1(SerialUtils.getAxisZ(data));
                                    rootReport.getLocation().getExtras().setM1(SerialUtils.getMagnitude(data));
                                    Control.saveReportEvent(context, new Event(rootReport));
                                    startClearFlagThread();
                                }
                                break;
                            case REPORT_FALL:
                            case REPORT_COL:
                            case FLAG_FALL:
                            case FLAG_COL:
                            case SEC_TEMP_ALC:
                            case SEC_TEMP_ACC:
                            case SEC_LOW_BAT:
                            case TEMP_ALC:
                            case TEMP_ACC:
                            case STAT_ALC:
                            case UNKNOWN:
                            default:
                                Log.d(Constants.TAG, String.format("data rejected in service: %s", data));
                                break;
                        }
                    }
                }
            }
        }
    };

    ///endregion
}
