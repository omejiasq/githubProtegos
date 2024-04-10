package co.itfusion.assets;

import android.text.Editable;
import android.text.TextWatcher;

import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

public class InputWatcher implements TextWatcher {

    private final TextInputEditText input;
    private final TextInputLayout layout;

    public InputWatcher(TextInputEditText input) {
        this.input = input;
        this.layout = null;
    }

    public InputWatcher(TextInputEditText input, TextInputLayout layout) {
        this.input = input;
        this.layout = layout;
    }

    @Override
    public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
        /*NOP*/
    }

    @Override
    public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
        if(input != null) input.setError(null);
        if(layout != null) layout.setError(null);
    }

    @Override
    public void afterTextChanged(Editable editable) {
        /*NOP*/
    }
}