/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import sipl.dominio.Multa;

/**
 *
 * @author Samy
 */
public class multaDAO {
    private Conexion con;
    private usuarioDAO usuDAO;
    public multaDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Multa> getMultas() {
        ArrayList<Multa> data = new ArrayList<Multa>();
        ResultSet rs = con.getQuery("select * from multa");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String uso = rs.getString("cod_usuario");
                Calendar cal= Calendar.getInstance();
                Timestamp t1=rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                Multa mul = new Multa(codigo, usuDAO.getUsuario(codigo), cal, estado_multa, tiempo_multa);
                data.add(mul);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Multa getMulta(int codigo) {
        Multa mul = null;
        ResultSet rs = con.getQuery("select * from multa where codigo=" + codigo);
        try {
            if (rs.next()) {
                String uso = rs.getString("cod_usuario");
                Calendar cal= Calendar.getInstance();
                Timestamp t1=rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                mul = new Multa(codigo, usuDAO.getUsuario(codigo), cal, estado_multa, tiempo_multa);
            }
            rs.close();
        } catch (SQLException ex) {
            mul = null;
        }
        return mul;
    }

    public boolean addLaboratorio(Laboratorio lab) {
        boolean result = false;
        String sql = "insert into laboratorio (nombre, descripcion, ubicacion) values ('" + lab.getNombre() + "','"
                + lab.getDescripcion() + "','" + lab.getUbicacion() + "')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateLaboratorio(Laboratorio lab) {
        boolean result = false;
        String sql = "update laboratorio set nombre='" + lab.getNombre() + "',"
                + " descripcion='" + lab.getDescripcion() + "', ubicacion='" + lab.getUbicacion()
                + "' where codigo=" + lab.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
