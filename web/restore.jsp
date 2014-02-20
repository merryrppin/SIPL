<%-- 
    Document   : restore
    Created on : 19-feb-2014, 17:42:12
    Author     : WM
--%>

<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restore</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function fijarURL(url, form) {
                form.action = url;
                form.submit();
            }
            function mensaje() {
                alert('Recuerde que esta acción no se puede deshacer y tendrá que iniciar sesión nuevamente');
            }
        </script>
    </head>
    <body>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Restore</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 col-sm-2"></div>
            <div class="col-xs-12 col-sm-8">
                <form name="Restore" class="form-horizontal" action="aplicarRestore.jsp" method="POST" enctype="multipart/form-data">
                    <table class="table-hover" align="center">
                        <tr>
                            <td>
                                <label class="control-label" for="restore">Restore</label>
                                <input type="file" id="restore" name="restore">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br>
                                <button type="submit" class="btn btn-success" style='width:200px;' onclick="mensaje();">Restore</button>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-2"></div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp?error=sin_permisos");
    }
%>