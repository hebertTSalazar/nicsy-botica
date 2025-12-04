/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.VentaResultado;

/**
 *
 * @author frank
 */
@WebServlet("/ComprobantePdfServlet")
public class ComprobantePdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/CarritoServlet");
            return;
        }

        VentaResultado vr = (VentaResultado) session.getAttribute("ultimaVentaResultado");
        String nombreCliente = (String) session.getAttribute("ultimaVentaCliente");
        String metodoEntrega = (String) session.getAttribute("ultimaVentaMetodoEntrega");

        @SuppressWarnings("unchecked")
        List<ItemCarrito> items = (List<ItemCarrito>) session.getAttribute("ultimaVentaItems");

        if (vr == null || items == null || items.isEmpty()) {
            session.setAttribute("msgCarritoError",
                    "No se encontraron datos para generar el comprobante.");
            response.sendRedirect(request.getContextPath() + "/CarritoServlet");
            return;
        }

        String nombreArchivo = "comprobante_" + vr.getNumeroComprobante() + ".pdf";

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + nombreArchivo + "\"");

        try {
            generarPdf(vr, nombreCliente, metodoEntrega, items, response);
        } catch (DocumentException e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                    "<h3>Error al generar el comprobante en PDF: "
                    + e.getMessage() + "</h3>");
        }
    }

    /**
     * Genera un PDF con formato de boleta electrónica (ticket).
     */
    private void generarPdf(VentaResultado vr,
                            String nombreCliente,
                            String metodoEntrega,
                            List<ItemCarrito> items,
                            HttpServletResponse response)
            throws DocumentException, IOException {

        // Página tipo ticket (más angosta) pero usando alto de A4
        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Fuentes tipo ticket
        Font tituloFont   = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
        Font negrita      = FontFactory.getFont(FontFactory.COURIER_BOLD, 9);
        Font normal       = FontFactory.getFont(FontFactory.COURIER, 9);
        Font smallNormal  = FontFactory.getFont(FontFactory.COURIER, 8);

        // Fecha y hora actual de emisión del PDF
        LocalDateTime ahora = LocalDateTime.now();
        DateTimeFormatter fFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter fHora  = DateTimeFormatter.ofPattern("HH:mm:ss");

        String fechaStr = ahora.format(fFecha);
        String horaStr  = ahora.format(fHora);

        // =========================================================
        // ENCABEZADO PRINCIPAL
        // =========================================================
        Paragraph p;

        p = new Paragraph("BOTICA NICSY", tituloFont);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);

        p = new Paragraph("CAYALTÍ - LAMBAYEQUE", normal);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);

        p = new Paragraph("Av. 09 de Octubre Mz 8 Lt. 01 - Cayaltí", normal);
        p.setAlignment(Element.ALIGN_CENTER);
        p.setSpacingAfter(4f);
        document.add(p);

        Paragraph linea = new Paragraph("----------------------------------------", normal);
        linea.setAlignment(Element.ALIGN_CENTER);
        document.add(linea);

        p = new Paragraph("BOLETA ELECTRÓNICA N° " + vr.getNumeroComprobante(), negrita);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);

        p = new Paragraph("FECHA: " + fechaStr + "    HORA: " + horaStr, smallNormal);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);

        p = new Paragraph("MÉTODO ENTREGA: " + (metodoEntrega != null ? metodoEntrega.toUpperCase() : ""),
                smallNormal);
        p.setAlignment(Element.ALIGN_CENTER);
        p.setSpacingAfter(4f);
        document.add(p);

        linea = new Paragraph("----------------------------------------", normal);
        linea.setAlignment(Element.ALIGN_CENTER);
        document.add(linea);

        // Datos del cliente
        p = new Paragraph("CLIENTE: " + (nombreCliente != null ? nombreCliente : "Cliente General"),
                smallNormal);
        p.setAlignment(Element.ALIGN_LEFT);
        document.add(p);

        document.add(new Paragraph(" ", normal)); // espacio

        // =========================================================
        // DETALLE DE PRODUCTOS
        // =========================================================
        Paragraph tituloDetalle = new Paragraph("DETALLE DE LA COMPRA", negrita);
        tituloDetalle.setAlignment(Element.ALIGN_CENTER);
        tituloDetalle.setSpacingAfter(4f);
        document.add(tituloDetalle);

        PdfPTable tablaDetalle = new PdfPTable(4);
        tablaDetalle.setWidthPercentage(100);
        tablaDetalle.setWidths(new float[]{3.0f, 1.0f, 1.2f, 1.3f});

        // Cabecera
        tablaDetalle.addCell(celdaHeader("DESCRIPCIÓN"));
        tablaDetalle.addCell(celdaHeader("CANT."));
        tablaDetalle.addCell(celdaHeader("P.UNIT"));
        tablaDetalle.addCell(celdaHeader("IMPORTE"));

        for (ItemCarrito item : items) {
            tablaDetalle.addCell(celdaNormalIzq(item.getNombre()));
            tablaDetalle.addCell(celdaNormalCen(String.valueOf(item.getCantidad())));
            tablaDetalle.addCell(celdaNormalDer(
                    "S/ " + item.getPrecioUnitario().setScale(2, RoundingMode.HALF_UP)));
            tablaDetalle.addCell(celdaNormalDer(
                    "S/ " + item.getSubtotal().setScale(2, RoundingMode.HALF_UP)));
        }

        document.add(tablaDetalle);

        document.add(new Paragraph(" ", normal));

        linea = new Paragraph("----------------------------------------", normal);
        linea.setAlignment(Element.ALIGN_CENTER);
        document.add(linea);

        // =========================================================
        // CÁLCULO DE SUBTOTAL / IGV / ENVÍO / TOTAL
        // =========================================================
        BigDecimal subtotal = vr.getSubtotal() != null ? vr.getSubtotal() : BigDecimal.ZERO;
        BigDecimal envio    = vr.getEnvio()    != null ? vr.getEnvio()    : BigDecimal.ZERO;
        BigDecimal total    = vr.getTotal()    != null ? vr.getTotal()    : subtotal.add(envio);

        // IGV = total - envío - subtotal (si sale negativo, calculamos 18 % del subtotal)
        BigDecimal igv = total.subtract(envio).subtract(subtotal);
        if (igv.compareTo(BigDecimal.ZERO) < 0) {
            igv = subtotal.multiply(new BigDecimal("0.18")).setScale(2, RoundingMode.HALF_UP);
            total = subtotal.add(igv).add(envio);
        }

        PdfPTable tablaTotales = new PdfPTable(2);
        tablaTotales.setWidthPercentage(60);
        tablaTotales.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tablaTotales.setWidths(new float[]{1.2f, 1.0f});

        agregarFilaTotal(tablaTotales, "SUBTOTAL:", subtotal);
        agregarFilaTotal(tablaTotales, "IGV (18%):", igv);
        agregarFilaTotal(tablaTotales, "ENVÍO:", envio);
        agregarFilaTotal(tablaTotales, "TOTAL A PAGAR:", total);

        document.add(tablaTotales);

        document.add(new Paragraph(" ", normal));

        linea = new Paragraph("----------------------------------------", normal);
        linea.setAlignment(Element.ALIGN_CENTER);
        document.add(linea);

        Paragraph gracias = new Paragraph(
                "¡Gracias por su compra!\nConserve su comprobante.",
                smallNormal);
        gracias.setAlignment(Element.ALIGN_CENTER);
        gracias.setSpacingBefore(4f);
        document.add(gracias);

        document.close();
    }

    // =========================================================
    // Helpers de celdas
    // =========================================================
    private PdfPCell celdaHeader(String texto) {
        Font headerFont = FontFactory.getFont(FontFactory.COURIER_BOLD, 9);
        PdfPCell cell = new PdfPCell(new Phrase(texto, headerFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        return cell;
    }

    private PdfPCell celdaNormalIzq(String texto) {
        Font normal = FontFactory.getFont(FontFactory.COURIER, 8);
        PdfPCell cell = new PdfPCell(new Phrase(texto, normal));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }

    private PdfPCell celdaNormalCen(String texto) {
        Font normal = FontFactory.getFont(FontFactory.COURIER, 8);
        PdfPCell cell = new PdfPCell(new Phrase(texto, normal));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        return cell;
    }

    private PdfPCell celdaNormalDer(String texto) {
        Font normal = FontFactory.getFont(FontFactory.COURIER, 8);
        PdfPCell cell = new PdfPCell(new Phrase(texto, normal));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return cell;
    }

    private void agregarFilaTotal(PdfPTable tabla, String etiqueta, BigDecimal valor) {
        Font negrita = FontFactory.getFont(FontFactory.COURIER_BOLD, 9);
        Font normal = FontFactory.getFont(FontFactory.COURIER, 9);

        if (valor == null) {
            valor = BigDecimal.ZERO;
        }
        valor = valor.setScale(2, RoundingMode.HALF_UP);

        PdfPCell c1 = new PdfPCell(new Phrase(etiqueta, negrita));
        c1.setBorder(PdfPCell.NO_BORDER);
        c1.setHorizontalAlignment(Element.ALIGN_RIGHT);

        PdfPCell c2 = new PdfPCell(new Phrase("S/ " + valor, normal));
        c2.setBorder(PdfPCell.NO_BORDER);
        c2.setHorizontalAlignment(Element.ALIGN_RIGHT);

        tabla.addCell(c1);
        tabla.addCell(c2);
    }
}