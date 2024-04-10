package co.itfusion.models.endpoint.location;

import java.io.Serializable;
import java.util.Date;

public class Location implements Serializable {
    protected String event = "motioncharge";
    protected boolean is_moving = true;
    protected String uuid;
    protected String timestamp;
    protected int age = 82;
    protected int odometer = 0;
    protected Coords coords;

    protected Activity activity;
    protected Battery battery;
    protected Extras extras;

    public Location() {
        this.coords = new Coords();
        this.activity = new Activity();
        this.battery = new Battery();
        this.extras = new Extras();
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public boolean isIs_moving() {
        return is_moving;
    }

    public void setIs_moving(boolean is_moving) {
        this.is_moving = is_moving;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getOdometer() {
        return odometer;
    }

    public void setOdometer(int odometer) {
        this.odometer = odometer;
    }

    public Coords getCoords() {
        return coords;
    }

    public void setCoords(Coords coords) {
        this.coords = coords;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public Battery getBattery() {
        return battery;
    }

    public void setBattery(Battery battery) {
        this.battery = battery;
    }

    public Extras getExtras() {
        return extras;
    }

    public void setExtras(Extras extras) {
        this.extras = extras;
    }
}
