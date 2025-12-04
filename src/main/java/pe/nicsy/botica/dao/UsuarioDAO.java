/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.dao;

import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author frank
 */
public interface UsuarioDAO {
     Usuario validarLogin(String nombreUsuario, String password) throws Exception;
}
