package co.itfusion.models.main;

import java.io.Serializable;

import co.itfusion.models.endpoint.location.RootReport;

public class Event implements Serializable {
    protected boolean isSync = false;
    protected RootReport report;

    public Event() {
    }

    public Event(RootReport report) {
        this.report = report;
    }

    public boolean isSync() {
        return isSync;
    }

    public void setSync(boolean sync) {
        isSync = sync;
    }

    public RootReport getReport() {
        return report;
    }

    public void setReport(RootReport report) {
        this.report = report;
    }
}
