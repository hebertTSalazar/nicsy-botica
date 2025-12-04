/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.dao;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.dao.ProductoAdminDAOTest.class, pe.nicsy.botica.dao.impl.ImplSuite.class, pe.nicsy.botica.dao.UsuarioDAOTest.class, pe.nicsy.botica.dao.ProductoDAOTest.class, pe.nicsy.botica.dao.ContactoDAOTest.class})
public class DaoSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
