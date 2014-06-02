/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sipl.dominio.Tipo_material;

/**
 *
 * @author Samy
 */
public class tipo_materialDAO {

    private final Conexion con;

    public tipo_materialDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Tipo_material> getTipo_material() {
        ArrayList<Tipo_material> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from tipo_material");
        try {
            while (rs.next()) {
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                String descripcion = rs.getString("descripcion");
                int cantidad = rs.getInt("cantidad");
                int disponibilidad = rs.getInt("disponibilidad");
                Tipo_material tip = new Tipo_material(id, nombre, descripcion, cantidad, disponibilidad);
                data.add(tip);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Tipo_material getTipo_material(int id) {
        Tipo_material tip = null;
        ResultSet rs = con.getQuery("select * from tipo_material where id=" + id);
        try {
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String descripcion = rs.getString("descripcion");
                int cantidad = rs.getInt("cantidad");
                int disponibilidad = rs.getInt("disponibilidad");
                tip = new Tipo_material(id, nombre, descripcion, cantidad, disponibilidad);
            }
            rs.close();
        } catch (SQLException ex) {
            tip = null;
        }
        return tip;
    }

    public boolean addTipo_material(Tipo_material tip) {
        boolean result = false;
        String sql = "insert into tipo_material (nombre, descripcion, cantidad, disponibilidad) values ('" + tip.getNombre() + "','"
                + tip.getDescripcion() + "'," + tip.getCantidad() + ", " + tip.getDisponibilidad() + ")";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateTipo_material(Tipo_material tip) {
        boolean result = false;
        String sql = "update tipo_material set nombre='" + tip.getNombre() + "',"
                + " descripcion='" + tip.getDescripcion() + "',cantidad=" + tip.getCantidad() + ",disponibilidad= " + tip.getDisponibilidad()
                + " where id=" + tip.getId();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
