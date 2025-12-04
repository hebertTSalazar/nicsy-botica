/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.dao.ContactoDAO;
import pe.nicsy.botica.model.Contacto;

/**
 *
 * @author frank
 */
public class ContactoDAOImpl implements ContactoDAO {

    @Override
    public void registrarContacto(Contacto c) throws Exception {
        String sql = "{ CALL RegistrarContacto(?, ?, ?, ?, ?, ?) }";

        try (Connection con = DBPool.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            if (c.getIdCliente() != null) {
                cs.setInt(1, c.getIdCliente());
            } else {
                cs.setNull(1, Types.INTEGER);
            }

            cs.setString(2, c.getNombre());
            cs.setString(3, c.getTelefono());
            cs.setString(4, c.getEmail());
            cs.setString(5, c.getAsunto());
            cs.setString(6, c.getMensaje());

            cs.executeUpdate();
        }
    }

}