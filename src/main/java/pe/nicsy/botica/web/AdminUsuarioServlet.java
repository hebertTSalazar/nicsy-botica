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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import pe.nicsy.botica.model.Usuario;
import pe.nicsy.botica.service.UsuarioService;
import pe.nicsy.botica.service.impl.UsuarioServiceImpl;

/**
 *
 * @author frank
 */
@WebServlet("/AdminUsuarioServlet")
public class AdminUsuarioServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Verificar que exista sesión y sea ADMIN
        HttpSession session = request.getSession(false);
        if (session == null || !"administrador".equalsIgnoreCase((String) session.getAttribute("rol"))) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null || accion.equals("listar")) {
            try {
                listarUsuarios(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            }
        } else if ("eliminar".equals(accion)) {
            try {
                eliminarUsuario(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("msg", "❌ Error al eliminar usuario: " + e.getMessage());
                response.sendRedirect("AdminUsuarioServlet?accion=listar");
            }
        } else {
            response.sendRedirect("AdminUsuarioServlet?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Verificar sesión y rol admin
        HttpSession session = request.getSession(false);
        if (session == null || !"administrador".equalsIgnoreCase((String) session.getAttribute("rol"))) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String accion = request.getParameter("accion");

        try {
            if ("actualizar".equals(accion)) {
                actualizarUsuario(request, response);
            } else if ("insertar".equals(accion)) {
                insertarUsuario(request, response);
            } else {
                response.sendRedirect("AdminUsuarioServlet?accion=listar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "❌ Error en la operación: " + e.getMessage());
            response.sendRedirect("AdminUsuarioServlet?accion=listar");
        }
    }

    // ==========================================================
    // MÉTODOS PRIVADOS
    // ==========================================================

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List<Usuario> usuarios = usuarioService.listarUsuarios();
        request.setAttribute("usuarios", usuarios);

        // Mensaje que venga de operaciones previas
        String msg = (String) request.getSession().getAttribute("msg");
        if (msg != null) {
            request.setAttribute("msg", msg);
            request.getSession().removeAttribute("msg");
        }

        request.getRequestDispatcher("views/adminUsuarios.jsp").forward(request, response);
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String dni = request.getParameter("dni");
        String edadStr = request.getParameter("edad");

        int edad = 0;
        try {
            edad = Integer.parseInt(edadStr);
        } catch (NumberFormatException e) {
            // si viene vacío o mal, dejamos en 0
        }

        Usuario u = new Usuario();
        u.setIdUsuario(id);
        u.setNombre(nombre);
        u.setRol(rol);
        u.setEstado(estado);
        u.setCorreo(correo);
        u.setTelefono(telefono);
        u.setDni(dni);
        u.setEdad(edad);

        usuarioService.actualizarDatosBasicos(u);

        request.getSession().setAttribute("msg", "✏️ Usuario actualizado correctamente.");
        response.sendRedirect("AdminUsuarioServlet?accion=listar");
    }

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        usuarioService.eliminarUsuario(id);

        request.getSession().setAttribute("msg", "🗑️ Usuario eliminado correctamente.");
        response.sendRedirect("AdminUsuarioServlet?accion=listar");
    }

    private void insertarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String nombre   = request.getParameter("nombre");
        String rol      = request.getParameter("rol");
        String estado   = request.getParameter("estado");
        String correo   = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String dni      = request.getParameter("dni");
        String edadStr  = request.getParameter("edad");
        String pass1    = request.getParameter("password");
        String pass2    = request.getParameter("password2");

        // Validación básica
        if (nombre == null || nombre.isBlank()
                || correo == null || correo.isBlank()
                || pass1 == null || pass1.isBlank()
                || pass2 == null || pass2.isBlank()) {

            request.getSession().setAttribute("msg", "❌ Complete los campos obligatorios.");
            response.sendRedirect("AdminUsuarioServlet?accion=listar");
            return;
        }

        if (!pass1.equals(pass2)) {
            request.getSession().setAttribute("msg", "❌ Las contraseñas no coinciden.");
            response.sendRedirect("AdminUsuarioServlet?accion=listar");
            return;
        }

        int edad = 0;
        try {
            edad = Integer.parseInt(edadStr);
        } catch (NumberFormatException e) {
            edad = 0;
        }

        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setRol(rol);
        u.setEstado(estado);
        u.setCorreo(correo);
        u.setTelefono(telefono);
        u.setDni(dni);
        u.setEdad(edad);
        u.setPassword(pass1);

        usuarioService.registrarUsuarioPanel(u);

        request.getSession().setAttribute("msg", "✅ Usuario registrado correctamente.");
        response.sendRedirect("AdminUsuarioServlet?accion=listar");
    }
}
