/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao;

import java.util.List;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author frank
 */
public interface ProductoDAO {
    
    List<Producto> listarTodos();

    List<Producto> buscarPorNombreYCategoria(String q, String categoria);

   }
