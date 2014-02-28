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
            function fijarURL(url, form) {
                if (form.codigo.value.length === 0) { //¿Tiene 0 caracteres?
                    form.codigo.focus();    // Damos el foco al control
                    alert('No has llenado el campo del código'); //Mostramos el mensaje
                    return false; //devolvemos el foco
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
            function getUsuario(){
                //alert('Cambio');
                var code=$("#codigo").val(); //.. y se obtiene el valor
                //llama al servlet con el parametro seleccionado
                $("#nombre").load("UsuarioServlet", {productCode:code})
                return false;
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
                                <input type="text" id="codigo" name="codigo" onchange="return getUsuario();"
                                       <%if (cod.length() > 0 && cod != null) {
                                               out.print("value='" + cod + "'");
                                           }%>
                                       >
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td >
                                <input disabled>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <label class="control-label">Laboratorio</label>
                                <input disabled>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Código elemento</th>
                                            <th>Nombre elemento</th>
                                            <th>Cantidad</th>
                                            <th>Descripcion</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label"> Fecha de préstamo</label>
                            </td>
                            <td colspan="2">
                                <input disabled>
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
<%}%>
