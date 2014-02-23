<%-- 
    Document   : guardarMaterial
    Created on : 14-feb-2014, 0:32:24
    Author     : WM
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.Exception"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    String accion = request.getParameter("accion");
    int a = 0;
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String codigo = request.getParameter("codigo");
        String tipo = request.getParameter("tipo");
        String marca = request.getParameter("marca");
        String numero = request.getParameter("numero");
        String serial = request.getParameter("serial");
        String estado = request.getParameter("estado");
        String fecha = request.getParameter("fecha");
        String foto = request.getParameter("foto");
        String descripcion = request.getParameter("descripcion");
        String laboratorio = request.getParameter("laboratorio");
        String disponibilidad = request.getParameter("disponibilidad");
        String hora = request.getParameter("hora");
        String minutos = request.getParameter("minutos");
        String direccion = this.getServletContext().getRealPath("/QR/");
        String d[] = direccion.split("build");
        String a1 = d[0];
        String b1 = d[1];
        String c1 = a1.substring(a1.length() - 1, a1.length());
        String A = a1.substring(0, a1.length() - 1);
        String dir = A + b1 + c1 + codigo;

        try {
            a = Integer.parseInt(accion);
            if (a == 1) {
                try {
                    Gestor.generarQR(codigo, dir);
                } catch (Exception e) {
                    error = "QR_error";
                }
                try {
                    if (foto == null && foto.length() == 0) {
                        foto = "ninguna";
                    }
                } catch (Exception e) {
                    foto = "ninguna";
                }
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
                }
                if (numero.length() == 0 || numero == null) {
                    numero = " ";
                }
                if (marca.length() == 0 || marca == null) {
                    marca = "ninguna";
                }
                if (serial.length() == 0 || serial == null) {
                    serial = "ninguna";
                }
                try {
                    int h = Integer.parseInt(hora);
                    if (h < 10) {
                        hora = "0" + h;
                    }
                    int m = Integer.parseInt(minutos);
                    if (m < 10) {
                        minutos = "0" + m;
                    }
                    String[] f = fecha.split("/");
                    String fe = f[2] + "-" + f[1] + "-" + f[0];
                    fe += " " + hora + ":" + minutos + ":00";
                    Calendar cal = Calendar.getInstance();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    try {
                        Date myDate = sdf.parse(fe);
                        cal.setTime(myDate);
                    } catch (Exception e) {
                        error = "error_fecha";
                    }
                    Material mat = new Material(Integer.parseInt(codigo), descripcion, Gestor.getTipoM(Integer.parseInt(tipo)),
                            marca, serial, foto, numero, Integer.parseInt(estado), cal, Integer.parseInt(disponibilidad),
                            Gestor.getLaboratorio(Integer.parseInt(laboratorio)), dir);
                    if (Gestor.addMaterial(mat) == true) {
                        Tipo_material tip = Gestor.getTipoM(Integer.parseInt(tipo));
                        int disp = tip.getDisponibilidad();
                        int can = tip.getCantidad();
                        can++;
                        if (Integer.parseInt(estado) == 0 || Integer.parseInt(estado) == 3) {
                            disp++;
                        }
                        tip.setDisponibilidad(disp);
                        tip.setCantidad(can);
                        Gestor.updateTipoMat(tip);
                        response.sendRedirect("verMaterial.jsp?id=" + mat.getCodigo());
                    } else {
                        error = "no_agrego";
                    }
                } catch (Exception e) {
                    error = "fecha_error";
                }
            } else if (a == 2) {
                try {
                    Gestor.generarQR(codigo, dir);
                } catch (Exception e) {
                    error = "QR_error";
                }
                try {
                    if (foto == null && foto.length() == 0) {
                        foto = "ninguna";
                    }
                } catch (Exception e) {
                    foto = "ninguna";
                }
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
                }
                if (numero.length() == 0 || numero == null) {
                    numero = " ";
                }
                if (marca.length() == 0 || marca == null) {
                    marca = "ninguna";
                }
                if (serial.length() == 0 || serial == null) {
                    serial = "ninguna";
                }
                try {
                    int h = Integer.parseInt(hora);
                    if (h < 10) {
                        hora = "0" + h;
                    }
                    int m = Integer.parseInt(minutos);
                    if (m < 10) {
                        minutos = "0" + m;
                    }
                    String[] f = fecha.split("/");
                    String fe = f[2] + "-" + f[1] + "-" + f[0];
                    fe += " " + hora + ":" + minutos + ":00";
                    Calendar cal = Calendar.getInstance();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    try {
                        Date myDate = sdf.parse(fe);
                        cal.setTime(myDate);
                    } catch (Exception e) {
                        error = "error_fecha";
                    }
                    Material mat = new Material(Integer.parseInt(codigo), descripcion, Gestor.getTipoM(Integer.parseInt(tipo)),
                            marca, serial, foto, numero, Integer.parseInt(estado), cal, Integer.parseInt(disponibilidad),
                            Gestor.getLaboratorio(Integer.parseInt(laboratorio)), dir);
                    if (Gestor.updateMaterial(mat) == true) {
                        response.sendRedirect("listarMateriales.jsp?accion=1");
                    } else {
                        error = "no_agrego";
                    }
                } catch (Exception e) {
                    error = "fecha_error";
                }
            }
        } catch (Exception e) {
            error = "sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("agregarMaterial.jsp?" + error);
    }
%>
