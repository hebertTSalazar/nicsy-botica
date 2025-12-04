/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.dao.UsuarioDAO;
import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author frank
 */
public class UsuarioDAOImpl implements UsuarioDAO{
   @Override
    public Usuario validarLogin(String nombreUsuario, String password) throws Exception {
        Usuario user = null;
        String sql = "{ CALL sp_validarLogin(?, ?) }";

        try (Connection con = DBPool.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, nombreUsuario);
            cs.setString(2, password);

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    int estado = rs.getInt("estado");

                    if (estado == 2) { // Acceso correcto
                        user = new Usuario();
                        user.setIdUsuario(rs.getInt("id_usuario"));
                        user.setNombre(rs.getString("nombre"));
                        user.setRol(rs.getString("rol"));
                        user.setNombreUsuario(nombreUsuario);
                        user.setPassword(password);
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error en validarLogin(): " + e.getMessage());
            throw e;
        }

        return user;
    }
}
