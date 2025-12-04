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
import pe.nicsy.botica.model.Contacto;
import pe.nicsy.botica.service.ContactoService;
import pe.nicsy.botica.service.impl.ContactoServiceImpl;

/**
 *
 * @author frank
 */
@WebServlet("/contacto")
public class ContactoServlet extends HttpServlet {

    private final ContactoService contactoService = new ContactoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("views/contacto.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nombre = trimOrEmpty(req.getParameter("nombre"));
        String dni = trimOrEmpty(req.getParameter("dni"));
        String telefono = trimOrEmpty(req.getParameter("telefono"));
        String email = trimOrEmpty(req.getParameter("email"));
        String asunto = trimOrEmpty(req.getParameter("asunto"));
        String mensaje = trimOrEmpty(req.getParameter("mensaje"));

        StringBuilder errores = new StringBuilder();

        if (nombre.isEmpty()) {
            errores.append("El nombre es obligatorio. ");
        } else if (!nombre.matches("[A-Za-zÁÉÍÓÚÜÑáéíóúüñ ]{3,60}")) {
            errores.append("El nombre y apellidos solo deben contener letras y espacios (mínimo 3 caracteres). ");
        }

        if (dni.isEmpty()) {
            errores.append("El DNI es obligatorio. ");
        } else if (!dni.matches("\\d{8}")) {
            errores.append("El DNI debe tener exactamente 8 dígitos numéricos. ");
        }

        if (email.isEmpty()) {
            errores.append("El correo electrónico es obligatorio. ");
        } else if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            errores.append("El formato del correo electrónico no es válido. ");
        }

        if (asunto.isEmpty()) {
            errores.append("El asunto es obligatorio. ");
        } else if (asunto.length() < 3) {
            errores.append("El asunto debe tener al menos 3 caracteres. ");
        }

        if (mensaje.isEmpty()) {
            errores.append("El mensaje es obligatorio. ");
        } else if (mensaje.length() < 5) {
            errores.append("El mensaje debe tener al menos 5 caracteres. ");
        }

        // Teléfono: opcional, pero si viene, solo números, espacios y +
        if (!telefono.isEmpty()) {
            if (!telefono.matches("\\d{9}")) {
                errores.append("El teléfono debe contener exactamente 9 dígitos numéricos. ");
            }
        }

        if (errores.length() > 0) {
            req.setAttribute("errorContacto", errores.toString());

            req.setAttribute("nombre", nombre);
            req.setAttribute("dni", dni);
            req.setAttribute("telefono", telefono);
            req.setAttribute("email", email);
            req.setAttribute("asunto", asunto);
            req.setAttribute("mensaje", mensaje);

            req.getRequestDispatcher("views/contacto.jsp").forward(req, resp);
            return;
        }

        Integer idCliente = null;
        HttpSession session = req.getSession(false);
        if (session != null) {
            Object objIdCli = session.getAttribute("idCliente");
            if (objIdCli instanceof Integer) {
                idCliente = (Integer) objIdCli;
            }
        }

        Contacto c = new Contacto();
        c.setIdCliente(idCliente);
        c.setNombre(nombre);
        c.setTelefono(telefono.isEmpty() ? null : telefono);
        c.setEmail(email);
        c.setAsunto(asunto);
        c.setMensaje(mensaje);

        try {
            contactoService.registrarContacto(c);
            req.setAttribute("okContacto",
                    "Tu mensaje ha sido enviado correctamente. Pronto nos pondremos en contacto contigo.");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorContacto",
                    "Ocurrió un error al registrar tu mensaje: " + e.getMessage());
        }

        req.getRequestDispatcher("views/contacto.jsp").forward(req, resp);
    }

    private String trimOrEmpty(String value) {
        return (value == null) ? "" : value.trim();
    }

}
