/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.dominio;

import java.io.IOException;
import java.util.ArrayList;
import sipl.db.*;
import sipl.recursos.*;

/**
 *
 * @author WM
 */
public class Gestor {

    private final usuarioDAO usuDAO;
    private final materialDAO matDAO;
    private final tipo_materialDAO tipDAO;
    private final laboratorioDAO labDAO;
    private final danhoDAO danDAO;
    private final prestamoDAO preDAO;
    Encri enc = new Encri();
    QRCode qrC = new QRCode();
    Graficar gra = new Graficar();

    public Gestor() {
        Conexion con = new Conexion();
        usuDAO = new usuarioDAO(con);
        matDAO = new materialDAO(con);
        tipDAO = new tipo_materialDAO(con);
        labDAO = new laboratorioDAO(con);
        danDAO = new danhoDAO(con);
        preDAO = new prestamoDAO(con);
    }
    public Usuario validarLogin(String login, String clave) {
        return usuDAO.getLogin(login, clave);
    }
    public String encriptar(String palabra) {
        return enc.encriptarMD5(palabra);
    }
    public void generarQR(String data, String direccion) {
        qrC.QRmini(data, direccion);
        qrC.QRMedium(data, direccion);
        qrC.QRsmall(data, direccion);
    }
    public boolean addUsuario(Usuario usu) {
        return usuDAO.addUsuario(usu);
    }
    public ArrayList<Material> getMateriales() {
        return matDAO.getMateriales();
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
    public ArrayList<Danho> getDanhos() {
        return danDAO.getDanhos();
    }
    public Danho getDanho(int codigo) {
        return danDAO.getDanho(codigo);
    }
    public Usuario getUsuario(String codigo){
        return usuDAO.getUsuario(codigo);
    }
    public boolean updateDanho(Danho dan){
        return danDAO.updateDanho(dan);
    }
    public boolean addDanho(Danho dan){
        return danDAO.addDanho(dan);
    }
    public boolean updateMaterial(Material mat){
        return matDAO.updateMaterial(mat);
    }
    public boolean addTipoMaterial(Tipo_material tip){
        return tipDAO.addTipo_material(tip);
    }
    public boolean updateTipoMat(Tipo_material tip){
        return tipDAO.updateTipo_material(tip);
    }
    public boolean updateUsuario(Usuario usu){
        return usuDAO.updateUsuario(usu);
    }
    public boolean addPrestamo(Prestamo pre){
        return preDAO.addPrestamo(pre);
    }
    public void Graficar(ArrayList<Tipo_material> data, String direccion) throws IOException{
        gra.TipoMaterial(data, direccion);
    }
    public ArrayList<Prestamo> getPrestamos() {
        return preDAO.getprestamos();
    }
    public ArrayList<Prestamo> getPrestamosFecha(String fecha1, String fecha2){
        return preDAO.getRangoFecha_prestamo(fecha1, fecha2);
    }
}
