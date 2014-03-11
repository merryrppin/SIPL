<%-- 
    Document   : cambiarClavePer
    Created on : 11-mar-2014, 15:32:36
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2 || user.getTipo_usuario() == 0) {
        Usuario usu = Gestor.getUsuario(user.getCodigo());
        if (usu != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambiar clave</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function validarForm(Usuario) {
                if (Usuario.clave1.value.length === 0 || /^\s+$/.test(Usuario.clave1.value)) {
                    Usuario.clave1.focus();
                    alert('No has llenado el campo de la contraseña');
                    return false;
                } else if (Usuario.clave2.value.length === 0 || /^\s+$/.test(Usuario.clave2.value)) {
                    Usuario.clave2.focus();
                    alert('No has llenado el campo de la contraseña');
                    return false;
                } else if (Usuario.clave2.value !== Usuario.clave1.value) {
                    alert('Las contraseñas no coinciden');
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Cambiar clave</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Usuario" class="form-horizontal" action="guardarUsuario.jsp?accion=7" method="POST" onsubmit="return validarForm(this);">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <input type="text" id="codigo" name="codigo" hidden value="<%out.print(usu.getCodigo());%>">
                                <label class="control-label">Nombre</label>
                            </td>
                            <td>
                                <input maxlength="30" type="text" hidden id="nombre" name="nombre" value="<%out.print(usu.getNombre());%>">
                                <%out.print(usu.getNombre());%>
                            </td>
                            <td>
                                <label class="control-label">Teléfono</label>
                            </td>
                            <td>
                                <input maxlength="15" type="text" hidden id="telefono" name="telefono" value="<%out.print(usu.getTelefono());%>">
                                <%out.print(usu.getTelefono());%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Apellidos</label>
                            </td>
                            <td>
                                <input maxlength="30" type="text" hidden id="apellidos" name="apellidos" value="<%out.print(usu.getApellido());%>">
                                <%out.print(usu.getApellido());%>
                            </td>
                            <%
                                if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
                                    int est = usu.getEstado();
                            %>
                            <td>
                                <label class="control-label">Estado</label>
                            </td>
                            <td>
                                <%if (est == 0) {
                                        out.print("Activo");
                                    } else if (est == 1) {
                                        out.print("Inactivo");
                                    }%>
                            </td>
                            <%
                                } else {
                                    out.print("<input hidden type='text' id='estado' name='estado' value='" + usu.getCorreo() + "'>");
                                }
                            %>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Correo</label>
                            </td>
                            <td colspan="3">
                                <input maxlength="50" type="text" hidden id="correo" name="correo" value="<%out.print(usu.getCorreo());%>">
                                <%out.print(usu.getCorreo());%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label">Observaciones</label>
                            </td>
                            <td colspan="3">
                                <input maxlength="50" type="text" hidden id="observaciones" name="observaciones" value="<%out.print(usu.getObservaciones());%>">
                                <textarea disabled="disabled" maxlength="200" style='width:500px;'><%out.print(usu.getObservaciones());%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <label class="control-label" for="clave1">Contraseña</label>
                            </td>
                            <td>
                                <input maxlength="100" type="password" id="clave1" name="clave1">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <label class="control-label" for="clave2">Repetir Contraseña</label>
                            </td>
                            <td>
                                <input maxlength="100" type="password" id="clave2" name="clave2">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center"> 
                                <button type="submit" class="btn btn-success" style='width:150px;' onclick="return check();">Guardar</button>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'modificarUsuario.jsp?id=<%out.print(usu.getCodigo());%>'" style='width:150px;'>Atrás</button>
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
            error = "no_existe";
        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>
