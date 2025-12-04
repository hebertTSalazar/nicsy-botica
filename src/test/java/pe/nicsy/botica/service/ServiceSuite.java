/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.service;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.service.UsuarioServiceTest.class, pe.nicsy.botica.service.ContactoServiceTest.class, pe.nicsy.botica.service.ProductoServiceTest.class, pe.nicsy.botica.service.VentaServiceTest.class, pe.nicsy.botica.service.ProductoServiceAdminTest.class, pe.nicsy.botica.service.impl.ImplSuite.class})
public class ServiceSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
