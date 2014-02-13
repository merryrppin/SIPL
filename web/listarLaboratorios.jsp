<%-- 
    Document   : listarLaboratorios
    Created on : 13-feb-2014, 18:20:26
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        ArrayList<Laboratorio> data = Gestor.getLaboratorios();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Laboratorios</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Listar Laboratorios</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <table class="table table-hover" align="center">
                    <tr>
                        <td>Código</td>
                        <td>Nombre</td>
                        <td>Descripción</td>
                        <td>Ubicación</td>
                    </tr>
                    <tr>
                        <%
                            if (data.size() == 0) {
                                out.print("<td colspan='4' align='center'>No hay Laboratorios</td>");
                            } else {
                                for (int i = 0; i < data.size(); i++) {
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getDescripcion() + "</td>");
                                    out.print("<td>" + data.get(i).getUbicacion() + "</td>");
                                }
                            }
                        %>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:200px;'>Atrás</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-xs-6 col-sm-1"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>