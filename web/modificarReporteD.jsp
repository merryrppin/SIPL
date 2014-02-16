<%-- 
    Document   : modificarReporteD
    Created on : 16/02/2014, 03:58:57 PM
    Author     : Samy
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String ID = request.getParameter("id");
        int cod = Integer.parseInt(ID);
        Danho dan = Gestor.getDanho(cod);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Reporte Daño</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <style>
          html,body{ background: #e0e0e0; }   
               </style>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Agregar Laboratorio</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">


                <form class="form-horizontal" action="guardarLaboratorio.jsp?accion=2" method="POST">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input hidden type="text" id="codigo" name="codigo" value="<%out.print(lab.getCodigo());%>">
                                <input disabled="disabled" type="text" value="<%out.print(lab.getCodigo());%>">
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Nombre</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="nombre" name="nombre" value="<%out.print(lab.getNombre());%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="3">
                                <textarea  maxlength="150" id="descripcion" name="descripcion" style='width:500px;'><%out.print(lab.getDescripcion());%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="ubicacion">Ubicación</label>
                            </td>
                            <td>
                                <input maxlength="50"  type="text" id="ubicacion" name="ubicacion" value="<%out.print(lab.getUbicacion());%>">
                            </td>

                        </tr>

                        <tr>
                            <td colspan="2" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
                                    </div>
                                    
                                </div>
                            </td>
                            <td colspan="2" align="center">
                                <br>
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                        </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-3"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>