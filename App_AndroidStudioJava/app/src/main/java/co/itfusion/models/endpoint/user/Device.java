package co.itfusion.models.endpoint.user;

import java.io.Serializable;
import java.util.Date;

public class Device implements Serializable {
    public String status;
    public double lat;
    public double lng;
    public double last_lat;
    public double last_lng;
    public int geocerca_radio;
    public int geocerca_lat;
    public int geocerca_lng;
    public boolean ayuda;
    public Date created_time;
    public boolean trash;
    public Date last_location;
    public boolean defaultDevice;
    public String orden;
    public int velocidad_maxima_ciudad;
    public int velocidad_maxima_carril_simple_nacionales;
    public int velocidad_maxima_doble_carril_nacionales;
    public int seguimiento_metros;
    public int id_viaje_actual;
    public int cantidad_actual_frenadas_bruscas;
    public int cantidad_actual_aceleradas_bruscas;
    public int estado_viaje_actual;
    public int cantidad_locations;
    public int cantidad_locations_actual;
    public int cantidad_locations_viaje_actual;
    public double odometro;
    public int cantidad_exceso_velocidad;
    public double ultima_velocidad;
    public int hubo_evento_anomalo_antes;
    public String _id;
    public String device;
    public String nro_device;
    public String nro_sim;
    public String nro_imei;
    public String type;
    public String userId;
    public int deviceNumber;
    public String telefono1;
    public String telefono2;
    public String telefono3;
    public String telefono4;
    public String telefono5;
    public int velocidad;
    public Date last_ayuda;
    public String tipo_servicio;
    public Date fecha_hora_fin;
    public String municipio_inicial;
    public double total_velocidad;
    public String municipio_final;
    public Date fecha_hora_inicio;
    public String viajeId;
    public IdTipoVehiculo id_tipo_vehiculo;
    public Date edit_time_odometer;
    public Date edit_time;
    public int kilometraje_inicial;
    public int modelo;
    public String serial;
    public String uniqueToken;
    public String no_placa;

    public Device() {
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    public double getLast_lat() {
        return last_lat;
    }

    public void setLast_lat(double last_lat) {
        this.last_lat = last_lat;
    }

    public double getLast_lng() {
        return last_lng;
    }

    public void setLast_lng(double last_lng) {
        this.last_lng = last_lng;
    }

    public int getGeocerca_radio() {
        return geocerca_radio;
    }

    public void setGeocerca_radio(int geocerca_radio) {
        this.geocerca_radio = geocerca_radio;
    }

    public int getGeocerca_lat() {
        return geocerca_lat;
    }

    public void setGeocerca_lat(int geocerca_lat) {
        this.geocerca_lat = geocerca_lat;
    }

    public int getGeocerca_lng() {
        return geocerca_lng;
    }

    public void setGeocerca_lng(int geocerca_lng) {
        this.geocerca_lng = geocerca_lng;
    }

    public boolean isAyuda() {
        return ayuda;
    }

    public void setAyuda(boolean ayuda) {
        this.ayuda = ayuda;
    }

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    public boolean isTrash() {
        return trash;
    }

    public void setTrash(boolean trash) {
        this.trash = trash;
    }

    public Date getLast_location() {
        return last_location;
    }

    public void setLast_location(Date last_location) {
        this.last_location = last_location;
    }

    public boolean isDefaultDevice() {
        return defaultDevice;
    }

    public void setDefaultDevice(boolean defaultDevice) {
        this.defaultDevice = defaultDevice;
    }

    public String getOrden() {
        return orden;
    }

    public void setOrden(String orden) {
        this.orden = orden;
    }

    public int getVelocidad_maxima_ciudad() {
        return velocidad_maxima_ciudad;
    }

    public void setVelocidad_maxima_ciudad(int velocidad_maxima_ciudad) {
        this.velocidad_maxima_ciudad = velocidad_maxima_ciudad;
    }

    public int getVelocidad_maxima_carril_simple_nacionales() {
        return velocidad_maxima_carril_simple_nacionales;
    }

    public void setVelocidad_maxima_carril_simple_nacionales(int velocidad_maxima_carril_simple_nacionales) {
        this.velocidad_maxima_carril_simple_nacionales = velocidad_maxima_carril_simple_nacionales;
    }

    public int getVelocidad_maxima_doble_carril_nacionales() {
        return velocidad_maxima_doble_carril_nacionales;
    }

    public void setVelocidad_maxima_doble_carril_nacionales(int velocidad_maxima_doble_carril_nacionales) {
        this.velocidad_maxima_doble_carril_nacionales = velocidad_maxima_doble_carril_nacionales;
    }

    public int getSeguimiento_metros() {
        return seguimiento_metros;
    }

    public void setSeguimiento_metros(int seguimiento_metros) {
        this.seguimiento_metros = seguimiento_metros;
    }

    public int getId_viaje_actual() {
        return id_viaje_actual;
    }

    public void setId_viaje_actual(int id_viaje_actual) {
        this.id_viaje_actual = id_viaje_actual;
    }

    public int getCantidad_actual_frenadas_bruscas() {
        return cantidad_actual_frenadas_bruscas;
    }

    public void setCantidad_actual_frenadas_bruscas(int cantidad_actual_frenadas_bruscas) {
        this.cantidad_actual_frenadas_bruscas = cantidad_actual_frenadas_bruscas;
    }

    public int getCantidad_actual_aceleradas_bruscas() {
        return cantidad_actual_aceleradas_bruscas;
    }

    public void setCantidad_actual_aceleradas_bruscas(int cantidad_actual_aceleradas_bruscas) {
        this.cantidad_actual_aceleradas_bruscas = cantidad_actual_aceleradas_bruscas;
    }

    public int getEstado_viaje_actual() {
        return estado_viaje_actual;
    }

    public void setEstado_viaje_actual(int estado_viaje_actual) {
        this.estado_viaje_actual = estado_viaje_actual;
    }

    public int getCantidad_locations() {
        return cantidad_locations;
    }

    public void setCantidad_locations(int cantidad_locations) {
        this.cantidad_locations = cantidad_locations;
    }

    public int getCantidad_locations_actual() {
        return cantidad_locations_actual;
    }

    public void setCantidad_locations_actual(int cantidad_locations_actual) {
        this.cantidad_locations_actual = cantidad_locations_actual;
    }

    public int getCantidad_locations_viaje_actual() {
        return cantidad_locations_viaje_actual;
    }

    public void setCantidad_locations_viaje_actual(int cantidad_locations_viaje_actual) {
        this.cantidad_locations_viaje_actual = cantidad_locations_viaje_actual;
    }

    public double getOdometro() {
        return odometro;
    }

    public void setOdometro(double odometro) {
        this.odometro = odometro;
    }

    public int getCantidad_exceso_velocidad() {
        return cantidad_exceso_velocidad;
    }

    public void setCantidad_exceso_velocidad(int cantidad_exceso_velocidad) {
        this.cantidad_exceso_velocidad = cantidad_exceso_velocidad;
    }

    public double getUltima_velocidad() {
        return ultima_velocidad;
    }

    public void setUltima_velocidad(double ultima_velocidad) {
        this.ultima_velocidad = ultima_velocidad;
    }

    public int getHubo_evento_anomalo_antes() {
        return hubo_evento_anomalo_antes;
    }

    public void setHubo_evento_anomalo_antes(int hubo_evento_anomalo_antes) {
        this.hubo_evento_anomalo_antes = hubo_evento_anomalo_antes;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getNro_device() {
        return nro_device;
    }

    public void setNro_device(String nro_device) {
        this.nro_device = nro_device;
    }

    public String getNro_sim() {
        return nro_sim;
    }

    public void setNro_sim(String nro_sim) {
        this.nro_sim = nro_sim;
    }

    public String getNro_imei() {
        return nro_imei;
    }

    public void setNro_imei(String nro_imei) {
        this.nro_imei = nro_imei;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getDeviceNumber() {
        return deviceNumber;
    }

    public void setDeviceNumber(int deviceNumber) {
        this.deviceNumber = deviceNumber;
    }

    public String getTelefono1() {
        return telefono1;
    }

    public void setTelefono1(String telefono1) {
        this.telefono1 = telefono1;
    }

    public String getTelefono2() {
        return telefono2;
    }

    public void setTelefono2(String telefono2) {
        this.telefono2 = telefono2;
    }

    public String getTelefono3() {
        return telefono3;
    }

    public void setTelefono3(String telefono3) {
        this.telefono3 = telefono3;
    }

    public String getTelefono4() {
        return telefono4;
    }

    public void setTelefono4(String telefono4) {
        this.telefono4 = telefono4;
    }

    public String getTelefono5() {
        return telefono5;
    }

    public void setTelefono5(String telefono5) {
        this.telefono5 = telefono5;
    }

    public int getVelocidad() {
        return velocidad;
    }

    public void setVelocidad(int velocidad) {
        this.velocidad = velocidad;
    }

    public Date getLast_ayuda() {
        return last_ayuda;
    }

    public void setLast_ayuda(Date last_ayuda) {
        this.last_ayuda = last_ayuda;
    }

    public String getTipo_servicio() {
        return tipo_servicio;
    }

    public void setTipo_servicio(String tipo_servicio) {
        this.tipo_servicio = tipo_servicio;
    }

    public Date getFecha_hora_fin() {
        return fecha_hora_fin;
    }

    public void setFecha_hora_fin(Date fecha_hora_fin) {
        this.fecha_hora_fin = fecha_hora_fin;
    }

    public String getMunicipio_inicial() {
        return municipio_inicial;
    }

    public void setMunicipio_inicial(String municipio_inicial) {
        this.municipio_inicial = municipio_inicial;
    }

    public double getTotal_velocidad() {
        return total_velocidad;
    }

    public void setTotal_velocidad(double total_velocidad) {
        this.total_velocidad = total_velocidad;
    }

    public String getMunicipio_final() {
        return municipio_final;
    }

    public void setMunicipio_final(String municipio_final) {
        this.municipio_final = municipio_final;
    }

    public Date getFecha_hora_inicio() {
        return fecha_hora_inicio;
    }

    public void setFecha_hora_inicio(Date fecha_hora_inicio) {
        this.fecha_hora_inicio = fecha_hora_inicio;
    }

    public String getViajeId() {
        return viajeId;
    }

    public void setViajeId(String viajeId) {
        this.viajeId = viajeId;
    }

    public IdTipoVehiculo getId_tipo_vehiculo() {
        return id_tipo_vehiculo;
    }

    public void setId_tipo_vehiculo(IdTipoVehiculo id_tipo_vehiculo) {
        this.id_tipo_vehiculo = id_tipo_vehiculo;
    }

    public Date getEdit_time_odometer() {
        return edit_time_odometer;
    }

    public void setEdit_time_odometer(Date edit_time_odometer) {
        this.edit_time_odometer = edit_time_odometer;
    }

    public Date getEdit_time() {
        return edit_time;
    }

    public void setEdit_time(Date edit_time) {
        this.edit_time = edit_time;
    }

    public int getKilometraje_inicial() {
        return kilometraje_inicial;
    }

    public void setKilometraje_inicial(int kilometraje_inicial) {
        this.kilometraje_inicial = kilometraje_inicial;
    }

    public int getModelo() {
        return modelo;
    }

    public void setModelo(int modelo) {
        this.modelo = modelo;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getUniqueToken() {
        return uniqueToken;
    }

    public void setUniqueToken(String uniqueToken) {
        this.uniqueToken = uniqueToken;
    }

    public String getNo_placa() {
        return no_placa;
    }

    public void setNo_placa(String no_placa) {
        this.no_placa = no_placa;
    }
}