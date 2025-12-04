/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import pe.nicsy.botica.model.Usuario;
import pe.nicsy.botica.service.UsuarioService;
import pe.nicsy.botica.service.impl.UsuarioServiceImpl;

/**
 *
 * @author frank
 */
@WebServlet("/RegistrarClienteServlet")
public class RegistrarClienteServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nombre    = req.getParameter("nombre");
        String dni       = req.getParameter("dni");
        String telefono  = req.getParameter("telefono");
        String edadStr   = req.getParameter("edad");
        String correo    = req.getParameter("correo");
        String direccion = req.getParameter("direccion");
        String password  = req.getParameter("password");
        String password2 = req.getParameter("password2");

        // ===== Validaciones básicas del lado servidor =====
        if (nombre == null || nombre.isBlank()
                || dni == null || dni.length() != 8
                || telefono == null || telefono.isBlank()
                || edadStr == null || edadStr.isBlank()
                || correo == null || correo.isBlank()
                || password == null || password.isBlank()
                || password2 == null || password2.isBlank()) {

            req.setAttribute("error", "Complete todos los campos obligatorios correctamente.");
            req.getRequestDispatcher("/views/registroCliente.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(password2)) {
            req.setAttribute("error", "Las contraseñas no coinciden.");
            req.getRequestDispatcher("/views/registroCliente.jsp").forward(req, resp);
            return;
        }

        int edad;
        try {
            edad = Integer.parseInt(edadStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "La edad debe ser un número válido.");
            req.getRequestDispatcher("/views/registroCliente.jsp").forward(req, resp);
            return;
        }

        try {
            // Armar el objeto Usuario
            Usuario u = new Usuario();
            u.setNombre(nombre);
            u.setDni(dni);
            u.setTelefono(telefono);
            u.setEdad(edad);
            u.setCorreo(correo);
            u.setDireccion(direccion);
            u.setPassword(password);    // por ahora sin encriptar

            // Registrar en BD
            usuarioService.registrarCliente(u);

            // Mensaje de éxito y redirección al login
            req.setAttribute("mensaje", "Registro exitoso. Ahora puede iniciar sesión.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error al registrar cliente: " + e.getMessage());
            req.getRequestDispatcher("/views/registroCliente.jsp").forward(req, resp);
        }
    }
}
