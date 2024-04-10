package co.itfusion.models.endpoint.location;

import java.io.Serializable;

public class Extras implements Serializable {

    protected int ayuda = 0;
    protected String smartphone_blocked = "0";
    protected String tipos_viajes = "Automáticos";
    protected String company;
    protected String userId;
    protected String grado_alcohol = "0";
    protected String con_alcoholemia = "0";
    protected String colision = "0";
    protected String caida = "0";
    protected String token;
    protected String x1 = "111111111";
    protected String y1 = "111111111";
    protected String z1 = "111111111";
    protected String m1 = "111111111";
    protected String data_report = "1111111111";

    public Extras() {
    }

    public int getAyuda() {
        return ayuda;
    }

    public void setAyuda(int ayuda) {
        this.ayuda = ayuda;
    }

    public String getSmartphone_blocked() {
        return smartphone_blocked;
    }

    public void setSmartphone_blocked(String smartphone_blocked) {
        this.smartphone_blocked = smartphone_blocked;
    }

    public String getTipos_viajes() {
        return tipos_viajes;
    }

    public void setTipos_viajes(String tipos_viajes) {
        this.tipos_viajes = tipos_viajes;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getGrado_alcohol() {
        return grado_alcohol;
    }

    public void setGrado_alcohol(String grado_alcohol) {
        this.grado_alcohol = grado_alcohol;
    }

    public String getCon_alcoholemia() {
        return con_alcoholemia;
    }

    public void setCon_alcoholemia(String con_alcoholemia) {
        this.con_alcoholemia = con_alcoholemia;
    }

    public String getColision() {
        return colision;
    }

    public void setColision(String colision) {
        this.colision = colision;
    }

    public String getCaida() {
        return caida;
    }

    public void setCaida(String caida) {
        this.caida = caida;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getX1() {
        return x1;
    }

    public void setX1(String x1) {
        this.x1 = x1;
    }

    public String getY1() {
        return y1;
    }

    public void setY1(String y1) {
        this.y1 = y1;
    }

    public String getZ1() {
        return z1;
    }

    public void setZ1(String z1) {
        this.z1 = z1;
    }

    public String getM1() {
        return m1;
    }

    public void setM1(String m1) {
        this.m1 = m1;
    }

    public String getData_report() {
        return data_report;
    }

    public void setData_report(String data_report) {
        this.data_report = data_report;
    }
}
