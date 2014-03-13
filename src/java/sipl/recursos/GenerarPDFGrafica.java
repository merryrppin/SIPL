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
import sipl.db.prestamoDAO;
import sipl.db.tipo_materialDAO;
import sipl.dominio.Material;
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

    public void generarPDF(String titulo, String imagen, Usuario usu, String dir, String Fecha1, String Fecha2, String Rango) throws BadElementException, IOException {
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
        preface.add(new Paragraph("Este documento es creado a petición del autor",
                smallBold));
        preface.add(c);
        document.add(preface);
        document.newPage();
    }

    private static void addContent(Document document) throws DocumentException {
        Anchor anchor = new Anchor(Titulo, catFont);
        anchor.setName(Titulo);

        Chapter catPart = new Chapter(new Paragraph(anchor), 1);

        Paragraph subPara = new Paragraph("", subFont);
        Section subCatPart = catPart.addSection(subPara);

        createTable(subCatPart);

        document.add(catPart);

    }

    private static void createTable(Section subCatPart)
            throws BadElementException {
        String p = Titulo.charAt(0) + "";
        String f[] = fecha1.split("/");
        String fe = f[2] + "/" + f[1] + "/" + f[0] + " 00:00:00";
        String f2[] = fecha2.split("/");
        String fe2 = f2[2] + "/" + f2[1] + "/" + f2[0] + " 23:59:59";
        if (p.equals("P")) {
            ArrayList<Prestamo> prestamos = preDAO.getRangoFecha_prestamo(fe, fe2);
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
                    for (int[] T1 : T) {
                        int c;
                        Material mat = matDAO.getMaterial(T1[0]);
                        for (int j = 0; j < TM.length; j++) {
                            if (TM[j][0] == mat.getTipo_mat().getId()) {
                                c = TM[j][1];
                                c += T1[1];
                                TM[j][1] = c;
                                j = tm.size();
                            }
                        }
                    }
                    for (int[] TM1 : TM) {
                        if (TM1[1] > 0) {
                            Tipo_material tip = tipDAO.getTipo_material(TM1[0]);
                            table.addCell("" + tip.getNombre());
                            table.addCell("" + TM1[1]);
                        }
                    }
                }
                subCatPart.add(table);
            }
        }

    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
