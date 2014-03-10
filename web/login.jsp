<%-- 
    Document   : login
    Created on : 09-feb-2014, 22:49:34
    Author     : WM
--%>

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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script>
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
                        <button type="button" class="btn btn-warning" onclick="location.href = 'principal.jsp'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <div class="row">
            <br><br><br><br><br>
            <div class="col-xs-6 col-sm-6">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h2 align="center"><b>Bienvenid@ al SILAB - Sistema de Información de Laboratorios</b></h2>
                <br><br><br>
                <form class="form-horizontal" action="validar.jsp" method="POST">
                    <table align="center">
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="login">Usuario</label>
                                    <div class="controls">
                                        <input type="text" id="login" placeholder="Usuario" name="login">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="passwd">Contraseña</label>
                                    <div class="controls">
                                        <input type="password" id="passwd" placeholder="Contraseña" name="passwd">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <div align="center" class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-warning"><b>Ingresar</b></button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-6">
                <br>  
                <br> 
                <br> 
                <table align="center">
                    <tr>
                        <td>
                            <img src="img/unab12.png" width="400" height="250" alt=".." class="img-rounded">
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </body>
</html>