/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4Suite.java to edit this template
 */
package pe.nicsy.botica.model;

import org.junit.AfterClass;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 *
 * @author hatsa
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({pe.nicsy.botica.model.ItemCarritoTest.class, pe.nicsy.botica.model.UsuarioTest.class, pe.nicsy.botica.model.ContactoTest.class, pe.nicsy.botica.model.LoteTest.class, pe.nicsy.botica.model.LotePorVencerTest.class, pe.nicsy.botica.model.ItemCarritoInternoTest.class, pe.nicsy.botica.model.ProductoTest.class, pe.nicsy.botica.model.VentaResultadoTest.class})
public class ModelSuite {

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
}
