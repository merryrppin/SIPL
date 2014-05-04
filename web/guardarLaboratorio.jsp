<%-- 
    Document   : guardarLaboratorio
    Created on : 13-feb-2014, 23:49:00
    Author     : WM
--%>

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
        try {
            a = Integer.parseInt(accion);
            String codigo = request.getParameter("codigo");
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String ubicacion = request.getParameter("ubicacion");
            if (a == 1) {
                if (nombre != null && nombre.length() > 0) {
                    int c = Integer.parseInt(codigo);
                    Laboratorio lab = new Laboratorio(c, nombre, descripcion, ubicacion);
                    if (Gestor.addLaboratorio(lab) == true) {
                        response.sendRedirect("listarLaboratorios.jsp");
                    } else {
                        error = "no_agrego";
                    }
                }
            } else if (a == 2) {
                if (codigo != null && codigo.length() > 0 && nombre != null
                        && nombre.length() > 0 && descripcion != null && descripcion.length() > 0) {
                    int c = Integer.parseInt(codigo);
                    Laboratorio lab = new Laboratorio(c, nombre, descripcion, ubicacion);
                    if (Gestor.updateLaboratorio(lab) == true) {
                        response.sendRedirect("listarLaboratorios.jsp");
                    } else {
                        error = "no_agrego";
                    }
                } else {
                    error = "faltan_Datos";
                }
            }
        } catch (Exception e) {

        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>