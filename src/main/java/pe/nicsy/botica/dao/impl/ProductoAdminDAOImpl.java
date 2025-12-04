/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.dao.ProductoAdminDAO;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public class ProductoAdminDAOImpl implements ProductoAdminDAO {

    // =====================================================
    // === CRUD DE PRODUCTOS
    // =====================================================
    @Override
    public List<Producto> listarAdmin(String filtro, String categoria) throws Exception {
        List<Producto> lista = new ArrayList<>();
        String sql = "{ CALL ListarProductos(?, ?) }";

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            if (filtro == null || filtro.trim().isEmpty()) {
                cs.setNull(1, Types.VARCHAR);
            } else {
                cs.setString(1, filtro);
            }

            if (categoria == null || categoria.trim().isEmpty()) {
                cs.setNull(2, Types.VARCHAR);
            } else {
                cs.setString(2, categoria);
            }

            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setStock(rs.getInt("stock"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    lista.add(p);
                }
            }
        }
        return lista;
    }

    @Override
    public int crearProducto(Producto p) throws Exception {
        String sql = "{ CALL InsertarProducto(?, ?, ?, ?, ?, ?) }";
        int idGenerado = -1;

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, p.getNombre());
            cs.setString(2, p.getCategoria());
            cs.setBigDecimal(3, p.getPrecio());
            cs.setString(4, p.getDescripcion());
            cs.setInt(5, p.getStock());
            cs.setString(6, p.getImagenUrl());

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    idGenerado = rs.getInt("id_producto");
                }
            }
        } catch (SQLException ex) {
            if ("45000".equals(ex.getSQLState())) {
                throw new SQLException(ex.getMessage()); 
            } else {
                throw ex;
            }
        }
        return idGenerado;
    }

    @Override
    public int actualizarProducto(Producto p) throws Exception {
        String sql = "{ CALL ModificarProducto(?, ?, ?, ?, ?, ?, ?) }";
        int filas = 0;

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            cs.setInt(1, p.getIdProducto());
            cs.setString(2, p.getNombre());
            cs.setString(3, p.getCategoria());
            cs.setBigDecimal(4, p.getPrecio());
            cs.setString(5, p.getDescripcion());
            cs.setInt(6, p.getStock());
            cs.setString(7, p.getImagenUrl());

            
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    filas = rs.getInt("filas_afectadas");
                }
            }
        } catch (SQLException ex) {
            if ("45000".equals(ex.getSQLState())) {
                throw new SQLException(ex.getMessage());
            } else {
                throw ex;
            }
        }
        return filas;
    }

    @Override
    public boolean eliminarProducto(int idProducto) throws Exception {
        String sql = "{ CALL EliminarProducto(?) }";
        boolean ok = false;

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            cs.setInt(1, idProducto);
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    int flag = rs.getInt("ok");
                    ok = (flag == 1);
                }
            }
        } catch (SQLException ex) {
            throw new SQLException("No se puede eliminar el producto. Ya tiene historial de ventas o pedidos.", ex);
        }
        return ok;
    }

    @Override
    public Producto buscarPorId(int idProducto) throws Exception {
        Producto p = null;
    String sql = "{ CALL BuscarProductoPorId(?) }"; 

    try (Connection con = DBPool.getConnection(); 
         CallableStatement cs = con.prepareCall(sql)) {

        cs.setInt(1, idProducto);

        try (ResultSet rs = cs.executeQuery()) {
            if (rs.next()) {
                p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStock(rs.getInt("stock"));
                p.setImagenUrl(rs.getString("imagen_url"));
            }
        }
    } catch (SQLException ex) {
        throw new SQLException("Error al buscar producto por ID: " + ex.getMessage(), ex);
    }

    return p;
}

    // =====================================================
    // === LOTES Y ALERTAS
    // =====================================================
    @Override
    public List<Lote> listarLotesPorProducto(int idProducto) throws Exception {
        List<Lote> lista = new ArrayList<>();
        String sql = "{ CALL ListarLotesPorProducto(?) }";

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            cs.setInt(1, idProducto);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    Lote l = new Lote();
                    l.setIdProducto(idProducto);
                    l.setIdLote(rs.getInt("id_lote"));
                    Date fv = rs.getDate("fecha_vencimiento");
                    if (fv != null) {
                        l.setFechaVencimiento(fv.toLocalDate());
                    }
                    l.setCantidad(rs.getInt("cantidad"));
                    lista.add(l);
                }
            }
        }
        return lista;
    }

    @Override
    public void insertarLote(int idProducto, String fecha, int cantidad) throws Exception {
        String sql = "{ CALL InsertarLote(?, ?, ?) }";
        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql)) {

            cs.setInt(1, idProducto);
            cs.setDate(2, Date.valueOf(fecha));
            cs.setInt(3, cantidad);
            cs.executeUpdate();
        }
    }

    @Override
    public List<LotePorVencer> listarLotesPorVencer() throws Exception {
        List<LotePorVencer> lista = new ArrayList<>();
        String sql = "{ CALL ListarLotesPorVencer() }";

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql); ResultSet rs = cs.executeQuery()) {

            while (rs.next()) {
                LotePorVencer lv = new LotePorVencer();
                lv.setNombreProducto(rs.getString("producto"));
                Date fv = rs.getDate("fecha_vencimiento");
                if (fv != null) {
                    lv.setFechaVencimiento(fv.toLocalDate());
                }
                lv.setCantidad(rs.getInt("cantidad"));
                lista.add(lv);
            }
        }
        return lista;
    }

    @Override
    public List<Producto> listarStockBajo() throws Exception {
        List<Producto> lista = new ArrayList<>();
        String sql = "{ CALL ListarProductosStockBajo() }";

        try (Connection con = DBPool.getConnection(); CallableStatement cs = con.prepareCall(sql); ResultSet rs = cs.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setStock(rs.getInt("stock"));
                p.setImagenUrl(rs.getString("imagen_url"));
                lista.add(p);
            }
        }
        return lista;
    }
}
