<%-- 
    Document   : aplicarRestore
    Created on : 19-feb-2014, 18:06:48
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String dire = request.getParameter("restore");
    String direccion = this.getServletContext().getRealPath("/Backup/");
    String d[] = direccion.split("build");
    String a1 = d[0];
    String b1 = d[1];
    String c1 = a1.substring(a1.length() - 1, a1.length());
    String A = a1.substring(0, a1.length() - 1);
    String dir = A + b1 + c1;
    dir+=dire;
    //String resultado=Gestor.RestoreMysql(dir);
%>
<h1><%out.print("");%></h1>