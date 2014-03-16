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
    } else if (usuario.getTipo_usuario() == 1 || usuario.getTipo_usuario() == 2) {
        Calendar cal1 = Calendar.getInstance();
        String fecha = cal1.get(Calendar.YEAR) + "-";
        int mes = cal1.get(Calendar.MONTH);
        mes++;
        fecha += mes + "-";
        fecha += cal1.get(Calendar.DAY_OF_MONTH);
        fecha += "_" + cal1.get(Calendar.HOUR_OF_DAY);
        fecha += "-" + cal1.get(Calendar.MINUTE);
        fecha += "-" + cal1.get(Calendar.SECOND);
        String Filex = "";
        VariableSis vs = Gestor.getVariable(1);
        String img = vs.getDatos() + "img//logo_unab.jpg";
        if (a == 1) {
            String titulo = "Listar materiales";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 2) {
            String titulo = "Listar usuarios";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 3) {
            String titulo = "Listar laboratorios";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 4) {
            String titulo = "Listar reservas";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 5) {
            String titulo = "Listar multas";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 6) {
            String titulo = "Listar prestamos";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 7) {
            String titulo = "Listar Daño";
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFListar(titulo, img, usuario, vs.getDatos(), Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 8) {
            String rango = request.getParameter("rango");
            String titulo = "Prestamos por " + rango;
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            String imagen = request.getParameter("imagen");
            String imge = vs.getDatos() + "Grafica//" + imagen;
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFGrafica(titulo, imge, usuario, vs.getDatos(), fecha1, fecha2, rango, Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 9) {
            String rango = request.getParameter("rango");
            String titulo = "Multas por " + rango;
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            String imagen = request.getParameter("imagen");
            String imge = vs.getDatos() + "Grafica//" + imagen;
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFGrafica(titulo, imge, usuario, vs.getDatos(), fecha1, fecha2, rango, Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 10) {
            String rango = request.getParameter("rango");
            String titulo = "Daños por " + rango;
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            String imagen = request.getParameter("imagen");
            String imge = vs.getDatos() + "Grafica//" + imagen;
            Filex += titulo + " " + fecha + ".pdf";
            Gestor.GenerarPDFGrafica(titulo, imge, usuario, vs.getDatos(), fecha1, fecha2, rango, Filex);
            response.sendRedirect("PDF/" + Filex);
        } else if (a == 11) {
            String titulo = "Materiales_por_Categoria";
            String imagen = request.getParameter("imagen");
            String imge = vs.getDatos() + "Grafica//" + imagen;
            Filex += titulo + "_" + fecha + ".pdf";
            Gestor.GenerarPDFGrafica(titulo, imge, usuario, vs.getDatos(), Filex);
            response.sendRedirect("paginaCarga2.jsp?orden=PDF/" + Filex);
        } else {
            error = "error_accion";
        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>
