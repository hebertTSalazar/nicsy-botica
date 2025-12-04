/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.web.WebSuite.class, pe.nicsy.botica.dao.DaoSuite.class, pe.nicsy.botica.service.ServiceSuite.class, pe.nicsy.botica.model.ModelSuite.class, pe.nicsy.botica.config.ConfigSuite.class})
public class BoticaSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
