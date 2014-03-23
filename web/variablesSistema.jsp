<%-- 
    Document   : variablesSistema
    Created on : 14-mar-2014, 20:18:35
    Author     : WM
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Error_D er = null;
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    er = Gestor.getError(error);
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Configuración</title>
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
            function getUbicacion() {
                $("#ubicacion").load("GetUbicacionServlet");
                return false;
            }
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
                        <button type="button" class="btn btn-warning" onclick="location.href = 'configuracion.jsp'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Configuración</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                <form name="Variables" class="form-horizontal" action="guardarVariables.jsp?accion=2" method="POST">
                    <table align="center" class="table table-hover">
                        <%
                            String ubicacion = Gestor.getVariable(1).getDatos();
                            String mysql = Gestor.getVariable(2).getDatos();
                            String usuario = Gestor.getVariable(3).getDatos();
                            String password = Gestor.getVariable(4).getDatos();
                        %>
                        <tr id="ubicacion">
                            <td align="center">
                                <label class="control-label" for="ubicacion">Ubicación del sistema</label>
                                <input type="text" style='width:350px;' id="ubicaciona" placeholder='"C:\sipl\SIPL\web\"' name="ubicaciona" value='<%out.print(ubicacion);%>'>
                                <button onClick="return getUbicacion();"><span class="glyphicon glyphicon-home"></span></button>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <label class="control-label" for="Mysql">Ubicación de Mysql en el disco duro</label>
                                <input type="text" style='width:350px;' id="Mysql" placeholder='"C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\mysqldump"' name="Mysql" value='<%out.print(mysql);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <label class="control-label" for="usuario">Usuario Mysql</label>
                                <input type="text" style='width:350px;' id="usuario" placeholder='"root"' name="usuario" value='<%out.print(usuario);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <label class="control-label" for="password">Clave Mysql</label>
                                <input type="password" style='width:350px;' id="password" name="password" value='<%out.print(password);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                            <button class="btn btn-info" type="button" onclick="location.href = 'guardarVariables.jsp'" style='width:150px;'>Guardar</button>
                        </td>
                        </tr>
                        <tr>
                            <td align="center">
                            <button class="btn btn-danger" type="button" onclick="location.href = 'configuracion.jsp'" style='width:150px;'>Atrás</button>
                        </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-3"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>

