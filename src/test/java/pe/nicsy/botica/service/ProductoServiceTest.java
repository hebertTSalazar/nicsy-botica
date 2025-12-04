/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.service;

import java.util.List;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author hatsa
 */
public class ProductoServiceTest {
    
    public ProductoServiceTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of listarProductos method, of class ProductoService.
     */
    @Test
    public void testListarProductos() {
    }

    /**
     * Test of obtenerProductos method, of class ProductoService.
     */
    @Test
    public void testObtenerProductos() {
    }

    public class ProductoServiceImpl implements ProductoService {

        public List<Producto> listarProductos() {
            return null;
        }

        public List<Producto> obtenerProductos(String q, String categoria) {
            return null;
        }
    }
    
}
