<%-- 
    Document   : GenerarPDF
    Created on : 12-mar-2014, 13:52:45
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Error_D er = null;
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    Usuario user = (Usuario) session.getAttribute("user");
    Usuario usuario = Gestor.getUsuario(user.getCodigo());
    String accion = "";
    int a = 0;
    try {
        accion = request.getParameter("accion");
        a = Integer.parseInt(accion);
    } catch (Exception e) {
        error = "error_accion";
    }
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
        VariableSis vs = Gestor.getVariable(1);
        String img = vs.getDatos() + "img//logo_unab.jpg";
        if (a == 1) {
            String titulo = "Listar materiales";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarMateriales.jsp?");
        } else if (a == 2) {
            String titulo = "Listar usuarios";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarUsuarios.jsp?");
        } else if (a == 3) {
            String titulo = "Listar laboratorios";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarLaboratorios.jsp?");
        } else if (a == 4) {
            String titulo = "Listar reservas";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarReservas.jsp?");
        } else if (a == 5) {
            String titulo = "Listar multas";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarMultas.jsp?");
        } else if (a == 6) {
            String titulo = "Listar prestamos";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarPrestamos.jsp?");
        } else if (a == 7) {
            String titulo = "Listar Daño";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            response.sendRedirect("listarReporteD.jsp?");
        } else if (a == 8) {
            String orden = request.getParameter("orden");
            String rango = request.getParameter("rango");
            String titulo = "Prestamos por " + rango;
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            String imagen = request.getParameter("imagen");
            String imge = vs.getDatos() + "Grafica//" + imagen;
            Gestor.GenerarPDFGrafica(titulo, imge, usuario, vs.getDatos(), fecha1, fecha2, rango);
            response.sendRedirect("graficar.jsp?orden=" + orden);
        } else if (a == 9) {

        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>
