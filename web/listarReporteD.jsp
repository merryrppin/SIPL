<%-- 
    Document   : listarReporteD
    Created on : 16/02/2014, 03:18:31 PM
    Author     : Samy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        ArrayList<Danho> data = Gestor.getDanhos();
        String accion = request.getParameter("accion");
        int a = 0;
        if (accion != null) {
            a = Integer.parseInt(accion);
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Reporte de Daños en Materiales</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Listar Reporte de Daños en Materiales</h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form action="modificarReporteD.jsp" method="POST">
                    <table class="table table-striped" align="center">
                        <tr>
                            <%
                                if (a == 2) {
                                    out.print("<td></td>");
                                }
                            %>
                            <td><b>Código</b></td>
                            <td><b>Descripción</b></td>
                            <td><b>Código Material</b></td>
                            <td><b>Descripción Material</b></td>
                            <td><b>Código Usuario</b></td>
                            <td><b>Nombre Usuario</b></td>
                            <td><b>Apellidos Usuario</b></td>
                            <td><b>Fecha Daño</b></td>
                            <td><b>Daño Reportado por</b></td>
                            <td><b>Estado</b></td>
                        </tr>
                        <%
                            if (data.size() == 0) {
                                out.print("<tr>");
                                out.print("<td colspan='4' align='center'>No hay Reportes de Daños</td>");
                                out.print("</tr>");
                            } else {
                                for (int i = 0; i < data.size(); i++) {
                                    out.print("<tr>");
                                    if (a == 2) {
                                        out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                        out.print("checked='checked'/></td>");
                                    }
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getDescripcion() + "</td>");
                                    out.print("<td>" + data.get(i).getMat().getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getMat().getDescripcion() + "</td>");
                                    out.print("<td>" + data.get(i).getUsu().getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getUsu().getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getUsu().getApellido() + "</td>");
                                    Calendar cal1 = data.get(i).getFecha_d();
                                    String fecha = cal1.get(Calendar.YEAR) + "-";
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    fecha += mes + "-";
                                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                                    out.print("<td>" + fecha + "</td>");
                                    out.print("<td>" + data.get(i).getUsu_rd().getCodigo()+": "+Gestor.getUsuario(data.get(i).getUsu_rd().getCodigo()).getNombre() +"</td>");
                                    if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Dañado</td>");
                                    } else if (data.get(i).getEstado() == 1) {
                                        out.print("<td>Reparado</td>");
                                    } else if (data.get(i).getEstado() == 2) {
                                        out.print("<td>Dado de baja</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    out.print("</tr>");
                                }
                            }
                        %>
                        <tr>
                            <td colspan="11" align="center">
                                <%
                                if (a == 2) {%>
                                <button type="submit" class="btn btn-success" style='width:200px;'>Modificar</button>
                                <%}
                                %>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-1"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>