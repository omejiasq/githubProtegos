package co.itfusion.models.endpoint.location;

import java.io.Serializable;

public class Activity implements Serializable {
    protected String type = "in_vehicle";
    protected int confidence = 100;

    public Activity() {
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getConfidence() {
        return confidence;
    }

    public void setConfidence(int confidence) {
        this.confidence = confidence;
    }
}
