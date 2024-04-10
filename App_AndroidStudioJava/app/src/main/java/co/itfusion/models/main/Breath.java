package co.itfusion.models.main;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Breath implements Serializable {

    protected List<Event> breathList;

    public Breath() {
    }

    public List<Event> getBreathList() {
        return breathList;
    }

    public void setBreathList(List<Event> breathList) {
        this.breathList = breathList;
    }

    public void addBreathToList(Event event) {
        if(this.breathList == null)
            this.breathList = new ArrayList<>();
        breathList.add(event);
    }
}
