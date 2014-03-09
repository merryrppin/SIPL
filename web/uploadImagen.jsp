<%-- 
    Document   : upload
    Created on : 04-mar-2014, 10:58:50
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String accion = request.getParameter("accion");
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        error = "No_usuario";
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario() == 1) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Subir imágen</title>
    </head>
    <body>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Subir imágen</h1>
            </div>
        </div>
        <%
        int a=0;
            try {
                a = Integer.parseInt(accion);
            } catch (Exception e) {
                error = "error_accion";
            }
            if (a != 0) {

                if (a == 1) {
                    ArrayList<Material> data = Gestor.getMateriales();
        %>
        <table>
            <tr>
                <td align="center">
                    <img src="Imagenes/${foto}" alt="..." width="500" height="500">
                    <input id="foto" name="foto" value="${foto}" hidden>
                </td>
            </tr>
            <tr>
                <td>
                    
                    <form action="guardarMaterial.jsp?accion=3" method="POST">
                    <table>
                        <tr>
                            <td><b></b></td>
                            <td><b>Código</b></td>
                            <td><b>Tipo</b></td>
                            <td><b>Descripción</b></td>
                            <td><b>Marca</b></td>
                            <td><b>Serial</b></td>
                            <td><b>Estado actual del elemento</b></td>
                            <td><b>Nro Inventario</b></td>
                            <td><b>Disponibilidad</b></td>
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
                                    out.print("<td><input type='checkbox' name='id' value='" + data.get(i).getCodigo() + "' /></td>");
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
                                    if (data.get(i).getDisponibilidad() == 0) {
                                        out.print("<td>Libre</td>");
                                    } else if (data.get(i).getDisponibilidad() == 1) {
                                        out.print("<td>Prestado</td>");
                                    }
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
                                <button type="submit" class="btn btn-success" style='width:200px;'>Guardar imagen en material</button>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                            </td>
                        </tr>
                    </table>
                    </form>
                </td>
            </tr>
        </table>

        <%
            }
        } else {
        %>
        <div class="row">
            <div class="col-xs-12 col-sm-3" align="center">
            </div>
            <div class="col-xs-12 col-sm-6" align="center">
                <form method="post" action="FileUploadServlet" enctype="multipart/form-data">
                    <h2>Select file to upload:</h2>
                    <input type="file" name="uploadFile" />
                    <br/><br/>
                    <input type="submit" value="Upload" />
                </form>
            </div>
            <div class="col-xs-12 col-sm-3" align="center">

            </div>
        </div>
    </body>
</html>
<%}
    } else {
        error = "sin_permisos";
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>