package co.itfusion.adapters.list;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothDevice;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.content.res.AppCompatResources;

import com.google.android.material.textview.MaterialTextView;

import java.util.List;

import co.itfusion.dima.R;
import co.itfusion.models.main.Event;
import co.itfusion.utils.SerialUtils;
import co.itfusion.utils.Utils;

public class EventListAdapter extends ArrayAdapter<Event> {

    private final Context context;
    private final LayoutInflater layoutInflater;
    private final List<Event> eventList;
    private final int resourceId;

    public EventListAdapter(Context context, int resourceId, List<Event> eventList) {
        super(context, resourceId, eventList);
        this.context = context;
        this.eventList = eventList;
        this.layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.resourceId = resourceId;
    }

    @SuppressLint({"ViewHolder", "MissingPermission"})
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        convertView = layoutInflater.inflate(resourceId, null);

        Event event = eventList.get(position);

        if(event != null) {
            MaterialTextView title = convertView.findViewById(R.id.tvTitle);
            MaterialTextView subtitle = convertView.findViewById(R.id.tvSubtitle);
            View view = convertView.findViewById(R.id.vIcon);

            title.setText(Utils.getFormattedDate(event.getReport().getLocation().getTimestamp()));

            String isFall = event.getReport().getLocation().getExtras().getCaida();
            String isCollision = event.getReport().getLocation().getExtras().getColision();

            if(event.isSync())
                view.setBackground(AppCompatResources.getDrawable(context, R.drawable.icon_sync));
            else
                view.setBackground(AppCompatResources.getDrawable(context, R.drawable.icon_unsync));


            if(isFall.equals(SerialUtils.ONE)) {
                subtitle.setText(context.getString(R.string.fall));
            } else if(isCollision.equals(SerialUtils.ONE)) {
                subtitle.setText(context.getString(R.string.collision));
            } else {
                String level = String.format("%s: %s", context.getString(R.string.level), event.getReport().getLocation().getExtras().getGrado_alcohol());
                subtitle.setText(level);
            }
        }

        return convertView;
    }
}