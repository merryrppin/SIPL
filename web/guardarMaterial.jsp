<%-- 
    Document   : guardarMaterial
    Created on : 14-feb-2014, 0:32:24
    Author     : WM
--%>

<%@page import="java.lang.Exception"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    String accion = request.getParameter("accion");
    int a = 0;
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        
        try{
            a = Integer.parseInt(accion);
            if (a == 1) {
                String codigo = request.getParameter("codigo");
                String nombre = request.getParameter("nombre");
                String tipo = request.getParameter("tipo");
                String marca = request.getParameter("marca");
                String numero = request.getParameter("numero");
                String serial = request.getParameter("serial");
                String estado = request.getParameter("estado");
                String fecha = request.getParameter("fecha");
                String foto = request.getParameter("foto");
                String descripcion = request.getParameter("descripcion");
                String laboratorio = request.getParameter("laboratorio");
                String disponibilidad = request.getParameter("disponibilidad");
            } else if (a == 2) {

            }
        }catch(Exception e){
            error="sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>
