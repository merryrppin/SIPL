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
import java.util.Date;
import java.util.TimeZone;
import sipl.dominio.Material;

/**
 *
 * @author WM
 */
public class materialDAO {

    private final Conexion con;
    private final laboratorioDAO labDAO;
    private final tipo_materialDAO tipDAO;

    public materialDAO(Conexion con) {
        this.con = con;
        labDAO = new laboratorioDAO(con);
        tipDAO = new tipo_materialDAO(con);
    }

    public ArrayList<Material> getMateriales() {
        ArrayList<Material> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from material");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String descripcion = rs.getString("descripcion");
                int tipo_mat = rs.getInt("tipo_mat");
                String marca = rs.getString("marca");
                String serial = rs.getString("serial");
                String foto_mat = rs.getString("foto_mat");
                String num_inventario = rs.getString("num_inventario");
                int estado = rs.getInt("estado");
                Calendar cal1 = Calendar.getInstance();
                cal1.setTimeZone(TimeZone.getTimeZone("GMT"));
                Timestamp t1 = rs.getTimestamp("ult_fecha_mante");
                Date date = new Date(t1.getTime());
                System.out.println("date " + date.toString());
                cal1.setTimeInMillis(t1.getTime());
                System.out.println("cal " + cal1.toString());
                int disponibilidad = rs.getInt("disponibilidad");
                int codigo_lab = rs.getInt("codigo_lab");
                String imagenqr = rs.getString("imagenqr");
                Material mat = new Material(codigo, descripcion, tipDAO.getTipo_material(tipo_mat), marca, serial, foto_mat, num_inventario, estado, cal1, disponibilidad, labDAO.getLaboratorio(codigo_lab), imagenqr);
                data.add(mat);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Material getMaterial(int codigo) {
        Material mat = null;
        ResultSet rs = con.getQuery("select * from material where codigo=" + codigo);
        try {
            if (rs.next()) {
                String descripcion = rs.getString("descripcion");
                int tipo_mat = rs.getInt("tipo_mat");
                String marca = rs.getString("marca");
                String serial = rs.getString("serial");
                String foto_mat = rs.getString("foto_mat");
                String num_inventario = rs.getString("num_inventario");
                int estado = rs.getInt("estado");
                Calendar cal1 = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("ult_fecha_mante");
                cal1.setTimeInMillis(t1.getTime());
                int disponibilidad = rs.getInt("disponibilidad");
                int codigo_lab = rs.getInt("codigo_lab");
                String imagenqr = rs.getString("imagenqr");
                mat = new Material(codigo, descripcion, tipDAO.getTipo_material(tipo_mat), marca, serial, foto_mat, num_inventario, estado, cal1, disponibilidad, labDAO.getLaboratorio(codigo_lab), imagenqr);
            }
            rs.close();
        } catch (SQLException ex) {
            mat = null;
        }
        return mat;
    }

    public boolean addMaterial(Material mat) {
        boolean result = false;
        Calendar cal1 = mat.getUlt_fecha_mante();
        int year=cal1.get(Calendar.YEAR);
        int mes=cal1.get(Calendar.MONTH);
        mes++;
        int dia=cal1.get(Calendar.DAY_OF_MONTH);
        int hora=cal1.get(Calendar.HOUR_OF_DAY);
        int min=cal1.get(Calendar.MINUTE);
        String fecha=year+"-"+mes+"-"+dia+" "+hora+":"+min+":00";
        String sql = "insert into material (descripcion, tipo_mat, marca, serial, foto_mat, num_inventario,"
                + "estado, ult_fecha_mante, disponibilidad, codigo_lab, imagenqr) values ('" + mat.getDescripcion() + "',"
                + "" + mat.getTipo_mat().getId() + ",'" + mat.getMarca() + "','" + mat.getSerial() + "','" + mat.getFoto_mat() + "',"
                + "'" + mat.getNum_inventario() + "'," + mat.getEstado() + ",'" + fecha + "',"
                + "" + mat.getDisponibilidad() + "," + mat.getLab().getCodigo() + ",'" + mat.getImagenqr() + "')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateMaterial(Material mat) {
        boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal1 = sdf.format(mat.getUlt_fecha_mante().getTime());
        String sql = "update material set descripcion='" + mat.getDescripcion() + "',"
                + " tipo_mat=" + mat.getTipo_mat().getId() + ", marca='" + mat.getMarca()
                + "', serial='" + mat.getSerial() + "', foto_mat='" + mat.getFoto_mat()
                + "', num_inventario='" + mat.getNum_inventario() + "', estado=" + mat.getEstado()
                + ", ult_fecha_mante='" + cal1 + "'," + " disponibilidad=" + mat.getDisponibilidad()
                + ", codigo_lab=" + mat.getLab().getCodigo() + ", imagenqr='" + mat.getImagenqr()
                + "' where codigo=" + mat.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
