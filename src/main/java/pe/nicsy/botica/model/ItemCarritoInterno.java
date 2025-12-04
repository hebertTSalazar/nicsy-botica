/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.model;

/**
 *
 * @author frank
 */
public class ItemCarritoInterno {
    private int idProducto;
    private String nombre;
    private double precio;
    private int cantidad;
    private int stock;

    public ItemCarritoInterno() {}

    public ItemCarritoInterno(int idProducto, String nombre, double precio, int cantidad, int stock) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
        this.stock = stock;
    }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public double getSubtotal() {
        return precio * cantidad;
    }
}