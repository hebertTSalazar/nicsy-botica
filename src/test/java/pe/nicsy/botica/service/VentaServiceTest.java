/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.service;

import java.math.BigDecimal;
import java.util.List;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.VentaResultado;

/**
 *
 * @author hatsa
 */
public class VentaServiceTest {
    
    public VentaServiceTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of registrarVentaDesdeCarrito method, of class VentaService.
     */
    @Test
    public void testRegistrarVentaDesdeCarrito() throws Exception {
    }

    public class VentaServiceImpl implements VentaService {

        public VentaResultado registrarVentaDesdeCarrito(String nombreCompleto, String dni, String email, String telefono, String metodoEntrega, String direccion, String referencia, List<ItemCarrito> carrito, BigDecimal subtotal, BigDecimal envio, BigDecimal total) throws Exception {
            return null;
        }
    }
    
}
