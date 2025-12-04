/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.model;

import java.sql.Timestamp;

public class Usuario {

    private int idUsuario;
    private String nombre;
    private String rol;
    private String nombreUsuario;
    private String password;

    // 🔹 Nuevos campos agregados
    private String correo;
    private String estado;     // Verificado, Pendiente, Bloqueado
    private String telefono;
    private String dni;
    private String direccion;
    private int edad;          // 👈 NUEVO CAMPO

    private String otpCodigo;      // Código OTP generado
    private Timestamp otpExpiracion; // Fecha y hora de expiración del OTP

    // Constructor vacío
    public Usuario() {
    }

    // Constructor con parámetros (básico)
    public Usuario(int idUsuario, String nombre, String rol, String nombreUsuario, String password) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rol = rol;
        this.nombreUsuario = nombreUsuario;
        this.password = password;
    }

    // ======== GETTERS & SETTERS ========
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    // 👉 NUEVOS MÉTODOS PARA EDAD
    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getOtpCodigo() {
        return otpCodigo;
    }

    public void setOtpCodigo(String otpCodigo) {
        this.otpCodigo = otpCodigo;
    }

    public Timestamp getOtpExpiracion() {
        return otpExpiracion;
    }

    public void setOtpExpiracion(Timestamp otpExpiracion) {
        this.otpExpiracion = otpExpiracion;
    }
}
