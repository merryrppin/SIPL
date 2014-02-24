<%-- 
    Document   : graficar
    Created on : 23-feb-2014, 22:09:50
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function validarForm(Material) {
                if (Material.fecha.value.length === 0) { //¿Tiene 0 caracteres?
                    Material.fecha.focus();    // Damos el foco al control
                    alert('No has llenado el campo de la fecha'); //Mostramos el mensaje
                    return false; //devolvemos el foco
                }
            }
        </script>
    </head>
    <%
        String error = "";
        Usuario user = (Usuario) session.getAttribute("user");
        String accion = request.getParameter("accion");
        String orden = request.getParameter("orden");
        int a = 0;
        if (user == null) {
            response.sendRedirect("login.jsp?error=No_usuario");
        } else if (user.getTipo_usuario() == 2) {
            try {
                a = Integer.parseInt(accion);
            } catch (Exception e) {
                a = 0;
            }
            String direccion = this.getServletContext().getRealPath("/Grafica/");
            String d[] = direccion.split("build");
            String a1 = d[0];
            String b1 = d[1];
            String c1 = a1.substring(a1.length() - 1, a1.length());
            String A = a1.substring(0, a1.length() - 1);
            String dir = A + b1 + c1;
            if (a == 1) {
                ArrayList<Tipo_material> data = Gestor.getTiposM();
                dir += "TipoMaterial.jpg";
                Gestor.Graficar(data, dir);
                response.sendRedirect("graficar.jsp?orden=TipoMaterial.jpg");
            } else if (a == 2) {

            } else {%>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <%
                    String titulo = "";
                    if (orden.equals("TipoMaterial.jpg")) {
                        titulo = "Reporte de Cantidad de Materiales por Categoría";
                    }
                %>
                <h1><%out.print(titulo);%></h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <table>
                    <tr>
                        <td>
                            <img src="Grafica/<%out.print(orden);%>" alt="...">
                        </td>
                        <td>
                            <table class="table table-striped">
                                <%
                                if (orden.equals("TipoMaterial.jpg")) {%>
                                <tr>
                                    <td><b>Id</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Descripcion</b></td>
                                    <td><b>Cantidad</b></td>
                                    <td><b>Disponibilidad</b></td>
                                </tr>
                                    <%
                                    ArrayList<Tipo_material> Tipos = Gestor.getTiposM();
                                    if(Tipos.size()==0){
                                    out.print("<td>No hay Tipos de Material</td>");
                                    }else{
                                        for(int i=0; i<Tipos.size();i++){
                                            out.print("<tr>");
                                            out.print("<td>"+Tipos.get(i).getId()+"</td>");
                                            out.print("<td>"+Tipos.get(i).getNombre()+"</td>");
                                            out.print("<td>"+Tipos.get(i).getDescripcion()+"</td>");
                                            out.print("<td>"+Tipos.get(i).getCantidad()+"</td>");
                                            out.print("<td>"+Tipos.get(i).getDisponibilidad()+"</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                
                                }
                                %>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-xs-12 col-sm-1"></div>
        </div>
    </body>
</html>
<%}
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>

