package co.itfusion.utils;

import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Color;
import android.location.Location;
import android.view.View;
import android.widget.Toast;

import com.google.android.material.color.MaterialColors;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class Utils {
    public static void showToastMessage(Context context, String message) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
    }

    public static double getDistanceFromLocations(Location currentLocation, Location previousLocation) {
        return currentLocation.distanceTo(previousLocation);
    }

    public static String getFormattedDate(String timeStamp) {
        ZonedDateTime utcDate = ZonedDateTime.parse(timeStamp);
        ZonedDateTime colombiaDate = utcDate.withZoneSameInstant(ZoneId.of("America/Bogota"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy-HH:mm");
        return colombiaDate.format(formatter);
  }

    public static class UI {
        private static void colorNavigationBar(Activity activity, Context context) {
            activity.getWindow()
                    .setNavigationBarColor(
                            MaterialColors.getColor(context, com.google.android.material.R.attr.colorSecondary, Color.BLACK));
        }

        public static void setUpStatusBarColor(Activity activity, Context context) {
            setupStatusBar(activity, context);
        }

        public static void setupStatusAndNavigationBar(Activity activity, Context context) {
            setupStatusBar(activity, context);
            colorNavigationBar(activity, context);
        }

        public static void setupStatusBar(Activity activity, Context context) {
            int nightModeFlags =
                    context.getResources().getConfiguration().uiMode &
                            Configuration.UI_MODE_NIGHT_MASK;

            switch (nightModeFlags) {
                case Configuration.UI_MODE_NIGHT_YES:
                    colorStatusBar(activity,
                            MaterialColors.getColor(context, androidx.appcompat.R.attr.colorPrimary, Color.BLACK),
                            activity.getWindow().getDecorView().getSystemUiVisibility() & ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
                    break;
                case Configuration.UI_MODE_NIGHT_NO:
                    colorStatusBar(activity,
                            Color.WHITE,
                            View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
                    break;

                case Configuration.UI_MODE_NIGHT_UNDEFINED:
                    //TODO: check what we can do
                    break;
            }
        }

        private static void colorStatusBar(Activity activity, int color, int visibility) {
            activity.getWindow().setStatusBarColor(color);
            activity.getWindow().getDecorView().setSystemUiVisibility(visibility);
        }
    }
}
