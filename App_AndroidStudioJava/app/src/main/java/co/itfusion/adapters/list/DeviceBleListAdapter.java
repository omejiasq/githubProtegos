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
import java.util.List;

import co.itfusion.dima.R;

public class DeviceBleListAdapter extends ArrayAdapter<BluetoothDevice> {

    private final LayoutInflater layoutInflater;
    private final List<BluetoothDevice> devicesArrayList;
    private final int resourceId;

    public DeviceBleListAdapter(Context context, int resourceId, List<BluetoothDevice> devicesArrayList) {
        super(context, resourceId, devicesArrayList);
        this.devicesArrayList = devicesArrayList;
        this.layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.resourceId = resourceId;
    }

    @SuppressLint({"ViewHolder", "MissingPermission"})
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        convertView = layoutInflater.inflate(resourceId, null);

        BluetoothDevice bluetoothDevice = devicesArrayList.get(position);

        if(bluetoothDevice != null)
        {
            TextView deviceName = (TextView) convertView.findViewById(R.id.tvDeviceName);
            TextView deviceAddress = (TextView) convertView.findViewById(R.id.tvMacAddress);

            String name = (bluetoothDevice.getName() != null) ? bluetoothDevice.getName() : String.valueOf(R.string.hidden_name);
            String address = (bluetoothDevice.getAddress() != null) ? bluetoothDevice.getAddress() : String.valueOf(R.string.hidden_address);

            deviceName.setText(name);
            deviceAddress.setText(address);
        }

        return convertView;
    }
}
