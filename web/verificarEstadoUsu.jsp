<%-- 
    Document   : verificarMulta
    Created on : 22-feb-2014, 22:12:28
    Author     : WM
--%>

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
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario()==1) {
        String codigo = request.getParameter("codigo");
        try {
            Usuario usu = null;
            a = Integer.parseInt(accion);
            try{
                usu = Gestor.getUsuario(codigo);
            }catch(Exception e){
                error="no_usuario";
            }
            if (a == 3) {
                //reserva
            } else if (a == 4) {
                //multa
            }
        } catch (Exception e) {
            error = "sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("agregarMaterial.jsp?" + error);
    }
%>

