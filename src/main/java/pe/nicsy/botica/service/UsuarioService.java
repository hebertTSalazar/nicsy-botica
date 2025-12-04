/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service;

import java.sql.Timestamp;
import java.util.List;
import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author frank
 */
public interface UsuarioService {

    /**
     * Valida las credenciales del usuario contra la BD usando el
     * procedimiento almacenado sp_validarLogin.
     *
     * @param usuario correo o nombre de usuario
     * @param clave   contraseña
     * @return Usuario con datos y estado ("Verificado", "Bloqueado", "Pendiente")
     *         o null si usuario/clave no son correctos.
     */
    Usuario validarLogin(String usuario, String clave) throws Exception;

    /**
     * Registra el código OTP y su fecha de expiración para el usuario indicado.
     *
     * @param idUsuario  ID del usuario
     * @param otp        código OTP
     * @param expiracion fecha y hora de expiración
     */
    void registrarOTP(int idUsuario, String otp, Timestamp expiracion) throws Exception;

    /**
     * Registra un nuevo usuario con rol Cliente en el sistema.
     * Debe llenar los campos básicos (nombre, correo, dni, teléfono, edad, password).
     *
     * @param usuario objeto Usuario con los datos del cliente
     * @return Usuario con el idUsuario generado en la BD
     */
    Usuario registrarCliente(Usuario usuario) throws Exception;

    // ================= MÉTODOS PARA ADMINISTRAR USUARIOS =================

    /**
     * Lista todos los usuarios del sistema (para el panel del administrador).
     */
    List<Usuario> listarUsuarios() throws Exception;

    /**
     * Actualiza datos básicos del usuario (sin modificar la contraseña).
     *
     * @param usuario objeto Usuario con los datos a actualizar
     */
    void actualizarDatosBasicos(Usuario usuario) throws Exception;

    /**
     * Elimina un usuario por su ID.
     *
     * @param idUsuario ID del usuario a eliminar
     */
    void eliminarUsuario(int idUsuario) throws Exception;

    /**
     * Registra un usuario (Administrador, Cajero o Cliente) desde el panel del administrador.
     *
     * @param usuario objeto Usuario con los datos a registrar
     * @return Usuario con el idUsuario generado
     */
    Usuario registrarUsuarioPanel(Usuario usuario) throws Exception;
}
