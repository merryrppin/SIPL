<%-- 
    Document   : guardarVariables
    Created on : 01-jun-2014, 19:29:06
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String dias = request.getParameter("dias");
        String matMax = request.getParameter("matMax");
        String diasPre = request.getParameter("diasPre");
        try {
            int d = Integer.parseInt(dias);
            int matM = Integer.parseInt(matMax);
            int dPre = Integer.parseInt(diasPre);
            VariableSis var = Gestor.getVariable(6);
            var.setDatos("" + d);
            Gestor.updateVariableSis(var);
            VariableSis var2 = Gestor.getVariable(7);
            var2.setDatos("" + matM);
            Gestor.updateVariableSis(var2);
            VariableSis var3 = Gestor.getVariable(8);
            var3.setDatos("" + dPre);
            Gestor.updateVariableSis(var3);
            response.sendRedirect("configuracion.jsp");
        } catch (Exception e) {
            response.sendRedirect("configuracion.jsp?error=error");
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>