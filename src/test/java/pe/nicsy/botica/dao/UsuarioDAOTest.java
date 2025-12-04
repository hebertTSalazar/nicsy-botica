/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.dao;

import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author hatsa
 */
public class UsuarioDAOTest {
    
    public UsuarioDAOTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of validarLogin method, of class UsuarioDAO.
     */
    @Test
    public void testValidarLogin() throws Exception {
    }

    public class UsuarioDAOImpl implements UsuarioDAO {

        public Usuario validarLogin(String nombreUsuario, String password) throws Exception {
            return null;
        }
    }
    
}
