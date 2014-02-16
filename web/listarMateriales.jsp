<%-- 
    Document   : listarMateriales
    Created on : 13-feb-2014, 23:17:20
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
                <form action="modificarLaboratorio.jsp" method="POST">
                    <table class="table table-hover" align="center">
                        <tr>
                            <%
                                if (a == 2 && user.getTipo_usuario() == 2) {
                                    out.print("<td></td>");
                                }
                            %>
                            <td><b>Código</b></td>
                            <td><b>Tipo</b></td>
                            <td><b>Descripción</b></td>
                            <td><b>Marca</b></td>
                            <td><b>Serial</b></td>
                            <td><b>Estado</b></td>
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
                                    if (a == 2 && user.getTipo_usuario() == 2) {
                                        out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                        out.print("checked='checked'/></td>");
                                    }
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    ArrayList<Tipo_material> tipos = Gestor.getTiposM();
                                    out.print("<td>" + tipos.get(data.get(i).getTipo_mat().getId()).getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getDescripcion() + "</td>");
                                    out.print("<td>" + data.get(i).getMarca() + "</td>");
                                    out.print("<td>" + data.get(i).getSerial() + "</td>");
                                    if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Activo</td>");
                                    } else if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Dado de baja</td>");
                                    } else if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Dañado</td>");
                                    } else if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Reparado</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    out.print("<td>" + data.get(i).getNum_inventario() + "</td>");
                                    out.print("<td>" + data.get(i).getFoto_mat() + "</td>");
                                    out.print("<td>" + data.get(i).getUlt_fecha_mante() + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                        <tr>
                            <td colspan="10" align="center">
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