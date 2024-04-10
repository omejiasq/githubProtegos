package co.itfusion.services;

import android.annotation.SuppressLint;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import java.io.IOException;
import java.io.Serial;
import java.util.LinkedList;
import java.util.Queue;

import co.itfusion.interfaces.ISerialListener;
import co.itfusion.serial.SerialSocketDiadem;
import co.itfusion.utils.Constants;
import co.itfusion.utils.SerialUtils;

public class SerialServiceDiadem extends Service implements ISerialListener {

    public class SerialBinder extends Binder { public SerialServiceDiadem getService() { return SerialServiceDiadem.this; } }

    private enum QueueType {Connect, ConnectError, Read, IoError}

    private static class QueueItem {
        QueueType type;
        byte[] data;
        Exception e;

        QueueItem(QueueType type, byte[] data, Exception e) { this.type=type; this.data=data; this.e=e; }
    }

    private final Handler mainLooper;
    private final IBinder binder;
    private final Queue<QueueItem> queue1, queue2;

    private SerialSocketDiadem socket;
    private ISerialListener listener;
    private boolean connected;
    private String buffer = "";
    private Context context;

    private BluetoothDevice bluetoothDevice;

    ///region LIFE CYCLE

    public SerialServiceDiadem() {
        mainLooper = new Handler(Looper.getMainLooper());
        binder = new SerialBinder();
        queue1 = new LinkedList<>();
        queue2 = new LinkedList<>();

    }

    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();
        LocalBroadcastManager.getInstance(context).registerReceiver(dataSendBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_SEND_DATA));
        LocalBroadcastManager.getInstance(context).registerReceiver(actionsBroadcastReceiver, new IntentFilter(SerialUtils.FILTER_ACTIONS));
    }

    @Override
    public void onDestroy() {
        cancelNotification();
        disconnect();
        super.onDestroy();
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }

    ///endregion

    ///region API

    @RequiresApi(api = Build.VERSION_CODES.TIRAMISU)
    public void connect(SerialSocketDiadem socket) throws IOException {
        socket.connect(this);
        this.socket = socket;
        connected = true;
    }

    public void disconnect() {
        connected = false; // ignore data,errors while disconnecting
        cancelNotification();
        if(socket != null) {
            socket.disconnect();
            socket = null;
        }
    }

    public void attach(ISerialListener listener) {
        if(Looper.getMainLooper().getThread() != Thread.currentThread())
            throw new IllegalArgumentException("not in main thread");
        cancelNotification();
        // use synchronized() to prevent new items in queue2
        // new items will not be added to queue1 because mainLooper.post and attach() run in main thread
        synchronized (this) {
            this.listener = listener;
        }
        for(QueueItem item : queue1) {
            switch(item.type) {
                case Connect:       listener.onSerialConnect      (); break;
                case ConnectError:  listener.onSerialConnectError (item.e); break;
                case Read:          listener.onSerialRead         (item.data); break;
                case IoError:       listener.onSerialIoError      (item.e); break;
            }
        }
        for(QueueItem item : queue2) {
            switch(item.type) {
                case Connect:       listener.onSerialConnect      (); break;
                case ConnectError:  listener.onSerialConnectError (item.e); break;
                case Read:          listener.onSerialRead         (item.data); break;
                case IoError:       listener.onSerialIoError      (item.e); break;
            }
        }
        queue1.clear();
        queue2.clear();
    }

    private void write(byte[] data) throws IOException {
        if(!connected)
            throw new IOException("not connected");
        socket.write(data);
    }

    public void detach() {
        if(connected)
            createNotification();
        // items already in event queue (posted before detach() to mainLooper) will end up in queue1
        // items occurring later, will be moved directly to queue2
        // detach() and mainLooper.post run in the main thread, so all items are caught
        listener = null;
    }

    @SuppressLint("ObsoleteSdkInt")
    private void createNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel nc = new NotificationChannel(SerialUtils.NOTIFICATION_CHANNEL, "Background service", NotificationManager.IMPORTANCE_LOW);
            nc.setShowBadge(false);
            NotificationManager nm = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            nm.createNotificationChannel(nc);
        }
        Intent disconnectIntent = new Intent()
                .setAction(SerialUtils.INTENT_ACTION_DISCONNECT);
        Intent restartIntent = new Intent()
                .setClassName(this, SerialUtils.INTENT_CLASS_MAIN_ACTIVITY)
                .setAction(Intent.ACTION_MAIN)
                .addCategory(Intent.CATEGORY_LAUNCHER);
    }

    private void cancelNotification() {
        stopForeground(true);
    }

    ///endregion

    ///region SerialListener

    public void onSerialConnect() {
        if(connected) {
            synchronized (this) {
                if (listener != null) {
                    mainLooper.post(() -> {
                        if (listener != null) {
                            listener.onSerialConnect();
                        } else {
                            queue1.add(new QueueItem(QueueType.Connect, null, null));
                        }
                    });
                } else {
                    queue2.add(new QueueItem(QueueType.Connect, null, null));
                }
            }
//            SerialUtils.statusBleService(this, SerialUtils.ServiceStatus.Connected);
        }
    }

    public void onSerialConnectError(Exception e) {
        if(connected) {
            synchronized (this) {
                if (listener != null) {
                    mainLooper.post(() -> {
                        if (listener != null) {
                            listener.onSerialConnectError(e);
                        } else {
                            queue1.add(new QueueItem(QueueType.ConnectError, null, e));
                            cancelNotification();
                            disconnect();
                        }
                    });
                } else {
                    queue2.add(new QueueItem(QueueType.ConnectError, null, e));
                    cancelNotification();
                    disconnect();
                }
            }

            SerialUtils.statusBleService(this, SerialUtils.ServiceStatus.Error);

            try { stopSelf(); }
            catch (Exception ignored) { /*NOP*/ }
            try { stopForeground(true); }
            catch (Exception ignored) { /*NOP*/ }

        }
    }

    public void onSerialRead(byte[] data) {
        if(connected) {
            synchronized (this) {
                if (listener != null) {
                    mainLooper.post(() -> {
                        if (listener != null) {
                            listener.onSerialRead(data);
                            String received = new String(data);

                            Log.d(Constants.TAG_SERVICE, String.format("service: [%s]", received));


                            if(received.contains(SerialUtils.BEGIN) && buffer.isEmpty()) {
                                Log.d(Constants.TAG, String.format("received contains begin: %s", received));

                                int indexOfBegin = received.indexOf(SerialUtils.BEGIN);

                                try {
                                    char startStream = received.charAt(indexOfBegin);
                                    char receptionVerification = received.charAt(indexOfBegin + 1);
                                    if (startStream == receptionVerification) {
                                        indexOfBegin++;
                                        buffer = received.substring(indexOfBegin);
                                    } else {
                                        buffer = received.substring(received.indexOf(SerialUtils.BEGIN));
                                    }
                                } catch (Exception e) {
                                    buffer = received.substring(received.indexOf(SerialUtils.BEGIN));
                                }

                                if(buffer.contains(SerialUtils.TRAIL)) {
                                    buffer = buffer.substring(0, buffer.indexOf(SerialUtils.TRAIL) + 1);
                                    Log.d(Constants.TAG, String.format("received up to trail: %s", buffer));

                                    SerialUtils.receptionDataBleService(this, buffer);
                                    buffer = "";
                                }
                            }
                            else if(!buffer.isEmpty() && received.contains(SerialUtils.TRAIL)) {
                                Log.d(Constants.TAG, String.format("buffer has info and received has trail: %s", received));

                                buffer += received.substring(0, received.indexOf(SerialUtils.TRAIL) + 1);

                                Log.d(Constants.TAG, String.format("now buffer has: %s", buffer));

                                SerialUtils.receptionDataBleService(this, buffer);
                                buffer = "";
                            }
                            else {
                                if(!buffer.isEmpty()) {
                                    buffer += received;
                                    Log.d(Constants.TAG, String.format("buffer now has: %s", buffer));
                                } else {
                                    Log.d(Constants.TAG, String.format("discarded: %s", received));
                                    SerialUtils.receptionDataBleServiceV2(context, received);
                                }

                            }

                        } else {
                            queue1.add(new QueueItem(QueueType.Read, data, null));
                        }
                    });
                } else {
                    queue2.add(new QueueItem(QueueType.Read, data, null));
                }
            }
        }
    }

    public void onSerialIoError(Exception e) {
        if(connected) {
            synchronized (this) {
                if (listener != null) {
                    mainLooper.post(() -> {
                        if (listener != null) {
                            listener.onSerialIoError(e);
                        } else {
                            queue1.add(new QueueItem(QueueType.IoError, null, e));
                            cancelNotification();
                            disconnect();
                        }
                    });
                } else {
                    queue2.add(new QueueItem(QueueType.IoError, null, e));
                    cancelNotification();
                    disconnect();
                }
            }

            SerialUtils.statusBleService(this, SerialUtils.ServiceStatus.ErrorIO);

            try { stopSelf(); }
            catch (Exception ignored) { /*NOP*/ }
            try { stopForeground(true); }
            catch (Exception ignored) { /*NOP*/ }

        }
    }

    ///endregion


    private final BroadcastReceiver dataSendBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle bundle = intent.getExtras();
            if(bundle != null) {
                String data = (String) bundle.get(SerialUtils.EXTRA_MESSAGE);
                if (data == null) return;
                try { write(data.getBytes()); }
                catch (IOException e) { e.printStackTrace(); }
            }
        }
    };

    private final BroadcastReceiver actionsBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {

            Bundle bundle = intent.getExtras();
            if(bundle != null) {
                SerialUtils.ServiceAction serviceAction =
                        (SerialUtils.ServiceAction) bundle.get(SerialUtils.EXTRA_ACTIONS);
                if(serviceAction == null) return;
                switch (serviceAction) {
                    case None:
                    case Connect:
                    case Reconnect:
                        break;
                    case Disconnect:
                        disconnect();
                        break;
                }

            }
        }
    };


}
