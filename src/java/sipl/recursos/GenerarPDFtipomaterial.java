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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import sipl.db.Conexion;
import sipl.db.tipo_materialDAO;
import sipl.dominio.Tipo_material;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class GenerarPDFtipomaterial {

    private static final Conexion con = new Conexion();
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
    private static String imgG = "";

    public void generarPDF(String titulo, String imge, Usuario usuario, String dir, String Filex) throws BadElementException, IOException {
        FILE = "";
        Titulo = "";
        direc = "";
        imgG = "";
        imgG = imge;
        user = usuario;
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
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
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
        document.add(catPart);
    }

    private static void createTable(Section subCatPart)
            throws BadElementException {
        ArrayList<Tipo_material> Tipos = tipDAO.getTipo_material();
        PdfPTable table = new PdfPTable(5);
        PdfPCell c1 = new PdfPCell(new Phrase("Cat."));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Nombre"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Descripción"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Cantidad"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        c1 = new PdfPCell(new Phrase("Disponibilidad"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        table.setHeaderRows(1);
        if (Tipos.isEmpty()) {
            table.addCell("No hay Tipos de Material");
        } else {
            int cont = 0;
            for (int i = 0; i < Tipos.size(); i++) {
                table.addCell("" + Tipos.get(i).getId());
                table.addCell("" + Tipos.get(i).getNombre());
                table.addCell("" + Tipos.get(i).getDescripcion());
                table.addCell("" + Tipos.get(i).getCantidad());
                table.addCell("" + Tipos.get(i).getDisponibilidad());
                cont += Tipos.get(i).getCantidad();
            }
            table.addCell("");
            table.addCell("");
            table.addCell("Total Materiales");
            table.addCell("" + cont);
            table.addCell("");
        }
        subCatPart.add(table);
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
