<%-- 
    Document   : asignarPrivilegios
    Created on : 19-feb-2014, 16:38:30
    Author     : WM
--%>

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
    Usuario usu = Gestor.getUsuario(user.getCodigo());
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (usu.getTipo_usuario() == 2) {
        ArrayList<Usuario> data = Gestor.getUsuarios();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Asignar Privilegios</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function fijarURL(url, form) {
                form.action = url;
                form.submit();
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
        <style>
            html,body{ background: #e0e0e0; }   
        </style>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Asignar Privilegios</h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form action="guardarUsuario.jsp" method="POST">
                    <table class="table table-striped" align="center">
                        <tr>
                            <td></td>
                            <td><b>Código</b></td>
                            <td><b>Nombre</b></td>
                            <td><b>Apellido</b></td>
                            <td><b>Teléfono</b></td>
                            <td><b>Correo</b></td>
                            <td><b>Estado</b></td>
                            <td><b>Tipo Usuario</b></td>
                            <td><b>Observaciones</b></td>
                        </tr>
                        <%
                            if (data.size() == 0) {
                                out.print("<tr><td colspan='4' align='center'>No hay Usuarios</td></tr>");
                            } else {
                                for (int i = 0; i < data.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                    out.print("checked='checked'/></td>");
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getApellido() + "</td>");
                                    if (data.get(i).getTelefono() > 0) {
                                        out.print("<td>" + data.get(i).getTelefono() + "</td>");
                                    } else {
                                        out.print("<td> </td>");
                                    }
                                    out.print("<td>" + data.get(i).getCorreo() + "</td>");
                                    if (data.get(i).getEstado() == 0) {
                                        out.print("<td>Activo</td>");
                                    } else if (data.get(i).getEstado() == 1) {
                                        out.print("<td>Inactivo</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    if (data.get(i).getTipo_usuario() == 0) {
                                        out.print("<td>Estudiante</td>");
                                    } else if (data.get(i).getTipo_usuario() == 1) {
                                        out.print("<td>Administrador Local</td>");
                                    } else if (data.get(i).getTipo_usuario() == 2) {
                                        out.print("<td>Administrador Global</td>");
                                    } else {
                                        out.print("<td>Error</td>");
                                    }
                                    out.print("<td>" + data.get(i).getObservaciones() + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                        <tr>
                            <td colspan="9" align="center">
                                <input class="btn btn-info" type="button" value="Estudiante" onclick="fijarURL('guardarUsuario.jsp?accion=3', this.form)" style='width:200px;'/>
                                <input class="btn btn-info" type="button" value="Administrador Local" onclick="fijarURL('guardarUsuario.jsp?accion=4', this.form)" style='width:200px;'/>
                                <input class="btn btn-info" type="button" value="Administrador Global" onclick="fijarURL('guardarUsuario.jsp?accion=5', this.form)" style='width:200px;'/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="9" align="center">
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
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
