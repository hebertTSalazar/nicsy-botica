/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.service.impl.ContactoServiceImplTest.class, pe.nicsy.botica.service.impl.UsuarioServiceImplTest.class, pe.nicsy.botica.service.impl.ProductoServiceAdminImplTest.class, pe.nicsy.botica.service.impl.ProductoServiceImplTest.class, pe.nicsy.botica.service.impl.VentaServiceImplTest.class})
public class ImplSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
