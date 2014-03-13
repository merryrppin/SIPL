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
        if (a == 1) {
            String titulo = "Listar materiales";
            VariableSis vs = Gestor.getVariable(1);
            String img = vs.getDatos() + "img//logo_unab.jpg";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            String FILE = "";
            Calendar cal1 = Calendar.getInstance();
            String fecha = cal1.get(Calendar.YEAR) + "-";
            int mes = cal1.get(Calendar.MONTH);
            mes++;
            fecha += mes + "-";
            fecha += cal1.get(Calendar.DAY_OF_MONTH);
            fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
            fecha += "-" + cal1.get(Calendar.MINUTE) + "-00";
            FILE += titulo + " " + fecha + ".pdf";
            response.sendRedirect("listarMateriales.jsp?" + FILE);
        } else if (a == 2) {
            String titulo = "Listar usuarios";
            VariableSis vs = Gestor.getVariable(1);
            String img = vs.getDatos() + "img//logo_unab.jpg";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos());
            String FILE = "";
            Calendar cal1 = Calendar.getInstance();
            String fecha = cal1.get(Calendar.YEAR) + "-";
            int mes = cal1.get(Calendar.MONTH);
            mes++;
            fecha += mes + "-";
            fecha += cal1.get(Calendar.DAY_OF_MONTH);
            fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
            fecha += "-" + cal1.get(Calendar.MINUTE) + "-00";
            FILE += titulo + " " + fecha + ".pdf";
            response.sendRedirect("listarUsuarios.jsp?" + FILE);
        } else if (a == 3) {

        } else if (a == 4) {

        } else if (a == 5) {

        } else if (a == 6) {

        } else if (a == 7) {

        } else if (a == 8) {
            String titulo = "Prestamos por Año";
            VariableSis vs = Gestor.getVariable(1);
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            String rango = request.getParameter("rango");
            String imagen = request.getParameter("imagen");
            String img = vs.getDatos() + "img//" + imagen;
            Gestor.GenerarPDFGrafica(titulo, img, usuario, vs.getDatos(), fecha1, fecha2, rango);
            response.sendRedirect("listarMateriales.jsp");
        } else if (a == 9) {

        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>
