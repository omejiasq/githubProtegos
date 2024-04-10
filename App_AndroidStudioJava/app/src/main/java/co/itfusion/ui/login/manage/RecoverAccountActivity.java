package co.itfusion.ui.login.manage;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;

import co.itfusion.dima.R;
import co.itfusion.dima.databinding.ActivityRecoverAccountBinding;
import co.itfusion.interfaces.ISetup;
import co.itfusion.utils.Navigation;
import co.itfusion.utils.Utils;

public class RecoverAccountActivity extends AppCompatActivity implements ISetup {

    private final Context context = this;
    private final Activity activity = this;
    private ActivityRecoverAccountBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityRecoverAccountBinding.inflate(activity.getLayoutInflater());
        setContentView(binding.getRoot());
        setDependencies();
    }

    @Override
    public void setDependencies() {
        if(getSupportActionBar() != null) getSupportActionBar().hide();
        binding.header.tvHeaderTitle.setVisibility(View.GONE);
        binding.header.tvHeaderSubtitle.setVisibility(View.GONE);
        setClickEvents();
    }

    @Override
    public void setClickEvents() {
        binding.btnRecoverAccount.setOnClickListener(view -> Utils.showToastMessage(context, context.getString(R.string.message_function_disabled)));
        binding.header.btnBack.setOnClickListener(view -> finish());
    }
}