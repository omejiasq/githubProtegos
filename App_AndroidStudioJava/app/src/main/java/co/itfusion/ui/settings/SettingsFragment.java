package co.itfusion.ui.settings;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.content.res.AppCompatResources;
import androidx.fragment.app.Fragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;

import co.itfusion.data.Control;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.FragmentSettingsBinding;
import co.itfusion.interfaces.ISetup;
import co.itfusion.models.endpoint.user.RootUser;
import co.itfusion.services.ServiceMainDiadem;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Navigation;
import co.itfusion.utils.Utils;

public class SettingsFragment extends Fragment implements ISetup {

    private Context context;
    private Activity activity;
    private FragmentSettingsBinding binding;

    private RootUser user;
    private ServiceMainDiadem serviceMainDiadem;

    public SettingsFragment() {
        this.user = null;
    }

    public SettingsFragment(RootUser user) {
        this.user = user;
        this.serviceMainDiadem = null;
    }

    public SettingsFragment(RootUser user, ServiceMainDiadem serviceMainDiadem) {
        this.user = user;
        this.serviceMainDiadem = serviceMainDiadem;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        context = getContext();
        activity = getActivity();
    }

    @Override
    public void onResume() {
        super.onResume();
        if(user != null) {
            binding.profile.tvTitle.setText(String.format("%s %s", user.getData().getFirstName(), user.getData().getLastName()));
            binding.profile.tvSubtitle.setText(String.format("%s: %s", context.getString(R.string.email_2), user.getData().getUser().getEmail()));
            binding.profile.optionDescription3.setText(String.format("%s: %s", context.getString(R.string.country), user.getData().getUser().getCountry()));
        }
        else Log.d(Constants.TAG, "user is null");
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        binding = FragmentSettingsBinding.inflate(inflater, container, false);
        setDependencies();
        return binding.getRoot();
    }

    @Override
    public void setDependencies() {
        binding.profile.icon.setVisibility(View.INVISIBLE);
        binding.profile.optionDescription2.setVisibility(View.INVISIBLE);

        binding.option1.tvTitle.setText(context.getString(R.string.search_bluetooth));
        binding.option1.tvSubtitle.setText(context.getString(R.string.description_connection));

        binding.option2.vIcon.setBackground(AppCompatResources.getDrawable(context, R.drawable.icon_power));
        binding.option2.tvTitle.setText(context.getString(R.string.logout));
        binding.option2.tvSubtitle.setText(context.getString(R.string.description_logout));

        binding.option3.tvTitle.setText("Abrir Consola");
        binding.option3.tvSubtitle.setVisibility(View.INVISIBLE);

        setClickEvents();
    }

    @Override
    public void setClickEvents() {
        binding.option1.card.setOnClickListener(view -> {
                Navigation.searchBleDevices(context);
        });
        binding.option2.card.setOnClickListener(view -> alertLogout());
        binding.option3.card.setOnClickListener(view -> Navigation.console(context));
    }

    private void alertLogout() {
        AlertDialog alert = new MaterialAlertDialogBuilder(context)
                .setTitle(context.getString(R.string.logout))
                .setMessage(context.getString(R.string.message_logout))
                .setPositiveButton(context.getString(R.string.accept), (dialogInterface, i) -> {
                    try { logout(); }
                    catch (Exception e) {
                        Log.d(Constants.TAG, String.format("exception trying to logout: %s", e.getMessage()));
                        Utils.showToastMessage(context, context.getString(R.string.error_general_try_again));
                    }
                }).setNegativeButton(context.getString(R.string.cancel), null)
                .show();
        alert.show();
    }

    private void logout() {
        Control.clearSavedProfile(context);
        Control.clearAllEvents(context);
        Control.clearReports(context);
        Utils.showToastMessage(context, context.getString(R.string.good_bye));
        Navigation.splashMenu(context);
    }
}