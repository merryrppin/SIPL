<%-- 
    Document   : aplicarRestore
    Created on : 19-feb-2014, 18:06:48
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String dir = request.getParameter("restore");
%>
