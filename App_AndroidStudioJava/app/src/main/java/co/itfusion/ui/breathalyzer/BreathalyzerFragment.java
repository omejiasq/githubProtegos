package co.itfusion.ui.breathalyzer;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

import co.itfusion.adapters.list.EventListAdapter;
import co.itfusion.data.Control;
import co.itfusion.dima.R;
import co.itfusion.dima.databinding.FragmentWrecksBinding;
import co.itfusion.interfaces.IBlockUI;
import co.itfusion.interfaces.ISetup;
import co.itfusion.models.main.Breath;
import co.itfusion.models.main.Collision;
import co.itfusion.models.main.Event;
import co.itfusion.models.main.Fall;

public class BreathalyzerFragment extends Fragment implements ISetup, IBlockUI {

    private Context context;
    private Activity activity;
    private FragmentWrecksBinding binding;
    private EventListAdapter eventListAdapter;
    private List<Event> breathList;

    public BreathalyzerFragment() {
        // Required empty public constructor
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
        Breath eventsBreath = Control.getBreathSaved(activity);
        breathList.clear();

        if(eventsBreath != null) {
            hideBlockUI();
            breathList.addAll(eventsBreath.getBreathList());
        }
        else
            showBlockUI(null);

        eventListAdapter.notifyDataSetChanged();
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        binding = FragmentWrecksBinding.inflate(inflater, container, false);
        setDependencies();
        return binding.getRoot();
    }

    @Override
    public void setDependencies() {
        showBlockUI(null);
        breathList = new ArrayList<>();
        eventListAdapter = new EventListAdapter(context, R.layout.layout_card_text_icon, breathList);
        binding.lvWrecks.setAdapter(eventListAdapter);
    }

    @Override
    public void showBlockUI(@Nullable String message) {
        binding.lvWrecks.setVisibility(View.GONE);
        binding.tvStatus.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideBlockUI() {
        binding.lvWrecks.setVisibility(View.VISIBLE);
        binding.tvStatus.setVisibility(View.GONE);
    }
}