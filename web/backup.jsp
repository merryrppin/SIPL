<%-- 
    Document   : backup
    Created on : 28-feb-2014, 2:03:53
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
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
    String accion = "";
    int a = 0;
    try {
        accion = request.getParameter("accion");
        a = Integer.parseInt(accion);
    } catch (Exception e) {
        error = "sin_accion";
    }
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        error = "No_usuario";
    } else if (user.getTipo_usuario() == 2) {
        if (a == 1) {
            Calendar cal = Calendar.getInstance();
            int Y = cal.get(Calendar.YEAR);
            int M = cal.get(Calendar.MONTH);
            M++;
            int D = cal.get(Calendar.DAY_OF_MONTH);
            int h = cal.get(Calendar.HOUR_OF_DAY);
            int m = cal.get(Calendar.MINUTE);
            int s = cal.get(Calendar.SECOND);
            String nombre = "Backup\\";
            nombre += Y + "-" + M + "-" + D + "_" + h + "-" + m + "-" + s;
            nombre += ".sql";
            Gestor.GenerarBackup(nombre);
            response.sendRedirect("backup.jsp?accion=2");
        } else if (a == 2) {%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Listar Backups</title>
        <script>
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
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Listar Backups</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-sm-3" align="center">
            </div>
            <div class="col-xs-12 col-sm-6" align="center">
                <form action="guardarMaterial.jsp?accion=4" method="POST">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td>
                                <b>Fecha</b>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <%
                            String sDirectorio = Gestor.getVariable(1).getDatos();
                            sDirectorio += "//Backup";
                            File f = new File(sDirectorio);
                            if (f.exists()) {
                                File[] ficheros = f.listFiles();
                                for (int x = 0; x < ficheros.length; x++) {
                                    out.print("<tr>");
                                    out.print("<td>" + ficheros[x].getName());
                                    out.print("</td>");
                                    out.print("<td>");%>
                        <button onclick="location.href = 'Backup/<%out.print(ficheros[x].getName());%>'" type="button" class="btn btn-default"><span class='glyphicon glyphicon-download-alt'></span></button>
                            <%
                                        out.print("</td>");
                                        out.print("</tr>");
                                    }
                                } else {
                                    error = "no_directorio";
                                }
                            %>
                    </table>
                </form>
                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
            </div>
            <div class="col-xs-12 col-sm-3" align="center">

            </div>
        </div>
    </body>
</html>  
<%}
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>