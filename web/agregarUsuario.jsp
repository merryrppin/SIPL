<%-- 
    Document   : agregarUsuario
    Created on : 12/02/2014, 10:27:31 PM
    Author     : Samy
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
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {

        
        
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Usuario</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function validarForm(Usuario) {
                if (Usuario.codigo.value.length === 0 || /^\s+$/.test(Usuario.codigo.value)) {
                    Usuario.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                } else if (Usuario.nombre.value.length === 0 || /^\s+$/.test(Usuario.nombre.value)) {
                    Usuario.nombre.focus();
                    alert('No has llenado el campo del nombre');
                    return false;
                } else if (Usuario.apellidos.value.length === 0 || /^\s+$/.test(Usuario.apellidos.value)) {
                    Usuario.apellidos.focus();
                    alert('No has llenado el campo del apellido');
                    return false;
                } else if (/^\s+$/.test(Usuario.telefono.value)) {
                    Usuario.telefono.focus();
                    alert('El valor del telefono no es válido');
                    return false;
                }
            }
            function check() {
                var phone = Usuario.telefono.value;
                if (isNaN(phone)) {
                    alert("El numero telefónico debe ser con valores numéricos");
                    return false;
                }
                else {
                    return true;
                }
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
                        <button type="button" class="btn btn-warning" onclick="location.href = 'principal.jsp'" data-dismiss="modal">Aceptar</button>
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
                <h1>Agregar Usuario</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Usuario" class="form-horizontal" action="guardarUsuario.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input maxlength="20" type="text" id="codigo" name="codigo">
                            </td>
                            <td>
                                <label class="control-label" for="tipo">Tipo de Usuario</label>
                            </td>
                            <td>
                                <%
                                    if (user.getTipo_usuario() == 1) {
                                %>
                                <select name="tipo" disabled="disabled">
                                    <option value="0">
                                        Estudiante
                                    </option>
                                </select>
                                <%
                                } else if (user.getTipo_usuario() == 2) {
                                %>
                                <select name="tipo" id="tipo">
                                    <option value="0">
                                        Estudiante
                                    </option>
                                    <option value="1">
                                        Administrador Local
                                    </option>
                                    <option value="2">
                                        Administrador Global
                                    </option>
                                </select>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Nombre</label>
                            </td>
                            <td>
                                <input maxlength="30" type="text" id="nombre" name="nombre">
                            </td>
                            <td>
                                <label class="control-label" for="telefono">Teléfono</label>
                            </td>
                            <td>
                                <input maxlength="15" type="text" id="telefono" name="telefono">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="apellidos">Apellidos</label>
                            </td>
                            <td>
                                <input maxlength="30" type="text" id="apellidos" name="apellidos">
                            </td>
                            <td>
                                <label class="control-label" for="estado">Estado</label>
                            </td>
                            <td>
                                <select id="estado" name="estado">
                                    <option value="0">
                                        Activo
                                    </option>
                                    <option value="1">
                                        Inactivo
                                    </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="correo">Correo</label>
                            </td>
                            <td colspan="3">
                                <input maxlength="50" type="text" id="correo" name="correo">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="observaciones">Observaciones</label>
                            </td>
                            <td colspan="3">
                                <textarea  maxlength="200" id="observaciones" name="observaciones" style='width:500px;'></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" onclick="return check();" style='width:150px;'>Guardar</button>
                                        <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                                    </div>
                                </div>
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