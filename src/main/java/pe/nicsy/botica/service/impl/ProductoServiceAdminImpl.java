/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import java.util.List;
import pe.nicsy.botica.dao.ProductoAdminDAO;
import pe.nicsy.botica.dao.impl.ProductoAdminDAOImpl;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoServiceAdmin;

/**
 *
 * @author frank
 */
public class ProductoServiceAdminImpl implements ProductoServiceAdmin {

    private final ProductoAdminDAO dao;

    public ProductoServiceAdminImpl() {
        dao = new ProductoAdminDAOImpl();
    }

    // ================================================
    // === CRUD DE PRODUCTOS
    // ================================================
    @Override
    public List<Producto> listar(String filtro, String categoria) throws Exception {
        return dao.listarAdmin(filtro, categoria);
    }

    @Override
    public Producto buscarPorId(int idProducto) throws Exception {
        return dao.buscarPorId(idProducto);
    }

    @Override
    public void registrar(Producto producto) throws Exception {
        int idGenerado = dao.crearProducto(producto);
        if (idGenerado <= 0) {
            throw new Exception("No se pudo registrar el producto. Verifique los datos ingresados.");
        }
        producto.setIdProducto(idGenerado);
    }

    @Override
    public void actualizar(Producto producto) throws Exception {
        int filas = dao.actualizarProducto(producto);
        if (filas == 0) {
            throw new Exception("No se realizó ninguna actualización. Revise los valores ingresados.");
        }
    }

    @Override
    public void eliminar(int idProducto) throws Exception {
        boolean ok = dao.eliminarProducto(idProducto);
        if (!ok) {
            throw new Exception("No se pudo eliminar el producto. Verifique dependencias o historial.");
        }
    }

    // ================================================
    // === GESTIÓN DE LOTES
    // ================================================
    @Override
    public List<Lote> listarLotesPorProducto(int idProducto) throws Exception {
        return dao.listarLotesPorProducto(idProducto);
    }

    @Override
    public void insertarLote(int idProducto, String fecha, int cantidad) throws Exception {
        dao.insertarLote(idProducto, fecha, cantidad);
    }

    // ================================================
    // === ALERTAS
    // ================================================
    @Override
    public List<LotePorVencer> listarLotesPorVencer() throws Exception {
        return dao.listarLotesPorVencer();
    }

    @Override
    public List<Producto> listarStockBajo() throws Exception {
        return dao.listarStockBajo();
    }
}
