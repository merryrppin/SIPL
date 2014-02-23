<%-- 
    Document   : listarUsuario
    Created on : 16/02/2014, 02:37:11 AM
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
        ArrayList<Usuario> data = Gestor.getUsuarios();
        String accion = request.getParameter("accion");
        int a = 0;
        if (accion != null) {
            a = Integer.parseInt(accion);
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         
        <title>Listar Usuarios</title>
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
                <h1>Listar Usuarios</h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form action="modificarUsuario.jsp" method="POST">
                <table class="table table-striped" align="center">
                    <tr>
                        <%
                            if (a == 2) {
                                out.print("<td></td>");
                            }
                        %>
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
                                    if (a == 2) {
                                        out.print("<td><input type='radio' name='id' value='" + data.get(i).getCodigo() + "' ");
                                        out.print("checked='checked'/></td>");
                                    }
                                    out.print("<td>" + data.get(i).getCodigo() + "</td>");
                                    out.print("<td>" + data.get(i).getNombre() + "</td>");
                                    out.print("<td>" + data.get(i).getApellido() + "</td>");
                                    if(data.get(i).getTelefono()>0){
                                        out.print("<td>" + data.get(i).getTelefono() + "</td>");
                                    }else{
                                        out.print("<td> </td>");
                                    }
                                    out.print("<td>" + data.get(i).getCorreo() + "</td>");
                                    if(data.get(i).getEstado()==0){
                                        out.print("<td>Activo</td>");
                                    }else if(data.get(i).getEstado()==1){
                                        out.print("<td>Inactivo</td>");
                                    }else{
                                        out.print("<td>Error</td>");
                                    }
                                    if(data.get(i).getTipo_usuario()==0){
                                        out.print("<td>Estudiante</td>");
                                    }else if(data.get(i).getTipo_usuario()==1){
                                        out.print("<td>Administrador Local</td>");
                                    }else if(data.get(i).getTipo_usuario()==2){
                                        out.print("<td>Administrador Global</td>");   
                                    }else{
                                        out.print("<td>Error</td>");
                                    }
                                    
                                   
                                    out.print("<td>" + data.get(i).getObservaciones() + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                    <tr>
                        <td colspan="9" align="center">
                            <br>
                        <br>
                            <%
                            if(a==2){%>
                                <button type="submit" class="btn btn-success" style='width:200px;'>Modificar</button>
                            <%}
                            %>
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