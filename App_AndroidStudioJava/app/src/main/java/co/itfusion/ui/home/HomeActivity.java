package co.itfusion.ui.home;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.work.BackoffPolicy;
import androidx.work.OneTimeWorkRequest;
import androidx.work.WorkManager;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;

import com.google.android.material.navigation.NavigationBarView;

import java.util.concurrent.TimeUnit;

import co.itfusion.data.Control;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.ActivityHomeBinding;
import co.itfusion.interfaces.IBlockUI;
import co.itfusion.interfaces.ISetup;
import co.itfusion.models.endpoint.user.RootUser;
import co.itfusion.models.main.Reports;
import co.itfusion.services.LocationWork;
import co.itfusion.services.ServiceMainDiadem;
import co.itfusion.ui.breathalyzer.BreathalyzerFragment;
import co.itfusion.ui.dashboard.DashboardFragment;
import co.itfusion.ui.security.SecurityFragment;
import co.itfusion.ui.settings.SettingsFragment;
import co.itfusion.ui.wrecks.WrecksFragment;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Permissions;
import co.itfusion.utils.Utils;

public class HomeActivity extends AppCompatActivity implements ISetup, IBlockUI, ServiceConnection {

    private final Context context = this;
    private final Activity activity = this;
    private ActivityHomeBinding binding;
    private RootUser user;
    private Reports reports;

    private Intent intent;
    private ServiceMainDiadem serviceMainDiadem;
//    private LocationCallback locationCallback;
//    private FusedLocationProviderClient fusedLocationProviderClient;

//    private Location lastKnownLocation = null;

    private final Handler handler = new Handler();

    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityHomeBinding.inflate(activity.getLayoutInflater());
        setContentView(binding.getRoot());

        if(Permissions.checkIsPermissionMissing(context, Permissions.PERMISSION_LOCATION)) {
            Permissions.requestLocationPermissions(activity);
        } else {
            intent = new Intent(context, ServiceMainDiadem.class);
            bindService(intent, (ServiceConnection) context, Context.BIND_AUTO_CREATE);
            startService(intent);
        }

        setDependencies();
    }

    @Override
    protected void onResume() {
        super.onResume();

        if(Permissions.checkIsPermissionMissing(context, Permissions.PERMISSION_LOCATION)) {
            Permissions.requestLocationPermissions(activity);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        try { unbindService(this); }
        catch (Exception ignored) { /*NOP*/ }

        try { stopService(intent); }
        catch (Exception ignored) { /*NOP*/ }
    }

    @Override
    public void setDependencies() {
        if(getSupportActionBar() != null)
            getSupportActionBar().hide();

        Utils.UI.setupStatusBar(activity, context);
        hideBlockUI();

        user = Control.getSavedProfile(activity);

        replaceFragment(new DashboardFragment(user, serviceMainDiadem));
        binding.bnvMainActivity.setSelectedItemId(R.id.menu_item_home);
        setClickEvents();
    }

    @Override
    public void setClickEvents() {
        binding.bnvMainActivity.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @SuppressLint("NonConstantResourceId")
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                switch (item.getItemId()) {
                    case R.id.menu_item_wrecks:
                        replaceFragment(new WrecksFragment());
                        break;
                    case R.id.menu_item_alcohol:
                        replaceFragment(new BreathalyzerFragment());
                        break;
                    case R.id.menu_item_reports:
                        replaceFragment(new SecurityFragment());
                        break;
                    case R.id.menu_item_config:
                        replaceFragment(new SettingsFragment(user));
                        break;
                    case R.id.menu_item_home:
                    default:
                        replaceFragment(new DashboardFragment(user, serviceMainDiadem));
                }
                return true;
            }
        });
    }

    @Override
    public void showBlockUI(@Nullable String message) {
        if(message != null) binding.block.tvBlockMessage.setText(message);
        binding.block.getRoot().setVisibility(View.VISIBLE);

        binding.bnvMainActivity.setEnabled(false);
        binding.flMainActivity.setEnabled(false);
    }

    @Override
    public void hideBlockUI() {
        binding.block.getRoot().setVisibility(View.GONE);

        binding.bnvMainActivity.setEnabled(true);
        binding.flMainActivity.setEnabled(true);
    }

    private void startLocationWork() {
        OneTimeWorkRequest foregroundWorkRequest = new OneTimeWorkRequest.Builder(LocationWork.class)
                .addTag(Constants.Values.LOCATION_WORK)
                .setBackoffCriteria(
                        BackoffPolicy.LINEAR,
                        OneTimeWorkRequest.MIN_BACKOFF_MILLIS,
                        TimeUnit.SECONDS
                ).build();

        WorkManager.getInstance(context).enqueue(foregroundWorkRequest);
    }

    private void replaceFragment(Fragment fragment) {
        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.replace(R.id.flMainActivity, fragment);
        fragmentTransaction.commit();
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        Log.d(Constants.TAG, "Service connected");
        serviceMainDiadem = ((ServiceMainDiadem.SerialBinder) service ).getService();
        Log.d(Constants.TAG, String.format("service internet connection status bluetooth: %s", serviceMainDiadem.isBluetoothConnected()));
        Log.d(Constants.TAG, String.format("service internet connection status warming: %s", serviceMainDiadem.isWarmingSensor()));
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        Log.d(Constants.TAG, "service disconnected");
    }
}