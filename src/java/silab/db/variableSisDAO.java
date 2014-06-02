/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import sipl.dominio.VariableSis;

/**
 *
 * @author WM
 */
public class variableSisDAO {

    private final Conexion con;

    public variableSisDAO(Conexion con) {
        this.con = con;
    }

    public VariableSis getTipo_variable(int id) {
        VariableSis var = null;
        ResultSet rs = con.getQuery("select * from variable_sistema where id=" + id);
        try {
            if (rs.next()) {
                String datos = rs.getString("datos");
                String descripcion = rs.getString("descripcion");
                var = new VariableSis(id, datos, descripcion);
            }
            rs.close();
        } catch (SQLException ex) {
            var = null;
        }
        return var;
    }

    public boolean addTipo_variable(VariableSis var) {
        boolean result = false;
        String sql = "insert into variable_sistema (datos, descripcion) values ('" + var.getDatos() + "','"
                + var.getDescripcion() + "')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateTipo_variable(VariableSis var) {
        boolean result = false;
        String sql = "update variable_sistema set datos='" + var.getDatos() + "',"
                + " descripcion='" + var.getDescripcion() + "' where id=" + var.getId();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
