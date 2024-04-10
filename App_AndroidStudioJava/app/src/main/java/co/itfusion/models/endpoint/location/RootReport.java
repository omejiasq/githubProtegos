package co.itfusion.models.endpoint.location;

import java.io.Serializable;

public class RootReport  implements Serializable {

    protected Location location;

    public RootReport() {
        this.location = new Location();
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }
}
