<%-- 
    Document   : variablesSistema
    Created on : 28-may-2014, 0:13:19
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
                <h1>Variables del Sistema</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                <form name="Material" class="form-horizontal" action="guardarVariables.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td><%out.print(Gestor.getVariable(6).getDescripcion());%></td>
                            <td>
                                <input type="text" name="dias" id="dias" value="<%out.print(Gestor.getVariable(6).getDatos());%>">
                            </td>
                        </tr>
                        <tr>
                            <td><%out.print(Gestor.getVariable(7).getDescripcion());%></td>
                            <td>
                                <input type="text" name="matMax" id="matMax" value="<%out.print(Gestor.getVariable(7).getDatos());%>">
                            </td>
                        </tr>
                        <tr>
                            <td><%out.print(Gestor.getVariable(8).getDescripcion());%></td>
                            <td>
                                <input type="text" name="diasPre" id="diasPre" value="<%out.print(Gestor.getVariable(8).getDatos());%>">
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
