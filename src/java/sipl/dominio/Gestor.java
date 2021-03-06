/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.dominio;

import com.itextpdf.text.BadElementException;
import java.io.IOException;
import java.util.ArrayList;
import sipl.db.*;
import sipl.recursos.*;

/**
 *
 * @author WM
 */
public class Gestor {

    private final errorDAO errDAO;
    private final usuarioDAO usuDAO;
    private final materialDAO matDAO;
    private final tipo_materialDAO tipDAO;
    private final laboratorioDAO labDAO;
    private final danhoDAO danDAO;
    private final prestamoDAO preDAO;
    private final multaDAO mulDAO;
    private final variableSisDAO varDAO;
    private final reservaDAO resDAO;
    Encri enc = new Encri();
    QRCode qrC = new QRCode();
    Graficar gra = new Graficar();
    GenerarBackupMySQL gen = new GenerarBackupMySQL();
    //RestoreMySQL res = new RestoreMySQL();
    TextoImagen tei = new TextoImagen();
    DesactivarMultas actM = new DesactivarMultas();
    DesactivarReserva actR = new DesactivarReserva();
    AplicarRestore aplR = new AplicarRestore();

    public Gestor() {
        Conexion con = new Conexion();
        usuDAO = new usuarioDAO(con);
        matDAO = new materialDAO(con);
        tipDAO = new tipo_materialDAO(con);
        labDAO = new laboratorioDAO(con);
        danDAO = new danhoDAO(con);
        preDAO = new prestamoDAO(con);
        mulDAO = new multaDAO(con);
        varDAO = new variableSisDAO(con);
        resDAO = new reservaDAO(con);
        errDAO = new errorDAO(con);
    }

    public Usuario validarLogin(String login, String clave) {
        return usuDAO.getLogin(login, clave);
    }

    public String encriptar(String palabra) {
        return enc.encriptarMD5(palabra);
    }

    public void generarQR(String data, String direccion) {
        qrC.QR(data, direccion);
    }

    public boolean addUsuario(Usuario usu) {
        return usuDAO.addUsuario(usu);
    }

    public ArrayList<Material> getMateriales() {
        return matDAO.getMateriales();
    }
    
    public ArrayList<Material> getMaterialesActivos() {
        return matDAO.getMaterialesActivos();
    }

    public ArrayList<Tipo_material> getTiposM() {
        return tipDAO.getTipo_material();
    }

    public ArrayList<Laboratorio> getLaboratorios() {
        return labDAO.getLaboratorios();
    }

    public Material getMaterial(int codigo) {
        return matDAO.getMaterial(codigo);
    }

    public Laboratorio getLaboratorio(int codigo) {
        return labDAO.getLaboratorio(codigo);
    }

    public boolean updateLaboratorio(Laboratorio lab) {
        return labDAO.updateLaboratorio(lab);
    }

    public Tipo_material getTipoM(int codigo) {
        return tipDAO.getTipo_material(codigo);
    }

    public boolean addMaterial(Material mat) {
        return matDAO.addMaterial(mat);
    }

    public ArrayList<Usuario> getUsuarios() {
        return usuDAO.getUsuarios();
    }
    
    public ArrayList<Usuario> getUsuariosActivos() {
        return usuDAO.getUsuariosActivos();
    }

    public ArrayList<Danho> getDanhos() {
        return danDAO.getDanhos();
    }

    public ArrayList<Danho> getDanhosActivos() {
        return danDAO.getDanhosActivos();
    }
    
    public Danho getDanho(int codigo) {
        return danDAO.getDanho(codigo);
    }

    public Usuario getUsuario(String codigo) {
        return usuDAO.getUsuario(codigo);
    }

    public boolean updateDanho(Danho dan) {
        return danDAO.updateDanho(dan);
    }

    public boolean addDanho(Danho dan) {
        return danDAO.addDanho(dan);
    }

    public boolean updateMaterial(Material mat) {
        return matDAO.updateMaterial(mat);
    }

    public boolean addTipoMaterial(Tipo_material tip) {
        return tipDAO.addTipo_material(tip);
    }

    public boolean updateTipoMat(Tipo_material tip) {
        return tipDAO.updateTipo_material(tip);
    }

    public boolean updateUsuario(Usuario usu) {
        return usuDAO.updateUsuario(usu);
    }

    public boolean addPrestamo(Prestamo pre) {
        return preDAO.addPrestamo(pre);
    }

    public boolean GraficarTipoMat(ArrayList<Tipo_material> data, String direccion) throws IOException {
        return gra.TipoMaterial(data, direccion);
    }

    public ArrayList<Prestamo> getPrestamos() {
        return preDAO.getprestamos();
    }
    
    public ArrayList<Prestamo> getPrestamosActivos() {
        return preDAO.getprestamosActivos();
    }

    public ArrayList<Prestamo> getPrestamosFecha(String fecha1, String fecha2) {
        return preDAO.getRangoFecha_prestamo(fecha1, fecha2);
    }

    public ArrayList<Multa> getMultas() {
        return mulDAO.getMultas();
    }
    
    public ArrayList<Multa> getMultasActivas() {
        return mulDAO.getMultasAct();
    }

    public void GraficarPrestamos(int[] values, int[] fecha, int n, String direccion, String tiempo, String titulo) {
        gra.Prestamos(values, fecha, n, direccion, tiempo, titulo);
    }

    public void GraficarPrestamosYear(int[][] values, int n, String direccion, String tiempo, String titulo) {
        gra.PrestamosY(values, n, direccion, tiempo, titulo);
    }

    public void GraficarDanhoYear(int[][] values, int n, String direccion, String tiempo, String titulo) {
        gra.DanhosY(values, n, direccion, tiempo, titulo);
    }

    public void GraficarMultasYear(int[][] values, int n, String direccion, String tiempo, String titulo) {
        gra.MultasY(values, n, direccion, tiempo, titulo);
    }

    public Prestamo getPrestamoCodUsu(String codigo) {
        return preDAO.getPrestamoCodUsu(codigo);
    }

    public boolean updatePrestamo(Prestamo pre) {
        return preDAO.updatePrestamo(pre);
    }

    public boolean addMulta(Multa mul) {
        return mulDAO.addMulta(mul);
    }

    public Multa getMulta(int codigo) {
        return mulDAO.getMulta(codigo);
    }

    public boolean updateMulta(Multa mul) {
        return mulDAO.updateMulta(mul);
    }

    public String GenerarBackup(String nombre) {
        return gen.GenerarBackupMySQL(nombre);
    }

    public VariableSis getVariable(int id) {
        return varDAO.getTipo_variable(id);
    }

    public void agregarTextoImagen(String dir, String text, int ubi) throws Exception {
        tei.addTextoImagen(dir, text, ubi);
    }

    public Multa getMultaUsu(String cod) {
        return mulDAO.getMultaUsu(cod);
    }

    public ArrayList<Danho> getRangoFecha_danhos(String fecha1, String fecha2) {
        return danDAO.getRangoFecha_danhos(fecha1, fecha2);
    }

    public Reserva getReserva(int codigo) {
        return resDAO.getReserva(codigo);
    }

    public boolean addReserva(Reserva res) {
        return resDAO.addReserva(res);
    }

    public boolean updateReserva(Reserva res) {
        return resDAO.updateReserva(res);
    }

    public ArrayList<Reserva> getReservas() {
        return resDAO.getReservas();
    }
    
    public ArrayList<Reserva> getReservasActivas() {
        return resDAO.getReservasAct();
    }

    public ArrayList<Multa> getMultasFecha(String fecha1, String fecha2) {
        return mulDAO.getRangoFecha_multa(fecha1, fecha2);
    }

    public void GraficarMultas(int[] values, int[] fecha, int n, String direccion, String tiempo, String titulo) {
        gra.Multas(values, fecha, n, direccion, tiempo, titulo);
    }

    public void GraficarDanhos(int[] values, int[] fecha, int n, String direccion, String tiempo, String titulo) {
        gra.Danhos(values, fecha, n, direccion, tiempo, titulo);
    }

    public Reserva getReservaCodUsu(String codigo) {
        return resDAO.getReservaCodUsu(codigo);
    }

    public Error_D getError(String codigo) {
        return errDAO.getError(codigo);
    }

    public void desactivarMultas() {
        actM.desactivarMult();
    }

    public void GenerarPDFListar(String titulo, String imagen, Usuario usu, String dir, String Filex) throws BadElementException, IOException {
        GenerarPDFListar pdfL = new GenerarPDFListar();
        pdfL.generarPDF(titulo, imagen, usu, dir, Filex);
    }

    public void GenerarPDFListarActivos(String titulo, String imagen, Usuario usu, String dir, String Filex) throws BadElementException, IOException {
        GenerarPDFListarActivos pdfL = new GenerarPDFListarActivos();
        pdfL.generarPDF(titulo, imagen, usu, dir, Filex);
    }
    
    public void GenerarPDFGrafica(String titulo, String imagen, Usuario usu, String dir, String Fecha1, String Fecha2, String Rango, String Filex) throws BadElementException, IOException {
        GenerarPDFGrafica pdfG = new GenerarPDFGrafica();
        pdfG.generarPDF(titulo, imagen, usu, dir, Fecha1, Fecha2, Rango, Filex);
    }

    public void GenerarPDFGrafica(String titulo, String imge, Usuario usuario, String dir, String Filex) throws BadElementException, IOException {
        GenerarPDFtipomaterial pdfT = new GenerarPDFtipomaterial();
        pdfT.generarPDF(titulo, imge, usuario, dir, Filex);
    }

    public String AplicarRestore(String nombre) {
        return aplR.AplicarRestoreMySQL(nombre);
    }

    public void desactivarReservas() {
        actR.desactivarRes();
    }

    public boolean addLaboratorio(Laboratorio lab) {
        return labDAO.addLaboratorio(lab);
    }
    
    public int getCantidadMaximaMateriales(){
        return Integer.parseInt(varDAO.getTipo_variable(7).getDatos());
    }
    
    public int getCantidadDiasPrestamo(){
        return Integer.parseInt(varDAO.getTipo_variable(8).getDatos());
    }
    
    public boolean updateVariableSis(VariableSis var){
        return varDAO.updateTipo_variable(var);
    }
    
}
