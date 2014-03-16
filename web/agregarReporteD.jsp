<%-- 
    Document   : agregarDanho
    Created on : 12-feb-2014, 22:45:26
    Author     : WM
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
    Usuario usu = Gestor.getUsuario(user.getCodigo());
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (usu.getTipo_usuario() == 1 || usu.getTipo_usuario() == 2) {
        int id = Gestor.getDanhos().size();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Reporte Daño</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" src="js/calendar-en.js"></script>
        <script type="text/javascript" src="js/calendar-setup.js"></script>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            function validarForm(Reporte) {
                if (Reporte.codigo_material.value.length === 0 || /^\s+$/.test(Reporte.codigo_material.value)) {
                    Reporte.codigo_material.focus();
                    alert('No has llenado el campo del codigo del material');
                    return false;
                }
            }
            <%if (error != null && error.length() > 0) {%>
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
            <%}
            %>
        </script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
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
                <h1>Agregar Reporte Daño</h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Reporte" class="form-horizontal" action="guardarReporteD.jsp?accion=1" method="POST" onsubmit="return validarForm(this);">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo Reporte</label>
                            </td>
                            <td>
                                <input hidden type="text" id="codigo" name="codigo" value="<%out.print(id);%>">
                                <input disabled="disabled" type="text" value="<%out.print(id);%>">
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción Daño</label>
                            </td>
                            <td colspan="3">
                                <textarea  maxlength="150" id="descripcion" name="descripcion" style='width:500px;'></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="codigo_material">Código Material</label>
                            </td>
                            <td>
                                <input maxlength="10" type="text" id="codigo_material" name="codigo_material">
                            </td>
                        </tr> 

                        <tr>
                            <td>
                                <label class="control-label" for="codigo_usuario">Codigo Usuario</label>
                            </td>
                            <td>
                                <input maxlength="20" type="text" id="codigo_usuario" name="codigo_usuario">
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="cal-field-1">Fecha Daño</label>
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
                                <label class="control-label" for="estado">Estado</label>
                            </td>
                            <td>
                                <select id="estado" name="estado">
                                    <option value="0">Dañado</option>
                                    <option value="1">Reparado</option>
                                    <option value="2">Dado de baja</option>
                                </select>
                            </td>
                        </tr> 
                        <tr>
                            <td colspan="4" align="center">
                                <div class="control-group">
                                    <div class="controls">
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
                                        <br>
                                        <br>
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