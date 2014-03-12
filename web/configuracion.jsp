<%-- 
    Document   : configuracion
    Created on : 11-mar-2014, 14:45:53
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
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2 || user.getTipo_usuario() == 0) {
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
                <table align="center" class="table table-hover">
                    <tr>
                        <td align="center">
                            <button type="button" class="btn btn-info" onclick="location.href = 'cambiarClavePer.jsp'">Cambiar Contraseña</button>
                        </td>
                        <td></td>
                    </tr>
                    <%if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {%>
                    <tr>
                        <td align="center">
                            <button type="button" class="btn btn-info" onclick="location.href = 'eliminarTemporales.jsp?accion=1'">Eliminar Gráficas Temporales</button>
                            <%
                                String sDirectorio = Gestor.getVariable(1).getDatos();
                                sDirectorio += "//Grafica";
                                File f = new File(sDirectorio);
                                File[] ficheros = f.listFiles();
                            %>
                        </td>
                        <td>
                            <span class="label label-default"><%out.print(ficheros.length+" Archivos");%></span>
                        </td>
                    </tr>
                    <%}%>
                    <%if (user.getTipo_usuario() == 2) {%>
                    <tr>
                        <td align="center">
                            <button type="button" class="btn btn-info" onclick="location.href = 'eliminarTemporales.jsp?accion=2'">Eliminar Backups Temporales</button>
                            <%
                                String sDirectorio = Gestor.getVariable(1).getDatos();
                                sDirectorio += "//Backup";
                                File f = new File(sDirectorio);
                                File[] ficheros = f.listFiles();
                            %>
                        </td>
                        <td>
                            <span class="label label-default"><%out.print(ficheros.length+" Backup");%></span>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <button type="button" class="btn btn-info" onclick="location.href = 'variablesSistema.jsp'">Variables del Sistema</button>
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <%
                        String direccion="principal.jsp";
                        if(user.getTipo_usuario()==0){
                            direccion="principalUsuario.jsp";
                        }
                        %>
                        <td align="center">
                            <button class="btn btn-danger" type="button" onclick="location.href = '<%out.print(direccion);%>'" style='width:150px;'>Atrás</button>
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-xs-6 col-sm-3"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>
