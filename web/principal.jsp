<%-- 
    Document   : principal
    Created on : 11-feb-2014, 10:00:38
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
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
                <h6><b><%out.print(user.getNombre() + " " + user.getApellido());%></b><a href="logout.jsp" style='width:200px;'>Cerrar sesión</a></h6>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Menú Principal</h1>
            </div>
            <div align="center">
                <img src="img/mecatro.jpg" width="700" height="200" alt=".." class="img-rounded">
            </div>
        </div>

        <div class="row"> 
            <div class="col-xs-6 col-sm-2"></div>
            <div class="col-xs-12 col-sm-8">
                <ul class="nav nav-tabs" id="myTab" >
                    <li><a href="#Usuario" data-toggle="tab">Usuario  <span class="glyphicon glyphicon-user"></span></a></li>
                    <li><a href="#Multa" data-toggle="tab">Multa  <span class="glyphicon glyphicon-exclamation-sign"></span></a></li>
                    <li><a href="#Material" data-toggle="tab">Material  <span class="glyphicon glyphicon-wrench"></span></a></li>
                    <li><a href="#Reserva" data-toggle="tab">Reserva <span class="glyphicon glyphicon-tag"></span></a></li>
                    <li class="active"><a href="#Prestamo" data-toggle="tab">Préstamo  <span class="glyphicon glyphicon-time"></span></a></li>
                    <li><a href="#Laboratorio" data-toggle="tab">Laboratorio  <span class="glyphicon glyphicon-home"></span></a></li>
                    <li><a href="#Estadistica" data-toggle="tab">Estadísticas  <span class="glyphicon glyphicon-stats"></span></a></li>
                    <li><a href="#Backup" data-toggle="tab">Backup  <span class="glyphicon glyphicon-save"></span></a></li>
                    <li><a href="#Acercade" data-toggle="tab">Acerca de  <span class="glyphicon glyphicon-circle-arrow-right"></span></a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="Material">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" disabled="disabled" type="button" style='width:200px;'>Agregar Material</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarMaterial.jsp'" style='width:200px;'>Agregar Material</button>
                                    <%
                                        }
                                    %>

                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarReporteD.jsp'" style='width:200px;'>Agregar Reporte daño</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Modificar Material</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMateriales.jsp?accion=2'" style='width:200px;'>Modificar Material</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarReporteD.jsp?accion=2'" style='width:200px;'>Modificar Reporte daño</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMateriales.jsp?accion=1'" style='width:200px;'>Listar Materiales</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarReporteD.jsp?accion=1'" style='width:200px;'>Listar Reporte daños</button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarTipoM.jsp'" style='width:200px;'>Agregar Tipo de material</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Usuario">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarUsuario.jsp'"  style='width:200px;'>Agregar Usuario</button>
                                </td>
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Asignar Privilegios</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'asignarPrivilegios.jsp', this.form" style='width:200px;'>Asignar Privilegios</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarUsuarios.jsp?accion=2', this.form" style='width:200px;'>Modificar Usuario</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarUsuarios.jsp?accion=1'" style='width:200px;'>Listar Usuarios</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Prestamo">
                        <table class="table table-hover" align="center">
                            <tr align ="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarPrestamo.jsp?accion=0'" style='width:200px;'>Agregar Préstamo</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarPrestamo.jsp'" style='width:200px;'>Modificar Préstamo</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarPrestamos.jsp'" style='width:200px;'>Listar Préstamos</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Dar de baja multa</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'darBajaM.jsp?accion=2'"  style='width:200px;'>Dar de baja multa</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMultas.jsp'" style='width:200px;'>Listar Multas</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Agregar Laboratorio</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarLaboratorio.jsp'" style='width:200px;'>Agregar Laboratorio</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Modificar Laboratorio</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarLaboratorios.jsp?accion=2'" style='width:200px;'>Modificar Laboratorio</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled"  style='width:200px;'>Listar Laboratorios</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarLaboratorios.jsp'" style='width:200px;'>Listar Laboratorios</button>
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
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaPrestamo.jsp'" style='width:200px;'>Préstamos</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaMultas.jsp'" style='width:200px;'>Multas</button>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'graficar.jsp?accion=1'" style='width:200px;'>Materiales</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'estadisticaDanho.jsp'" style='width:200px;'>Daños</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Backup</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'backup.jsp'" style='width:200px;'>Backup</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Restore</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'restore.jsp'" style='width:200px;'>Restore</button>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Acercade">

                        <table class="table table-hover" align="center">

                            <tr>
                                <td align="left"> 
                                    <p class="bg-success"> <em> <b>Versión 1.0 </b><br><br>
                                            El Sistema de Información para el Control de Materiales de los Laboratorios de la Facultad de Ingenierías Físico-Mecánicas de la UNAB,
                                            fue elaborado como proyecto de grado por los estudiantes <b>Sandra Milena Vera Gómez</b> y <b>Wilmar González Franco</b> de la 
                                            Facultad de Ingeniería de Sistemas de la UNAB, bajo la supervisión y tutoría de los docentes <b>Juan Carlos García Ojeda</b> , <b>Freddy Mendez Ortiz</b> y
                                            <b>Daniel Arenas Seleey</b>.
                                        </em></p></td>
                            </tr>
                        </table>
                    </div>
                                <div class="tab-pane" id="Reserva">
                        <table class="table table-hover">
                            <tr align="center">
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Agregar Reserva</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarReserva.jsp'" style='width:200px;'>Agregar Reserva</button>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        if (user.getTipo_usuario() == 1) {
                                    %>
                                    <button class="btn btn-primary" type="button" disabled="disabled" style='width:200px;'>Modificar Reserva</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarReservas.jsp?accion=2'" style='width:200px;'>Modificar Reserva</button>
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
                                    <button class="btn btn-primary" type="button" disabled="disabled"  style='width:200px;'>Listar Reservas</button>
                                    <%} else if (user.getTipo_usuario() == 2) {
                                    %>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarReservas.jsp'" style='width:200px;'>Listar Reservas</button>
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
