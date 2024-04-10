package co.itfusion.data;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.location.Location;
import android.util.Log;

import com.google.gson.Gson;

import java.time.Instant;

import co.itfusion.models.endpoint.location.Battery;
import co.itfusion.models.endpoint.location.RootReport;
import co.itfusion.models.endpoint.user.RootUser;
import co.itfusion.models.main.Breath;
import co.itfusion.models.main.Collision;
import co.itfusion.models.main.Event;
import co.itfusion.models.main.Fall;
import co.itfusion.models.main.Reports;
import co.itfusion.utils.Constants;
import co.itfusion.utils.SerialUtils;

public class Control {

    public static RootReport getRootReportBase(Location location, RootUser user, double batteryLevel) {
        RootReport rootReport = new RootReport();

        Instant now = Instant.now();
        String timestamp = now.toString();

        rootReport.getLocation().setTimestamp(timestamp);
        rootReport.getLocation().setUuid(user.getData().getUser().get_id());
        rootReport.getLocation().getExtras().setUserId(user.getData().getUser().get_id());
        rootReport.getLocation().getExtras().setCompany(user.getData().getUser().getCompany());
        rootReport.getLocation().getExtras().setToken(user.getData().getToken());

        rootReport.getLocation().setBattery(new Battery(batteryLevel));

        if(location != null) {
            rootReport.getLocation().getCoords().setLatitude(location.getLatitude());
            rootReport.getLocation().getCoords().setLongitude(location.getLongitude());
            if(location.getSpeed() < 0)
                rootReport.getLocation().getCoords().setSpeed(0);
            else
                rootReport.getLocation().getCoords().setSpeed(location.getSpeed());
        }

        return rootReport;
    }

    public static void saveLoginProfile(Context context, String response) {
        Log.d(Constants.TAG, "Saving login response");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.USER_DATA, response);
        editor.apply();
    }

    public static void updateProfile(Context context, RootUser rootUser) {
        Log.d(Constants.TAG, "updating profile user");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(rootUser);
        editor.putString(Constants.Values.USER_DATA, json);
        editor.apply();
    }

    public static RootUser getSavedProfile(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString(Constants.Values.USER_DATA, null);
//        Log.d(Constants.TAG, String.format("user retrieved has: %s", json));
        if(json == null) return null;
        else return gson.fromJson(json, RootUser.class);
    }

    public static void clearSavedProfile(Context context) {
        Log.d(Constants.TAG, "Saving login response");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.USER_DATA, null);
        editor.apply();
    }

    public static void saveServiceStatus(Context context, SerialUtils.ServiceStatus status) {
        Log.d(Constants.TAG, "Saving connection status response");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.CONNECTION_STATUS, status.name());
        editor.apply();
    }

    public static SerialUtils.ServiceStatus getServiceStatus(Context context) {
        Log.d(Constants.TAG, "getting connection status response");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        String connection = sharedPreferences.getString(Constants.Values.CONNECTION_STATUS, String.valueOf(SerialUtils.ServiceStatus.None));
        return SerialUtils.ServiceStatus.valueOf(connection);
    }

    public static void clearServiceStatus(Context context) {
        Log.d(Constants.TAG, "clearing connection status");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.CONNECTION_STATUS, null);
        editor.apply();
    }

    public static void saveReportEvent(Context context, Event event) {
        Log.d(Constants.TAG, "saving report event");
        Reports reports = getReports(context);
        if(reports == null) reports = new Reports();
        reports.addReportToList(event);

        saveReports(context, reports);
    }

    public static void saveReports(Context context, Reports reports) {
        Log.d(Constants.TAG, "updating profile user");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(reports);
        editor.putString(Constants.Values.REPORTS, json);
        editor.apply();
    }

    public static Reports getReports(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString(Constants.Values.REPORTS, null);
        if(json == null) return null;
        else return gson.fromJson(json, Reports.class);
    }

    public static void clearReports(Context context) {
        Log.d(Constants.TAG, "Saving login response");
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.REPORTS, null);
        editor.apply();
    }

    public static void saveBreathEvent(Context context, Event event) {
        Log.d(Constants.TAG, "saving breath event");
        Breath breathSaved = getBreathSaved(context);
        if(breathSaved != null) {
            breathSaved.addBreathToList(event);
        } else {
            breathSaved = new Breath();
            breathSaved.addBreathToList(event);
        }
        saveBreaths(context, breathSaved);
    }

    public static void saveFallEvent(Context context, Event event) {
        Log.d(Constants.TAG, "saving fall event");
        Fall fallSaved = getFallSaved(context);
        if(fallSaved != null) {
            fallSaved.addFallingToList(event);
        } else {
            fallSaved = new Fall();
            fallSaved.addFallingToList(event);
        }
        saveFalls(context, fallSaved);
    }


    public static void saveCollisionEvent(Context context, Event event) {
        Log.d(Constants.TAG, "saving collision event");
        Collision collisionSaved = getCollisionsSaved(context);
        if(collisionSaved != null) {
            collisionSaved.addCollisionToList(event);
        } else {
            collisionSaved = new Collision();
            collisionSaved.addCollisionToList(event);
        }
        saveCollisions(context, collisionSaved);
    }

    public static void saveBreaths(Context context, Breath breath) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(breath);
        editor.putString(Constants.Values.BREATH, json);
        editor.apply();
        Log.d(Constants.TAG, "Breath saved");
    }

    public static void saveFalls(Context context, Fall fall) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(fall);
        editor.putString(Constants.Values.FALLING, json);
        editor.apply();
        Log.d(Constants.TAG, "Falling saved");
    }

    public static void saveCollisions(Context context, Collision collision) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(collision);
        editor.putString(Constants.Values.COLLISIONS, json);
        editor.apply();
        Log.d(Constants.TAG, "Collisions saved");
    }

    public static Breath getBreathSaved(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString(Constants.Values.BREATH, null);
        if(json != null) return gson.fromJson(json, Breath.class);
        else return null;
    }

    public static Fall getFallSaved(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString(Constants.Values.FALLING, null);
        if(json != null) return gson.fromJson(json, Fall.class);
        else return null;
    }

    public static Collision getCollisionsSaved(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF, Context.MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString(Constants.Values.COLLISIONS, null);
        if(json != null) return gson.fromJson(json, Collision.class);
        else return null;
    }

    public static void clearAllEvents(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(Constants.Values.SHARED_PREF , Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(Constants.Values.COLLISIONS, null);
        editor.putString(Constants.Values.BREATH, null);
        editor.putString(Constants.Values.FALLING, null);
        editor.apply();
    }

}
