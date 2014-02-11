<%-- 
    Document   : principal
    Created on : 11-feb-2014, 10:00:38
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Principal</title>
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
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="right">
                <h6><b><%out.print(user.getNombre() + " " + user.getApellido());%></b><a href="logout.jsp">Cerrar sesión</a></h6>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Menú Principal</h1>
            </div>
        </div>
        <br><br><br><br><br><br><br>
        <div class="row"> 
            <div class="col-xs-6 col-sm-2"></div>
            <div class="col-xs-12 col-sm-8">
                <ul class="nav nav-tabs" id="myTab" >
                    <li class="active"><a href="#Material" data-toggle="tab">Material  <span class="glyphicon glyphicon-qrcode"></span></a></li>
                    <li><a href="#Usuario" data-toggle="tab">Usuario  <span class="glyphicon glyphicon-user"></span></a></li>
                    <li><a href="#Prestamo" data-toggle="tab">Préstamo  <span class="glyphicon glyphicon-pencil"></span></a></li>
                    <li><a href="#Multa" data-toggle="tab">Multa  <span class="glyphicon glyphicon-paperclip"></span></a></li>
                    <li><a href="#Laboratorio" data-toggle="tab">Laboratorio  <span class="glyphicon glyphicon-tower"></span></a></li>
                    <li><a href="#Estadistica" data-toggle="tab">Estadística  <span class="glyphicon glyphicon-tasks"></span></a></li>
                    <li><a href="#Backup" data-toggle="tab">Backup  <span class="glyphicon glyphicon-floppy-save"></span></a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="Material">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" disabled="disabled" type="button">Agregar material</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarMaterial.jsp'">Agregar material</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarReporteD.jsp'">Agregar reporte daño</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Modificar material</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarMaterial.jsp'">Modificar material</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarReporteD.jsp'">Modificar reporte daño</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMaterial.jsp'">Listar material</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarReporteD.jsp'">Listar reporte daño</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Usuario">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarUsuario.jsp'">Agregar usuario</button>
                                </td>
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Asignar Privilegios</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarUsuario.jsp?accion=1', this.form">Asignar Privilegios</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarUsuario.jsp?accion=0', this.form">Modificar Usuario</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarUsuario.jsp'">Listar Usuario</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Prestamo">
                        <table class="table table-hover" align="center">
                            <tr align ="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarPrestamo.jsp'">Agregar Préstamo</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarPrestamo.jsp'">Modificar Préstamo</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarPrestamo.jsp'">Listar Préstamos</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Multa">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Dar de baja multa</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'darBajaM.jsp'">Dar de baja multa</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMultas.jsp'">Listar multas</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Laboratorio">
                        <table class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Agregar laboratorio</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarLaboratorio.jsp'">Agregar laboratorio</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Modificar Laboratorio</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarLaboratorio.jsp'">Modificar Laboratorio</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Listar laboratorios</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarLaboratorios.jsp'">Listar laboratorios</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Estadistica">
                        <table class="table table-hover">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaPrestamos.jsp'">Préstamos</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaMultas.jsp'">Multas</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaMateriales.jsp'">Materiales</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaDanhos.jsp'">Daños</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Backup">
                        <table class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Backup</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'backup.jsp'">Backup</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled">Restore</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'restore.jsp'">Restore</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-2"></div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp?error=sin_permisos");
    }
%>