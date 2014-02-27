<%-- 
    Document   : agregarMaterial
    Created on : 12-feb-2014, 22:44:32
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
    } else if (user.getTipo_usuario() == 2) {
        int id = Gestor.getMateriales().size();
        id++;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Material</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" src="js/calendar-en.js"></script>
        <script type="text/javascript" src="js/calendar-setup.js"></script>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function validarForm(Material) {
                if (Material.fecha.value.length === 0) { //¿Tiene 0 caracteres?
                    Material.fecha.focus();    // Damos el foco al control
                    alert('No has llenado el campo de la fecha'); //Mostramos el mensaje
                    return false; //devolvemos el foco
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
                <h1>Agregar Material</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarMaterial.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table align="center" class="table table-hover">
                        <tr>
                            <td>
                                <input hidden type="text" name="codigo" id="codigo" value="<%out.print(id);%>">
                            </td>
                            <td>
                                <label class="control-label" for="tipo">Tipo de Elemento</label>
                            </td>
                            <td>
                                <%
                                    ArrayList<Tipo_material> data = Gestor.getTiposM();
                                %>
                                <select id="tipo" name="tipo">
                                    <%
                                        for (int i = 0; i < data.size(); i++) {
                                            out.print("<option value='" + data.get(i).getId() + "'>" + data.get(i).getNombre() + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="marca">Marca</label>
                            </td>
                            <td>
                                <input  maxlength="50" type="text" id="marca" name="marca">
                            </td>
                            <td>
                                <label class="control-label" for="numero">Número de Inventario</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="numero" name="numero">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="serial">Serial</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="serial" name="serial">
                            </td>
                            <td>
                                <label class="control-label" for="estado">Estado actual del elemento</label>
                            </td>
                            <td>
                                <select id="estado" name="estado">
                                    <option value="0">Activo</option>
                                    <option value="1">Dado de baja</option>
                                    <option value="2">Dañado</option>
                                    <option value="3">Reparado</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="laboratorio">Laboratorio</label>
                            </td>
                            <td>
                                <%
                                    ArrayList<Laboratorio> data1 = Gestor.getLaboratorios();
                                %>
                                <select id="laboratorio" name="laboratorio">
                                    <%
                                        for (int i = 0; i < data1.size(); i++) {
                                            out.print("<option value='" + data1.get(i).getCodigo() + "'>" + data1.get(i).getNombre() + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <label class="control-label" for="disponibilidad">Disponibilidad</label>
                            </td>
                            <td>
                                <select id="disponibilidad" name="disponibilidad">
                                    <option value="0">Libre</option>
                                    <option value="1">Prestado</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label" for="cal-field-1">Última fecha de Matenimiento</label>
                            </td>
                            <td>
                                <input type="text" id="cal-field-1" name="fecha" placeholder="dd/mm/AAAA"/>
                                <button type="submit" id="cal-button-1"><span class="glyphicon glyphicon-calendar"></span></button>
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField: "cal-field-1",
                                        button: "cal-button-1",
                                        align: "Tr",
                                        ifFormat: "%d/%m/%Y"
                                    });
                                </script>

                            </td>
                            <td>
                                <label class="control-label" for="hora">Hora</label>
                                <select id="hora" name="hora">
                                    <%
                                        for (int i = 0; i < 24; i++) {
                                            if (i < 10) {
                                                out.print("<option value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option value='" + i + "'>" + i + "</option>");
                                            }

                                        }
                                    %>
                                </select>
                                <label class="control-label" for="minutos">Minutos</label>
                                <select id="minutos" name="minutos">
                                    <%
                                        for (int i = 0; i < 60; i++) {
                                            if (i < 10) {
                                                out.print("<option value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option value='" + i + "'>" + i + "</option>");
                                            }

                                        }
                                    %>
                                </select>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="2">
                                <textarea maxlength="150" id="descripcion" name="descripcion" style='width:500px;'></textarea>
                            </td>
                            <td>
                                <label class="control-label" for="foto">Foto Material</label>
                                <input type="file" id="foto" name="foto">
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
            <div class="col-xs-12 col-sm-1"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>