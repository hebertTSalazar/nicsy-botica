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
import java.time.LocalDateTime;
import pe.nicsy.botica.model.Usuario;
import pe.nicsy.botica.service.UsuarioService;
import pe.nicsy.botica.service.impl.UsuarioServiceImpl;



/**
 *
 * @author frank
 */
@WebServlet("/ValidarOtpServlet")
public class ValidarOtpServlet extends HttpServlet {

    private final UsuarioService usuarioService = new UsuarioServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String codigoIngresado = req.getParameter("otp");
        HttpSession session = req.getSession(false);

        // Validar que haya sesión temporal
        if (session == null || session.getAttribute("usuarioTemporal") == null) {
            req.setAttribute("error", "Sesión expirada. Inicie sesión nuevamente.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        Usuario uTemp = (Usuario) session.getAttribute("usuarioTemporal");

        // Verificamos si hay OTP en BD
        if (uTemp.getOtpCodigo() == null || uTemp.getOtpExpiracion() == null) {
            req.setAttribute("error", "No se generó código OTP. Inicie sesión otra vez.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Verificar expiración
        LocalDateTime ahora = LocalDateTime.now();
        if (uTemp.getOtpExpiracion().toLocalDateTime().isBefore(ahora)) {
            req.setAttribute("error", "El código ha expirado. Inicie sesión nuevamente.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Comparar códigos
        if (!codigoIngresado.equals(uTemp.getOtpCodigo())) {
            req.setAttribute("error", "Código incorrecto. Intente nuevamente.");
            req.getRequestDispatcher("/views/validarOtp.jsp").forward(req, resp);
            return;
        }

        // ✔ OTP correcto: crear sesión definitiva
        HttpSession sesionDefinitiva = req.getSession(true);
        sesionDefinitiva.setAttribute("idUsuario", uTemp.getIdUsuario());
        sesionDefinitiva.setAttribute("nombreUsuario", uTemp.getNombre());
        sesionDefinitiva.setAttribute("rol", uTemp.getRol());

        // Limpia el usuario temporal
        session.removeAttribute("usuarioTemporal");

        // Redirección según rol
        String rol = uTemp.getRol().toLowerCase();
        if (rol.equals("administrador")) {
            resp.sendRedirect(req.getContextPath() + "/views/panelAdmin.jsp");
        } else if (rol.equals("cajero")) {
            resp.sendRedirect(req.getContextPath() + "/views/panelCajero.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/views/index.jsp");
        }
    }
}