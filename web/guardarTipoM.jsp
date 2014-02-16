<%-- 
    Document   : guardarTipoM
    Created on : 16-feb-2014, 15:40:49
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
    } else if (user.getTipo_usuario() == 2) {
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        try {
            a = Integer.parseInt(accion);
            if (a == 1) {
                if(descripcion.length()==0 || descripcion==null){
                    descripcion="ninguno";
                }
                if (codigo != null && codigo.length() > 0 && nombre != null
                        && nombre.length() > 0 && descripcion != null && descripcion.length() > 0) {
                    int c = Integer.parseInt(codigo);
                    Tipo_material tip = new Tipo_material(c, nombre, descripcion, 0, 0);
                    if (Gestor.addTipoMaterial(tip) == true) {
                        response.sendRedirect("principal.jsp");
                    } else {
                        error = "no_agrego";
                    }
                } else {
                    error = "datos_incompletos";
                }
            } else if (a == 2) {
                
            }
        } catch (Exception e) {

        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>