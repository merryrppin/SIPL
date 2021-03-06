/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sipl.dominio.Usuario;

/**
 *
 * @author Samy
 */
public class usuarioDAO {

    private final Conexion con;

    public usuarioDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Usuario> getUsuarios() {
        ArrayList<Usuario> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from usuario");
        try {
            while (rs.next()) {
                String codigo = rs.getString("codigo");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                long telefono = rs.getLong("telefono");
                String correo = rs.getString("correo");
                int estado = rs.getInt("estado");
                int tipo_usuario = rs.getInt("tipo_usuario");
                String observaciones = rs.getString("observaciones");
                String clave = rs.getString("clave");
                Usuario usu = new Usuario(codigo, nombre, apellido, telefono, correo, estado, tipo_usuario, observaciones, clave);
                data.add(usu);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }

    public ArrayList<Usuario> getUsuariosActivos() {
        ArrayList<Usuario> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from usuario where estado=0 OR estado=2 OR estado=3 OR estado=4");
        try {
            while (rs.next()) {
                String codigo = rs.getString("codigo");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                long telefono = rs.getLong("telefono");
                String correo = rs.getString("correo");
                int estado = rs.getInt("estado");
                int tipo_usuario = rs.getInt("tipo_usuario");
                String observaciones = rs.getString("observaciones");
                String clave = rs.getString("clave");
                Usuario usu = new Usuario(codigo, nombre, apellido, telefono, correo, estado, tipo_usuario, observaciones, clave);
                data.add(usu);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
    
    public Usuario getUsuario(String codigo) {
        Usuario usu = null;
        ResultSet rs = con.getQuery("select * from usuario where codigo='" + codigo + "'");
        try {
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                long telefono = rs.getLong("telefono");
                String correo = rs.getString("correo");
                int estado = rs.getInt("estado");
                int tipo_usuario = rs.getInt("tipo_usuario");
                String observaciones = rs.getString("observaciones");
                String clave = rs.getString("clave");
                usu = new Usuario(codigo, nombre, apellido, telefono, correo, estado, tipo_usuario, observaciones, clave);
            }
            rs.close();
        } catch (SQLException ex) {
            usu = null;
        }
        return usu;
    }

    public Usuario getLogin(String codigo, String password) {
        Usuario usu = null;
        ResultSet rs = con.getQuery("select * from usuario where codigo='" + codigo + "' and clave='" + password + "'");
        try {
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                long telefono = rs.getLong("telefono");
                String correo = rs.getString("correo");
                int estado = rs.getInt("estado");
                int tipo_usuario = rs.getInt("tipo_usuario");
                String observaciones = rs.getString("observaciones");
                usu = new Usuario(codigo, nombre, apellido, telefono, correo, estado, tipo_usuario, observaciones, password);
            }
            rs.close();
        } catch (SQLException ex) {
            usu = null;
        }
        return usu;
    }

    public boolean addUsuario(Usuario usu) {
        boolean result = false;
        String sql = "insert into usuario (codigo, nombre, apellido, telefono, correo, estado, tipo_usuario, observaciones, clave) values ('" + usu.getCodigo() + "','" + usu.getNombre() + "','"
                + usu.getApellido() + "'," + usu.getTelefono() + ",'" + usu.getCorreo() + "', " + usu.getEstado() + "," + usu.getTipo_usuario() + ",'" + usu.getObservaciones() + "','" + usu.getClave() + "')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateUsuario(Usuario usu) {
        boolean result = false;
        String sql = "update usuario set nombre='" + usu.getNombre() + "',"
                + " apellido='" + usu.getApellido() + "', telefono=" + usu.getTelefono() + ",correo= '"
                + usu.getCorreo() + "',estado= " + usu.getEstado() + ", tipo_usuario= " + usu.getTipo_usuario()
                + ", observaciones='" + usu.getObservaciones() + "', clave='" + usu.getClave() + "' where codigo='"
                + usu.getCodigo() + "'";
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
}
