/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import pe.nicsy.botica.config.DBPool;

/**
 *
 * @author frank
 */
@WebServlet(name = "TestDBServlet", urlPatterns = {"/testdb"})
public class TestDBServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        try (PrintWriter out = resp.getWriter(); Connection cn = DBPool.getDataSource().getConnection()) {
            out.println("Conexión exitosa a la base de datos nicsy_botica");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
