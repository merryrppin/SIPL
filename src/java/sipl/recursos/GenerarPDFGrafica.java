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
import sipl.db.danhoDAO;
import sipl.db.materialDAO;
import sipl.db.multaDAO;
import sipl.db.prestamoDAO;
import sipl.db.tipo_materialDAO;
import sipl.db.usuarioDAO;
import sipl.dominio.Danho;
import sipl.dominio.Material;
import sipl.dominio.Multa;
import sipl.dominio.Prestamo;
import sipl.dominio.Tipo_material;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class GenerarPDFGrafica {

    private static final Conexion con = new Conexion();
    private static final materialDAO matDAO = new materialDAO(con);
    private static final prestamoDAO preDAO = new prestamoDAO(con);
    private static final tipo_materialDAO tipDAO = new tipo_materialDAO(con);
    private static final multaDAO mulDAO = new multaDAO(con);
    private static final danhoDAO danDAO = new danhoDAO(con);
    private static final usuarioDAO usuDAO = new usuarioDAO(con);
    private static String FILE = "";
    private static final Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
            Font.BOLD);
    private static final Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16,
            Font.BOLD);
    private static final Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12,
            Font.BOLD);
    private static String Titulo = "";
    private static Usuario user;
    private static String direc = "";
    private static String fecha1 = "";
    private static String fecha2 = "";
    private static String rango = "";
    private static String imgG = "";

    public void generarPDF(String titulo, String imagen, Usuario usu, String dir, String Fecha1, String Fecha2, String Rango) throws BadElementException, IOException {
        FILE = "";
        Titulo = "";
        direc = "";
        fecha1 = "";
        fecha2 = "";
        rango = "";
        imgG = "";
        imgG = imagen;
        fecha1 = Fecha1;
        fecha2 = Fecha2;
        rango = Rango;
        user = usu;
        direc += dir;
        Titulo = titulo;
        Calendar cal1 = Calendar.getInstance();
        String fecha = cal1.get(Calendar.YEAR) + "-";
        int mes = cal1.get(Calendar.MONTH);
        mes++;
        fecha += mes + "-";
        fecha += cal1.get(Calendar.DAY_OF_MONTH);
        fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
        fecha += "-" + cal1.get(Calendar.MINUTE);
        fecha += "-" + cal1.get(Calendar.SECOND);
        FILE += titulo + " " + fecha + ".pdf";
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

    private static void addMetaData(Document document) {
        document.addTitle(Titulo);
        document.addSubject("Gráfica");
        document.addKeywords("Java, Gráfica, PDF, iText");
        document.addAuthor("Wilmar González - Sandra Vera");
        document.addCreator("SIPL");
    }

    private static void addTitlePage(Document document)
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
        Paragraph preface1 = new Paragraph();
        preface1.add(new Paragraph("Gráfica",
                smallBold));
        addEmptyLine(preface1, 20);
        img = Image.getInstance(imgG);
        img.scaleAbsolute(400, 300);
        img.setAlignment(Image.ALIGN_CENTER);
        c = new Chunk(img, 0, 0);
        preface1.add(c);
        document.add(preface1);
        document.newPage();
    }

    private static void addContent(Document document) throws DocumentException {
        Anchor anchor = new Anchor(Titulo, catFont);
        anchor.setName(Titulo);
        Chapter catPart = new Chapter(new Paragraph(anchor), 1);
        Paragraph subPara = new Paragraph("", subFont);
        Section subCatPart = catPart.addSection(subPara);
        createTable(subCatPart);
        String p = Titulo.charAt(0) + "";
        if (p.equals("M")) {
            subPara = new Paragraph("", subFont);
            subCatPart = catPart.addSection(subPara);
            createTable2(subCatPart);
        }
        document.add(catPart);

    }

    private static void createTable(Section subCatPart)
            throws BadElementException {
        String p = Titulo.charAt(0) + "";
        if (p.equals("P")) {
            ArrayList<Prestamo> prestamos = preDAO.getRangoFecha_prestamo(fecha1, fecha2);
            ArrayList<Material> materiales = matDAO.getMateriales();
            if (rango.equals("Anho")) {
                int T[][] = new int[materiales.size()][2];
                for (int i = 0; i < materiales.size(); i++) {
                    T[i][0] = materiales.get(i).getCodigo();
                    T[i][1] = 0;
                }
                for (int i = 0; i < prestamos.size(); i++) {
                    String[] P = prestamos.get(i).getMat().split(";");
                    for (String P1 : P) {
                        for (int k = 0; k < materiales.size(); k++) {
                            int c;
                            if (T[k][0] == Integer.parseInt(P1)) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                }
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (prestamos.isEmpty()) {
                    table.addCell("No hay préstamos en ese rango de fecha");
                } else {
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                }
                table.addCell("");
                table.addCell("");
                table.addCell("Año");
                table.addCell("Cantidad Préstamos");
                String[] f1 = fecha1.split("/");
                int a = Integer.parseInt(f1[0]);
                String[] f2 = fecha2.split("/");
                int b = Integer.parseInt(f2[0]);
                int dif = b - a;
                dif++;
                int tamY[][] = new int[dif][2];
                for (int i = 0; i < dif; i++) {
                    tamY[i][0] = a;
                    a++;
                }
                for (int j = 0; j < dif; j++) {
                    tamY[j][1] = 0;
                }
                for (int k = 0; k < prestamos.size(); k++) {
                    int t = prestamos.get(k).getFecha_prestamo().get(Calendar.YEAR);
                    for (int l = 0; l < dif; l++) {
                        if (tamY[l][0] == t) {
                            int cant = tamY[l][1];
                            cant++;
                            tamY[l][1] = cant;
                        }
                    }
                }
                for (int i = 0; i < dif; i++) {
                    if (tamY[i][1] > 0) {
                        table.addCell("" + tamY[i][0]);
                        table.addCell("" + tamY[i][1]);
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Mes")) {
                int T[][] = new int[materiales.size()][2];
                for (int i = 0; i < materiales.size(); i++) {
                    T[i][0] = materiales.get(i).getCodigo();
                    T[i][1] = 0;
                }
                for (int i = 0; i < prestamos.size(); i++) {
                    String[] P = prestamos.get(i).getMat().split(";");
                    for (String P1 : P) {
                        for (int k = 0; k < materiales.size(); k++) {
                            int c;
                            if (T[k][0] == Integer.parseInt(P1)) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                }
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (prestamos.isEmpty()) {
                    table.addCell("No hay préstamos en ese rango de fecha");
                } else {
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                }
                table.addCell("");
                table.addCell("");
                table.addCell("Mes");
                table.addCell("Cantidad Préstamos");
                String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                int tamY[][] = new int[12][2];
                for (int i = 0; i < 12; i++) {
                    tamY[i][0] = i;
                }
                for (int j = 0; j < 12; j++) {
                    tamY[j][1] = 0;
                }
                for (int k = 0; k < prestamos.size(); k++) {
                    int t = prestamos.get(k).getFecha_prestamo().get(Calendar.MONTH);
                    for (int l = 0; l < 12; l++) {
                        if (tamY[l][0] == t) {
                            int cant = tamY[l][1];
                            cant++;
                            tamY[l][1] = cant;
                        }
                    }
                }
                for (int i = 0; i < 12; i++) {
                    if (tamY[i][1] > 0) {
                        table.addCell("" + meses[i]);
                        table.addCell("" + tamY[i][1]);
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Dia")) {
                int T[][] = new int[materiales.size()][2];
                for (int i = 0; i < materiales.size(); i++) {
                    T[i][0] = materiales.get(i).getCodigo();
                    T[i][1] = 0;
                }
                for (int i = 0; i < prestamos.size(); i++) {
                    String[] P = prestamos.get(i).getMat().split(";");
                    for (String P1 : P) {
                        for (int k = 0; k < materiales.size(); k++) {
                            int c;
                            if (T[k][0] == Integer.parseInt(P1)) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                }
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (prestamos.isEmpty()) {
                    table.addCell("No hay préstamos en ese rango de fecha");
                } else {
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                }
                table.addCell("");
                table.addCell("");
                table.addCell("Dia");
                table.addCell("Cantidad Préstamos");
                int tamY[][] = new int[32][2];
                for (int i = 0; i < 32; i++) {
                    tamY[i][0] = i;
                }
                for (int j = 0; j < 32; j++) {
                    tamY[j][1] = 0;
                }
                for (int k = 0; k < prestamos.size(); k++) {
                    int t = prestamos.get(k).getFecha_prestamo().get(Calendar.DAY_OF_MONTH);
                    for (int l = 0; l < 32; l++) {
                        if (tamY[l][0] == t) {
                            int cant = tamY[l][1];
                            cant++;
                            tamY[l][1] = cant;
                        }
                    }
                }
                for (int i = 0; i < 32; i++) {
                    if (tamY[i][1] > 0) {
                        table.addCell("" + i);
                        table.addCell("" + tamY[i][1]);
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Hora")) {
                int T[][] = new int[materiales.size()][2];
                for (int i = 0; i < materiales.size(); i++) {
                    T[i][0] = materiales.get(i).getCodigo();
                    T[i][1] = 0;
                }
                for (int i = 0; i < prestamos.size(); i++) {
                    String[] P = prestamos.get(i).getMat().split(";");
                    for (String P1 : P) {
                        for (int k = 0; k < materiales.size(); k++) {
                            int c;
                            if (T[k][0] == Integer.parseInt(P1)) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                }
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (prestamos.isEmpty()) {
                    table.addCell("No hay préstamos en ese rango de fecha");
                } else {
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                }
                table.addCell("");
                table.addCell("");
                table.addCell("Hora");
                table.addCell("Cantidad Préstamos");
                int tamY[][] = new int[24][2];
                for (int i = 0; i < 24; i++) {
                    tamY[i][0] = i;
                }
                for (int j = 0; j < 24; j++) {
                    tamY[j][1] = 0;
                }
                for (int k = 0; k < prestamos.size(); k++) {
                    int t = prestamos.get(k).getFecha_prestamo().get(Calendar.HOUR_OF_DAY);
                    for (int l = 0; l < 24; l++) {
                        if (tamY[l][0] == t) {
                            int cant = tamY[l][1];
                            cant++;
                            tamY[l][1] = cant;
                        }
                    }
                }
                for (int i = 0; i < 24; i++) {
                    if (tamY[i][1] > 0) {
                        table.addCell("" + i);
                        table.addCell("" + tamY[i][1]);
                    }
                }
                subCatPart.add(table);
            }
        } else if (p.equals("M")) {
            ArrayList<Multa> multas = mulDAO.getRangoFecha_multa(fecha1, fecha2);
            if (rango.equals("Anho")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Año"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Multas"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (multas.isEmpty()) {
                    table.addCell("No hay multas en ese rango de fecha");
                } else {
                    String[] f1 = fecha1.split("/");
                    int a = Integer.parseInt(f1[0]);
                    String[] f2 = fecha2.split("/");
                    int b = Integer.parseInt(f2[0]);
                    int dif = b - a;
                    dif++;

                    int tamY[][] = new int[dif][2];
                    int u = a;
                    for (int i = 0; i < dif; i++) {
                        tamY[i][0] = u;
                        u++;
                    }
                    for (int j = 0; j < dif; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < multas.size(); k++) {
                        int t = multas.get(k).getFecha_multa().get(Calendar.YEAR);
                        for (int l = 0; l < dif; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < dif; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + tamY[i][0]);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Mes")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Mes"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Multas"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (multas.isEmpty()) {
                    table.addCell("No hay multas en ese rango de fecha");
                } else {
                    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                    int tamY[][] = new int[12][2];
                    for (int i = 0; i < 12; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 12; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < multas.size(); k++) {
                        int t = multas.get(k).getFecha_multa().get(Calendar.MONTH);
                        for (int l = 0; l < 12; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 12; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + meses[i]);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Dia")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Día del mes"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Multas"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (multas.isEmpty()) {
                    table.addCell("No hay multas en ese rango de fecha");
                } else {
                    int tamY[][] = new int[32][2];
                    for (int i = 0; i < 32; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 32; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < multas.size(); k++) {
                        int t = multas.get(k).getFecha_multa().get(Calendar.DAY_OF_MONTH);
                        for (int l = 0; l < 32; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 32; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + i);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                }
                subCatPart.add(table);
            } else if (rango.equals("Hora")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Hora del día"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Multas"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (multas.isEmpty()) {
                    table.addCell("No hay multas en ese rango de fecha");
                } else {
                    int tamY[][] = new int[24][2];
                    for (int i = 0; i < 24; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 24; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < multas.size(); k++) {
                        int t = multas.get(k).getFecha_multa().get(Calendar.HOUR_OF_DAY);
                        for (int l = 0; l < 24; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 24; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + i);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                }
                subCatPart.add(table);
            }
        } else if (p.equals("D")) {
            ArrayList<Danho> danhos = danDAO.getRangoFecha_danhos(fecha1, fecha2);
            ArrayList<Material> materiales = matDAO.getMateriales();
            if (rango.equals("Anho")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (danhos.isEmpty()) {
                    table.addCell("No hay daños en ese rango de fecha");
                } else {
                    int T[][] = new int[materiales.size()][2];
                    for (int i = 0; i < materiales.size(); i++) {
                        T[i][0] = materiales.get(i).getCodigo();
                        T[i][1] = 0;
                    }
                    for (int i = 0; i < danhos.size(); i++) {
                        int P = danhos.get(i).getMat().getCodigo();
                        for (int k = 0; k < materiales.size(); k++) {
                            int c = 0;
                            if (T[k][0] == P) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c = 0;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Año"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad Daños"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    String[] f1 = fecha1.split("/");
                    int a = Integer.parseInt(f1[0]);
                    String[] f2 = fecha2.split("/");
                    int b = Integer.parseInt(f2[0]);
                    int dif = b - a;
                    dif++;
                    int tamY[][] = new int[dif][2];
                    int u = a;
                    for (int i = 0; i < dif; i++) {
                        tamY[i][0] = u;
                        u++;
                    }
                    for (int j = 0; j < dif; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int t = danhos.get(k).getFecha_d().get(Calendar.YEAR);
                        for (int l = 0; l < dif; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < dif; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + tamY[i][0]);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Estado"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tipoD[] = new int[3];
                    for (int i = 0; i < 3; i++) {
                        tipoD[i] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int cont;
                        if (danhos.get(k).getEstado() == 0) {
                            cont = tipoD[0];
                            cont++;
                            tipoD[0] = cont;
                        } else if (danhos.get(k).getEstado() == 1) {
                            cont = tipoD[1];
                            cont++;
                            tipoD[1] = cont;
                        } else if (danhos.get(k).getEstado() == 2) {
                            cont = tipoD[2];
                            cont++;
                            tipoD[2] = cont;
                        }
                    }
                    table.addCell("Dañado");
                    table.addCell("" + tipoD[0]);
                    table.addCell("Reparado");
                    table.addCell("" + tipoD[1]);
                    table.addCell("Dado de Baja");
                    table.addCell("" + tipoD[2]);
                }
                subCatPart.add(table);
            } else if (rango.equals("Mes")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (danhos.isEmpty()) {
                    table.addCell("No hay daños en ese rango de fecha");
                } else {
                    int T[][] = new int[materiales.size()][2];
                    for (int i = 0; i < materiales.size(); i++) {
                        T[i][0] = materiales.get(i).getCodigo();
                        T[i][1] = 0;
                    }
                    for (int i = 0; i < danhos.size(); i++) {
                        int P = danhos.get(i).getMat().getCodigo();
                        for (int k = 0; k < materiales.size(); k++) {
                            int c = 0;
                            if (T[k][0] == P) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c = 0;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Mes"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad Daños"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                    int tamY[][] = new int[12][2];
                    for (int i = 0; i < 12; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 12; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int t = danhos.get(k).getFecha_d().get(Calendar.MONTH);
                        for (int l = 0; l < 12; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 12; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + meses[i]);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Estado"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tipoD[] = new int[3];
                    for (int i = 0; i < 3; i++) {
                        tipoD[i] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int cont;
                        if (danhos.get(k).getEstado() == 0) {
                            cont = tipoD[0];
                            cont++;
                            tipoD[0] = cont;
                        } else if (danhos.get(k).getEstado() == 1) {
                            cont = tipoD[1];
                            cont++;
                            tipoD[1] = cont;
                        } else if (danhos.get(k).getEstado() == 2) {
                            cont = tipoD[2];
                            cont++;
                            tipoD[2] = cont;
                        }
                    }
                    table.addCell("Dañado");
                    table.addCell("" + tipoD[0]);
                    table.addCell("Reparado");
                    table.addCell("" + tipoD[1]);
                    table.addCell("Dado de Baja");
                    table.addCell("" + tipoD[2]);
                }
                subCatPart.add(table);
            } else if (rango.equals("Dia")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (danhos.isEmpty()) {
                    table.addCell("No hay daños en ese rango de fecha");
                } else {
                    int T[][] = new int[materiales.size()][2];
                    for (int i = 0; i < materiales.size(); i++) {
                        T[i][0] = materiales.get(i).getCodigo();
                        T[i][1] = 0;
                    }
                    for (int i = 0; i < danhos.size(); i++) {
                        int P = danhos.get(i).getMat().getCodigo();
                        for (int k = 0; k < materiales.size(); k++) {
                            int c = 0;
                            if (T[k][0] == P) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c = 0;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Día del mes"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad Daños"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tamY[][] = new int[32][2];
                    for (int i = 0; i < 32; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 32; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int t = danhos.get(k).getFecha_d().get(Calendar.DAY_OF_MONTH);
                        for (int l = 0; l < 32; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 32; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + i);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Estado"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tipoD[] = new int[3];
                    for (int i = 0; i < 3; i++) {
                        tipoD[i] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int cont;
                        if (danhos.get(k).getEstado() == 0) {
                            cont = tipoD[0];
                            cont++;
                            tipoD[0] = cont;
                        } else if (danhos.get(k).getEstado() == 1) {
                            cont = tipoD[1];
                            cont++;
                            tipoD[1] = cont;
                        } else if (danhos.get(k).getEstado() == 2) {
                            cont = tipoD[2];
                            cont++;
                            tipoD[2] = cont;
                        }
                    }
                    table.addCell("Dañado");
                    table.addCell("" + tipoD[0]);
                    table.addCell("Reparado");
                    table.addCell("" + tipoD[1]);
                    table.addCell("Dado de Baja");
                    table.addCell("" + tipoD[2]);
                }
                subCatPart.add(table);
            } else if (rango.equals("Hora")) {
                PdfPTable table = new PdfPTable(2);
                PdfPCell c1 = new PdfPCell(new Phrase("Categoría Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                c1 = new PdfPCell(new Phrase("Cantidad Material"));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(c1);
                table.setHeaderRows(1);
                if (danhos.isEmpty()) {
                    table.addCell("No hay daños en ese rango de fecha");
                } else {
                    int T[][] = new int[materiales.size()][2];
                    for (int i = 0; i < materiales.size(); i++) {
                        T[i][0] = materiales.get(i).getCodigo();
                        T[i][1] = 0;
                    }
                    for (int i = 0; i < danhos.size(); i++) {
                        int P = danhos.get(i).getMat().getCodigo();
                        for (int k = 0; k < materiales.size(); k++) {
                            int c = 0;
                            if (T[k][0] == P) {
                                c = T[k][1];
                                c++;
                                T[k][1] = c;
                                k = materiales.size();
                            }
                        }
                    }
                    ArrayList<Tipo_material> tm = tipDAO.getTipo_material();
                    int TM[][] = new int[tm.size()][2];
                    for (int i = 0; i < tm.size(); i++) {
                        TM[i][0] = tm.get(i).getId();
                        TM[i][1] = 0;
                    }
                    for (int i = 0; i < T.length; i++) {
                        int c = 0;
                        Material mat = matDAO.getMaterial(T[i][0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T[i][1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int i = 0; i < TM.length; i++) {
                        if (TM[i][1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM[i][0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Hora del día"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad Daños"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tamY[][] = new int[24][2];
                    for (int i = 0; i < 24; i++) {
                        tamY[i][0] = i;
                    }
                    for (int j = 0; j < 24; j++) {
                        tamY[j][1] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        Calendar cy = danhos.get(k).getFecha_d();
                        int t = danhos.get(k).getFecha_d().get(Calendar.HOUR_OF_DAY);
                        for (int l = 0; l < 24; l++) {
                            if (tamY[l][0] == t) {
                                int cant = tamY[l][1];
                                cant++;
                                tamY[l][1] = cant;
                            }
                        }
                    }
                    for (int i = 0; i < 24; i++) {
                        if (tamY[i][1] > 0) {
                            table.addCell("" + i);
                            table.addCell("" + tamY[i][1]);
                        }
                    }
                    c1 = new PdfPCell(new Phrase("Estado"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    c1 = new PdfPCell(new Phrase("Cantidad"));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(c1);
                    int tipoD[] = new int[3];
                    for (int i = 0; i < 3; i++) {
                        tipoD[i] = 0;
                    }
                    for (int k = 0; k < danhos.size(); k++) {
                        int cont;
                        if (danhos.get(k).getEstado() == 0) {
                            cont = tipoD[0];
                            cont++;
                            tipoD[0] = cont;
                        } else if (danhos.get(k).getEstado() == 1) {
                            cont = tipoD[1];
                            cont++;
                            tipoD[1] = cont;
                        } else if (danhos.get(k).getEstado() == 2) {
                            cont = tipoD[2];
                            cont++;
                            tipoD[2] = cont;
                        }
                    }
                    table.addCell("Dañado");
                    table.addCell("" + tipoD[0]);
                    table.addCell("Reparado");
                    table.addCell("" + tipoD[1]);
                    table.addCell("Dado de Baja");
                    table.addCell("" + tipoD[2]);
                }
                subCatPart.add(table);
            }
        }
    }

    private static void createTable2(Section subCatPart)
            throws BadElementException {
        ArrayList<Multa> multas = mulDAO.getRangoFecha_multa(fecha1, fecha2);
        ArrayList<Usuario> usuarios = usuDAO.getUsuarios();
        String codusuarios[] = new String[usuarios.size()];
        int canMult[] = new int[usuarios.size()];
        for (int i = 0; i < usuarios.size(); i++) {
            codusuarios[i] = usuarios.get(i).getCodigo();
            canMult[i] = 0;
        }
        for (int i = 0; i < multas.size(); i++) {
            for (int j = 0; j < usuarios.size(); j++) {
                if (codusuarios[j].equals(multas.get(i).getUsu().getCodigo())) {
                    canMult[j]++;
                    j = usuarios.size();
                }
            }
        }
        PdfPTable table = new PdfPTable(4);
        PdfPCell c1 = new PdfPCell(new Phrase("Usuario"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Nombre"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Apellidos"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Cantidad Multas"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        table.setHeaderRows(1);
        if (multas.isEmpty()) {
            table.addCell("No hay multas en ese rango de fecha");
        } else {
            for (int i = 0; i < usuarios.size(); i++) {
                if (canMult[i] > 0) {
                    Usuario usuario1 = usuDAO.getUsuario(codusuarios[i]);
                    table.addCell("" + codusuarios[i]);
                    table.addCell("" + usuario1.getNombre());
                    table.addCell("" + usuario1.getApellido());
                    table.addCell("" + canMult[i]);
                }
            }
            subCatPart.add(table);
        }
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
