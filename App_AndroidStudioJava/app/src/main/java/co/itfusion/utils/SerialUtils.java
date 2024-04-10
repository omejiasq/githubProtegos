package co.itfusion.utils;

import android.app.Service;
import android.bluetooth.BluetoothDevice;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import co.itfusion.dima.BuildConfig;

public class SerialUtils {
    public static final long LESCAN_PERIOD = 10000;
    public static final long CLASSIC_SCAN_PERIOD = 10000;

    // values have to be globally unique
    public static final String INTENT_ACTION_DISCONNECT = BuildConfig.APPLICATION_ID + ".Disconnect";
    public static final String NOTIFICATION_CHANNEL = BuildConfig.APPLICATION_ID + ".Channel";
    public static final String INTENT_CLASS_MAIN_ACTIVITY = BuildConfig.APPLICATION_ID + ".MainActivity";



    public static final String DIMA_SERVICE = "dima_service";
    public enum ServiceAction { None, Disconnect, Connect, Reconnect }
    public enum ServiceStatus { None, ErrorIO, Error, Connecting, Connected, Listening, Disconnecting, Disconnected }

    // values have to be unique within each app
    public static final int NOTIFY_MANAGER_START_FOREGROUND_SERVICE = 1001;

    public enum ScanStatus {None, LeScan, Discovery, DiscoveryFinished}
    public enum ConnectionStatus {None, False, Pending, True}
    public enum BleConnection {None, DevelopmentBle, Scale, Rfid}

    public static String FILTER_SEND_DATA = "DATA_TX";
    public static String FILTER_STATUS = "CONNECTION_STATUS";

    public static String FILTER_DATA_RECEIVED = "DATA_RX";
    public static String FILTER_DATA_RECEIVED_V2 = "DATA_RECEIVED_";
    public static String FILTER_ACTIONS = "CONNECTION_ACTION";


    public static final String EXTRA_SERIAL_1 = "SERIAL_EXTRA_1";
    public static final String EXTRA_SERIAL_2 = "SERIAL_EXTRA_2";

    public static final String EXTRA_MESSAGE = "message";
    public static final String EXTRA_CASE = "case";
    public static final String EXTRA_ACTIONS = "action";
    public static final String EXTRA_STATUS = "status";


    public static String NEW_LINE = "\r\n", TRAIL = "#", BEGIN = "$";

    public static String ZERO = "0";
    public static String ONE = "1";
    public static String DEFAULT = "-1";

    public static String TEMP_ALC = "1A", TEMP_ACC = "1B";
    public static String STAT_ALC = "2A",  STAT_BAT = "2B";
    public static String VAL_ALC = "3A", VAL_FALL = "3B", VAL_COL = "3C";
    public static String FLAG_ALC = "4A" , FLAG_FALL = "4B", FLAG_COL = "4C";
    public static String SEC_TEMP_ALC = "5A", SEC_TEMP_ACC = "5B", SEC_LOW_BAT = "5C";
    public static String REPORT_FALL = "6B" , REPORT_COL = "6C";

    public enum StreamType {
        TEMP_ALC, TEMP_ACC, STAT_ALC, STAT_BAT, VAL_ALC, VAL_FALL,
        VAL_COL, FLAG_ALC, FLAG_FALL, FLAG_COL, SEC_TEMP_ALC,
        SEC_TEMP_ACC, SEC_LOW_BAT, REPORT_FALL, REPORT_COL,
        UNKNOWN
    }

    public static String getStream(@NonNull String data) {
        String result = data.trim();

        if(!data.contains(BEGIN) || !data.contains(TRAIL)) return null;

        if(!data.startsWith(BEGIN) && data.contains(BEGIN)) {
            result = result.substring(data.indexOf(BEGIN)).trim();
        }

        if(!data.endsWith(TRAIL) && data.contains(TRAIL)) {
            result = result.substring(0, data.indexOf(TRAIL)).trim();
        }

        result = result.replace(BEGIN, Constants.Characters.EMPTY);
        result = result.replace(TRAIL, Constants.Characters.EMPTY);

        return result.trim();
    }

    public static String getStreamData(String data) {
        try {
            if(data == null) return Constants.Characters.EMPTY;
            return data.substring(2);
        } catch (Exception ignored) {
            return Constants.Characters.EMPTY;
        }
    }

    public static StreamType getStreamType(@NonNull String data) {
        if (data.startsWith(TEMP_ALC))
            return StreamType.TEMP_ALC;
        else if (data.startsWith(TEMP_ACC))
            return StreamType.TEMP_ACC;
        else if (data.startsWith(STAT_ALC))
            return StreamType.STAT_ALC;
        else if (data.startsWith(STAT_BAT))
            return StreamType.STAT_BAT;
        else if (data.startsWith(VAL_ALC))
            return StreamType.VAL_ALC;
        else if (data.startsWith(VAL_FALL))
            return StreamType.VAL_FALL;
        else if (data.startsWith(VAL_COL))
            return StreamType.VAL_COL;
        else if (data.startsWith(FLAG_ALC))
            return StreamType.FLAG_ALC;
        else if (data.startsWith(FLAG_FALL))
            return StreamType.FLAG_FALL;
        else if (data.startsWith(FLAG_COL))
            return StreamType.FLAG_COL;
        else if (data.startsWith(SEC_TEMP_ALC))
            return StreamType.SEC_TEMP_ALC;
        else if (data.startsWith(SEC_TEMP_ACC))
            return StreamType.SEC_TEMP_ACC;
        else if (data.startsWith(SEC_LOW_BAT))
            return StreamType.SEC_LOW_BAT;
        else if (data.startsWith(REPORT_FALL))
            return StreamType.REPORT_FALL;
        else if(data.startsWith(REPORT_COL))
            return StreamType.REPORT_COL;
        else
            return StreamType.UNKNOWN;
    }

    public static double convertBatteryLevel(String battery) {
        try {
            battery = battery.replace(Constants.Characters.COMMA, Constants.Characters.DOT);
            double data = Double.parseDouble(battery);
            return data / 100;
        } catch (Exception ignored) {
            return Double.NaN;
        }
    }

    public static String getAxisX(String data) {
        try {
            String[] split = data.split(Constants.Characters.SEMI_COLON);
            return (split[0] != null && !split[0].isEmpty()) ? split[0] : ZERO;
        } catch (Exception ignored) {
            return DEFAULT;
        }
    }

    public static String getAxisY(String data) {
        try {
            String[] split = data.split(Constants.Characters.SEMI_COLON);
            return (split[1] != null && !split[1].isEmpty()) ? split[1] : ZERO;
        } catch (Exception ignored) {
            return DEFAULT;
        }
    }

    public static String getAxisZ(String data) {
        try {
            String[] split = data.split(Constants.Characters.SEMI_COLON);
            return (split[2] != null && !split[2].isEmpty()) ? split[2] : ZERO;
        } catch (Exception ignored) {
            return DEFAULT;
        }
    }

    public static String getMagnitude(String data) {
        try {
            String[] split = data.split(Constants.Characters.SEMI_COLON);
            return (split[3] != null && !split[3].isEmpty()) ? split[3] : ZERO;
        } catch (Exception ignored) {
            return DEFAULT;
        }
    }

    public static String getValue(String data) {
        String value = data.substring(0, data.length() - 1);
        String decimalValue = data.substring(data.length() - 1);
        return String.format("%s,%s", value, decimalValue);
    }
    public static String getTemperatureValue(String data) {
        String firstValue = "", secondValue = "";
        try { firstValue = data.substring(0, 2); }
        catch (Exception e) {
            Log.d(Constants.TAG, String.format("exception getting temperature value %s", e.getMessage()));
        }


        if(data.length() == 2) {
            secondValue = "0";
        } else {
            try { secondValue = data.substring(2, 3); }
            catch (Exception e) {
                Log.d(Constants.TAG, String.format("exception getting temperature value %s", e.getMessage()));
            }
        }
        return String.format("%s,%s", firstValue, secondValue);
    }

    public static String getBatteryValue(String data) {
        String firstValue, secondValue;
        if(data.length() >= 4) {
            firstValue = data.substring(0, 3);
            secondValue = "0";
        } else {
            firstValue = data.substring(0, 2);
            secondValue = data.substring(2, 3);

        }
        return String.format("%s,%s", firstValue, secondValue);
    }

    public static boolean getFlag(String data) {
        return !data.trim().equals(ZERO);
    }

    public static String getBreathValue(String data) {
        String lastValue = data.substring(data.length() - 1);
        String firstValue = data.substring(0, data.length() - 1);
        return String.format("%s,%s", firstValue, lastValue);
    }

    public static String getBreathLevelFromFlag(String data) {
        try {
            String[] splits = data.split(Constants.Characters.COMMA);
            return (splits[0] != null) ? splits[0] : Constants.Characters.EMPTY;
        } catch (Exception ignored) {
            return DEFAULT;
        }
    }

    public static String getBreathValueFromFlag(String data) {
        String[] splits = data.split(Constants.Characters.COMMA);
        String value = (splits[1] != null) ? splits[1] : Constants.Characters.EMPTY;

        try {
            if(value != null && !value.isEmpty() && value.length() > 2) {
                Log.d(Constants.TAG, String.format("value received %s" , data));
                String info = splits[1];
                String lastValue = info.substring(info.length() - 1);
                String firstValue = info.substring(0, info.length() - 1);
                return String.format("%s,%s", firstValue, lastValue);
            } else
                return ZERO;

        } catch (Exception e) {
            Log.d(Constants.TAG, String.format("exception getting breath value %s", e.getMessage()));
            return DEFAULT;
        }
    }

    public static void receptionDataBleServiceV2(Context context, String data) {
        Intent intent = new Intent(SerialUtils.FILTER_DATA_RECEIVED_V2);
        intent.putExtra(SerialUtils.EXTRA_SERIAL_1, data);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }

    public static void receptionDataBleService(Context context, String data) {
        Intent intent = new Intent(SerialUtils.FILTER_DATA_RECEIVED);
        intent.putExtra(SerialUtils.EXTRA_SERIAL_1, data);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }

    public static void statusBleService(Context context, ServiceStatus serviceStatus) {
        Intent intent = new Intent(SerialUtils.FILTER_STATUS);
        intent.putExtra(EXTRA_SERIAL_1, serviceStatus);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }

    public static void statusBleService(Context context, ServiceStatus serviceStatus, BluetoothDevice bluetoothDevice) {
        Intent intent = new Intent(SerialUtils.FILTER_STATUS);
        intent.putExtra(EXTRA_SERIAL_1, serviceStatus);
        intent.putExtra(EXTRA_SERIAL_2, bluetoothDevice);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }


    public static void actionsScaleBleService(Context context, ServiceAction serviceAction) {
        Intent intent = new Intent(FILTER_ACTIONS);
        intent.putExtra(EXTRA_ACTIONS, serviceAction);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }


    public static void sendDataScaleBleService(Context context, String message) {
        Intent intent = new Intent(SerialUtils.FILTER_SEND_DATA);
        intent.putExtra(SerialUtils.EXTRA_MESSAGE, message);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }


}
