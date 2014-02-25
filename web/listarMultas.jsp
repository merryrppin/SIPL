<%-- 
    Document   : listarMultas
    Created on : 24/02/2014, 10:44:08 PM
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
        ArrayList<Multa> data = Gestor.getMultas();
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
        <title>Listar Multas</title>
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
                <h1>Listar Multas</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form action="DarbajaMulta.jsp" method="POST">
                <table class="table table-striped" align="center">
                    <tr>
                        <%
                            if (a == 2) {
                                out.print("<td></td>");
                            }
                        %>
                        <td><b>Código Usuario</b></td>
                        <td><b>Nombre Usuario</b></td>
                        <td><b>Apellido Usuario</b></td>
                        <td><b>Fecha Multa</b></td>
                        <td><b>Estado Multa</b></td>
                        <td><b>Tiempo Multa</b></td>
                    </tr>
                        <%
                            if (data.size() == 0) {
                                out.print("<tr>");
                                out.print("<td colspan='4' align='center'>No hay Multas</td>");
                                out.print("</tr>");
                            } else {
                                for (int i = 0; i < data.size(); i++) {
                                    out.print("<tr>");
                                    if (a == 2) {
                                        out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                        out.print("checked='checked'/></td>");
                                    }
                                    out.print("<td>" + data.get(i).getUsu().getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getUsu().getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getUsu().getApellido() + "</td>");
                                    Calendar cal1 = data.get(i).getFecha_multa();
                                    String fecha = cal1.get(Calendar.YEAR) + "-";
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    fecha += mes + "-";
                                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                                    out.print("<td>" + fecha + "</td>");
                                    if (data.get(i).getEstado_multa() == 0) {
                                        out.print("<td>Activo</td>");
                                    } else if (data.get(i).getEstado_multa() == 1) {
                                        out.print("<td>Inactivo</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    out.print("<td>" + data.get(i).getTiempo_multa() + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                    <tr>
                        <td colspan="6" align="center">
                            <%
                            if(a==2){%>
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