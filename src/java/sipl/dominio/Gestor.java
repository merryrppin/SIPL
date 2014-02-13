/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.dominio;

import java.util.ArrayList;
import sipl.db.*;
import sipl.recursos.*;
/**
 *
 * @author WM
 */
public class Gestor {
    private usuarioDAO usuDAO;
    private materialDAO matDAO;
    private tipo_materialDAO tipDAO;
    Encri enc = new Encri();
    QRCode qrC = new QRCode();
    public Gestor(){
        Conexion con = new Conexion();
        usuDAO = new usuarioDAO(con);
        matDAO = new materialDAO(con);
        tipDAO = new tipo_materialDAO(con);
    }
    
    public Usuario validarLogin(String login, String clave){
        return usuDAO.getLogin(login, clave);
    }
    public String encriptar(String palabra){
        return enc.encriptarMD5(palabra);
    }
    public void generarQR(String data, String direccion){
        qrC.QRmini(data, direccion);
        qrC.QRMedium(data, direccion);
        qrC.QRHigh(data, direccion);
    }
    public boolean addUsuario(Usuario usu){
        return usuDAO.addUsuario(usu);
    }
    public ArrayList<Material> getMateriales(){
        return matDAO.getMateriales();
    }
    public ArrayList<Tipo_material> getTiposM(){
        return tipDAO.getTipo_material();
    }
}