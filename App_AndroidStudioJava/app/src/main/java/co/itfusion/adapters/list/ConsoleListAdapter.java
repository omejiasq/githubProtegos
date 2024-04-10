package co.itfusion.adapters.list;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.content.res.AppCompatResources;

import com.google.android.material.textview.MaterialTextView;

import java.util.List;

import co.itfusion.dima.R;
import co.itfusion.models.main.ConsoleStream;
import co.itfusion.utils.Constants;
import co.itfusion.utils.SerialUtils;
import co.itfusion.utils.Utils;

public class ConsoleListAdapter extends ArrayAdapter<ConsoleStream> {

    private final Context context;
    private final LayoutInflater layoutInflater;
    private final List<ConsoleStream> consoleStreamList;
    private final int resourceId;

    public ConsoleListAdapter(Context context, int resourceId, List<ConsoleStream> consoleStreamList) {
        super(context, resourceId, consoleStreamList);
        this.context = context;
        this.consoleStreamList = consoleStreamList;
        this.layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.resourceId = resourceId;
    }

    @SuppressLint({"ViewHolder", "MissingPermission"})
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        convertView = layoutInflater.inflate(resourceId, null);

        ConsoleStream consoleStream = consoleStreamList.get(position);

        if(consoleStream != null) {
            MaterialTextView timeStamp = convertView.findViewById(R.id.tvTimestamp);
            MaterialTextView infoReceived = convertView.findViewById(R.id.tvInfoReceived);
            MaterialTextView streamReceived = convertView.findViewById(R.id.tvStreamReceived);

            timeStamp.setText(consoleStream.getTimeStamp());
            infoReceived.setText(consoleStream.getData());
            streamReceived.setText(consoleStream.getStream());
        }

        return convertView;
    }
}