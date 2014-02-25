<%-- 
    Document   : estadisticaPrestamo
    Created on : 24-feb-2014, 21:52:21
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
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
        <title>Estadísticas Préstamo</title>
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
        </script>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Estadísticas Préstamo</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                <form name="Estadistica" class="form-horizontal" action="Graficar.jsp?accion=2" method="POST" onsubmit="return validarForm(this);">
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
                            <td>
                                <label class="control-label" for="hora2">Hora</label>
                                <select id="hora2" name="hora2">
                                    <%
                                        for (int i = 0; i < 23; i++) {
                                            if (i < 10) {
                                                out.print("<option value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option value='" + i + "'>" + i + "</option>");
                                            }
                                        }
                                        out.print("<option selected value='23'>" + 23 + "</option>");
                                    %>
                                </select>
                            </td> 
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <label class="control-label" for="r">Rango</label>
                                <select name="rango" id="r">
                                    <option value="Año">Año</option>
                                    <option value="Mes">Mes</option>
                                    <option value="Dia">Día</option>
                                    <option value="Hor">Hora</option>
                                    <option value="Min">Minuto</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center"> 
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