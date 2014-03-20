/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.recursos;

import java.util.ArrayList;
import java.util.Calendar;
import sipl.db.Conexion;
import sipl.db.materialDAO;
import sipl.db.reservaDAO;
import sipl.db.tipo_materialDAO;
import sipl.db.usuarioDAO;
import sipl.dominio.Material;
import sipl.dominio.Reserva;
import sipl.dominio.Tipo_material;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class DesactivarReserva {
    public void desactivarRes(){
        Conexion con = new Conexion();
        reservaDAO resDAO = new reservaDAO(con);
        usuarioDAO usuDAO = new usuarioDAO(con);
        materialDAO matDAO = new materialDAO(con);
        tipo_materialDAO tipDAO = new tipo_materialDAO(con);
        ArrayList<Reserva> data = resDAO.getReservasAct();
        for(int i = 0; i< data.size(); i++){
            Calendar cal1 = data.get(i).getFecha_reserva();
            if (data.get(i).getEstado() == 0) {
                Calendar hoy = Calendar.getInstance();
                long tiempo1 = hoy.getTimeInMillis();
                long tiempo2 = cal1.getTimeInMillis();
                if (tiempo1 - tiempo2 >= 172800000) {
                    Reserva res = resDAO.getReservaCodUsu(data.get(i).getUsu().getCodigo());
                    res.setEstado(1);
                    String [] materi = res.getMat().split(";");
                    for (String materi1 : materi) {
                        Material mat = matDAO.getMaterial(Integer.parseInt(materi1));
                        mat.setEstado(0);
                        Tipo_material tip = tipDAO.getTipo_material(mat.getTipo_mat().getId());
                        int cantidad = tip.getDisponibilidad();
                        cantidad++;
                        tip.setDisponibilidad(cantidad);
                        tipDAO.updateTipo_material(tip);
                        matDAO.updateMaterial(mat);
                    }
                    Usuario usu = usuDAO.getUsuario(res.getUsu().getCodigo());
                    usu.setEstado(0);
                    usuDAO.updateUsuario(usu);
                    resDAO.updateReserva(res);
                }
            }
        }
    }
}
