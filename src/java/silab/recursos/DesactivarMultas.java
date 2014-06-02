/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.recursos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import sipl.db.Conexion;
import sipl.db.multaDAO;
import sipl.db.usuarioDAO;
import sipl.db.variableSisDAO;
import sipl.dominio.Multa;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class DesactivarMultas {

    public void desactivarMult() {
        Conexion con = new Conexion();
        multaDAO mulDAO = new multaDAO(con);
        usuarioDAO usuDAO = new usuarioDAO(con);
        ArrayList<Multa> data = mulDAO.getMultasAct();
        for (int i = 0; i < data.size(); i++) {
            Calendar cal1 = data.get(i).getFecha_multa();
            if (data.get(i).getEstado_multa() == 0) {
                Calendar hoy = Calendar.getInstance();
                long tiempo1 = hoy.getTimeInMillis();
                long tiempo2 = cal1.getTimeInMillis();
                int diasMulta = data.get(i).getTiempo_multa();
                int tiempoMax = diasMulta * 86400000;
                if (tiempo1 - tiempo2 >= tiempoMax) {
                    Multa mul = mulDAO.getMultaUsu(data.get(i).getUsu().getCodigo());
                    mul.setEstado_multa(1);
                    Usuario usu = usuDAO.getUsuario(mul.getUsu().getCodigo());
                    usu.setEstado(0);
                    usuDAO.updateUsuario(usu);
                    mulDAO.updateMulta(mul);
                }
            }
        }
        try{
            con.Close_DB();
        }catch(SQLException e){
            System.out.print("No cerró");
        }
    }
}
