<%-- 
    Document   : guardarReporteD
    Created on : 16/02/2014, 05:34:23 PM
    Author     : Samy
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
        String descripcion = request.getParameter("descripcion");
        String codigo_material = request.getParameter("codigo_material");
        String codigo_usuario = request.getParameter("codigo_usuario");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String minutos = request.getParameter("minutos");
        String estado = request.getParameter("estado");

        try {
            a = Integer.parseInt(accion);
            if (a == 1) {
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
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
                    if (codigo_material != null && codigo_material.length() > 0) {

                        Danho dan = new Danho(Integer.parseInt(codigo), descripcion, Gestor.getMaterial(Integer.parseInt(codigo_material)), Gestor.getUsuario(codigo_usuario), cal, user, Integer.parseInt(estado));
                        if (Gestor.addDanho(dan) == true) {
                            response.sendRedirect("listarReporteD.jsp?accion=1");
                        } else {
                            error = "no_agrego";
                        }

                    }
                } catch (Exception e) {
                    error = "fecha_error";
                }
             } else if (a == 2) {
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
                }
                    int cod= Integer.parseInt(codigo);
                    Danho dan= Gestor.getDanho(cod);
                    dan.setDescripcion(descripcion);
                    dan.setEstado(Integer.parseInt(estado));
                    if (Gestor.updateDanho(dan) == true) {
                        response.sendRedirect("listarReporteD.jsp?accion=1");
                    } else {
                        error = "no_agrego";
                    }
            }
        } catch (Exception e) {
            error = "sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("agregarReporteD.jsp?" + error);
    }
%>
