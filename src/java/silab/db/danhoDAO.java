/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import sipl.dominio.Danho;

/**
 *
 * @author WM
 */
public class danhoDAO {

    private final Conexion con;
    private final usuarioDAO usuDAO;
    private final materialDAO matDAO;

    public danhoDAO(Conexion con) {
        this.con = con;
        usuDAO = new usuarioDAO(con);
        matDAO = new materialDAO(con);
    }

    public ArrayList<Danho> getDanhos() {
        ArrayList<Danho> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from danho");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String descripcion = rs.getString("descripcion_d");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1 = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("cod_usu_rd");
                int estado = rs.getInt("estado");
                Danho dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1, usuDAO.getUsuario(codigo_usu_rd), estado);
                data.add(dan);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
    
    public ArrayList<Danho> getDanhosActivos() {
        ArrayList<Danho> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from danho where estado=0");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String descripcion = rs.getString("descripcion_d");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1 = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("cod_usu_rd");
                int estado = rs.getInt("estado");
                Danho dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1, usuDAO.getUsuario(codigo_usu_rd), estado);
                data.add(dan);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Danho getDanho(int codigo) {
        Danho dan = null;
        ResultSet rs = con.getQuery("select * from danho where codigo=" + codigo);
        try {
            if (rs.next()) {
                String descripcion = rs.getString("descripcion_d");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1 = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("cod_usu_rd");
                int estado = rs.getInt("estado");
                dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1, usuDAO.getUsuario(codigo_usu_rd), estado);
            }
            rs.close();
        } catch (SQLException ex) {
            dan = null;
        }
        return dan;
    }

    public boolean addDanho(Danho dan) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal1 = sdf.format(dan.getFecha_d().getTime());
        String sql = "insert into danho (descripcion_d, codigo_mat, codigo_usu, fecha_d, cod_usu_rd, estado"
                + ") values ('" + dan.getDescripcion() + "'," + dan.getMat().getCodigo() + ",'" + dan.getUsu().getCodigo() + "',"
                + "'" + cal1 + "','" + dan.getUsu_rd().getCodigo() + "'," + dan.getEstado() + ")";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateDanho(Danho dan) {
        boolean result = false;
        String sql = "update danho set estado=" + dan.getEstado() + ","
                + " descripcion_d='" + dan.getDescripcion() + "' where codigo=" + dan.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }

    public ArrayList<Danho> getRangoFecha_danhos(String fecha1, String fecha2) {
        ArrayList<Danho> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from danho where fecha_d between '" + fecha1 + "' and '" + fecha2 + "'");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String descripcion = rs.getString("descripcion_d");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1 = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("cod_usu_rd");
                int estado = rs.getInt("estado");
                Danho dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1, usuDAO.getUsuario(codigo_usu_rd), estado);
                data.add(dan);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
}
