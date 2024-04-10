package co.itfusion.models.endpoint.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class User implements Serializable {
    public String firstName;
    public String lastName;
    public String email;
    public boolean admin;
    public String country;
    public int maxUsers;
    public String rol;
    public String photo;
    public boolean enabled;
    public Date created_time;
    public String infectado;
    public String riesgo;
    public int documento;
    public String notificacioncorreo;
    public double lat;
    public double lng;
    public int seguimiento_metros;
    public int id_pais;
    public int no_minutos_viaje;
    public String gastos_obligatorio;
    public int id_viaje_actual;
    public String mobile;
    public int umbralAceleracionAccidente;
    public int velocidadFinalAccidente;
    public int velocidad_maxima_ciudad_privado;
    public int velocidad_maxima_carril_simple_nacionales_privado;
    public int velocidad_maxima_doble_carril_nacionales_privado;
    public int velocidad_maxima_ciudad_publico;
    public int velocidad_maxima_carril_simple_nacionales_publico;
    public int velocidad_maxima_doble_carril_nacionales_publico;
    public int zoom;
    public int valor_galon;
    public int valor_galon_gasolina;
    public int valor_galon_diesel;
    public int valor_gnv;
    public int total_viajes_usuario;
    public double total_kilometros_usuario;
    public int seleccionar_foto_galeria;
    public int mostrar_publicidad;
    public int crear_carvanas;
    public int modificar_usuarios_carvanas;
    public Date fecha_inicio_demo;
    public Date fecha_fin_demo;
    public int enviar_notificaciones_push;
    public int usuario_demo;
    public String _id;
    public String user;
    public String city;
    public Object expiration_date;
    public String company;
    public String salt;
    public String hash;
    public int __v;
    public Date edit_time;
    public Date fecha_nacimiento;
    public String genero;
    public String departamento;
    public ArrayList<Object> emails;
    public String id_region;
    public String tipoCompania;
    public String tipos_viajes;
    public String contactoNotificationEmail;
    public String contactoNotificationEmail2;
    public String contactoNotificationTelefono;
    public String contactoNotificationTelefono2;
    public ArrayList<Menu> menu;

    public User() {
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getMaxUsers() {
        return maxUsers;
    }

    public void setMaxUsers(int maxUsers) {
        this.maxUsers = maxUsers;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    public String getInfectado() {
        return infectado;
    }

    public void setInfectado(String infectado) {
        this.infectado = infectado;
    }

    public String getRiesgo() {
        return riesgo;
    }

    public void setRiesgo(String riesgo) {
        this.riesgo = riesgo;
    }

    public int getDocumento() {
        return documento;
    }

    public void setDocumento(int documento) {
        this.documento = documento;
    }

    public String getNotificacioncorreo() {
        return notificacioncorreo;
    }

    public void setNotificacioncorreo(String notificacioncorreo) {
        this.notificacioncorreo = notificacioncorreo;
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

    public int getSeguimiento_metros() {
        return seguimiento_metros;
    }

    public void setSeguimiento_metros(int seguimiento_metros) {
        this.seguimiento_metros = seguimiento_metros;
    }

    public int getId_pais() {
        return id_pais;
    }

    public void setId_pais(int id_pais) {
        this.id_pais = id_pais;
    }

    public int getNo_minutos_viaje() {
        return no_minutos_viaje;
    }

    public void setNo_minutos_viaje(int no_minutos_viaje) {
        this.no_minutos_viaje = no_minutos_viaje;
    }

    public String getGastos_obligatorio() {
        return gastos_obligatorio;
    }

    public void setGastos_obligatorio(String gastos_obligatorio) {
        this.gastos_obligatorio = gastos_obligatorio;
    }

    public int getId_viaje_actual() {
        return id_viaje_actual;
    }

    public void setId_viaje_actual(int id_viaje_actual) {
        this.id_viaje_actual = id_viaje_actual;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getUmbralAceleracionAccidente() {
        return umbralAceleracionAccidente;
    }

    public void setUmbralAceleracionAccidente(int umbralAceleracionAccidente) {
        this.umbralAceleracionAccidente = umbralAceleracionAccidente;
    }

    public int getVelocidadFinalAccidente() {
        return velocidadFinalAccidente;
    }

    public void setVelocidadFinalAccidente(int velocidadFinalAccidente) {
        this.velocidadFinalAccidente = velocidadFinalAccidente;
    }

    public int getVelocidad_maxima_ciudad_privado() {
        return velocidad_maxima_ciudad_privado;
    }

    public void setVelocidad_maxima_ciudad_privado(int velocidad_maxima_ciudad_privado) {
        this.velocidad_maxima_ciudad_privado = velocidad_maxima_ciudad_privado;
    }

    public int getVelocidad_maxima_carril_simple_nacionales_privado() {
        return velocidad_maxima_carril_simple_nacionales_privado;
    }

    public void setVelocidad_maxima_carril_simple_nacionales_privado(int velocidad_maxima_carril_simple_nacionales_privado) {
        this.velocidad_maxima_carril_simple_nacionales_privado = velocidad_maxima_carril_simple_nacionales_privado;
    }

    public int getVelocidad_maxima_doble_carril_nacionales_privado() {
        return velocidad_maxima_doble_carril_nacionales_privado;
    }

    public void setVelocidad_maxima_doble_carril_nacionales_privado(int velocidad_maxima_doble_carril_nacionales_privado) {
        this.velocidad_maxima_doble_carril_nacionales_privado = velocidad_maxima_doble_carril_nacionales_privado;
    }

    public int getVelocidad_maxima_ciudad_publico() {
        return velocidad_maxima_ciudad_publico;
    }

    public void setVelocidad_maxima_ciudad_publico(int velocidad_maxima_ciudad_publico) {
        this.velocidad_maxima_ciudad_publico = velocidad_maxima_ciudad_publico;
    }

    public int getVelocidad_maxima_carril_simple_nacionales_publico() {
        return velocidad_maxima_carril_simple_nacionales_publico;
    }

    public void setVelocidad_maxima_carril_simple_nacionales_publico(int velocidad_maxima_carril_simple_nacionales_publico) {
        this.velocidad_maxima_carril_simple_nacionales_publico = velocidad_maxima_carril_simple_nacionales_publico;
    }

    public int getVelocidad_maxima_doble_carril_nacionales_publico() {
        return velocidad_maxima_doble_carril_nacionales_publico;
    }

    public void setVelocidad_maxima_doble_carril_nacionales_publico(int velocidad_maxima_doble_carril_nacionales_publico) {
        this.velocidad_maxima_doble_carril_nacionales_publico = velocidad_maxima_doble_carril_nacionales_publico;
    }

    public int getZoom() {
        return zoom;
    }

    public void setZoom(int zoom) {
        this.zoom = zoom;
    }

    public int getValor_galon() {
        return valor_galon;
    }

    public void setValor_galon(int valor_galon) {
        this.valor_galon = valor_galon;
    }

    public int getValor_galon_gasolina() {
        return valor_galon_gasolina;
    }

    public void setValor_galon_gasolina(int valor_galon_gasolina) {
        this.valor_galon_gasolina = valor_galon_gasolina;
    }

    public int getValor_galon_diesel() {
        return valor_galon_diesel;
    }

    public void setValor_galon_diesel(int valor_galon_diesel) {
        this.valor_galon_diesel = valor_galon_diesel;
    }

    public int getValor_gnv() {
        return valor_gnv;
    }

    public void setValor_gnv(int valor_gnv) {
        this.valor_gnv = valor_gnv;
    }

    public int getTotal_viajes_usuario() {
        return total_viajes_usuario;
    }

    public void setTotal_viajes_usuario(int total_viajes_usuario) {
        this.total_viajes_usuario = total_viajes_usuario;
    }

    public double getTotal_kilometros_usuario() {
        return total_kilometros_usuario;
    }

    public void setTotal_kilometros_usuario(double total_kilometros_usuario) {
        this.total_kilometros_usuario = total_kilometros_usuario;
    }

    public int getSeleccionar_foto_galeria() {
        return seleccionar_foto_galeria;
    }

    public void setSeleccionar_foto_galeria(int seleccionar_foto_galeria) {
        this.seleccionar_foto_galeria = seleccionar_foto_galeria;
    }

    public int getMostrar_publicidad() {
        return mostrar_publicidad;
    }

    public void setMostrar_publicidad(int mostrar_publicidad) {
        this.mostrar_publicidad = mostrar_publicidad;
    }

    public int getCrear_carvanas() {
        return crear_carvanas;
    }

    public void setCrear_carvanas(int crear_carvanas) {
        this.crear_carvanas = crear_carvanas;
    }

    public int getModificar_usuarios_carvanas() {
        return modificar_usuarios_carvanas;
    }

    public void setModificar_usuarios_carvanas(int modificar_usuarios_carvanas) {
        this.modificar_usuarios_carvanas = modificar_usuarios_carvanas;
    }

    public Date getFecha_inicio_demo() {
        return fecha_inicio_demo;
    }

    public void setFecha_inicio_demo(Date fecha_inicio_demo) {
        this.fecha_inicio_demo = fecha_inicio_demo;
    }

    public Date getFecha_fin_demo() {
        return fecha_fin_demo;
    }

    public void setFecha_fin_demo(Date fecha_fin_demo) {
        this.fecha_fin_demo = fecha_fin_demo;
    }

    public int getEnviar_notificaciones_push() {
        return enviar_notificaciones_push;
    }

    public void setEnviar_notificaciones_push(int enviar_notificaciones_push) {
        this.enviar_notificaciones_push = enviar_notificaciones_push;
    }

    public int getUsuario_demo() {
        return usuario_demo;
    }

    public void setUsuario_demo(int usuario_demo) {
        this.usuario_demo = usuario_demo;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Object getExpiration_date() {
        return expiration_date;
    }

    public void setExpiration_date(Object expiration_date) {
        this.expiration_date = expiration_date;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public int get__v() {
        return __v;
    }

    public void set__v(int __v) {
        this.__v = __v;
    }

    public Date getEdit_time() {
        return edit_time;
    }

    public void setEdit_time(Date edit_time) {
        this.edit_time = edit_time;
    }

    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public ArrayList<Object> getEmails() {
        return emails;
    }

    public void setEmails(ArrayList<Object> emails) {
        this.emails = emails;
    }

    public String getId_region() {
        return id_region;
    }

    public void setId_region(String id_region) {
        this.id_region = id_region;
    }

    public String getTipoCompania() {
        return tipoCompania;
    }

    public void setTipoCompania(String tipoCompania) {
        this.tipoCompania = tipoCompania;
    }

    public String getTipos_viajes() {
        return tipos_viajes;
    }

    public void setTipos_viajes(String tipos_viajes) {
        this.tipos_viajes = tipos_viajes;
    }

    public String getContactoNotificationEmail() {
        return contactoNotificationEmail;
    }

    public void setContactoNotificationEmail(String contactoNotificationEmail) {
        this.contactoNotificationEmail = contactoNotificationEmail;
    }

    public String getContactoNotificationEmail2() {
        return contactoNotificationEmail2;
    }

    public void setContactoNotificationEmail2(String contactoNotificationEmail2) {
        this.contactoNotificationEmail2 = contactoNotificationEmail2;
    }

    public String getContactoNotificationTelefono() {
        return contactoNotificationTelefono;
    }

    public void setContactoNotificationTelefono(String contactoNotificationTelefono) {
        this.contactoNotificationTelefono = contactoNotificationTelefono;
    }

    public String getContactoNotificationTelefono2() {
        return contactoNotificationTelefono2;
    }

    public void setContactoNotificationTelefono2(String contactoNotificationTelefono2) {
        this.contactoNotificationTelefono2 = contactoNotificationTelefono2;
    }

    public ArrayList<Menu> getMenu() {
        return menu;
    }

    public void setMenu(ArrayList<Menu> menu) {
        this.menu = menu;
    }
}