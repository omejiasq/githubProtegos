package co.itfusion.models.endpoint.user;

import java.io.Serializable;
import java.util.ArrayList;

public class RootUser implements Serializable {
    public String message;
    public Data data;
    public ArrayList<Device> devices;
    public String tipos_viajes;
    public int viaje_pendiente;

    public RootUser() {
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public ArrayList<Device> getDevices() {
        return devices;
    }

    public void setDevices(ArrayList<Device> devices) {
        this.devices = devices;
    }

    public String getTipos_viajes() {
        return tipos_viajes;
    }

    public void setTipos_viajes(String tipos_viajes) {
        this.tipos_viajes = tipos_viajes;
    }

    public int getViaje_pendiente() {
        return viaje_pendiente;
    }

    public void setViaje_pendiente(int viaje_pendiente) {
        this.viaje_pendiente = viaje_pendiente;
    }
}
