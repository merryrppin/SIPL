<%-- 
    Document   : generarQR
    Created on : 02-mar-2014, 20:30:41
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String codigo = request.getParameter("codigo");
        String direccion = Gestor.getVariable(1).getDatos();
        direccion += "QR/"+codigo;
        Gestor.generarQR(codigo, direccion);
        int num = Integer.parseInt(codigo);
        int ubi = 0;
        if (num < 10) {
            ubi = 50;
        } else if (num < 99) {
            ubi = 44;
        } else if (num < 999) {
            ubi = 38;
        } else {
            ubi = 32;
        }
        Gestor.agregarTextoImagen(direccion, codigo, ubi);
        response.sendRedirect("verMaterial.jsp?id=" + codigo);
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>