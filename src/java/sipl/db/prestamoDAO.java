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
import sipl.dominio.Prestamo;

/**
 *
 * @author Samy
 */
public class prestamoDAO {

    private final Conexion con;
    private final usuarioDAO usuDAO;

    public prestamoDAO(Conexion con) {
        this.con = con;
        usuDAO = new usuarioDAO(con);
    }

    public ArrayList<Prestamo> getprestamosActivos() {
        ArrayList<Prestamo> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from prestamo where estado=0");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String mat = rs.getString("cod_material");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_prestamo");
                cal.setTimeInMillis(t1.getTime());
                Calendar cal1 = Calendar.getInstance();
                Timestamp t2 = rs.getTimestamp("fecha_devolucion");
                cal1.setTimeInMillis(t2.getTime());
                int est = rs.getInt("estado");
                Prestamo pre = new Prestamo(codigo, mat, usuDAO.getUsuario(usu), cal, cal1, est);
                data.add(pre);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
    
    public ArrayList<Prestamo> getprestamos() {
        ArrayList<Prestamo> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from prestamo");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String mat = rs.getString("cod_material");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_prestamo");
                cal.setTimeInMillis(t1.getTime());
                Calendar cal1 = Calendar.getInstance();
                Timestamp t2 = rs.getTimestamp("fecha_devolucion");
                cal1.setTimeInMillis(t2.getTime());
                int est = rs.getInt("estado");
                Prestamo pre = new Prestamo(codigo, mat, usuDAO.getUsuario(usu), cal, cal1, est);
                data.add(pre);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Prestamo getPrestamoCodUsu(String codigo) {
        Prestamo pre = null;
        ResultSet rs = con.getQuery("select * from prestamo where cod_usuario='" + codigo + "' and estado=0");
        try {
            if (rs.next()) {
                int cod = rs.getInt("codigo");
                String mat = rs.getString("cod_material");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_prestamo");
                cal.setTimeInMillis(t1.getTime());
                Calendar cal1 = Calendar.getInstance();
                Timestamp t2 = rs.getTimestamp("fecha_devolucion");
                cal1.setTimeInMillis(t2.getTime());
                int est = rs.getInt("estado");
                pre = new Prestamo(cod, mat, usuDAO.getUsuario(usu), cal, cal1, est);
            }
            rs.close();
        } catch (SQLException ex) {
            pre = null;
        }
        return pre;
    }

    public Prestamo getPrestamo(int codigo) {
        Prestamo pre = null;
        ResultSet rs = con.getQuery("select * from prestamo where codigo=" + codigo);
        try {
            if (rs.next()) {
                String mat = rs.getString("cod_material");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_prestamo");
                cal.setTimeInMillis(t1.getTime());
                Calendar cal1 = Calendar.getInstance();
                Timestamp t2 = rs.getTimestamp("fecha_devolucion");
                cal1.setTimeInMillis(t2.getTime());
                int est = rs.getInt("estado");
                pre = new Prestamo(codigo, mat, usuDAO.getUsuario(usu), cal, cal1, est);
            }
            rs.close();
        } catch (SQLException ex) {
            pre = null;
        }
        return pre;
    }

    public boolean addPrestamo(Prestamo pre) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String cal2 = sdf.format(pre.getFecha_prestamo().getTime());
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String cal3 = sdf1.format(pre.getFecha_devolucion().getTime());
        String sql = "insert into prestamo (cod_material, cod_usuario, fecha_prestamo, fecha_devolucion, estado) values ('"
                + pre.getMat() + "','" + pre.getUsu().getCodigo() + "','" + cal2 + "','" + cal3 + "'," + pre.getEstado() + ")";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updatePrestamo(Prestamo pre) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String cal2 = sdf.format(pre.getFecha_prestamo().getTime());
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String cal3 = sdf1.format(pre.getFecha_devolucion().getTime());
        String sql = "update prestamo set cod_material='" + pre.getMat() + "',cod_usuario='" + pre.getUsu().getCodigo() + "',"
                + " fecha_prestamo='" + cal2 + "', fecha_devolucion='" + cal3 + "',estado=" + pre.getEstado() + " where codigo=" + pre.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }

    public ArrayList<Prestamo> getRangoFecha_prestamo(String fecha1, String fecha2) {
        ArrayList<Prestamo> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from prestamo where fecha_prestamo between '" + fecha1 + "' and '" + fecha2 + "'");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String mat = rs.getString("cod_material");
                String usu = rs.getString("cod_usuario");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_prestamo");
                cal.setTimeInMillis(t1.getTime());
                Calendar cal1 = Calendar.getInstance();
                Timestamp t2 = rs.getTimestamp("fecha_devolucion");
                cal1.setTimeInMillis(t2.getTime());
                int est = rs.getInt("estado");
                Prestamo pre = new Prestamo(codigo, mat, usuDAO.getUsuario(usu), cal, cal1, est);
                data.add(pre);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
}
