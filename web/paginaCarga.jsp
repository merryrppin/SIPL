<%-- 
    Document   : paginaCarga
    Created on : 01-mar-2014, 18:26:39
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
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
            }, 300);
            function ocultar() {
                document.getElementById('btnNext').style.visibility = "hidden";
            }
        </script>
        <title>Página de Carga</title>
    </head>
    <body onload="ocultar();">
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
                    String orden = request.getParameter("orden");
                %>
                <form class="form-horizontal" action="graficar.jsp?orden=<%out.print(orden);%>" method="POST">
                    <table align="center">
                        <tr>
                            <td>
                                <h2>
                                    Debe esperar un momento mientras los datos son procesados y se genera la gráfica correctamente.
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
                            <td>
                                <button id="btnNext" type="submit" class="btn btn-info" style='width:200px;'>Ver Resultado</button>
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
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>