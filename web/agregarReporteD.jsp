<%-- 
    Document   : agregarDanho
    Created on : 12-feb-2014, 22:45:26
    Author     : WM
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
        <title>Agregar Reporte Daño</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Agregar Reporte Daño</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">
                
                
                <form class="form-horizontal" action="guardarReporteD.jsp" method="POST">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo Estudiante</label>
                            </td>
                            <td>
                                <input type="text" id="codigo" name="codigo">
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Nombre Estudiante</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" id="nombre" name="nombre">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo Material</label>
                            </td>
                            <td>
                                <input type="text" id="codigo" name="codigo">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción Daño</label>
                            </td>
                           <td colspan="3">
                                <textarea  id="descripcion" name="descripcion" style='width:500px;'></textarea>
                            </td>
                        </tr>
                       
                   
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn-large btn-success">Guardar</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-3"></div>
        </div>
    </body>
</html>
<%}%>
