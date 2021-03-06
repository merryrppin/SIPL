<%-- 
    Document   : paginaCarga2
    Created on : 16-mar-2014, 3:59:19
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
    if (user == null) {
        error = "No_usuario";
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario() == 1) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            setTimeout(function() {
                $('.progress .progress-bar').each(function() {
                    var me = $(this);
                    var perc = me.attr("data-percentage");
                    var current_perc = 0;
                    var progress = setInterval(function() {
                        if (current_perc >= perc) {
                            clearInterval(progress);
                            document.getElementById('btnNext').style.visibility = "visible";
                        } else {
                            current_perc += 1;
                            me.css('width', (current_perc) + '%');
                        }
                        me.text((current_perc) + '%');
                    }, 100);
                });
            }, 200);
            function ocultar() {
                document.getElementById('btnNext').style.visibility = "hidden";
            }
            <%if (error != null && error.length() > 0) {%>
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
            <%}
            %>
        </script>
        <title>Página de Carga</title>
    </head>
    <body onload="ocultar();">
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
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Página de Carga</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-sm-3" align="center">
            </div>
            <div class="col-xs-12 col-sm-6" align="center">
                <%
                    String orden = "";
                    try {
                        orden = request.getParameter("orden");
                    } catch (Exception e) {
                        error = "no_orden";
                    }
                    if (orden.length() <= 0) {
                        error = "no_orden";
                    } else {
                %>
                <form class="form-horizontal" action="<%out.print(orden);%>" method="POST">
                    <table align="center">
                        <tr>
                            <td>
                                <h2>
                                    Espere unos segundos... El PDF está siendo generado
                                </h2>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="progress">
                                    <div id="div_bar" class="progress-bar" style="float: left; width: 0%; " data-percentage="100"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <input id="btnNext" class="btn btn-info" type="button" value="Abrir PDF" onclick="window.open('<%out.print(orden);%>');" style='width:150px;'/>
                            </td>
                        </tr>
                        <tr>
                            <td align="center"> - - - </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-12 col-sm-3" align="center">
            </div>
        </div>
    </body>
</html>
<%
        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>