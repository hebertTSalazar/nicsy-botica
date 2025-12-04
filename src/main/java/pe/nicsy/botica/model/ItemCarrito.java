/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.model;

import java.math.BigDecimal;
/**
 *
 * @author frank
 */
public class ItemCarrito {
    private int idProducto;
    private String nombre;
    private String imagenUrl;
    private BigDecimal precioUnitario;
    private int cantidad;

    public ItemCarrito() {
    }

    public ItemCarrito(int idProducto, String nombre, String imagenUrl,
                       BigDecimal precioUnitario, int cantidad) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.imagenUrl = imagenUrl;
        this.precioUnitario = precioUnitario;
        this.cantidad = cantidad;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }

    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    // Subtotal = precio * cantidad
    public BigDecimal getSubtotal() {
        if (precioUnitario == null) {
            return BigDecimal.ZERO;
        }
        return precioUnitario.multiply(BigDecimal.valueOf(cantidad));
    }
}
