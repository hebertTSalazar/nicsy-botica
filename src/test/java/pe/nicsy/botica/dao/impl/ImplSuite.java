/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.dao.impl;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.dao.impl.UsuarioDAOImplTest.class, pe.nicsy.botica.dao.impl.ProductoAdminDAOImplTest.class, pe.nicsy.botica.dao.impl.ContactoDAOImplTest.class, pe.nicsy.botica.dao.impl.ProductoDAOImplTest.class})
public class ImplSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
