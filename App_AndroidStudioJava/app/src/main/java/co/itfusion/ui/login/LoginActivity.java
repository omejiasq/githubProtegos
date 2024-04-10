package co.itfusion.ui.login;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import java.io.IOException;

import co.itfusion.assets.InputWatcher;
import co.itfusion.data.Control;
import co.itfusion.data.EndPoint;
import co.itfusion.dima.databinding.ActivityLoginBinding;
import co.itfusion.interfaces.IBlockUI;
import co.itfusion.interfaces.ISetup;
import co.itfusion.utils.Constants;
import co.itfusion.utils.Navigation;
import co.itfusion.utils.Permissions;
import co.itfusion.utils.Utils;
import co.itfusion.utils.Validation;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class LoginActivity extends AppCompatActivity implements ISetup , IBlockUI {

    private final Context context = this;
    private final Activity activity = this;

    private ActivityLoginBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityLoginBinding.inflate(activity.getLayoutInflater());
        setContentView(binding.getRoot());
        setDependencies();
    }

    @Override
    public void setDependencies() {
        if(getSupportActionBar() != null) getSupportActionBar().hide();

        Utils.UI.setupStatusBar(activity, context);
        hideBlockUI();

        setClickEvents();
        setInputEvents();
    }

    @Override
    public void setClickEvents() {
        binding.btnLogin.setOnClickListener(view -> validateAndLogin());

        binding.btnLoginRecovery.setOnClickListener(view -> Navigation.recoverAccountMenu(context));
        binding.btnCreateAccount.setOnClickListener(view -> Navigation.createAccountMenu(context));
    }

    @Override
    public void setInputEvents() {
        binding.etUserLogin.addTextChangedListener(new InputWatcher(null, binding.tilUserLogin));
        binding.etPasswordLogin.addTextChangedListener(new InputWatcher(null, binding.tilPasswordLogin));
    }

    @Override
    public void showBlockUI(@Nullable String message) {
        if(message != null) binding.block.tvBlockMessage.setText(message);

        binding.block.getRoot().setVisibility(View.VISIBLE);

        binding.tilUserLogin.setEnabled(false);
        binding.tilPasswordLogin.setEnabled(false);
        binding.btnLogin.setEnabled(false);

    }

    @Override
    public void hideBlockUI() {
        binding.block.getRoot().setVisibility(View.GONE);

        binding.tilUserLogin.setEnabled(true);
        binding.tilPasswordLogin.setEnabled(true);
        binding.btnLogin.setEnabled(true);
    }

    private boolean isRequestedDataValid() {
        try {
            Validation.validateInput(context, binding.etUserLogin.getEditableText(), Validation.MIN_LENGTH);
        } catch (Exception e) {
            binding.tilUserLogin.setError(e.getMessage());
            return false;
        }

        try {
            Validation.validateInput(context, binding.etPasswordLogin.getEditableText(), Validation.MIN_LENGTH);
        } catch (Exception e) {
            binding.tilPasswordLogin.setError(e.getMessage());
            return false;
        }
        return true;
    }

    private void validateAndLogin() {
        if(isRequestedDataValid()) {
            String user = Validation.getInputData(context, binding.etUserLogin.getEditableText());
            String password = Validation.getInputData(context, binding.etPasswordLogin.getEditableText());

            if(Permissions.checkIsPermissionMissing(context, Permissions.PERMISSION_LOCATION)) {
                Permissions.requestLocationPermissions(activity);
            }
            else if (Permissions.isSdk29orUp()) {
                if(Permissions.checkIfLocationBackgroundPermissionIsRequired(context))
                    Permissions.requestLocationBackgroundPermission(activity);
                else if(Permissions.checkIfPostNotificationPermissionIsRequired(context))
                    Permissions.requestPostNotificationPermission(activity);
                else
                    login(user, password);
            }
            else
                login(user, password);
        }
    }

    private void login(String user, String password) {
        showBlockUI(null);
        OkHttpClient client = new OkHttpClient().newBuilder().build();

        MediaType mediaType = MediaType.parse(EndPoint.Type.X_WWW_FORM_URLENCODED);

        RequestBody body = RequestBody.create(mediaType, EndPoint.Login.getLogin(user, password));

        Request request = new Request.Builder()
                .url(EndPoint.Login.URL_LOGIN)
                .method(EndPoint.Request.POST, body)
                .addHeader(EndPoint.Type.CONTENT_TYPE, EndPoint.Type.X_WWW_FORM_URLENCODED)
                .build();

        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(@NonNull Call call, @NonNull IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(@NonNull Call call, @NonNull Response response) throws IOException {

                assert response.body() != null;
                final String endPointResponse = response.body().string();
                LoginActivity.this.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        hideBlockUI();
                        if(!endPointResponse.isEmpty()) {
                            Control.saveLoginProfile(context, endPointResponse);
                            Navigation.homeMenu(context);
                        } else
                            Log.d(Constants.TAG, "response is null");
                    }
                });

            }
        });

    }

}