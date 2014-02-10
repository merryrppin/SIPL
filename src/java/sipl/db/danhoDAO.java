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
import sipl.dominio.Danho;

/**
 *
 * @author WM
 */
public class danhoDAO {
    private Conexion con;
    private usuarioDAO usuDAO;
    private materialDAO matDAO;
    
    public danhoDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Danho> getDanhos() {
        ArrayList<Danho> data = new ArrayList<Danho>();
        ResultSet rs = con.getQuery("select * from danho");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String descripcion = rs.getString("descripcion");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1=Calendar.getInstance();
                Timestamp t1=rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("codigo_usu_rd");
                int estado = rs.getInt("estado");
                Danho dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1 , usuDAO.getUsuario(codigo_usu_rd), estado);
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
                String descripcion = rs.getString("descripcion");
                int codigo_mat = rs.getInt("codigo_mat");
                String codigo_usu = rs.getString("codigo_usu");
                Calendar cal1=Calendar.getInstance();
                Timestamp t1=rs.getTimestamp("fecha_d");
                cal1.setTimeInMillis(t1.getTime());
                String codigo_usu_rd = rs.getString("codigo_usu_rd");
                int estado = rs.getInt("estado");
                dan = new Danho(codigo, descripcion, matDAO.getMaterial(codigo_mat), usuDAO.getUsuario(codigo_usu), cal1 , usuDAO.getUsuario(codigo_usu_rd), estado);
            }
            rs.close();
        } catch (SQLException ex) {
            dan = null;
        }
        return dan;
    }

    public boolean addDanho(Danho dan) {
        boolean result = false;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal1=sdf.format(dan.getFecha_d().getTime());
        String sql = "insert into danho (descripcion, codigo_mat, codigo_usu, fecha_d, codigo_usu_rd, estado"
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
                + " descripcion='" + dan.getDescripcion() + " where codigo=" + dan.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
