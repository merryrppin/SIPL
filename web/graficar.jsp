<%-- 
    Document   : graficar
    Created on : 23-feb-2014, 22:09:50
    Author     : WM
--%>

<%@page import="java.io.File"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.Invocable"%>
<%@page import="javax.script.ScriptEngineManager"%>
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
            setTimeout(function() {
                $('.progress .progress-bar').each(function() {
                    var me = $(this);
                    var perc = me.attr("data-percentage");
                    var current_perc = 0;
                    var progress = setInterval(function() {
                        if (current_perc >= perc) {
                            clearInterval(progress);
                        } else {
                            current_perc += 1;
                            me.css('width', (current_perc) + '%');
                        }
                        me.text((current_perc) + '%');
                    }, 100);
                });
            }, 300);
        </script>
    </head>
    <body>
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
                    response.sendRedirect("paginaCarga.jsp?orden=TipoMaterial.jpg");
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
                        for (int j = 0; j < rest; j++) {
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
                        response.sendRedirect("paginaCarga.jsp?orden=PrestamoAnho.jpg;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0]);
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
                        Gestor.GraficarPrestamos(values, tiempo, 31, dir, "Dia", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=PrestamosMes.jpg;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0]);
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
                        response.sendRedirect("paginaCarga.jsp?orden=PrestamosDia.jpg;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0]);
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
                        response.sendRedirect("paginaCarga.jsp?orden=PrestamosHora.jpg;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0]);
                    } else if (rango.equals("Min")) {

                    }
                } else {%>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <%
                    String titulo = "";
                    String[] o = orden.split(";");
                    if (o[0].equals("TipoMaterial.jpg")) {
                        titulo = "Reporte de Cantidad de Materiales por Categoría";
                    } else if (o[0].equals("PrestamoAnho.jpg")) {
                        titulo = "Reporte de Préstamos por año";
                    } else if (o[0].equals("PrestamosMes.jpg")) {
                        titulo = "Reporte de Préstamos por mes";
                    } else if (o[0].equals("PrestamosDia.jpg")) {
                        titulo = "Reporte de Préstamos por día";
                    } else if (o[0].equals("PrestamosHora.jpg")) {
                        titulo = "Reporte de Préstamos por Hora";
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
                            <img src="Grafica/<%out.print(o[0]);%>" alt="<%out.print(titulo);%>">
                        </td>
                        <td>
                            <table class="table table-striped">
                                <%
                                    if (o[0].equals("TipoMaterial.jpg")) {%>
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
                                        out.print("<tr>");
                                        out.print("<td>No hay Tipos de Material</td>");
                                        out.print("</tr>");
                                    } else {
                                        int cont = 0;
                                        for (int i = 0; i < Tipos.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>" + Tipos.get(i).getId() + "</td>");
                                            out.print("<td>" + Tipos.get(i).getNombre() + "</td>");
                                            out.print("<td>" + Tipos.get(i).getDescripcion() + "</td>");
                                            out.print("<td>" + Tipos.get(i).getCantidad() + "</td>");
                                            out.print("<td>" + Tipos.get(i).getDisponibilidad() + "</td>");
                                            out.print("</tr>");
                                            cont += Tipos.get(i).getCantidad();
                                        }
                                        out.print("<tr><td><td><td><b>Total Materiales</b><td><b>" + cont + "</b></td></td></td></td></tr>");
                                    }

                                } else if (o[0].equals("PrestamoAnho.jpg")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Prestamo> prestamos = Gestor.getPrestamosFecha(f1, f2);
                                    ArrayList<Material> materiales = Gestor.getMateriales();
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < prestamos.size(); i++) {
                                        String[] P = prestamos.get(i).getMat().split(";");
                                        for (int j = 0; j < P.length; j++) {
                                            for (int k = 0; k < materiales.size(); k++) {
                                                int c = 0;
                                                if (T[k][0] == Integer.parseInt(P[j])) {
                                                    c = T[k][1];
                                                    c++;
                                                    T[k][1] = c;
                                                    k = materiales.size();
                                                }
                                            }
                                        }
                                    }
                                    if (prestamos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay préstamos en ese rango de fecha</td>");
                                        out.print("</tr>");
                                    } else {
                                        ArrayList<Tipo_material> tm = Gestor.getTiposM();
                                        int TM[][] = new int[tm.size()][2];
                                        for (int i = 0; i < tm.size(); i++) {
                                            TM[i][0] = tm.get(i).getId();
                                            TM[i][1] = 0;
                                        }
                                        for (int i = 0; i < T.length; i++) {
                                            int c = 0;
                                            Material mat = Gestor.getMaterial(T[i][0]);
                                            for (int j = 0; j < TM.length; j++) {
                                                if (TM[j][0] == mat.getTipo_mat().getId()) {
                                                    c = TM[j][1];
                                                    c += T[i][1];
                                                    TM[j][1] = c;
                                                    j = tm.size();
                                                }
                                            }
                                        }
                                        for (int i = 0; i < TM.length; i++) {
                                            if (TM[i][1] > 0) {
                                                Tipo_material tip = Gestor.getTipoM(TM[i][0]);
                                                out.print("<tr>");
                                                out.print("<td>" + tip.getNombre() + "</td>");
                                                out.print("<td>" + TM[i][1] + "</td>");
                                                out.print("</tr>");
                                            }
                                        }
                                    }%>
                                <tr>
                                    <td><b>Año</b></td>
                                    <td><b>Cantidad Préstamos</b></td>
                                </tr>
                                <%
                                    int dif = Integer.parseInt(o[1]) - Integer.parseInt(o[4]);
                                    dif++;
                                    int tamY[][] = new int[dif][2];
                                    int u = Integer.parseInt(o[4]);
                                    for (int i = 0; i < dif; i++) {
                                        tamY[i][0] = u;
                                        u++;
                                    }
                                    for (int j = 0; j < dif; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < prestamos.size(); k++) {
                                        int t = prestamos.get(k).getFecha_prestamo().get(Calendar.YEAR);
                                        for (int l = 0; l < dif; l++) {
                                            if (tamY[l][0] == t) {
                                                int cant = tamY[l][1];
                                                cant++;
                                                tamY[l][1] = cant;
                                            }
                                        }
                                    }
                                    for (int i = 0; i < dif; i++) {
                                        if (tamY[i][1] > 0) {
                                            out.print("<tr>");
                                            out.print("<td>" + tamY[i][0] + "</td>");
                                            out.print("<td>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (orden.equals("PrestamosMes.jpg")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Prestamo> prestamos = Gestor.getPrestamosFecha(f1, f2);
                                    ArrayList<Material> materiales = Gestor.getMateriales();
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < prestamos.size(); i++) {
                                        String[] P = prestamos.get(i).getMat().split(";");
                                        for (int j = 0; j < P.length; j++) {
                                            for (int k = 0; k < materiales.size(); k++) {
                                                int c = 0;
                                                if (T[k][0] == Integer.parseInt(P[j])) {
                                                    c = T[k][1];
                                                    c++;
                                                    T[k][1] = c;
                                                    k = materiales.size();
                                                }
                                            }
                                        }
                                    }
                                    if (prestamos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay préstamos en ese rango de fecha</td>");
                                        out.print("</tr>");
                                    } else {
                                        ArrayList<Tipo_material> tm = Gestor.getTiposM();
                                        int TM[][] = new int[tm.size()][2];
                                        for (int i = 0; i < tm.size(); i++) {
                                            TM[i][0] = tm.get(i).getId();
                                            TM[i][1] = 0;
                                        }
                                        for (int i = 0; i < T.length; i++) {
                                            int c = 0;
                                            Material mat = Gestor.getMaterial(T[i][0]);
                                            for (int j = 0; j < TM.length; j++) {
                                                if (TM[j][0] == mat.getTipo_mat().getId()) {
                                                    c = TM[j][1];
                                                    c += T[i][1];
                                                    TM[j][1] = c;
                                                    j = tm.size();
                                                }
                                            }
                                        }
                                        for (int i = 0; i < TM.length; i++) {
                                            if (TM[i][1] > 0) {
                                                Tipo_material tip = Gestor.getTipoM(TM[i][0]);
                                                out.print("<tr>");
                                                out.print("<td>" + tip.getNombre() + "</td>");
                                                out.print("<td>" + TM[i][1] + "</td>");
                                                out.print("</tr>");
                                            }
                                        }
                                    }%>
                                <tr>
                                    <td><b>Año</b></td>
                                    <td><b>Cantidad Préstamos</b></td>
                                </tr>
                                <%
                                    int dif = Integer.parseInt(o[1]) - Integer.parseInt(o[4]);
                                    dif++;
                                    int tamY[][] = new int[dif][2];
                                    int u = Integer.parseInt(o[4]);
                                    for (int i = 0; i < dif; i++) {
                                        tamY[i][0] = u;
                                        u++;
                                    }
                                    for (int j = 0; j < dif; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < prestamos.size(); k++) {
                                        int t = prestamos.get(k).getFecha_prestamo().get(Calendar.YEAR);
                                        for (int l = 0; l < dif; l++) {
                                            if (tamY[l][0] == t) {
                                                int cant = tamY[l][1];
                                                cant++;
                                                tamY[l][1] = cant;
                                            }
                                        }
                                    }
                                    for (int i = 0; i < dif; i++) {
                                        if (tamY[i][1] > 0) {
                                            out.print("<tr>");
                                            out.print("<td>" + tamY[i][0] + "</td>");
                                            out.print("<td>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (orden.equals("PrestamosDia.jpg")) {%>
                                <tr>
                                    <td><b>Fecha Préstamo</b></td>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    ArrayList<Tipo_material> Tipos = Gestor.getTiposM();
                                    if (Tipos.size() == 0) {
                                        out.print("<td>No hay préstamos en ese rango de fecha</td>");
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
                                } else if (orden.equals("PrestamosHora.jpg")) {%>
                                <tr>
                                    <td><b>Fecha Préstamo</b></td>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                        ArrayList<Tipo_material> Tipos = Gestor.getTiposM();
                                        if (Tipos.size() == 0) {
                                            out.print("<td>No hay préstamos en ese rango de fecha</td>");
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

