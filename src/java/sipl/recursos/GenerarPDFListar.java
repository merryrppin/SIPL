/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import com.itextpdf.text.Anchor;
import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import sipl.db.Conexion;
import sipl.db.materialDAO;
import sipl.db.usuarioDAO;
import sipl.db.laboratorioDAO;
import sipl.db.reservaDAO;
import sipl.db.multaDAO;
import sipl.db.prestamoDAO;
import sipl.db.danhoDAO;
import sipl.dominio.Danho;
import sipl.dominio.Prestamo;
import sipl.dominio.Laboratorio;
import sipl.dominio.Material;
import sipl.dominio.Usuario;
import sipl.dominio.Reserva;
import sipl.dominio.Multa;

/**
 *
 * @author WM
 */
public class GenerarPDFListar {

    private final Conexion con = new Conexion();
    private final materialDAO matDAO = new materialDAO(con);
    private final usuarioDAO usuDAO = new usuarioDAO(con);
    private final laboratorioDAO labDAO = new laboratorioDAO(con);
    private final reservaDAO resDAO = new reservaDAO(con);
    private final multaDAO mulDAO = new multaDAO(con);
    private final prestamoDAO preDAO = new prestamoDAO(con);
    private final danhoDAO danDAO = new danhoDAO(con);
    private String FILE = "";
    private final Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
            Font.BOLD);
    private final Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16,
            Font.BOLD);
    private final Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12,
            Font.BOLD);
    private String Titulo = "";
    private Usuario user;
    private String direc = "";

    public void generarPDF(String titulo, String imagen, Usuario usu, String dir, String Filex) throws BadElementException, IOException {
        FILE = "";
        direc = "";
        Titulo = "";
        user = usu;
        direc += dir;
        Titulo = titulo;
        FILE = Filex;
        try {
            Document document = new Document();
            FileOutputStream file = new FileOutputStream(dir + "PDF//" + FILE);
            PdfWriter.getInstance(document, file);
            document.open();
            document.setMargins(10, 10, 10, 10);
            addMetaData(document);
            addTitlePage(document);
            addContent(document);
            document.close();
        } catch (FileNotFoundException | DocumentException e) {
        }
    }
    
    private void addMetaData(Document document) {
        document.addTitle(Titulo);
        document.addSubject("Lista específica");
        document.addKeywords("Java, PDF, iText");
        document.addAuthor("Wilmar González - Sandra Vera");
        document.addCreator("SIPL");
    }

    private void addTitlePage(Document document)
            throws DocumentException, MalformedURLException, BadElementException, IOException {
        Paragraph preface = new Paragraph();
        addEmptyLine(preface, 1);
        preface.add(new Paragraph(Titulo, catFont));
        addEmptyLine(preface, 1);
        preface.add(new Paragraph("Reporte generado por: " + user.getNombre() + " " + user.getApellido() + ", " + new Date(), //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
                smallBold));
        addEmptyLine(preface, 3);
        preface.add(new Paragraph("Este documento es creado a petición del autor",
                smallBold));
        addEmptyLine(preface, 6);
        Image img = Image.getInstance(direc + "img//logo_unab.jpg");
        img.scaleAbsolute(70, 100);
        img.setAlignment(Image.ALIGN_CENTER);
        Chunk c = new Chunk(img, 0, 0);
        preface.add(c);
        document.add(preface);
        document.newPage();
    }

    private void addContent(Document document) throws DocumentException {
        Anchor anchor = new Anchor(Titulo, catFont);
        anchor.setName(Titulo);
        Chapter catPart = new Chapter(new Paragraph(anchor), 1);
        Paragraph subPara = new Paragraph("", subFont);
        Section subCatPart = catPart.addSection(subPara);
        createTable(subCatPart);
        document.add(catPart);
    }

    private void createTable(Section subCatPart) {
        switch (Titulo) {
            case "Listar materiales": {
                ArrayList<Material> materiales = matDAO.getMateriales();
                PdfPTable table = new PdfPTable(7);
                PdfPCell c1 = new PdfPCell(new Phrase("Código"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Tipo"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Marca"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Serial"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado actual"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nro Inventario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Disp"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < materiales.size(); i++) {
                    Material mat = materiales.get(i);
                    table.addCell("" + mat.getCodigo());
                    table.addCell(mat.getTipo_mat().getNombre());
                    table.addCell(mat.getMarca());
                    table.addCell(mat.getSerial());
                    if (mat.getEstado() == 0) {
                        table.addCell("Activo");
                    } else if (mat.getEstado() == 1) {
                        table.addCell("Dado de Baja");
                    } else if (mat.getEstado() == 2) {
                        table.addCell("Dañado");
                    } else {
                        table.addCell("Error");
                    }
                    table.addCell(mat.getNum_inventario());
                    if (mat.getDisponibilidad() == 0) {
                        table.addCell("Libre");
                    } else if (mat.getDisponibilidad() == 1) {
                        table.addCell("Prestado");
                    } else if (mat.getDisponibilidad() == 2) {
                        table.addCell("Reservado");
                    } else {
                        table.addCell("Error");
                    }
                }
                subCatPart.add(table);
                break;
            }
            case "Listar usuarios": {
                ArrayList<Usuario> usuarios = usuDAO.getUsuarios();
                PdfPTable table = new PdfPTable(6);
                PdfPCell c1 = new PdfPCell(new Phrase("Código"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Apellido"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Teléfono"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Correo"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < usuarios.size(); i++) {
                    Usuario usu = usuarios.get(i);
                    table.addCell("" + usu.getCodigo());
                    table.addCell(usu.getNombre());
                    table.addCell(usu.getApellido());
                    table.addCell("" + usu.getTelefono());
                    table.addCell("" + usu.getCorreo());
                    if (usu.getEstado() == 0) {
                        table.addCell("Activo");
                    } else if (usu.getEstado() == 1) {
                        table.addCell("Inactivo");
                    } else if (usu.getEstado() == 2) {
                        table.addCell("Con préstamo");
                    } else if (usu.getEstado() == 3) {
                        table.addCell("Con reserva ");
                    } else if (usu.getEstado() == 4) {
                        table.addCell("Con multa");
                    } else {
                        table.addCell("Error");
                    }
                }
                subCatPart.add(table);
                break;
            }
            case "Listar laboratorios": {
                ArrayList<Laboratorio> laboratorios = labDAO.getLaboratorios();
                PdfPTable table = new PdfPTable(4);
                PdfPCell c1 = new PdfPCell(new Phrase("Código"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Descripción"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Ubicación"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < laboratorios.size(); i++) {
                    Laboratorio lab = laboratorios.get(i);
                    table.addCell("" + lab.getCodigo());
                    table.addCell(lab.getNombre());
                    table.addCell(lab.getDescripcion());
                    table.addCell(lab.getUbicacion());
                }
                subCatPart.add(table);
                break;
            }
            case "Listar reservas": {
                ArrayList<Reserva> reservas = resDAO.getReservas();
                PdfPTable table = new PdfPTable(6);
                PdfPCell c1 = new PdfPCell(new Phrase("Código Reserva"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Apellido Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Código Materiales"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Fecha Reserva"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado Reserva"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < reservas.size(); i++) {
                    Reserva res = reservas.get(i);
                    table.addCell("" + res.getCodigo());
                    table.addCell(res.getUsu().getNombre());
                    table.addCell(res.getUsu().getApellido());
                    table.addCell(res.getMat());
                    Calendar cal1 = res.getFecha_reserva();
                    String fecha = cal1.get(Calendar.YEAR) + "-";
                    int mes = cal1.get(Calendar.MONTH);
                    mes++;
                    fecha += mes + "-";
                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                    table.addCell(fecha);
                    if (res.getEstado() == 0) {
                        table.addCell("Activo");
                    } else if (res.getEstado() == 1) {
                        table.addCell("Inactivo");
                    } else {
                        table.addCell("Error");
                    }
                }
                subCatPart.add(table);
                break;
            }
            case "Listar multas": {
                ArrayList<Multa> multas = mulDAO.getMultas();
                PdfPTable table = new PdfPTable(6);
                PdfPCell c1 = new PdfPCell(new Phrase("Código Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Apellido Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Fecha Multa"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado Multa"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Tiempo Multa"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < multas.size(); i++) {
                    Multa mul = multas.get(i);
                    table.addCell("" + mul.getUsu().getCodigo());
                    table.addCell(mul.getUsu().getNombre());
                    table.addCell(mul.getUsu().getApellido());
                    Calendar cal1 = mul.getFecha_multa();
                    String fecha = cal1.get(Calendar.YEAR) + "-";
                    int mes = cal1.get(Calendar.MONTH);
                    mes++;
                    fecha += mes + "-";
                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                    table.addCell(fecha);
                    if (mul.getEstado_multa() == 0) {
                        table.addCell("Activo");
                    } else if (mul.getEstado_multa() == 1) {
                        table.addCell("Inactivo");
                    } else {
                        table.addCell("Error");
                    }
                    table.addCell("" + mul.getTiempo_multa());
                }
                subCatPart.add(table);
                break;
            }
            case "Listar prestamos": {
                ArrayList<Prestamo> prestamos = preDAO.getprestamos();
                PdfPTable table = new PdfPTable(7);
                PdfPCell c1 = new PdfPCell(new Phrase("Código Préstamo"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Código Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Apellido Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Fecha Préstamo"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Fecha Devolución"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < prestamos.size(); i++) {
                    Prestamo pre = prestamos.get(i);
                    table.addCell("" + pre.getCodigo());
                    table.addCell(pre.getMat());
                    table.addCell(pre.getUsu().getNombre());
                    table.addCell(pre.getUsu().getApellido());
                    Calendar cal1 = pre.getFecha_prestamo();
                    String fecha = cal1.get(Calendar.YEAR) + "-";
                    int mes = cal1.get(Calendar.MONTH);
                    mes++;
                    fecha += mes + "-";
                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                    table.addCell(fecha);
                    Calendar cal2 = pre.getFecha_devolucion();
                    String fecha1 = cal2.get(Calendar.YEAR) + "-";
                    int mes1 = cal2.get(Calendar.MONTH);
                    mes1++;
                    fecha1 += mes1 + "-";
                    fecha1 += cal2.get(Calendar.DAY_OF_MONTH);
                    fecha1 += " " + cal2.get(Calendar.HOUR_OF_DAY);
                    fecha1 += ":" + cal2.get(Calendar.MINUTE) + ":00";
                    table.addCell(fecha1);
                    if (pre.getEstado() == 0) {
                        table.addCell("Activo");
                    } else if (pre.getEstado() == 1) {
                        table.addCell("Inactivo");
                    } else {
                        table.addCell("Error");
                    }
                }
                subCatPart.add(table);
                break;
            }
            case "Listar Danho": {
                ArrayList<Danho> danhos = danDAO.getDanhos();
                PdfPTable table = new PdfPTable(9);
                PdfPCell c1 = new PdfPCell(new Phrase("Descripción Daño"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Código Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Descripción Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Codigo Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Nombre Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Apellidos Usuario"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Fecha Daño"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Daño Reportado por"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Estado"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                for (int i = 0; i < danhos.size(); i++) {
                    Danho dan = danhos.get(i);
                    table.addCell("" + dan.getDescripcion());
                    table.addCell("" + dan.getMat().getCodigo());
                    table.addCell(dan.getMat().getDescripcion());
                    table.addCell(dan.getUsu().getCodigo());
                    table.addCell(dan.getUsu().getNombre());
                    table.addCell(dan.getUsu().getApellido());
                    Calendar cal1 = dan.getFecha_d();
                    String fecha = cal1.get(Calendar.YEAR) + "-";
                    int mes = cal1.get(Calendar.MONTH);
                    mes++;
                    fecha += mes + "-";
                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                    table.addCell(fecha);
                    table.addCell("" + dan.getUsu_rd().getNombre());
                    if (dan.getEstado() == 0) {
                        table.addCell("Dañado");
                    } else if (dan.getEstado() == 1) {
                        table.addCell("Reparado");
                    } else if (dan.getEstado() == 2) {
                        table.addCell("Dado de baja");
                    } else {
                        table.addCell("Error");
                    }
                }
                subCatPart.add(table);
                break;
            }
        }
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
