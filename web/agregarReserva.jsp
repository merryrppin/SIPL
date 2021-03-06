<%-- 
    Document   : agregarReserva
    Created on : 8/03/2014, 07:22:28 PM
    Author     : Samy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String vs = "";
    try {
        vs = Gestor.getVariable(1).getDatos();
    } catch (Exception e) {

    }
    if (vs != null && vs.length() > 0) {
        Gestor.desactivarMultas();
        Gestor.desactivarReservas();
    }
    String error = "";
    Error_D er = null;
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 0) {
        Usuario usu = Gestor.getUsuario(user.getCodigo());
        if (usu.getEstado() == 2) {
            error = "usuario_prestamo";
        }
        if (usu.getEstado() == 4) {
            error = "usuario_multa";
        }
        if (usu.getEstado() == 3) {
            error = "usuario_reserva";
        }
        er = Gestor.getError(error);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Reserva</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            var counter = 1;
            var limit = 5;
            function addInput(divName) {
                if (counter === limit) {
                    alert("Haz alcanzado el límite máximo de " + counter + " materiales");
                    return false;
                }
                else {
                    var newdiv = document.createElement('tr');
                    newdiv.innerHTML = "<td><input type='text' name='mat" + (counter + 1) + "' id='mat" + (counter + 1) + "' onchange='return getMaterial" + (counter + 1) + "();'></td>";
                    document.getElementById(divName).appendChild(newdiv);
                    counter++;
                    return false;
                }
            }
            function fijarURL(url, form) {
                if (form.codigo.value.length === 0) {
                    form.codigo.focus();
                    alert('No has llenado el campo del código');
                    return false;
                } else {
                    form.action = url;
                    form.submit();
                }
            }
            function validarForm(Material) {
                if (Material.codigo.value.length === 0 || /^\s+$/.test(Material.codigo.value)) {
                    Material.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                }
                if (Material.mat1.value.length === 0 || /^\s+$/.test(Material.mat1.value)) {
                    Material.mat1.focus();
                    alert('El campo del código del material es obligatorio');
                    return false;
                }
            }
            function getMulta() {
                var code = $("#codigo").val();
                $("#verificar").load("MultaUsuarioServlet", {Code: code});
                return false;
            }
            function getUsuario() {
                var code = $("#codigo").val();
                $("#nombre").load("UsuarioServlet", {Code: code});
                return false;
            }
            function getMaterial1() {
                var code = $("#mat1").val();
                $("#r1").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial2() {
                var code = $("#mat2").val();
                $("#r2").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial3() {
                var code = $("#mat3").val();
                $("#r3").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial4() {
                var code = $("#mat4").val();
                $("#r4").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial5() {
                var code = $("#mat5").val();
                $("#r5").load("MaterialServlet", {id_material: code});
                return false;
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
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Agregar Reserva</h1>
                <br>
                <br>
                <br>

                <h5><b>Importante:</b> Tiene dos días de plazo para prestar los materiales con el monitor, la reserva <br>de materiales se inactivará automáticamente al 
                    finalizar dos días después de Guardar la reserva. </h5>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Reserva" class="form-horizontal" action="guardarReserva.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <%
                                String accion = request.getParameter("accion");
                                int a = 0;
                                try {
                                    a = Integer.parseInt(accion);
                                } catch (Exception e) {
                                }
                            %>
                            <td>
                                <label class="control-label" ><%out.print(user.getCodigo());%></label>
                                <input hidden id="codigo" name="codigo" value="<%out.print(user.getCodigo());%>">
                            </td>
                            <td><b>Nombre Completo:</b></td>
                            <td>
                                <label class="control-label" ><%out.print(user.getNombre());%></label>
                            </td>
                            <td>
                                <label class="control-label" ><%out.print(user.getApellido());%></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" align="center">
                                <input class="btn btn-info" type="button" value="Verificar Multa" onclick="return getMulta();" style='width:200px;'/>

                            </td>
                        </tr>
                        <tr>
                            <td id="verificar" colspan="5" align="center">

                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <table class="table table-striped">
                                    <tr>
                                        <th><button onClick="return addInput('dynamicInput');"><span class="glyphicon glyphicon-plus-sign"></span></button><label class="control-label">Código del Elemento</label></th>
                                        <th><label class="control-label">Tipo de Elemento</label></th>
                                        <th><label class="control-label">Descripción del Elemento</label></th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="table table-striped">
                                                <tbody  id="dynamicInput">
                                                    <tr>
                                                        <td>
                                                            <input type="text" name="mat1" id="mat1" onchange="return getMaterial1();">
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td colspan="2">
                                            <table class="table table-striped" id="materialito">
                                                <tbody>
                                                    <tr id="r1"></tr>
                                                    <tr id="r2"></tr>
                                                    <tr id="r3"></tr>
                                                    <tr id="r4"></tr>
                                                    <tr id="r5"></tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" align="center">
                                <br><br>
                                <button type="submit" class="btn btn-success" style='width:150px;'>Reservar</button>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principalUsuario.jsp'" style='width:150px;'>Atrás</button>
                                <br><br>
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
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principalUsuario.jsp?error=" + error);
    }%>