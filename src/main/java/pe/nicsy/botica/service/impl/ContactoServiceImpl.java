/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import pe.nicsy.botica.dao.ContactoDAO;
import pe.nicsy.botica.dao.impl.ContactoDAOImpl;
import pe.nicsy.botica.model.Contacto;
import pe.nicsy.botica.service.ContactoService;

/**
 *
 * @author frank
 */
public class ContactoServiceImpl implements ContactoService {

    private final ContactoDAO contactoDAO = new ContactoDAOImpl();

    @Override
    public void registrarContacto(Contacto contacto) throws Exception {
        contactoDAO.registrarContacto(contacto);
    }

}
