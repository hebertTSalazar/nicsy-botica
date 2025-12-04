/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.service;

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
public class ProductoServiceAdminTest {
    
    public ProductoServiceAdminTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of listar method, of class ProductoServiceAdmin.
     */
    @Test
    public void testListar() throws Exception {
    }

    /**
     * Test of buscarPorId method, of class ProductoServiceAdmin.
     */
    @Test
    public void testBuscarPorId() throws Exception {
    }

    /**
     * Test of registrar method, of class ProductoServiceAdmin.
     */
    @Test
    public void testRegistrar() throws Exception {
    }

    /**
     * Test of actualizar method, of class ProductoServiceAdmin.
     */
    @Test
    public void testActualizar() throws Exception {
    }

    /**
     * Test of eliminar method, of class ProductoServiceAdmin.
     */
    @Test
    public void testEliminar() throws Exception {
    }

    /**
     * Test of listarLotesPorProducto method, of class ProductoServiceAdmin.
     */
    @Test
    public void testListarLotesPorProducto() throws Exception {
    }

    /**
     * Test of insertarLote method, of class ProductoServiceAdmin.
     */
    @Test
    public void testInsertarLote() throws Exception {
    }

    /**
     * Test of listarLotesPorVencer method, of class ProductoServiceAdmin.
     */
    @Test
    public void testListarLotesPorVencer() throws Exception {
    }

    /**
     * Test of listarStockBajo method, of class ProductoServiceAdmin.
     */
    @Test
    public void testListarStockBajo() throws Exception {
    }

    public class ProductoServiceAdminImpl implements ProductoServiceAdmin {

        public List<Producto> listar(String filtro, String categoria) throws Exception {
            return null;
        }

        public Producto buscarPorId(int idProducto) throws Exception {
            return null;
        }

        public void registrar(Producto p) throws Exception {
        }

        public void actualizar(Producto p) throws Exception {
        }

        public void eliminar(int idProducto) throws Exception {
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
