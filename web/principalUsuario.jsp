<%-- 
    Document   : principalUsuario
    Created on : 11-mar-2014, 16:44:22
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Error_D er = null;
    String error = "";
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    if (error != null && error.length() > 0) {
        er = Gestor.getError(error);
    }
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 0) {
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
            <%if (error != null && error.length() > 0) {%>
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
            <%}
            %>
        </script>
    </head>
    <body>
        <%if (error != null && error.length() > 0) {%>
        <div id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-warning"><%out.print(er.getMensaje());%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" onclick="location.href = 'principalUsuario.jsp'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="right">
                <h6><b><button onclick="location.href = 'configuracion.jsp'"><span class="glyphicon glyphicon-cog"></span></button><%out.print("  " + user.getNombre() + " " + user.getApellido() + "  ");%></b><a href="logout.jsp" style='width:200px;'>Cerrar sesión</a></h6>
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
                    <li><a href="#Multa" data-toggle="tab">Multa  <span class="glyphicon glyphicon-exclamation-sign"></span></a></li>
                    <li><a href="#Material" data-toggle="tab">Material  <span class="glyphicon glyphicon-wrench"></span></a></li>
                    <li><a href="#Reserva" data-toggle="tab">Reserva <span class="glyphicon glyphicon-tag"></span></a></li>
                    <li class="active"><a href="#Prestamo" data-toggle="tab">Préstamo  <span class="glyphicon glyphicon-time"></span></a></li>
                    <li><a href="#Acercade" data-toggle="tab">Acerca de  <span class="glyphicon glyphicon-circle-arrow-right"></span></a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane" id="Material">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'listarMateriales.jsp?accion=1'" style='width:200px;'>Listar Materiales</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane active" id="Prestamo">
                        <table class="table table-hover" align="center">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'verPrestamo.jsp'" style='width:200px;'>Ver Préstamo Activo</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Multa">
                        <table align="center" class="table table-hover">
                            <tr align="center">
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'verMulta.jsp'" style='width:200px;'>Ver Multa</button>
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
                                        </em></p>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="Reserva">
                        <table class="table table-hover">
                            <tr align="center">
                                <td colspan="2">
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'verReserva.jsp'" style='width:200px;'>Ver Reserva Activa</button>
                                </td>
                            </tr>
                            <tr align="center">                                
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'agregarReserva.jsp'" style='width:200px;'>Agregar Reserva</button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="button" onclick="location.href = 'modificarReserva.jsp'" style='width:200px;'>Dar de Baja Reserva</button>
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
