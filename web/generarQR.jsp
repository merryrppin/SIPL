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
        Material mat = Gestor.getMaterial(Integer.parseInt(codigo));
        String direccion = this.getServletContext().getRealPath("/QR/");
        String d[] = direccion.split("build");
        String a1 = d[0];
        String b1 = d[1];
        String c1 = a1.substring(a1.length() - 1, a1.length());
        String A = a1.substring(0, a1.length() - 1);
        String dir = A + b1 + c1 + codigo;
        Gestor.generarQR(codigo, dir);
        response.sendRedirect("verMaterial.jsp?id="+codigo);
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>