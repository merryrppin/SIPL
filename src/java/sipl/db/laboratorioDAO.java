/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sipl.dominio.Laboratorio;

/**
 *
 * @author WM
 */
public class laboratorioDAO {

    private final Conexion con;

    public laboratorioDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Laboratorio> getLaboratorios() {
        ArrayList<Laboratorio> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from laboratorio");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String nombre = rs.getString("nombre");
                String descripcion = rs.getString("descripcion");
                String ubicacion = rs.getString("ubicacion");
                Laboratorio lab = new Laboratorio(codigo, nombre, descripcion, ubicacion);
                data.add(lab);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public Laboratorio getLaboratorio(int codigo) {
        Laboratorio lab = null;
        ResultSet rs = con.getQuery("select * from laboratorio where codigo=" + codigo);
        try {
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String descripcion = rs.getString("descripcion");
                String ubicacion = rs.getString("ubicacion");
                lab = new Laboratorio(codigo, nombre, descripcion, ubicacion);
            }
            rs.close();
        } catch (SQLException ex) {
            lab = null;
        }
        return lab;
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
