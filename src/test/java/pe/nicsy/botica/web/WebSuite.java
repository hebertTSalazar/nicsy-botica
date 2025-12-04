/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.web;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.web.RegistrarClienteServletTest.class, pe.nicsy.botica.web.AdminProductoServletTest.class, pe.nicsy.botica.web.RegistrarVentaInternaServletTest.class, pe.nicsy.botica.web.AdminUsuarioServletTest.class, pe.nicsy.botica.web.CarritoInternoServletTest.class, pe.nicsy.botica.web.ComprobantePdfServletTest.class, pe.nicsy.botica.web.ValidarOtpServletTest.class, pe.nicsy.botica.web.TestDBServletTest.class, pe.nicsy.botica.web.CatalogoServletTest.class, pe.nicsy.botica.web.LoginServletTest.class, pe.nicsy.botica.web.CheckoutServletTest.class, pe.nicsy.botica.web.ContactoServletTest.class, pe.nicsy.botica.web.LogoutServletTest.class, pe.nicsy.botica.web.CarritoServletTest.class, pe.nicsy.botica.web.VentasInternasServletTest.class, pe.nicsy.botica.web.FinalizarCompraServletTest.class})
public class WebSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
