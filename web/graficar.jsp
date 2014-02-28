<%-- 
    Document   : graficar
    Created on : 23-feb-2014, 22:09:50
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
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
            function fijarURL(url, form) {
                form.action = url;
                form.submit();
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
                Gestor.GraficarTipoMat(data, dir);
                response.sendRedirect("graficar.jsp?orden=TipoMaterial.jpg");
            } else if (a == 2) {
                String titulo = "Préstamos entre el  ";
                String fecha = request.getParameter("fecha");
                String fecha2 = request.getParameter("fecha2");
                String f[] = fecha.split("/");
                String fe = f[2] + "/" + f[1] + "/" + f[0] + " 00:00:00";
                String f2[] = fecha2.split("/");
                String fe2 = f2[2] + "/" + f2[1] + "/" + f2[0] + " 00:00:00";
                titulo += fecha + " al " + fecha2;
                ArrayList<Prestamo> data = Gestor.getPrestamosFecha(fe, fe2);
                String rango = request.getParameter("rango");
                if (rango.equals("Anho")) {
                    // pendiente revisar que aún no funciona bien
                    int rest;
                    rest = Integer.parseInt(f2[2]) - Integer.parseInt(f[2]);
                    rest++;
                    dir += "PrestamoAnho.jpg";
                    int[][] y = new int[rest][2];
                    int y1 = Integer.parseInt(f[2]);
                    for (int i = 0; i < rest; i++) {
                        y[i][0] = y1;
                        y1++;
                    }
                    for (int j = 0; j < Integer.parseInt(f[1]) + 4; j++) {
                        y[j][1] = 0;
                    }
                    for (int k = 0; k < data.size(); k++) {
                        int t = data.get(k).getFecha_prestamo().get(Calendar.YEAR);
                        for (int l = 0; l < rest; l++) {
                            if (y[l][0] == t) {
                                int cant = y[l][1];
                                cant++;
                                y[l][1] = cant;
                            }
                        }
                    }
                    Gestor.GraficarPrestamosYear(y, rest, dir, "Años", titulo);
                    response.sendRedirect("graficar.jsp?orden=PrestamoAnho.jpg");

                } else if (rango.equals("Mes")) {

                    dir += "PrestamosMes.jpg";
                    int[] values = new int[12];
                    int[] tiempo = new int[12];
                    for (int i = 0; i < 12; i++) {
                        int gj = i;
                        gj++;
                        tiempo[i] = gj;
                    }
                    for (int j = 0; j < 12; j++) {
                        values[j] = 0;
                    }
                    for (int k = 0; k < data.size(); k++) {
                        int t = data.get(k).getFecha_prestamo().get(Calendar.MONTH);
                        int cant = values[t];
                        cant++;
                        values[t] = cant;
                    }
                    Gestor.GraficarPrestamos(values, tiempo, 12, dir, "Meses", titulo);
                    response.sendRedirect("graficar.jsp?orden=PrestamosMes.jpg");

                } else if (rango.equals("Dia")) {
                    dir += "PrestamosDia.jpg";
                    int[] values = new int[31];
                    int[] tiempo = new int[31];
                    for (int i = 0; i < 31; i++) {
                        int gj = i;
                        gj++;
                        tiempo[i] = gj;
                    }
                    for (int j = 0; j < 31; j++) {
                        values[j] = 0;
                    }
                    for (int k = 0; k < data.size(); k++) {
                        int t = data.get(k).getFecha_prestamo().get(Calendar.DAY_OF_MONTH);
                        int gj = t;
                        gj--;
                        int cant = values[gj];
                        cant++;
                        values[gj] = cant;
                    }
                    Gestor.GraficarPrestamos(values, tiempo, 31, dir, "Dia", titulo);
                    response.sendRedirect("graficar.jsp?orden=PrestamosDia.jpg");
                } else if (rango.equals("Hor")) {
                    dir += "PrestamosHora.jpg";
                    int[] values = new int[24];
                    int[] tiempo = new int[24];
                    for (int i = 0; i < 24; i++) {
                        tiempo[i] = i;
                    }
                    for (int j = 0; j < 24; j++) {
                        values[j] = 0;
                    }
                    for (int k = 0; k < data.size(); k++) {
                        int t = data.get(k).getFecha_prestamo().get(Calendar.HOUR_OF_DAY);
                        int cant = values[t];
                        cant++;
                        values[t] = cant;
                    }
                    Gestor.GraficarPrestamos(values, tiempo, 24, dir, "Horas", titulo);
                    response.sendRedirect("graficar.jsp?orden=PrestamosHora.jpg");
                } else if (rango.equals("Min")) {

                }
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
                    else if(orden.equals("PrestamoAnho.jpg")){
                        titulo = "Reporte de Préstamos por año";
                    }else if (orden.equals("PrestamosMes.jpg")){
                        titulo = "Reporte de Préstamos por mes";
                    }else if (orden.equals("PrestamosDia.jpg")){
                        titulo = "Reporte de Préstamos por día";
                    }else if (orden.equals("PrestamosHora.jpg")){
                        
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
                                    <td><b>Cat.</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Descripción</b></td>
                                    <td><b>Cantidad</b></td>
                                    <td><b>Disponibilidad</b></td>
                                </tr>
                                <%
                                        ArrayList<Tipo_material> Tipos = Gestor.getTiposM();
                                        if (Tipos.size() == 0) {
                                            out.print("<td>No hay Tipos de Material</td>");
                                        } else {
                                            for (int i = 0; i < Tipos.size(); i++) {
                                                out.print("<tr>");
                                                out.print("<td>" + Tipos.get(i).getId() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getNombre() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getDescripcion() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getCantidad() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getDisponibilidad() + "</td>");
                                                out.print("</tr>");
                                            }
                                        }

                                    }else if(orden.equals("PrestamoAnho.jpg")){%>
                                <tr>
                                    <td><b>Fecha </b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Descripción</b></td>
                                    <td><b>Cantidad</b></td>
                                    <td><b>Disponibilidad</b></td>
                                </tr>
                                <%
                                        ArrayList<Tipo_material> Tipos = Gestor.getTiposM();
                                        if (Tipos.size() == 0) {
                                            out.print("<td>No hay Tipos de Material</td>");
                                        } else {
                                            for (int i = 0; i < Tipos.size(); i++) {
                                                out.print("<tr>");
                                                out.print("<td>" + Tipos.get(i).getId() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getNombre() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getDescripcion() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getCantidad() + "</td>");
                                                out.print("<td>" + Tipos.get(i).getDisponibilidad() + "</td>");
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

