package co.itfusion.services;

import android.location.Location;
import android.location.LocationListener;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;

import co.itfusion.utils.Constants;

public class InsideLocationListener implements LocationListener {

    @Override
    public void onLocationChanged(@NonNull Location location) {
        Log.d(Constants.TAG, String.format("location changed lat: [%s] lng: [%s]", location.getLatitude(), location.getLongitude()));
    }

    @Override
    public void onLocationChanged(@NonNull List<Location> locations) {
        Log.d(Constants.TAG, "locations changes");
        android.location.LocationListener.super.onLocationChanged(locations);
    }

    @Override
    public void onFlushComplete(int requestCode) {
        Log.d(Constants.TAG, "flush completed");
        android.location.LocationListener.super.onFlushComplete(requestCode);
    }

    @Override
    public void onProviderEnabled(@NonNull String provider) {
        Log.d(Constants.TAG, String.format("provider enabled: %s", provider));
        android.location.LocationListener.super.onProviderEnabled(provider);
    }

    @Override
    public void onProviderDisabled(@NonNull String provider) {
        Log.d(Constants.TAG, String.format("provider disabled: %s", provider));
        android.location.LocationListener.super.onProviderDisabled(provider);
    }

}
