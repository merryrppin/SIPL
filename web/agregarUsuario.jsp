<%-- 
    Document   : agregarUsuario
    Created on : 12/02/2014, 10:27:31 PM
    Author     : Samy
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
        <title>Agregar Usuario</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function validarForm(Usuario) {
                if (Usuario.codigo.value.length === 0) {
                    Usuario.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                } else if (Usuario.nombre.value.length === 0) {
                    Usuario.nombre.focus();
                    alert('No has llenado el campo del nombre');
                    return false;
                } else if (Usuario.apellido.value.length === 0) {
                    Usuario.apellido.focus();
                    alert('No has llenado el campo del apellido');
                    return false;
                }
            }
            function check()
            {
                var phone = Usuario.telefono.value;
                if (isNaN(phone)) {
                    alert("El numero telefónico debe ser con valores numéricos");
                    return false;
                }
                else {
                    return true;
                }
            }
        </script>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Agregar Usuario</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Usuario" class="form-horizontal" action="guardarUsuario.jsp" method="POST" onsubmit="return validarForm(this);">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input type="text" id="codigo" name="codigo">
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
                                <input type="text" id="nombre" name="nombre">
                            </td>
                            <td>
                                <label class="control-label" for="telefono">Teléfono</label>
                            </td>
                            <td>
                                <input type="text" id="telefono" name="telefono">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="apellidos">Apellidos</label>
                            </td>
                            <td>
                                <input type="text" id="apellidos" name="apellidos">
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
                                <input type="text" id="correo" name="correo">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="observaciones">Observaciones</label>
                            </td>
                            <td colspan="3">
                                <textarea  id="observaciones" name="observaciones" style='width:500px;'></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" onclick="return check();">Guardar</button>
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