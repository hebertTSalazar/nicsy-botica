/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao;

import java.util.List;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public interface ProductoAdminDAO {

   
   // === CRUD de productos ===
    List<Producto> listarAdmin(String filtro, String categoria) throws Exception;

    int crearProducto(Producto producto) throws Exception;

    int actualizarProducto(Producto producto) throws Exception;

    boolean eliminarProducto(int idProducto) throws Exception;

    Producto buscarPorId(int idProducto) throws Exception;   // ← NUEVO

    // === Lotes ===
    List<Lote> listarLotesPorProducto(int idProducto) throws Exception;

    void insertarLote(int idProducto, String fecha, int cantidad) throws Exception; // ← NUEVO

    // === Alertas ===
    List<LotePorVencer> listarLotesPorVencer() throws Exception;

    List<Producto> listarStockBajo() throws Exception;  // ← NUEVO
}