/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import sipl.dominio.Error_D;

/**
 *
 * @author WM
 */
public class errorDAO {
    private final Conexion con;

    public errorDAO(Conexion con) {
        this.con = con;
    }

    public Error_D getError(String codigo) {
        Error_D error = null;
        ResultSet rs = con.getQuery("select * from error where codigo='" + codigo+"'");
        try {
            if (rs.next()) {
                String mensaje = rs.getString("mensaje");
                error = new Error_D(codigo, mensaje);
            }
            rs.close();
        } catch (SQLException ex) {
            error = null;
        }
        return error;
    }
}
