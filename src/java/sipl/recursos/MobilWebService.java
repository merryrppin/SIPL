/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import sipl.db.Conexion;
import sipl.db.materialDAO;
import sipl.db.multaDAO;
import sipl.db.prestamoDAO;
import sipl.db.reservaDAO;
import sipl.db.tipo_materialDAO;
import sipl.db.usuarioDAO;
import sipl.db.variableSisDAO;
import sipl.dominio.Material;
import sipl.dominio.Multa;
import sipl.dominio.Prestamo;
import sipl.dominio.Reserva;
import sipl.dominio.Tipo_material;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
@WebService(serviceName = "MobilWebService")
public class MobilWebService {

    Encri encrip = new Encri();

    /**
     * Web service operation
     *
     * @param cod_materiales
     * @param cod_usuario
     * @param apiK
     * @param apiS
     * @return
     */
    @WebMethod(operationName = "addPrestamo")
    public String addPrestamo(@WebParam(name = "cod_materiales") String cod_materiales,
            @WebParam(name = "cod_usuario") String cod_usuario, @WebParam(name = "apiK") String apiK,
            @WebParam(name = "apiS") String apiS) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        prestamoDAO preDAO = new prestamoDAO(con);
        materialDAO matDAO = new materialDAO(con);
        tipo_materialDAO tipDAO = new tipo_materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (cod_usuario != null && cod_usuario.length() > 0) {
            if (aK.equals(apiK)) {
                String aS = "";
                try {
                    if (apiS.length() > 0) {
                        String t = apiS.substring(0, 1);
                        System.out.print(t);
                        int tam = Integer.parseInt(t);
                        tam++;
                        String codigoAdm = apiS.substring(1, tam);
                        Usuario adm = usuDAO.getUsuario(codigoAdm);
                        String cod = adm.getCodigo();
                        aS += cod.length() + "" + cod + "" + adm.getClave();
                    }
                } catch (NumberFormatException e) {
                }
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (apiS.equals(aS)) {
                    if (usu != null) {
                        Calendar cal = Calendar.getInstance();
                        if (usu.getEstado() == 2) {
                            rs = "Usuario con prestamo";
                        } else if (usu.getEstado() == 3) {
                            rs = "Usuario con reserva";
                        } else if (usu.getEstado() == 4) {
                            rs = "Usuario con multa";
                        } else if (usu.getEstado() == 1) {
                            rs = "Usuario inactivo";
                        } else if (usu.getEstado() == 0) {
                            long i = cal.getTimeInMillis();
                            Calendar cal2 = Calendar.getInstance();
                            cal2.setTimeInMillis(i);
                            int dia = cal.get(Calendar.DAY_OF_MONTH);
                            dia += 3;
                            cal2.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), dia);
                            int disp = 0;
                            int esta = 0;
                            int errorMat = 0;
                            String mates[] = cod_materiales.split(";");
                            int matRepetido = 0;
                            for (String mate : mates) {
                                int x = 0;
                                try {
                                    x = Integer.parseInt(mate);
                                } catch (NumberFormatException e) {
                                    errorMat++;
                                }
                                Material mat = matDAO.getMaterial(x);
                                if (mat != null) {
                                    if (mat.getDisponibilidad() != 0) {
                                        disp++;
                                    }
                                    if (mat.getEstado() == 1 || mat.getEstado() == 2) {
                                        esta++;
                                    }
                                }
                                for (String cadena2 : mates) {
                                    if (x == Integer.parseInt(cadena2)) {
                                        matRepetido++;
                                    }
                                }
                                if (matRepetido == 1) {
                                    matRepetido = 0;
                                }
                            }
                            if (errorMat == 0) {
                                if (disp == 0 && esta == 0) {
                                    if (matRepetido == 0) {
                                        Prestamo pre = new Prestamo(0, cod_materiales, usu, cal, cal2, 0);
                                        for (String mate : mates) {
                                            Material mat = matDAO.getMaterial(Integer.parseInt(mate));
                                            mat.setDisponibilidad(1);
                                            matDAO.updateMaterial(mat);
                                            Tipo_material tip = mat.getTipo_mat();
                                            int d = tip.getDisponibilidad();
                                            d--;
                                            tip.setDisponibilidad(d);
                                            tipDAO.updateTipo_material(tip);
                                        }
                                        usu.setEstado(2);
                                        usuDAO.updateUsuario(usu);
                                        preDAO.addPrestamo(pre);
                                        rs = "Prestamo Agregado";
                                    } else {
                                        rs = "Error en código de Material";
                                    }
                                } else {
                                    rs = "Hay materiales repetidos en el préstamo";
                                }
                            } else {
                                rs = "Materiales no disponibles";
                            }
                        } else {
                            rs = "El usuario no puede realizar Préstamos";
                        }
                    } else {
                        rs = "Error de usuario";
                    }
                } else {
                    rs = "ApiS error";
                }
            } else {
                rs = "ApiK error";
            }
        } else {
            rs = "Codigo usuario error";
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param user
     * @param password
     * @param apiK
     * @return
     */
    @WebMethod(operationName = "login")
    public String login(@WebParam(name = "user") String user, @WebParam(name = "password") String password,
            @WebParam(name = "apiK") String apiK) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            Usuario usu = usuDAO.getLogin(user, encrip.encriptarMD5(password));
            if (usu != null) {
                rs = usu.getCodigo() + ";" + usu.getNombre() + ";" + usu.getApellido() + ";" + usu.getTipo_usuario() + ";"
                        + usu.getEstado() + ";" + usu.getClave();
            } else {
                rs = "errorUsu";
            }
        } else {
            rs = "ApiK error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param cod_usuario
     * @param apiK
     * @param apiS
     * @return
     */
    @WebMethod(operationName = "finalizarPrestamo")
    public String finalizarPrestamo(@WebParam(name = "cod_usuario") String cod_usuario,
            @WebParam(name = "apiK") String apiK, @WebParam(name = "apiS") String apiS) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        prestamoDAO preDAO = new prestamoDAO(con);
        materialDAO matDAO = new materialDAO(con);
        tipo_materialDAO tipDAO = new tipo_materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        multaDAO mulDAO = new multaDAO(con);
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            String aS = "";
            int tam = Integer.parseInt("" + apiS.charAt(0));
            String cod = apiS.substring(1, tam + 1);
            Usuario adm = usuDAO.getUsuario(cod);
            String c = adm.getCodigo();
            aS += c.length() + "" + c + "" + adm.getClave();
            if (apiS.equals(aS) && (adm.getTipo_usuario() == 1 || adm.getTipo_usuario() == 2)) {
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (usu != null) {
                    if (usu.getEstado() == 2) {
                        Prestamo pre;
                        pre = preDAO.getPrestamoCodUsu(usu.getCodigo());
                        if (pre != null) {
                            String[] cadena = pre.getMat().split(";");
                            int matError = 0;
                            for (String cadena1 : cadena) {
                                try {
                                    int x = Integer.parseInt(cadena1);
                                } catch (NumberFormatException e) {
                                    matError++;
                                }
                            }
                            if (matError == 0) {
                                for (String cadena1 : cadena) {
                                    try {
                                        Material mat = matDAO.getMaterial(Integer.parseInt(cadena1));
                                        if (mat != null) {
                                            mat.setDisponibilidad(0);
                                            matDAO.updateMaterial(mat);
                                            Tipo_material tip = mat.getTipo_mat();
                                            int d = tip.getDisponibilidad();
                                            d++;
                                            tip.setDisponibilidad(d);
                                            tipDAO.updateTipo_material(tip);
                                        }
                                    } catch (NumberFormatException e) {
                                        matError++;
                                    }
                                }
                                usu.setEstado(0);
                                Calendar cal = Calendar.getInstance();
                                Calendar cal2 = pre.getFecha_prestamo();
                                long time1 = cal.getTimeInMillis();
                                long time2 = cal2.getTimeInMillis();
                                long dias3 = 259200000;
                                time1 -= dias3;
                                int m = 0;
                                if (time1 > time2) {
                                    usu.setEstado(4);
                                    Multa mul = new Multa(0, usu, cal, 0, 3);
                                    mulDAO.addMulta(mul);
                                    m++;
                                }
                                pre.setEstado(1);
                                pre.setFecha_devolucion(cal);
                                usuDAO.updateUsuario(usu);
                                preDAO.updatePrestamo(pre);
                                if (m > 0) {
                                    rs = "Multa generada";
                                } else {
                                    rs = "Prestamo finalizado";
                                }
                            } else {
                                rs = "Error en 1 o más materiales";
                            }
                        } else {
                            rs = "Sin Prestamo";
                        }
                    } else {
                        rs = "Sin Prestamo";
                    }
                } else {
                    rs = "Usuario inexistente";
                }
            } else {
                rs = "ApiS error";
            }
        } else {
            rs = "ApiK error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param apiK
     * @param idMaterial
     * @return
     */
    @WebMethod(operationName = "validarMaterial")
    public String validarMaterial(@WebParam(name = "apiK") String apiK, @WebParam(name = "idMaterial") String idMaterial) {
        Conexion con = new Conexion();
        materialDAO matDAO = new materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs = "";
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            try {
                int codM = Integer.parseInt(idMaterial);
                Material mat = matDAO.getMaterial(codM);
                if (mat != null) {
                    if (mat.getEstado() == 0) {
                        if (mat.getDisponibilidad() == 0) {
                            rs = "0;" + mat.getTipo_mat().getNombre() + ";Disponible";
                        } else if (mat.getDisponibilidad() == 1) {
                            rs = "1;Prestado";
                        } else if (mat.getDisponibilidad() == 2) {
                            rs = "1;Reservado";
                        }
                    } else if (mat.getEstado() == 1) {
                        rs = "1;Dado de Baja";
                    } else if (mat.getEstado() == 2) {
                        rs = "1;Dañado";
                    }
                } else {
                    rs = "1;Material inexistente";
                }
            } catch (NumberFormatException e) {
                rs = "1;Error Codigo Material";
            }
        } else {
            rs = "1;ApiK error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param apiK
     * @return
     */
    @WebMethod(operationName = "listarMateriales")
    public ArrayList<String> listarMateriales(@WebParam(name = "apiK") String apiK) {
        Conexion con = new Conexion();
        materialDAO matDAO = new materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        ArrayList<String> data = new ArrayList();
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            ArrayList<Material> materiales = matDAO.getMateriales();
            for (Material mat : materiales) {
                if (mat.getDisponibilidad() == 0 && mat.getEstado() == 0) {
                    data.add(mat.getCodigo() + " | " + mat.getDescripcion());
                }
            }
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return data;
    }

    /**
     * Web service operation
     *
     * @param cod_usuario
     * @param apiK
     * @return
     */
    @WebMethod(operationName = "getPrestamo")
    public String getPrestamo(@WebParam(name = "cod_usuario") String cod_usuario, @WebParam(name = "apiK") String apiK) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        prestamoDAO preDAO = new prestamoDAO(con);
        materialDAO matDAO = new materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs = "";
        String aK = varDAO.getTipo_variable(5).getDatos();
        Usuario usu = usuDAO.getUsuario(cod_usuario);
        if (aK.equals(apiK)) {
            if (usu != null) {
                Prestamo pre = preDAO.getPrestamoCodUsu(cod_usuario);
                if (pre != null) {
                    String materiales[] = pre.getMat().split(";");
                    for (String mat : materiales) {
                        Material material = matDAO.getMaterial(Integer.parseInt(mat));
                        rs += mat + ":" + material.getTipo_mat().getNombre() + "/";
                    }
                    Calendar cal1 = pre.getFecha_prestamo();
                    String fecha = cal1.get(Calendar.YEAR) + "-";
                    int mes = cal1.get(Calendar.MONTH);
                    mes++;
                    fecha += mes + "-";
                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                    rs += ";" + fecha;
                } else {
                    rs = "sin Prestamo";
                }
            } else {
                rs = "Usuario inexistente";
            }
        } else {
            rs = "ApiK Error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param apiK
     * @param materiales
     * @param cod_usuario
     * @return
     */
    @WebMethod(operationName = "addReserva")
    public String addReserva(@WebParam(name = "apiK") String apiK, @WebParam(name = "materiales") String materiales,
            @WebParam(name = "cod_usuario") String cod_usuario) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        materialDAO matDAO = new materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        reservaDAO resDAO = new reservaDAO(con);
        String rs = "";
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            if (cod_usuario != null && cod_usuario.length() > 0) {
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (usu != null) {
                    String mats[] = materiales.split(";");
                    int matRepetido = 0;
                    int cont = 0;
                    for (String m : mats) {
                        try {
                            int x = Integer.parseInt(m);
                            Material mat = matDAO.getMaterial(x);
                            if (mat != null) {
                                if (mat.getEstado() == 0) {
                                    if (mat.getDisponibilidad() != 0) {
                                        cont++;
                                    }
                                } else {
                                    cont++;
                                }
                                for (String cadena2 : mats) {
                                    if (x == Integer.parseInt(cadena2)) {
                                        matRepetido++;
                                    }
                                }
                                if (matRepetido == 1) {
                                    matRepetido = 0;
                                }
                            } else {
                                cont++;
                            }
                        } catch (NumberFormatException e) {
                            cont++;
                        }
                    }
                    if (cont == 0) {
                        if (matRepetido == 0) {
                            if (usu.getEstado() == 2) {
                                rs = "Usuario con prestamo";
                            } else if (usu.getEstado() == 3) {
                                rs = "Usuario con reserva";
                            } else if (usu.getEstado() == 4) {
                                rs = "Usuario con multa";
                            } else if (usu.getEstado() == 1) {
                                rs = "Usuario inactivo";
                            } else if (usu.getEstado() == 0) {
                                Calendar cal = Calendar.getInstance();
                                Reserva res = new Reserva(0, usu, 0, cal, materiales);
                                usu.setEstado(3);
                                usuDAO.updateUsuario(usu);
                                resDAO.addReserva(res);
                                rs = "Reserva Agregada";
                            }
                        } else {
                            rs = "Materiales repetidos";
                        }
                    } else {
                        rs = "Error en 1 o más materiales";
                    }
                } else {
                    rs = "Usuario inexistente";
                }
            } else {
                rs = "Codigo usuario error";
            }
        } else {
            rs = "Apik error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param cod_usuario
     * @param apiK
     * @param apiS
     * @return
     */
    @WebMethod(operationName = "getReserva")
    public String getReserva(@WebParam(name = "cod_usuario") String cod_usuario,
            @WebParam(name = "apiK") String apiK, @WebParam(name = "apiS") String apiS) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        reservaDAO resDAO = new reservaDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (cod_usuario != null && cod_usuario.length() > 0) {
            if (aK.equals(apiK)) {
                String aS = "";
                try {
                    if (apiS.length() > 0) {
                        String t = apiS.substring(0, 1);
                        System.out.print(t);
                        int tam = Integer.parseInt(t);
                        tam++;
                        String codigoAdm = apiS.substring(1, tam);
                        Usuario adm = usuDAO.getUsuario(codigoAdm);
                        String cod = adm.getCodigo();
                        aS += cod.length() + "" + cod + "" + adm.getClave();
                    }
                } catch (NumberFormatException e) {
                }
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (apiS.equals(aS)) {
                    if (usu != null) {
                        if (usu.getEstado() == 2 || usu.getEstado() == 0 || usu.getEstado() == 4) {
                            rs = "El usuario no tiene reservas";
                        } else if (usu.getEstado() == 1) {
                            rs = "Usuario inactivo";
                        } else if (usu.getEstado() == 3) {
                            Reserva res = resDAO.getReservaCodUsu(cod_usuario);
                            if (res != null) {
                                Calendar cal = res.getFecha_reserva();
                                String fecha = cal.get(Calendar.YEAR) + "/";
                                int mes = cal.get(Calendar.MONTH);
                                fecha += mes + "/" + cal.get(Calendar.DAY_OF_MONTH);
                                fecha += " - " + cal.get(Calendar.HOUR_OF_DAY) + ":";
                                fecha += cal.get(Calendar.MINUTE) + ":" + cal.get(Calendar.SECOND);
                                rs = fecha + "-.-" + res.getMat();
                            } else {
                                rs = "No se encontró la reserva";
                            }
                        } else {
                            rs = "El usuario no tiene reservas";
                        }
                    } else {
                        rs = "Error de usuario";
                    }
                } else {
                    rs = "ApiS error";
                }
            } else {
                rs = "ApiK error";
            }
        } else {
            rs = "Codigo usuario error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }

    /**
     * Web service operation
     *
     * @param cod_usuario
     * @param apiK
     * @param apiS
     * @return
     */
    @WebMethod(operationName = "addReservaPrestamo")
    public String addReservaPrestamo(@WebParam(name = "cod_usuario") String cod_usuario,
            @WebParam(name = "apiK") String apiK, @WebParam(name = "apiS") String apiS) {
        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        prestamoDAO preDAO = new prestamoDAO(con);
        reservaDAO resDAO = new reservaDAO(con);
        materialDAO matDAO = new materialDAO(con);
        variableSisDAO varDAO = new variableSisDAO(con);
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (cod_usuario != null && cod_usuario.length() > 0) {
            if (aK.equals(apiK)) {
                String aS = "";
                try {
                    if (apiS.length() > 0) {
                        String t = apiS.substring(0, 1);
                        System.out.print(t);
                        int tam = Integer.parseInt(t);
                        tam++;
                        String codigoAdm = apiS.substring(1, tam);
                        Usuario adm = usuDAO.getUsuario(codigoAdm);
                        String cod = adm.getCodigo();
                        aS += cod.length() + "" + cod + "" + adm.getClave();
                    }
                } catch (NumberFormatException e) {
                }
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (apiS.equals(aS)) {
                    if (usu != null) {
                        if (usu.getEstado() == 2) {
                            rs = "Usuario con prestamo";
                        } else if (usu.getEstado() == 0) {
                            rs = "Usuario sin reserva";
                        } else if (usu.getEstado() == 4) {
                            rs = "Usuario con multa";
                        } else if (usu.getEstado() == 1) {
                            rs = "Usuario inactivo";
                        } else if (usu.getEstado() == 3) {
                            usu.setEstado(2);
                            usuDAO.updateUsuario(usu);
                            Reserva res = resDAO.getReservaCodUsu(cod_usuario);
                            Calendar cal = Calendar.getInstance();
                            Prestamo pres = new Prestamo(0, res.getMat(), res.getUsu(), cal, cal, 0);
                            String[] mates = res.getMat().split(";");
                            for (String mate : mates) {
                                Material mat = matDAO.getMaterial(Integer.parseInt(mate));
                                mat.setDisponibilidad(1);
                                matDAO.updateMaterial(mat);
                            }
                            preDAO.addPrestamo(pres);
                            res.setEstado(1);
                            resDAO.updateReserva(res);
                            rs = "Prestamo agregado";
                        } else {
                            rs = "El usuario no puede realizar Préstamos";
                        }
                    } else {
                        rs = "Error de usuario";
                    }
                } else {
                    rs = "ApiS error";
                }
            } else {
                rs = "ApiK error";
            }
        } else {
            rs = "Codigo usuario error";
        }
        try {
            con.Close_DB();
        } catch (SQLException e) {
            System.out.print("No cerró");
        }
        return rs;
    }
}
