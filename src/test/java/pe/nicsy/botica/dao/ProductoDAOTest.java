/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.dao;

import java.util.List;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author hatsa
 */
public class ProductoDAOTest {
    
    public ProductoDAOTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of listarTodos method, of class ProductoDAO.
     */
    @Test
    public void testListarTodos() {
    }

    /**
     * Test of buscarPorNombreYCategoria method, of class ProductoDAO.
     */
    @Test
    public void testBuscarPorNombreYCategoria() {
    }

    public class ProductoDAOImpl implements ProductoDAO {

        public List<Producto> listarTodos() {
            return null;
        }

        public List<Producto> buscarPorNombreYCategoria(String q, String categoria) {
            return null;
        }
    }
    
}
