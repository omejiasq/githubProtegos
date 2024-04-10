package co.itfusion.models.endpoint.location;

import java.io.Serializable;

public class Battery implements Serializable {
    protected boolean is_charging = false;
    protected double level = 1;

    public Battery() {
    }

    public Battery(double level) {
        this.level = level;
    }

    public boolean isIs_charging() {
        return is_charging;
    }

    public void setIs_charging(boolean is_charging) {
        this.is_charging = is_charging;
    }

    public double getLevel() {
        return level;
    }

    public void setLevel(double level) {
        this.level = level;
    }
}
