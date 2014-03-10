<%-- 
    Document   : listarImagenes
    Created on : 08-mar-2014, 23:27:46
    Author     : WM
--%>


<%@page import="java.io.File"%>
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
        error = "No_usuario";
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario() == 1) {
        String id = request.getParameter("codigo");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            <%if (error != null && error.length() > 0) {%>
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
            <%}
            %>
        </script>
        <title>Listar Imágenes</title>
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
                <h1>Listar Imágenes</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-sm-3" align="center">
            </div>
            <div class="col-xs-12 col-sm-6" align="center">
                <form action="guardarMaterial.jsp?accion=4" method="POST">
                    <input name="id" hidden value="<%out.print(id);%>">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td>
                            </td>
                            <td>
                                <b>Nombre</b>
                            </td>
                            <td>
                                <b>Imagen</b>
                            </td>
                        </tr>
                        <%
                            String sDirectorio = Gestor.getVariable(1).getDatos();
                            sDirectorio += "//Imagenes";
                            File f = new File(sDirectorio);
                            if (f.exists()) {
                                File[] ficheros = f.listFiles();
                                for (int x = 0; x < ficheros.length; x++) {
                                    if (ficheros[x].getName().equals("noimage.jpg")) {

                                    } else {
                                        out.print("<tr>");
                                        out.print("<td><input type='radio' name='foto' value='" + ficheros[x].getName() + "' ");
                                        out.print("checked='checked'/></td>");
                                        out.print("<td>" + ficheros[x].getName());
                                        out.print("</td>");
                                        out.print("<td><img src='Imagenes/" + ficheros[x].getName() + "' alt='...' width='150' height='150'>");
                                        out.print("</td>");
                                        out.print("</tr>");
                                    }
                                }

                            } else {
                                error = "no_directorio";
                            }
                        %>
                        <tr>
                            <td colspan="3" align="center">
                                <button type="submit" class="btn btn-success" style='width:200px;'>Guardar</button>
                            </td>
                        </tr>
                    </table>
                </form>
                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
            </div>
            <div class="col-xs-12 col-sm-3" align="center">

            </div>
        </div>
    </body>
</html>
<%    } else {
        error = "sin_permisos";
    }

    if (error.length()
            > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }%>