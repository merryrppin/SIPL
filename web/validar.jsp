<%-- 
    Document   : validar
    Created on : 09-feb-2014, 23:50:04
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String login = request.getParameter("login");
    String passwd = request.getParameter("passwd");
    if (login != null && login.length() > 0 && passwd != null && passwd.length() > 0) {
        String encr = passwd;
        encr = Gestor.encriptar(encr);
        Usuario usu = Gestor.validarLogin(login, encr);
        if (usu != null) {
            HttpSession hsession = request.getSession(true);
            hsession.setMaxInactiveInterval(30 * 60);
            hsession.setAttribute("user", usu);
            response.sendRedirect("principal.jsp");
        } else {
            response.sendRedirect("login.jsp?error=loginIncorrecto");
        }
    } else {
        response.sendRedirect("login.jsp?error=faltanDatos");
    }
%>