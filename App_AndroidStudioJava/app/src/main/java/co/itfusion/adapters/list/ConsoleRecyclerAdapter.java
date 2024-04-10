package co.itfusion.adapters.list;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.textview.MaterialTextView;


import java.util.List;

import co.itfusion.dima.R;
import co.itfusion.models.main.ConsoleStream;
import co.itfusion.utils.Constants;

public class ConsoleRecyclerAdapter extends RecyclerView.Adapter<ConsoleRecyclerAdapter.ViewHolderData> {

    private final List<ConsoleStream> consoleStreamList;
    private final Context context;

    public ConsoleRecyclerAdapter(Context context, List<ConsoleStream> consoleStreamList) {
        Log.d(Constants.TAG, "Recycler Constructor");
        this.context = context;
        this.consoleStreamList = consoleStreamList;
    }

    public static class ViewHolderData extends RecyclerView.ViewHolder {
        private Context context;
        private View itemView;
        private MaterialTextView tvTimestamp, tvInfoReceived, tvStreamReceived;

        public ViewHolderData(@NonNull View itemView, Context context) {
            super(itemView);
            this.context = context;
            this.itemView = itemView;
            tvTimestamp = itemView.findViewById(R.id.tvTimestamp);
            tvInfoReceived = itemView.findViewById(R.id.tvInfoReceived);
            tvStreamReceived = itemView.findViewById(R.id.tvStreamReceived);
            Log.d(Constants.TAG, "View Holder Data configured");
        }

        @SuppressLint("UseCompatLoadingForDrawables")
        public void assignData(ConsoleStream consoleStream) {
            if(consoleStream == null) return;
            Log.d(Constants.TAG, "Recycler Assinging data");

            tvTimestamp.setText(consoleStream.getTimeStamp());
            tvInfoReceived.setText(consoleStream.getData());
            tvStreamReceived.setText(consoleStream.getStream());
        }
    }

    @SuppressLint("InflateParams")
    @NonNull
    @Override
    public ViewHolderData onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.list_item_console, parent, false);
        Log.d(Constants.TAG, "Recycler inflated");
        return new ViewHolderData(view, context);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolderData holder, int position) {
        Log.d(Constants.TAG, "Recycler binded");
        holder.assignData(consoleStreamList.get(position));
    }

    @Override
    public int getItemCount() {
        return consoleStreamList.size();
    }
}
