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
import sipl.dominio.Reserva;

/**
 *
 * @author Samy
 */
public class reservaDAO {
    private final Conexion con;
    private final usuarioDAO usuDAO;
    
      public reservaDAO(Conexion con) {
        this.con = con;
        usuDAO = new usuarioDAO(con);
    }

    public ArrayList<Reserva> getReservas() {
        ArrayList<Reserva> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from reserva");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                int estado= rs.getInt("estado");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_reserva");
                cal.setTimeInMillis(t1.getTime());
                String mat = rs.getString("cod_material");
                Reserva res = new Reserva(codigo, usuDAO.getUsuario(usu), estado, cal, mat);
                data.add(res);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
    

    public Reserva getReserva(int codigo) {
        Reserva res = null;
        ResultSet rs = con.getQuery("select * from reserva where codigo=" + codigo);
        try {
            if (rs.next()) {
                String usu = rs.getString("cod_usuario");
                int estado= rs.getInt("estado");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_reserva");
                cal.setTimeInMillis(t1.getTime());
                String mat = rs.getString("cod_material");
                res = new Reserva (codigo, usuDAO.getUsuario(usu), estado, cal, mat);
            }
            rs.close();
        } catch (SQLException ex) {
            res = null;
        }
        return res;
    }

    public Reserva getReservaCodUsu(String codigo) {
        Reserva res = null;
        ResultSet rs = con.getQuery("select * from reserva where cod_usuario='" + codigo + "' and estado=0");
        try {
            if (rs.next()) {
                int cod = rs.getInt("codigo");
                int estado= rs.getInt("estado");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_reserva");
                cal.setTimeInMillis(t1.getTime());
                String mat = rs.getString("cod_material");
                res = new Reserva (cod, usuDAO.getUsuario(codigo), estado, cal, mat);
            }
            rs.close();
        } catch (SQLException ex) {
            res = null;
        }
        return res;
    }
    
    public boolean addReserva(Reserva res) {
       boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal2 = sdf.format(res.getFecha_reserva().getTime());
        String sql = "insert into reserva (cod_usuario,estado,fecha_reserva,cod_material) values ('"+res.getUsu().getCodigo()+"'," +res.getEstado()+ ",'"
                + cal2 + "','" + res.getMat() + "')";
        int registros = con.setQuery(sql);
        if (registros == 1) {
            result = true;
        }
        return result;
    }

    public boolean updateReserva(Reserva res) {
         boolean result = false;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String cal2 = sdf.format(res.getFecha_reserva().getTime());
        String sql = "update reserva set cod_usuario='" +res.getUsu().getCodigo()+ "',"
                + " estado="+res.getEstado()+", fecha_reserva='" + cal2
                + "', cod_material='"+ res.getMat()+"' where codigo=" + res.getCodigo();
        int registros = con.setQuery(sql);
        if (registros >= 1) {
            result = true;
        }
        return result;
    }
    
    public ArrayList<Reserva> getRangoFecha_reserva(String fecha1, String fecha2) {
        ArrayList<Reserva> data = new ArrayList<>();
        ResultSet rs = con.getQuery("select * from reserva where fecha_reserva between '" + fecha1 + "' and '" + fecha2 + "'");
        try {
            while (rs.next()) {
                int codigo = rs.getInt("codigo");
                String usu = rs.getString("cod_usuario");
                int est= rs.getInt("estado");
                Calendar cal = Calendar.getInstance();
                Timestamp t1 = rs.getTimestamp("fecha_reserva");
                cal.setTimeInMillis(t1.getTime());
                String mat = rs.getString("cod_material");
                Reserva res = new Reserva(codigo,usuDAO.getUsuario(usu),est,cal,mat);
                data.add(res);
            }
            rs.close();
        } catch (SQLException ex) {
            data = null;
        }
        return data;
    }
}
