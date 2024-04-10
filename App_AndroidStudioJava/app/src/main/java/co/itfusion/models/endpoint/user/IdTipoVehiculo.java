package co.itfusion.models.endpoint.user;

import java.io.Serializable;
import java.util.Date;

public class IdTipoVehiculo implements Serializable {
    public String id;
    public String ctr;
    public String tipo;
    public String clase;
    public String marca;
    public String linea;
    public String peso;
    public int kilometros_por_galon;
    public String cilindros;
    public String caballos_fuerza;
    public String cilindraje;
    public boolean activo;
    public String _id;
    public Date created_time;

    public IdTipoVehiculo() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCtr() {
        return ctr;
    }

    public void setCtr(String ctr) {
        this.ctr = ctr;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getLinea() {
        return linea;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getPeso() {
        return peso;
    }

    public void setPeso(String peso) {
        this.peso = peso;
    }

    public int getKilometros_por_galon() {
        return kilometros_por_galon;
    }

    public void setKilometros_por_galon(int kilometros_por_galon) {
        this.kilometros_por_galon = kilometros_por_galon;
    }

    public String getCilindros() {
        return cilindros;
    }

    public void setCilindros(String cilindros) {
        this.cilindros = cilindros;
    }

    public String getCaballos_fuerza() {
        return caballos_fuerza;
    }

    public void setCaballos_fuerza(String caballos_fuerza) {
        this.caballos_fuerza = caballos_fuerza;
    }

    public String getCilindraje() {
        return cilindraje;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }
}