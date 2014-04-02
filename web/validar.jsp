<%-- 
    Document   : validar
    Created on : 09-feb-2014, 23:50:04
    Author     : WM
--%>

<%@page import="sipl.db.Conexion"%>
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
        if (usu != null ) {
            if (usu.getEstado() != 1) {
                HttpSession hsession = request.getSession(true);
                hsession.setMaxInactiveInterval(30 * 60);
                hsession.setAttribute("user", usu);
                if(usu.getTipo_usuario()==1 || usu.getTipo_usuario()==2){
                    response.sendRedirect("principal.jsp");
                }else if(usu.getTipo_usuario()==0){
                    response.sendRedirect("principalUsuario.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=usuario_inactivo");
            }
        } else {
            response.sendRedirect("login.jsp?error=login_Incorrecto");
        }
    } else {
        response.sendRedirect("login.jsp?error=faltan_Datos");
    }
%>