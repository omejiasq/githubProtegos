package co.itfusion.utils;

import android.content.Context;
import android.text.Editable;

import co.itfusion.dima.R;

public class Validation {

    public static int NO_LENGTH = 0;
    public static int MIN_LENGTH = 4;
    public static int SHORT_LENGTH = 8;
    public static int MEDIUM_LENGTH = 12;
    public static int LONG_LENGTH = 18;
    public static int MAX_LENGTH = 22;


    public static void validateInput(Context context, Editable editable, int minLen, int maxLen) throws Exception {
        try { validateInput(context, editable); }
        catch (Exception e) { throw new Exception(e.getMessage()); }
        try { validateInput(context, editable, minLen); }
        catch (Exception e) { throw new Exception(e.getMessage()); }
        String value = getInputData(context, editable);
        if(value.length() > maxLen)
            throw new Exception(context.getString(R.string.error_max_length));
    }

    public static void validateInput(Context context, Editable editable, int minLen) throws Exception {
        try { validateInput(context, editable); }
        catch (Exception e) { throw new Exception(e.getMessage()); }
        String value = getInputData(context, editable);
        if(value.length() < minLen)
            throw new Exception(context.getString(R.string.error_min_length));
    }

    public static void validateInput(Context context, Editable editable) throws Exception {
        if(editable == null)
            throw new Exception(context.getString(R.string.error_null));
        else if(editable.toString().isEmpty() || editable.toString().length() == 0)
            throw new Exception(context.getString(R.string.error_empty));
    }

    public static void validateDropdown(Context context, Editable editable) throws Exception {
        if(editable == null)
            throw new Exception(context.getString(R.string.error_null));
        else if(editable.toString().isEmpty() || editable.toString().length() == 0)
            throw new Exception(context.getString(R.string.error_empty));
    }

    public static String getInputData(Context context, Editable editable) {
        return editable.toString().trim();
    }

}
