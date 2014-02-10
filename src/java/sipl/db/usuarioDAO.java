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
import sipl.dominio.Usuario;

/**
 *
 * @author Samy
 */
class usuarioDAO {
   private Conexion con;

    public usuarioDAO(Conexion con) {
        this.con = con;
    }

    public ArrayList<Usuario> getUsuarios() {
        ArrayList<Usuario> data = new ArrayList<Usuario>();
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
                Usuario usu = new Usuario(codigo, nombre,apellido, telefono, correo, estado, tipo_usuario, observaciones, clave);
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
        ResultSet rs = con.getQuery("select * from usuario where codigo=" + codigo);
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
                usu = new Usuario(codigo, nombre,apellido,telefono,correo, estado, tipo_usuario, observaciones, clave);
            }
            rs.close();
        } catch (SQLException ex) {
            usu = null;
        }
        return usu;
    }

    public boolean addUsuario(Usuario usu) {
        boolean result = false;
        String sql = "insert into usuario (nombre, apellido, telefono,correo,estado,tipo_usuario,observaciones,clave) values ('" + usu.getNombre() + "','"
                + usu.getApellido() + "',"+ usu.getTelefono()+",'"+usu.getCorreo()+"', " + usu.getEstado()+"," + usu.getTipo_usuario()+",'"+usu.getObservaciones()+"','"+usu.getClave()+"')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateUsuario(Usuario usu) {
        boolean result = false;
        String sql = "update usuario set nombre='" + usu.getNombre() + "',"
                + " descripcion='" + lab.getDescripcion() + "', ubicacion='" + lab.getUbicacion()
                + "' where codigo=" + lab.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    } 
}
