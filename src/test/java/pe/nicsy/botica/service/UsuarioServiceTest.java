/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package pe.nicsy.botica.service;

import java.sql.Timestamp;
import java.util.List;
import org.junit.AfterClass;
import org.junit.Test;
import static org.junit.Assert.*;
import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author hatsa
 */
public class UsuarioServiceTest {
    
    public UsuarioServiceTest() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of validarLogin method, of class UsuarioService.
     */
    @Test
    public void testValidarLogin() throws Exception {
    }

    /**
     * Test of registrarOTP method, of class UsuarioService.
     */
    @Test
    public void testRegistrarOTP() throws Exception {
    }

    /**
     * Test of registrarCliente method, of class UsuarioService.
     */
    @Test
    public void testRegistrarCliente() throws Exception {
    }

    /**
     * Test of listarUsuarios method, of class UsuarioService.
     */
    @Test
    public void testListarUsuarios() throws Exception {
    }

    /**
     * Test of actualizarDatosBasicos method, of class UsuarioService.
     */
    @Test
    public void testActualizarDatosBasicos() throws Exception {
    }

    /**
     * Test of eliminarUsuario method, of class UsuarioService.
     */
    @Test
    public void testEliminarUsuario() throws Exception {
    }

    /**
     * Test of registrarUsuarioPanel method, of class UsuarioService.
     */
    @Test
    public void testRegistrarUsuarioPanel() throws Exception {
    }

    public class UsuarioServiceImpl implements UsuarioService {

        public Usuario validarLogin(String usuario, String clave) throws Exception {
            return null;
        }

        public void registrarOTP(int idUsuario, String otp, Timestamp expiracion) throws Exception {
        }

        public Usuario registrarCliente(Usuario usuario) throws Exception {
            return null;
        }

        public List<Usuario> listarUsuarios() throws Exception {
            return null;
        }

        public void actualizarDatosBasicos(Usuario usuario) throws Exception {
        }

        public void eliminarUsuario(int idUsuario) throws Exception {
        }

        public Usuario registrarUsuarioPanel(Usuario usuario) throws Exception {
            return null;
        }
    }
    
}
