package co.itfusion.models.main;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Fall implements Serializable {
    protected List<Event> fallingList;

    public Fall() {
    }

    public List<Event> getFallingList() {
        return fallingList;
    }

    public void setFallingList(List<Event> fallingList) {
        this.fallingList = fallingList;
    }

    public void addFallingToList(Event event) {
        if(this.fallingList == null)
            this.fallingList = new ArrayList<>();

        this.fallingList.add(event);
    }
}
