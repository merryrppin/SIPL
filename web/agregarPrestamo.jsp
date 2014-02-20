<%-- 
    Document   : agregarPrestamo
    Created on : 12-feb-2014, 22:45:58
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Préstamo</title>
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
                    var newdiv = document.createElement('div');
                    newdiv.innerHTML = "<input type='text' name='mat" + (counter + 1) + "'>";
                    document.getElementById(divName).appendChild(newdiv);
                    counter++;
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
                <h1>Agregar Préstamo</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarPrestamo.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input type="text" id="codigo" name="codigo">
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td>
                                <input type="text" id="nombre" disabled size="50">
                            </td>
                        </tr>
                        <tr>
                            <%
                                ArrayList<Laboratorio> lab = Gestor.getLaboratorios();
                            %>
                            <td colspan="2">
                                <label class="control-label" for="laboratorio">Laboratorio</label>
                                <select id="laboratorio" name="laboratorio">
                                    <%
                                        for (int i = 0; i < lab.size(); i++) {
                                            out.print("<option value='" + lab.get(i).getCodigo() + "'>" + lab.get(i).getNombre()
                                                    + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <td colspan="2">
                                <label class="control-label" for="dias">Días para la devolución</label>
                                <select name="dias" id="dias">
                                    <option value="1"> 1 </option>
                                    <option value="1"> 2 </option>
                                    <option value="1"> 3 </option>
                                    <option value="1"> 4 </option>
                                    <option value="1"> 5 </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th><button onClick="return addInput('dynamicInput');"><span class="glyphicon glyphicon-plus-sign"></span></button><label class="control-label">Código del Elemento</label></th>
                                            <th><label class="control-label">Tipo de Elemento</label></th>
                                            <th><label class="control-label">Descripción del Elemento</label></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div id="dynamicInput">
                                                    <input type="text" name="mat1">
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <br><br>
                                <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
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
