<%-- 
    Document   : listarMateriales
    Created on : 13-feb-2014, 23:17:20
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario() == 1) {
        ArrayList<Material> data = Gestor.getMateriales();
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
        <style>
            html,body{ background: #e0e0e0; }   
        </style>
        <title>Listar Materiales</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function fijarURL(url, form) {
                form.action = url;
                form.submit();
            }
        </script>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Listar Materiales</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form action="modificarMaterial.jsp" method="POST">
                    <table class="table table-hover" align="center">
                        <tr>
                            <%
                                if (a == 2 && user.getTipo_usuario() == 2) {
                                    out.print("<td></td>");
                                }
                            %>
                            <td><b></b></td>
                            <td><b>Código</b></td>
                            <td><b>Tipo</b></td>
                            <td><b>Descripción</b></td>
                            <td><b>Marca</b></td>
                            <td><b>Serial</b></td>
                            <td><b>Estado actual del elemento</b></td>
                            <td><b>Nro Inventario</b></td>
                            <td><b>Foto</b></td>
                            <td><b>Ult. Fecha Mantenimiento</b></td>
                        </tr>
                        <%
                            if (data.size() == 0) {
                                out.print("<tr>");
                                out.print("<td colspan='10' align='center'>No hay Materiales</td>");
                                out.print("</tr>");
                            } else {
                                for (int i = 0; i < data.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                    out.print("checked='checked'/></td>");
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    out.print("<td>" + Gestor.getTipoM(data.get(i).getTipo_mat().getId()).getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getDescripcion() + "</td>");
                                    out.print("<td>" + data.get(i).getMarca() + "</td>");
                                    out.print("<td>" + data.get(i).getSerial() + "</td>");
                                    if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Activo</td>");
                                    } else if (data.get(i).getEstado() == 1) {
                                        out.print("<td>Dado de baja</td>");
                                    } else if (data.get(i).getEstado() == 2) {
                                        out.print("<td>Dañado</td>");
                                    } else if (data.get(i).getEstado() == 3) {
                                        out.print("<td>Reparado</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    out.print("<td>" + data.get(i).getNum_inventario() + "</td>");
                                    out.print("<td>" + data.get(i).getFoto_mat() + "</td>");
                                    Calendar cal1 = data.get(i).getUlt_fecha_mante();
                                    String fecha = cal1.get(Calendar.YEAR) + "-";
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    fecha += mes + "-";
                                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                                    out.print("<td>" + fecha + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                        <tr>
                            <td colspan="10" align="center">
                                <%
                                    if (a == 2 && data.size() > 0) {%>
                                <button type="submit" class="btn btn-success" style='width:200px;'>Modificar</button>
                                <%}
                                %>
                                <%
                                    if (data.size() > 0) {%>
                                <input class="btn btn-info" type="button" value="Ver Material" onclick="fijarURL('verMaterial.jsp', this.form)" style='width:200px;'/>
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
