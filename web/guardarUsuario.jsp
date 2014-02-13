<%-- 
    Document   : guardarUsuario
    Created on : 12/02/2014, 11:26:39 PM
    Author     : Samy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
        String codigo = request.getParameter("codigo");
        String tipo = request.getParameter("tipo");
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String apellidos = request.getParameter("apellidos");
        String estado = request.getParameter("estado");
        String correo = request.getParameter("correo");
        String observaciones = request.getParameter("observaciones");
        String error = "";
        if (codigo != null && codigo.length() > 0 && nombre != null
                && nombre.length() > 0 && telefono != null && telefono.length() > 0
                && apellidos != null && apellidos.length() > 0 && correo != null && correo.length() > 0
                && observaciones != null && observaciones.length() > 0) {
            long tel = 0;
            int tip, est;
            try {
                tel = Long.parseLong(telefono);
                try{
                    tip = Integer.parseInt(tipo);
                }catch(Exception e){
                    tip=0;
                }
                est = Integer.parseInt(estado);
                Usuario usu = new Usuario(codigo, nombre, apellidos, tel, correo, est, tip, observaciones, codigo);
                if (Gestor.addUsuario(usu) == true) {
                    response.sendRedirect("listarUsuarios.jsp");
                } else {
                    error = "usuario_no_agregado";
                }
            } catch (Exception e) {
                error = "telefono_incorrecto";
            }
            if (error.length() > 0) {
                response.sendRedirect("agregarUsuario.jsp?" + error);
            }
        }else{
            error="datos_incompletos";
            response.sendRedirect("agregarUsuario.jsp?" + error);
        }
    }
%>