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
public class VentaResultado {
    private int idVenta;
    private String numeroComprobante;
    private BigDecimal subtotal;
    private BigDecimal envio;
    private BigDecimal total;

    public VentaResultado() {
    }

    public VentaResultado(int idVenta, String numeroComprobante,
                          BigDecimal subtotal, BigDecimal envio, BigDecimal total) {
        this.idVenta = idVenta;
        this.numeroComprobante = numeroComprobante;
        this.subtotal = subtotal;
        this.envio = envio;
        this.total = total;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public String getNumeroComprobante() {
        return numeroComprobante;
    }

    public void setNumeroComprobante(String numeroComprobante) {
        this.numeroComprobante = numeroComprobante;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getEnvio() {
        return envio;
    }

    public void setEnvio(BigDecimal envio) {
        this.envio = envio;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}
