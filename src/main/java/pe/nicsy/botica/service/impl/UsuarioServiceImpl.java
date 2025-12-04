/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.model.Usuario;
import pe.nicsy.botica.service.UsuarioService;

/**
 *
 * @author frank
 */
public class UsuarioServiceImpl implements UsuarioService {

    // ===================== LOGIN + OTP ======================

    @Override
    public Usuario validarLogin(String usuario, String clave) throws Exception {
        Usuario user = null;

        String sql = "{ CALL sp_validarLogin(?, ?) }";

        try (Connection con = DBPool.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, usuario); // puede ser correo o nombre_usuario
            cs.setString(2, clave);

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    int estadoNum = rs.getInt("estado");
                    String mensaje = rs.getString("mensaje");

                    switch (estadoNum) {
                        case 2: // Acceso correcto
                            user = new Usuario();
                            user.setIdUsuario(rs.getInt("id_usuario"));
                            user.setNombre(rs.getString("nombre"));
                            user.setRol(rs.getString("rol"));
                            user.setCorreo(rs.getString("correo"));   // viene del SP
                            user.setNombreUsuario(usuario);
                            user.setEstado("Verificado");
                            break;

                        case 3: // Usuario bloqueado
                            user = new Usuario();
                            user.setEstado("Bloqueado");
                            System.out.println("⚠️ Usuario bloqueado: " + mensaje);
                            break;

                        case 4: // Cuenta pendiente
                            user = new Usuario();
                            user.setEstado("Pendiente");
                            System.out.println("⚠️ Cuenta pendiente de verificación: " + mensaje);
                            break;

                        default: // 0: no existe, 1: clave incorrecta u otros
                            System.out.println("⚠️ Login fallido: " + mensaje);
                            // user se queda en null
                            break;
                    }
                }
            }
        }
        return user;
    }

    @Override
    public void registrarOTP(int idUsuario, String otp, Timestamp expiracion) throws Exception {
        String sql = "UPDATE usuarios "
                   + "SET otp_codigo = ?, otp_expiracion = ? "
                   + "WHERE id_usuario = ?";

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, otp);
            ps.setTimestamp(2, expiracion);
            ps.setInt(3, idUsuario);

            ps.executeUpdate();
        }
    }

    // ===================== REGISTRO CLIENTE ======================

    @Override
    public Usuario registrarCliente(Usuario u) throws Exception {
        // Insert directo a la tabla usuarios.
        // NOTA: aquí aún no guardamos "direccion" porque tu tabla usuarios
        // actual no tiene esa columna. La usaremos luego si decides normalizarla.
        String sql = "INSERT INTO usuarios "
                   + "(nombre, rol, estado, nombre_usuario, correo, telefono, dni, edad, password) "
                   + "VALUES (?, 'Cliente', 'Verificado', ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Usamos el correo también como nombre_usuario
            ps.setString(1, u.getNombre());        // nombre
            ps.setString(2, u.getCorreo());        // nombre_usuario
            ps.setString(3, u.getCorreo());        // correo
            ps.setString(4, u.getTelefono());      // telefono
            ps.setString(5, u.getDni());           // dni
            ps.setInt(6, u.getEdad());             // edad
            ps.setString(7, u.getPassword());      // password

            ps.executeUpdate();

            // Obtener el ID generado
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    u.setIdUsuario(rs.getInt(1));
                }
            }

            // Setear rol y estado en el objeto por coherencia
            u.setRol("Cliente");
            u.setEstado("Verificado");
            u.setNombreUsuario(u.getCorreo());
        }

        return u;
    }

    // ============= MÉTODOS PARA ADMINISTRAR USUARIOS =============

    @Override
    public List<Usuario> listarUsuarios() throws Exception {
        List<Usuario> lista = new ArrayList<>();

        String sql = "SELECT id_usuario, nombre, rol, estado, "
                   + "nombre_usuario, correo, telefono, dni, edad "
                   + "FROM usuarios "
                   + "ORDER BY id_usuario";

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setCorreo(rs.getString("correo"));
                u.setTelefono(rs.getString("telefono"));
                u.setDni(rs.getString("dni"));
                u.setEdad(rs.getInt("edad"));

                lista.add(u);
            }
        }

        return lista;
    }

    @Override
    public void actualizarDatosBasicos(Usuario u) throws Exception {
        // No tocamos la contraseña ni el OTP
        String sql = "UPDATE usuarios SET "
                   + "nombre = ?, "
                   + "rol = ?, "
                   + "estado = ?, "
                   + "nombre_usuario = ?, "
                   + "correo = ?, "
                   + "telefono = ?, "
                   + "dni = ?, "
                   + "edad = ? "
                   + "WHERE id_usuario = ?";

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getRol());
            ps.setString(3, u.getEstado());
            // seguimos la misma lógica que el registro: nombre_usuario = correo
            ps.setString(4, u.getCorreo());
            ps.setString(5, u.getCorreo());
            ps.setString(6, u.getTelefono());
            ps.setString(7, u.getDni());
            ps.setInt(8, u.getEdad());
            ps.setInt(9, u.getIdUsuario());

            ps.executeUpdate();
        }
    }

    @Override
    public void eliminarUsuario(int idUsuario) throws Exception {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.executeUpdate();
        }
    }

    // ============= REGISTRO DE USUARIOS DESDE PANEL ADMIN =============

    @Override
    public Usuario registrarUsuarioPanel(Usuario u) throws Exception {
        String sql = "INSERT INTO usuarios "
                   + "(nombre, rol, estado, nombre_usuario, correo, telefono, dni, edad, password) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // Si no se envía estado, asumimos Verificado por defecto
        if (u.getEstado() == null || u.getEstado().isBlank()) {
            u.setEstado("Verificado");
        }

        try (Connection con = DBPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, u.getNombre());         // nombre
            ps.setString(2, u.getRol());            // rol (Admin / Cajero / Cliente)
            ps.setString(3, u.getEstado());         // estado
            ps.setString(4, u.getCorreo());         // nombre_usuario = correo
            ps.setString(5, u.getCorreo());         // correo
            ps.setString(6, u.getTelefono());       // telefono
            ps.setString(7, u.getDni());            // dni
            ps.setInt(8, u.getEdad());              // edad
            ps.setString(9, u.getPassword());       // password

            ps.executeUpdate();

            // Obtener ID generado
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    u.setIdUsuario(rs.getInt(1));
                }
            }

            u.setNombreUsuario(u.getCorreo());
        }

        return u;
    }
}
