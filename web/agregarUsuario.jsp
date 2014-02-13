<%-- 
    Document   : agregarUsuario
    Created on : 12/02/2014, 10:27:31 PM
    Author     : Samy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Usuario</title>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Menú Principal</h1>
            </div>
        </div>
        <br><br><br><br><br><br><br>
        <div class="row"> 
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                
                
                <form class="form-horizontal" action="guardarUsuario.jsp" method="POST">
                    <table align="center">
                        <tr>
                            <td>
                                    <label class="control-label">Codigo</label>
                            </td>
                            <td>
                                <input type="text" id="login" name="codigo">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="passwd">Contraseña</label>
                                    <div class="controls">
                                        <input type="password" id="passwd" placeholder="Contraseña" name="passwd">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn-large btn-info">Ingresar</button>
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
<%}%>