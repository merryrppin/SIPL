<%-- 
    Document   : backup
    Created on : 28-feb-2014, 2:03:53
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String direccion = this.getServletContext().getRealPath("/Backup/");
        String d[] = direccion.split("build");
        String a1 = d[0];
        String b1 = d[1];
        String c1 = a1.substring(a1.length() - 1, a1.length());
        String A = a1.substring(0, a1.length() - 1);
        String dir = A + b1 + c1;
        Calendar cal = Calendar.getInstance();
        int Y = cal.get(Calendar.YEAR);
        int M = cal.get(Calendar.MONTH);
        int D = cal.get(Calendar.DAY_OF_MONTH);
        int h = cal.get(Calendar.HOUR_OF_DAY);
        int m = cal.get(Calendar.MINUTE);
        int s = cal.get(Calendar.SECOND);
        String nombre = "backup";
        nombre += Y + "-" + M + "-" + D + "_" + h + "-" + m + "-" + s;
        nombre += ".sql";
        dir += nombre;
        String resultado = Gestor.GenerarBackup(dir);
%>
<h1><%out.print(resultado);%></h1>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>