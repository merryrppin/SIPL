/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Samy
 */
public class Conexion {
    private Connection con;
    private final String driver = "com.mysql.jdbc.Driver";
    private final String dbName = "siprelab";
    private final String url = "jdbc:mysql://localhost:3306/";
    private final String user = "root";
    private final String passwd = "12345";

    public Conexion() {
        try {
            Class.forName(driver);
            con=DriverManager.getConnection(url+dbName, user, passwd);
        } catch (ClassNotFoundException cne) {
            cne.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
    
    public ResultSet getQuery(String sql) {
        ResultSet rs = null;
        try {
            Statement stm = con.createStatement();
            rs = stm.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    
    public int setQuery(String sql) {
        int result = -1;
        try {
            Statement stm = con.createStatement();
            result = stm.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }
    
    public static void main(String [] args) {
        Conexion c = new Conexion();
    }
    
}
