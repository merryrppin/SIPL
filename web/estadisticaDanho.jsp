<%-- 
    Document   : estadisticaDanho
    Created on : 07-mar-2014, 15:26:20
    Author     : WM
--%>

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
        String error = "";
        Error_D er = null;
        try {
            error = request.getParameter("error");
        } catch (Exception e) {
        }
        er = Gestor.getError(error);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Estadísticas Daño</title>
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
                    alert('No has llenado el campo de la fecha inicial'); //Mostramos el mensaje
                    return false; //devolvemos el foco
                }
                if (Material.fecha2.value.length === 0) { //¿Tiene 0 caracteres?
                    Material.fecha2.focus();    // Damos el foco al control
                    alert('No has llenado el campo de la fecha final'); //Mostramos el mensaje
                    return false; //devolvemos el foco
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
                <h1>Estadísticas Daño</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                <form name="Estadistica" class="form-horizontal" action="graficarD.jsp?accion=3" method="POST" onsubmit="return validarForm(this);">
                    <table align="center" class="table table-hover">
                        <tr>
                            <td colspan="2">
                                <label class="control-label" for="cal-field-1">Fecha inicio reporte</label>
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
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label" for="cal-field-2">Fecha final reporte</label>
                            </td>
                            <td>
                                <input type="text" id="cal-field-2" name="fecha2" placeholder="dd/mm/AAAA"/>
                                <button type="submit" id="cal-button-2"><span class="glyphicon glyphicon-calendar"></span></button>
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField: "cal-field-2",
                                        button: "cal-button-2",
                                        align: "Tr",
                                        ifFormat: "%d/%m/%Y"
                                    });
                                </script>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <label class="control-label" for="rango">Rango</label>
                                <select name="rango" id="rango">
                                    <option value="Anho">Año</option>
                                    <option value="Mes">Mes</option>
                                    <option value="Dia">Día</option>
                                    <option value="Hor">Hora</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Ver Reporte</button>
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
            <div class="col-xs-12 col-sm-3"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>
