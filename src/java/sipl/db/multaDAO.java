/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import sipl.dominio.Multa;

/**
 *
 * @author Samy
 */
public class multaDAO {

    private final Conexion con;
    private final usuarioDAO usuDAO;

    public multaDAO(Conexion con) {
        this.con = con;
        usuDAO = new usuarioDAO(con);
    }

    public ArrayList<Multa> getMultas() {
        ArrayList<Multa> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from multa");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                Multa mul = new Multa(codigo, usuDAO.getUsuario(usu), cal, estado_multa, tiempo_multa);
                data.add(mul);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public ArrayList<Multa> getMultasAct() {
        ArrayList<Multa> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from multa where estado_multa=0");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                Multa mul = new Multa(codigo, usuDAO.getUsuario(usu), cal, estado_multa, tiempo_multa);
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
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                mul = new Multa(codigo, usuDAO.getUsuario(usu), cal, estado_multa, tiempo_multa);
            }
            rs.close();
        } catch (SQLException ex) {
            mul = null;
        }
        return mul;
    }

    public Multa getMultaUsu(String cod) {
        Multa mul = null;
        ResultSet rs = con.getQuery("select * from multa where cod_usuario='" + cod + "' and estado_multa=0");
        try {
            if (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                mul = new Multa(codigo, usuDAO.getUsuario(usu), cal, estado_multa, tiempo_multa);
            }
            rs.close();
        } catch (SQLException ex) {
            mul = null;
        }
        return mul;
    }

    public boolean addMulta(Multa mul) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal1 = sdf.format(mul.getFecha_multa().getTime());
        String sql = "insert into multa (cod_usuario, fecha_multa, estado_multa, tiempo_multa) values ('"
                + mul.getUsu().getCodigo() + "','" + cal1 + "'," + mul.getEstado_multa() + ","
                + mul.getTiempo_multa() + ")";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateMulta(Multa mul) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal1 = sdf.format(mul.getFecha_multa().getTime());
        String sql = "update multa set cod_usuario='" + mul.getUsu().getCodigo() + "',"
                + " fecha_multa='" + cal1 + "', estado_multa=" + mul.getEstado_multa()
                + ",tiempo_multa= " + mul.getTiempo_multa() + " where codigo=" + mul.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }

    public ArrayList<Multa> getRangoFecha_multa(String fecha1, String fecha2) {
        ArrayList<Multa> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from multa where fecha_multa between '" + fecha1 + "' and '" + fecha2 + "'");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_multa");
                cal.setTimeInMillis(t1.getTime());
                int estado_multa = rs.getInt("estado_multa");
                int tiempo_multa = rs.getInt("tiempo_multa");
                Multa mul = new Multa(codigo, usuDAO.getUsuario(usu), cal, estado_multa, tiempo_multa);
                data.add(mul);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
}
