/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service;

import java.util.List;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public interface ProductoService {

    List<Producto> listarProductos();

    List<Producto> obtenerProductos(String q, String categoria);

}
