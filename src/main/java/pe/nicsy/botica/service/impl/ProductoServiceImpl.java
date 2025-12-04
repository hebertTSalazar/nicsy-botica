/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import java.util.List;
import pe.nicsy.botica.dao.ProductoDAO;
import pe.nicsy.botica.dao.impl.ProductoDAOImpl;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoService;

/**
 *
 * @author frank
 */
public class ProductoServiceImpl implements ProductoService {

    private final ProductoDAO productoDAO = new ProductoDAOImpl();

    @Override
    public List<Producto> listarProductos() {
        return productoDAO.listarTodos();
    }

    @Override
    public List<Producto> obtenerProductos(String q, String categoria) {
        return productoDAO.buscarPorNombreYCategoria(q, categoria);
    }
}