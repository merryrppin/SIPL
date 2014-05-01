<%-- 
    Document   : modificarPrestamo
    Created on : 27-feb-2014, 14:47:43
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
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
        <title>Modificar Préstamo</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            var counter = 1;
            var limit = 15;
            function addInput(divName) {
                if (counter === limit) {
                    alert("Haz alcanzado el límite máximo de " + counter + " materiales");
                    return false;
                }
                else {
                    var newdiv = document.createElement('tr');
                    newdiv.innerHTML = "<td><input type='text' name='mat" + (counter + 1) + "' id='mat"
                            + (counter + 1) + "' onchange='return getMaterial" + (counter + 1)
                            + "();'></td><td colspan='2'><table class='table table-hover'><tr id='r" + (counter + 1) + "'></tr></table>";
                    document.getElementById(divName).appendChild(newdiv);
                    counter++;
                    return false;
                }
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
            function getMaterial6() {
                var code = $("#mat6").val();
                $("#r6").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial7() {
                var code = $("#mat7").val();
                $("#r7").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial8() {
                var code = $("#mat8").val();
                $("#r8").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial9() {
                var code = $("#mat9").val();
                $("#r9").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial10() {
                var code = $("#mat10").val();
                $("#r10").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial11() {
                var code = $("#mat11").val();
                $("#r11").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial12() {
                var code = $("#mat12").val();
                $("#r12").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial13() {
                var code = $("#mat13").val();
                $("#r13").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial14() {
                var code = $("#mat14").val();
                $("#r14").load("MaterialServlet", {id_material: code});
                return false;
            }
            function getMaterial15() {
                var code = $("#mat15").val();
                $("#r15").load("MaterialServlet", {id_material: code});
                return false;
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
            function validarForm(Prestamo) {
                if (Prestamo.codigo.value.length === 0 || /^\s+$/.test(Material.codigo.value)) {
                    Prestamo.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                }
            }
            function getDatos() {
                var code = $("#codigo").val();
                $("#nombre").load("UsuarioServlet", {Code: code});
                $("#materiales").load("MaterialesPrestamoServlet", {Code: code});
                $("#fechaPrestamo").load("FechaPrestamoServlet", {Code: code});
                counter = 1;
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
                <h1>Modificar Préstamo</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarPrestamo.jsp?accion=2" method="POST" onsubmit="return validarForm(this);">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td colspan="4">
                                <label class="control-label">
                                    Ingresar el código del estudiante para encontrar el préstamo activo
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Id del estudiante: </label>
                            </td>
                            <%
                                String cod = "";
                                String accion = request.getParameter("accion");
                                int a = 0;
                                try {
                                    a = Integer.parseInt(accion);
                                } catch (Exception e) {
                                }
                                if (a == 1) {
                                    cod = request.getParameter("codigo");
                                }
                            %>
                            <td>
                                <input type="text" id="codigo" name="codigo" onchange="return getDatos();"
                                       <%if (cod.length() > 0 && cod != null) {
                                               out.print("value='" + cod + "'");
                                           }%>
                                       >
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td id="nombre">

                            </td>
                        </tr>
                        <tr>
                            <td  colspan="4">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th><button onClick="return addInput('materiales');" onkeypress=" if (event.keyCode == 13)
                                                        event.returnValue = false;
                                                    "><span class="glyphicon glyphicon-plus-sign"></span></button><label class="control-label">Código Elemento</label></th>
                                            <th>Tipo elemento</th>
                                            <th>Descripcion</th>
                                        </tr>
                                    </thead>
                                    <tbody id="materiales">

                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <button onclick="fijarURL('guardarPrestamo.jsp?accion=3', this.form)" class="btn btn-warning" style='width:150px;'>Actualizar Préstamo</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label"> Fecha de préstamo</label>
                            </td>
                            <td id="fechaPrestamo" colspan="2">

                            </td>
                            <td>
                                <button type="submit" class="btn btn-success" style='width:150px;'>Finalizar Préstamo</button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <br><br>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
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
<%}
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>
