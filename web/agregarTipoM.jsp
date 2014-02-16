<%-- 
    Document   : agregarTipoM
    Created on : 16-feb-2014, 15:33:23
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
        int id = Gestor.getTiposM().size();
        id++;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Tipo Material</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function fijarURL(url, form) {
                form.action = url;
                form.submit();
            }
            function validarForm(Usuario) {
                if (Usuario.codigo.value.length === 0 || /^\s+$/.test(Usuario.codigo.value)) {
                    Usuario.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                } else if (Usuario.nombre.value.length === 0 || /^\s+$/.test(Usuario.nombre.value)) {
                    Usuario.nombre.focus();
                    alert('No has llenado el campo del nombre');
                    return false;
                } else if (Usuario.apellido.value.length === 0 || /^\s+$/.test(Usuario.apellido.value)) {
                    Usuario.apellido.focus();
                    alert('No has llenado el campo del apellido');
                    return false;
                } else if (/^\s+$/.test(Usuario.telefono.value)) {
                    Usuario.telefono.focus();
                    alert('El valor del telefono no es válido');
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
                <h1>Agregar Tipo Material</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                <form name="Material" class="form-horizontal" action="guardarTipoM.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input hidden type="text" id="codigo" name="codigo" value="<%out.print(id);%>">
                                <input disabled="disabled" type="text" value="<%out.print(id);%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Nombre</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="nombre" name="nombre">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="3">
                                <textarea maxlength="150" id="descripcion" name="descripcion" style='width:500px;'></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                         <tr>
                        <td colspan="5" align="center">
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
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
