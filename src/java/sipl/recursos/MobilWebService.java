/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.util.ArrayList;
import java.util.Calendar;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import sipl.db.Conexion;
import sipl.db.materialDAO;
import sipl.db.multaDAO;
import sipl.db.prestamoDAO;
import sipl.db.tipo_materialDAO;
import sipl.db.usuarioDAO;
import sipl.db.variableSisDAO;
import sipl.dominio.Gestor;
import sipl.dominio.Material;
import sipl.dominio.Multa;
import sipl.dominio.Prestamo;
import sipl.dominio.Tipo_material;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
@WebService(serviceName = "MobilWebService")
public class MobilWebService {

    Gestor gestor = new Gestor();
    Conexion con = new Conexion();
    usuarioDAO usuDAO = new usuarioDAO(con);
    prestamoDAO preDAO = new prestamoDAO(con);
    materialDAO matDAO = new materialDAO(con);
    tipo_materialDAO tipDAO = new tipo_materialDAO(con);
    variableSisDAO varDAO = new variableSisDAO(con);
    multaDAO mulDAO = new multaDAO(con);

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
        String rs = "";
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
                    } else {
                        rs = "error_apiS";
                    }
                } catch (NumberFormatException e) {
                    rs = "error_apiS";
                }
                Usuario usu = usuDAO.getUsuario(cod_usuario);
                if (apiS.equals(aS)) {
                    Calendar cal = Calendar.getInstance();
                    if (usu.getEstado() == 2) {
                        rs = "usuario_prestamo";
                    } else if (usu.getEstado() == 3) {
                        rs = "usuario_reserva";
                    } else if (usu.getEstado() == 4) {
                        rs = "usuario_multa";
                    } else if (usu.getEstado() == 1) {
                        rs = "usuario_inactivo";
                    } else if (usu.getEstado() == 0) {
                        long i = cal.getTimeInMillis();
                        Calendar cal2 = Calendar.getInstance();
                        cal2.setTimeInMillis(i);
                        int dia = cal.get(Calendar.DAY_OF_MONTH);
                        dia += 3;
                        cal2.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), dia);
                        int disp = 0;
                        int esta = 0;
                        String mates[] = cod_materiales.split(";");
                        try {
                            for (String mate : mates) {
                                Material mat = matDAO.getMaterial(Integer.parseInt(mate));
                                if (mat != null) {
                                    if (mat.getDisponibilidad() != 0) {
                                        disp++;
                                    }
                                    if (mat.getEstado() == 1 || mat.getEstado() == 2) {
                                        esta++;
                                    }
                                }
                            }
                            if (disp == 0 && esta == 0) {
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
                                rs = "Prestamo_Agregado";
                            }
                        } catch (NumberFormatException e) {
                            rs = "error";
                        }
                    }
                } else {
                    rs = "ApiS_error";
                }
            } else {
                rs = "ApiK_error";
            }
        } else {
            rs = "codigo usuario error";
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
        String rs;
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            Usuario usu = usuDAO.getLogin(user, gestor.encriptar(password));
            if (usu != null) {
                rs = usu.getCodigo() + ";" + usu.getNombre() + ";" + usu.getApellido() + ";" + usu.getTipo_usuario() + ";"
                        + usu.getEstado() + ";" + usu.getClave();
            } else {
                rs = "Error_usu";
            }
        } else {
            rs = "ApiK_error";
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
        String rs = "";
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            Usuario usu = usuDAO.getUsuario(cod_usuario);
            String aS = "";
            int tam = Integer.parseInt("" + apiS.charAt(0));
            String cod = apiS.substring(1, tam + 1);
            Usuario adm = usuDAO.getUsuario(cod);
            String c = adm.getCodigo();
            aS += c.length() + "" + c + "" + adm.getClave();
            if (apiS.equals(aS) && (adm.getTipo_usuario() == 1 || adm.getTipo_usuario() == 2)) {
                if (usu.getEstado() == 2) {
                    Prestamo pre;
                    pre = preDAO.getPrestamoCodUsu(usu.getCodigo());
                    if (pre != null) {
                        String[] cadena = pre.getMat().split(";");
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
                                rs = "error_material";
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
                            rs = "multa_generada";
                        } else {
                            rs = "prestamo_finalizado";
                        }
                    }else{
                        rs="Sin Prestamo";
                    }
                }
            } else {
                rs = "ApiS_error";
            }
        } else {
            rs = "ApiK_error";
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
                }
            } catch (NumberFormatException e) {
                rs = "1;Error_CodigoMaterial";
            }
        } else {
            rs = "1;ApiK_error";
        }
        System.out.print(rs);
        return rs;
    }

    /**
     * Web service operation
     *
     * @param apiK
     * @return
     */
    @WebMethod(operationName = "listarMateriales")
    public ArrayList listarMateriales(@WebParam(name = "apiK") String apiK) {
        ArrayList data = new ArrayList();
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            ArrayList<Material> materiales = matDAO.getMateriales();
            for (Material mat : materiales) {
                data.add(mat.getCodigo() + ";" + mat.getDescripcion() + ";" + mat.getDisponibilidad() + ";" + mat.getEstado());
            }
        }
        return data;
    }

    /**
     * Web service operation
     * @param cod_usuario
     * @param apiK
     * @return 
     */
    @WebMethod(operationName = "getPrestamo")
    public String getPrestamo(@WebParam(name = "cod_usuario") String cod_usuario, @WebParam(name = "apiK") String apiK) {
        String rs = "";
        String aK = varDAO.getTipo_variable(5).getDatos();
        if (aK.equals(apiK)) {
            Prestamo pre = preDAO.getPrestamoCodUsu(cod_usuario);
            if(pre!=null){
                String materiales [] = pre.getMat().split(";");
                for(String mat:materiales){
                    Material material = matDAO.getMaterial(Integer.parseInt(mat));
                    rs+=mat+":"+material.getTipo_mat().getNombre()+"/";
                }
                rs+=";"+pre.getFecha_prestamo();
            }else{
                rs="sin Prestamo";
            }
        }else{
            rs="apiK Error";
        }
        return rs;
    }

}