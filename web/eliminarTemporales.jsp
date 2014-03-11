<%-- 
    Document   : eliminarTemporales
    Created on : 11-mar-2014, 14:25:38
    Author     : WM
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    String accion = request.getParameter("accion");
    int a = 0;
    String error = "";
    try {
        a = Integer.parseInt(accion);
    } catch (Exception e) {
        a = 0;
        error = "error_accion";
    }
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
        if (a == 1) {
            String sDirectorio = Gestor.getVariable(1).getDatos();
            sDirectorio += "//Grafica";
            File f = new File(sDirectorio);
            if (f.exists()) {
                File[] ficheros = f.listFiles();
                for (int x = 0; x < ficheros.length; x++) {
                    ficheros[x].delete();
                }
            } else {
                error = "no_directorio";
            }
        } else if (a == 2) {
            String sDirectorio = Gestor.getVariable(1).getDatos();
            sDirectorio += "//Backup";
            File f = new File(sDirectorio);
            if (f.exists()) {
                File[] ficheros = f.listFiles();
                if (ficheros.length > 10) {
                    int cantidad = ficheros.length;
                    cantidad -= 10;
                    for (int x = 0; x < cantidad; x++) {
                        ficheros[x].delete();
                    }
                } else {
                    error = "backup_insuficiente";
                }
            } else {
                error = "no_directorio";
            }
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>