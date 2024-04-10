package co.itfusion.models.main;

import java.io.Serializable;

public class ConsoleStream implements Serializable {
    protected String timeStamp;
    protected String stream;
    protected String data;

    public ConsoleStream(String timeStamp, String stream, String data) {
        this.timeStamp = timeStamp;
        this.stream = stream;
        this.data = data;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getStream() {
        return stream;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
