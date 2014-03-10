<%-- 
    Document   : darBajaMulta
    Created on : 28-feb-2014, 1:30:40
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
        String ID = request.getParameter("id");
        Multa mul = Gestor.getMulta(Integer.parseInt(ID));
        mul.setEstado_multa(1);
        Usuario usu = Gestor.getUsuario(mul.getUsu().getCodigo());
        usu.setEstado(0);
        Gestor.updateUsuario(usu);
        Gestor.updateMulta(mul);
        response.sendRedirect("darBajaM.jsp?accion=2");
    } else {
        error = "sin_permisos";
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>