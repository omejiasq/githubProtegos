package co.itfusion.models.main;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Collision implements Serializable {
    protected List<Event> collisionList;

    public Collision() {
    }

    public List<Event> getCollisionList() {
        return collisionList;
    }

    public void setCollisionList(List<Event> collisionList) {
        this.collisionList = collisionList;
    }

    public void addCollisionToList(Event event) {
        if(this.collisionList == null)
            this.collisionList = new ArrayList<>();

        this.collisionList.add(event);
    }
}
