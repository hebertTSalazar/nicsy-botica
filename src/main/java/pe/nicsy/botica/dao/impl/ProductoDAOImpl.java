/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.dao.ProductoDAO;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public class ProductoDAOImpl implements ProductoDAO {

    @Override
    public List<Producto> listarTodos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "CALL ListarProductos(?, ?)";

        try (Connection con = DBPool.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            cs.setNull(1, Types.VARCHAR);
            cs.setNull(2, Types.VARCHAR);

            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    lista.add(p);
                }
            }

        } catch (SQLException e) {
            System.err.println(" Error en listarTodos(): " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("Productos cargados: " + lista.size());
        return lista;
    }

    @Override
    public List<Producto> buscarPorNombreYCategoria(String q, String categoria) {
        List<Producto> lista = new ArrayList<>();
        String sql = "CALL BuscarProducto(?, ?)";

        try (Connection con = DBPool.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, q);
            cs.setString(2, categoria);

            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    lista.add(p);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error en buscarPorNombreYCategoria(): " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("Productos filtrados: " + lista.size());
        return lista;
    }
}