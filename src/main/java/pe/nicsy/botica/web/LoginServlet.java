/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Random;
import pe.nicsy.botica.model.Usuario;
import pe.nicsy.botica.service.UsuarioService;
import pe.nicsy.botica.service.impl.UsuarioServiceImpl;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String usuario = req.getParameter("usuario"); // puede ser correo o nombre_usuario
        String clave = req.getParameter("clave");

        try {
            Usuario user = usuarioService.validarLogin(usuario, clave);

            if (user == null) {
                req.setAttribute("error", "Usuario o contraseña incorrectos.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            // Validación de estados
            if ("Bloqueado".equalsIgnoreCase(user.getEstado())) {
                req.setAttribute("error", "Usuario bloqueado. Contacte al administrador.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            if ("Pendiente".equalsIgnoreCase(user.getEstado())) {
                req.setAttribute("error", "Debe verificar su cuenta por correo antes de iniciar sesión.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }

            String rol = user.getRol().toLowerCase().trim();

            // 🎯 CLIENTE → acceso directo sin OTP
            if (rol.equals("cliente")) {
                HttpSession session = req.getSession(true);
                session.setAttribute("idUsuario", user.getIdUsuario());
                session.setAttribute("nombreUsuario", user.getNombre());
                session.setAttribute("rol", user.getRol());
                resp.sendRedirect(req.getContextPath() + "/views/index.jsp");
                return;
            }

            // 🔐 ADMINISTRADOR y CAJERO → OTP requerido
            if (rol.equals("administrador") || rol.equals("cajero")) {

                // Generar OTP aleatorio (6 dígitos)
                String otpCodigo = String.format("%06d", new Random().nextInt(999999));

                LocalDateTime expiracion = LocalDateTime.now().plusMinutes(10);

                // Guardar en BD el OTP
                usuarioService.registrarOTP(
                        user.getIdUsuario(),
                        otpCodigo,
                        java.sql.Timestamp.valueOf(expiracion)
                );

                // 👉 Guardar también en el objeto Usuario (IMPORTANTE para ValidarOtpServlet)
                user.setOtpCodigo(otpCodigo);
                user.setOtpExpiracion(java.sql.Timestamp.valueOf(expiracion));

                // Simular envío al correo (cuando integremos email real)
                System.out.println("🔐 OTP enviado a " + user.getCorreo() + ": " + otpCodigo);

                // Guardar user incompleto en sesión (sin marcar como logueado)
                HttpSession session = req.getSession(true);
                session.setAttribute("usuarioTemporal", user);

                // Redirigir a validarOtp.jsp
                resp.sendRedirect(req.getContextPath() + "/views/validarOtp.jsp");
                return;
            }

            // Rol no reconocido
            req.setAttribute("error", "Rol no autorizado.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error al validar las credenciales: " + e.getMessage());
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Cerrar sesión manualmente
        if (req.getParameter("logout") != null) {
            if (session != null) {
                session.invalidate();
            }
            req.setAttribute("mensaje", "Sesión cerrada correctamente.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Si hay sesión → redirigir según rol
        if (session != null && session.getAttribute("rol") != null) {
            String rol = ((String) session.getAttribute("rol")).toLowerCase().trim();

            switch (rol) {
                case "administrador":
                    resp.sendRedirect(req.getContextPath() + "/views/panelAdmin.jsp");
                    return;
                case "cajero":
                    resp.sendRedirect(req.getContextPath() + "/views/panelCajero.jsp");
                    return;
                default:
                    resp.sendRedirect(req.getContextPath() + "/views/index.jsp");
                    return;
            }
        }

        // No hay sesión → mostrar login
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }
}
