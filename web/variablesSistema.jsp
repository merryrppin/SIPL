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
                <form name="Variables" class="form-horizontal" action="guardarVariables.jsp?accion=2" method="POST">
                    <table align="center" class="table table-hover">
                        <%
                            String ubicacion = Gestor.getVariable(1).getDatos();
                            String mysql = Gestor.getVariable(2).getDatos();
                            String usuario = Gestor.getVariable(3).getDatos();
                            String password = Gestor.getVariable(4).getDatos();
                        %>
                        <tr>
                            <td>
                                <label class="control-label" for="ubicacion">Ubicación del sistema</label>
                                <input type="text" id="ubicacion" placeholder='"C:\sipl\SIPL\web\"' name="ubicacion" value='<%out.print(ubicacion);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="Mysql">Ubicación de Mysql en el disco duro</label>
                                <input type="text" id="Mysql" placeholder='"C:\Program Files (x86)\MySQL\MySQL Server 5.5\bin\mysqldump"' name="Mysql" value='<%out.print(mysql);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="usuario">Usuario Mysql</label>
                                <input type="text" id="usuario" placeholder='"root"' name="usuario" value='<%out.print(usuario);%>'>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="password">Clave Mysql</label>
                                <input type="password" id="password" placeholder='"C:\sipl\SIPL\web\"' name="password" value='<%out.print(password);%>'>
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

