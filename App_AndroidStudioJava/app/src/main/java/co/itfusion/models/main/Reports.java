package co.itfusion.models.main;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import co.itfusion.models.endpoint.location.RootReport;

public class Reports implements Serializable {
    protected List<Event> reportList;

    public Reports() {
    }

    public List<Event> getReportList() {
        return reportList;
    }

    public void setReportList(List<Event> reportList) {
        this.reportList = reportList;
    }

    public void addReportToList(Event event) {
        if(event == null) return;
        if(reportList == null) reportList = new ArrayList<>();
        reportList.add(event);
    }
}
