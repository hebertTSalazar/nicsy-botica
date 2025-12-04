/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.dao;

import java.util.List;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;

/**
 *
 * @author hatsa
 */
public class ProductoAdminDAOTest {
    
    public ProductoAdminDAOTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of listarAdmin method, of class ProductoAdminDAO.
     */
    @Test
    public void testListarAdmin() throws Exception {
    }

    /**
     * Test of crearProducto method, of class ProductoAdminDAO.
     */
    @Test
    public void testCrearProducto() throws Exception {
    }

    /**
     * Test of actualizarProducto method, of class ProductoAdminDAO.
     */
    @Test
    public void testActualizarProducto() throws Exception {
    }

    /**
     * Test of eliminarProducto method, of class ProductoAdminDAO.
     */
    @Test
    public void testEliminarProducto() throws Exception {
    }

    /**
     * Test of buscarPorId method, of class ProductoAdminDAO.
     */
    @Test
    public void testBuscarPorId() throws Exception {
    }

    /**
     * Test of listarLotesPorProducto method, of class ProductoAdminDAO.
     */
    @Test
    public void testListarLotesPorProducto() throws Exception {
    }

    /**
     * Test of insertarLote method, of class ProductoAdminDAO.
     */
    @Test
    public void testInsertarLote() throws Exception {
    }

    /**
     * Test of listarLotesPorVencer method, of class ProductoAdminDAO.
     */
    @Test
    public void testListarLotesPorVencer() throws Exception {
    }

    /**
     * Test of listarStockBajo method, of class ProductoAdminDAO.
     */
    @Test
    public void testListarStockBajo() throws Exception {
    }

    public class ProductoAdminDAOImpl implements ProductoAdminDAO {

        public List<Producto> listarAdmin(String filtro, String categoria) throws Exception {
            return null;
        }

        public int crearProducto(Producto producto) throws Exception {
            return 0;
        }

        public int actualizarProducto(Producto producto) throws Exception {
            return 0;
        }

        public boolean eliminarProducto(int idProducto) throws Exception {
            return false;
        }

        public Producto buscarPorId(int idProducto) throws Exception {
            return null;
        }

        public List<Lote> listarLotesPorProducto(int idProducto) throws Exception {
            return null;
        }

        public void insertarLote(int idProducto, String fecha, int cantidad) throws Exception {
        }

        public List<LotePorVencer> listarLotesPorVencer() throws Exception {
            return null;
        }

        public List<Producto> listarStockBajo() throws Exception {
            return null;
        }
    }
    
}
