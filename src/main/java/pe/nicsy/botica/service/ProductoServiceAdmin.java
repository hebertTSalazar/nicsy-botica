/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service;

import java.util.List;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public interface ProductoServiceAdmin {

    // === CRUD de Productos ===
    List<Producto> listar(String filtro, String categoria) throws Exception;

    Producto buscarPorId(int idProducto) throws Exception;  // ← nuevo para mostrar detalle

    void registrar(Producto p) throws Exception;

    void actualizar(Producto p) throws Exception;

    void eliminar(int idProducto) throws Exception;

    // === Gestión de Lotes ===
    List<Lote> listarLotesPorProducto(int idProducto) throws Exception;

    void insertarLote(int idProducto, String fecha, int cantidad) throws Exception; // ← nuevo

    // === Alertas ===
    List<LotePorVencer> listarLotesPorVencer() throws Exception;

    List<Producto> listarStockBajo() throws Exception; // ← nuevo para alerta de stock bajo
}
