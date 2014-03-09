<%-- 
    Document   : graficarD
    Created on : 07-mar-2014, 15:29:52
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
    <body>
        <%
            String error = "";
            Usuario user = (Usuario) session.getAttribute("user");
            String accion = request.getParameter("accion");
            String orden = request.getParameter("orden");
            int a = 0;
            if (user == null) {
                error = "No_usuario";
            } else if (user.getTipo_usuario() == 2) {
                try {
                    a = Integer.parseInt(accion);
                } catch (Exception e) {
                    a = 0;
                }
                String direccion = Gestor.getVariable(1).getDatos();
                direccion += "/Grafica/";
                if (a == 3) {
                    String titulo = "Daños entre el  ";
                    String fecha = request.getParameter("fecha");
                    String fecha2 = request.getParameter("fecha2");
                    String f[] = fecha.split("/");
                    String fe = f[2] + "/" + f[1] + "/" + f[0] + " 00:00:00";
                    String f2[] = fecha2.split("/");
                    String fe2 = f2[2] + "/" + f2[1] + "/" + f2[0] + " 00:00:00";
                    titulo += fecha + " al " + fecha2;
                    ArrayList<Danho> data = Gestor.getRangoFecha_danhos(fe, fe2);
                    String rango = request.getParameter("rango");
                    if (rango.equals("Anho")) {
                        int rest;
                        rest = Integer.parseInt(f2[2]) - Integer.parseInt(f[2]);
                        rest++;
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "DY.jpg";
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
                            int t = data.get(k).getFecha_d().get(Calendar.YEAR);
                            for (int l = 0; l < rest; l++) {
                                if (y[l][0] == t) {
                                    int cant = y[l][1];
                                    cant++;
                                    y[l][1] = cant;
                                }
                            }
                        }
                        Gestor.GraficarPrestamosYear(y, rest, direccion, "Años", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=DanhoAnho;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "DY.jpg");
                    } else if (rango.equals("Mes")) {
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
                            int t = data.get(k).getFecha_d().get(Calendar.MONTH);
                            int cant = values[t];
                            cant++;
                            values[t] = cant;
                        }
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "DM.jpg";
                        Gestor.GraficarPrestamos(values, tiempo, 12, direccion, "Mes", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=DanhoMes;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "DM.jpg");
                    } else if (rango.equals("Dia")) {
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "DD.jpg";
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
                            int t = data.get(k).getFecha_d().get(Calendar.DAY_OF_MONTH);
                            int gj = t;
                            gj--;
                            int cant = values[gj];
                            cant++;
                            values[gj] = cant;
                        }
                        Gestor.GraficarPrestamos(values, tiempo, 31, direccion, "Dia", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=DanhoDia;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "DD.jpg");
                    } else if (rango.equals("Hor")) {
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "DH.jpg";
                        int[] values = new int[24];
                        int[] tiempo = new int[24];
                        for (int i = 0; i < 24; i++) {
                            tiempo[i] = i;
                        }
                        for (int j = 0; j < 24; j++) {
                            values[j] = 0;
                        }
                        for (int k = 0; k < data.size(); k++) {
                            int t = data.get(k).getFecha_d().get(Calendar.HOUR_OF_DAY);
                            int cant = values[t];
                            cant++;
                            values[t] = cant;
                        }
                        Gestor.GraficarPrestamos(values, tiempo, 24, direccion, "Horas", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=DanhoHora;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "DH.jpg");
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
                    if (o[0].equals("DanhoAnho")) {
                        titulo = "Reporte de Daños por año";
                    } else if (o[0].equals("DanhoMes")) {
                        titulo = "Reporte de Daños por mes";
                    } else if (o[0].equals("DanhoDia")) {
                        titulo = "Reporte de Daños por día";
                    } else if (o[0].equals("DanhoHora")) {
                        titulo = "Reporte de Daños por Hora";
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
                            <img src="Grafica/<%out.print(o[7]);%>" alt="<%out.print(titulo);%>">
                        </td>
                        <td>
                            <table class="table table-striped">
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Danho> danhos = Gestor.getRangoFecha_danhos(f1, f2);
                                    ArrayList<Material> materiales = Gestor.getMateriales();
                                    if (o[0].equals("DanhoAnho")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < danhos.size(); i++) {
                                        int P = danhos.get(i).getMat().getCodigo();
                                        for (int k = 0; k < materiales.size(); k++) {
                                            int c = 0;
                                            if (T[k][0] == P) {
                                                c = T[k][1];
                                                c++;
                                                T[k][1] = c;
                                                k = materiales.size();
                                            }
                                        }
                                    }
                                    if (danhos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay daños en ese rango de fecha</td>");
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
                                    <td><b>Cantidad Daños</b></td>
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
                                    for (int k = 0; k < danhos.size(); k++) {
                                        int t = danhos.get(k).getFecha_d().get(Calendar.YEAR);
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
                                } else if (o[0].equals("DanhoMes")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < danhos.size(); i++) {
                                        int P = danhos.get(i).getMat().getCodigo();
                                        for (int k = 0; k < materiales.size(); k++) {
                                            int c = 0;
                                            if (T[k][0] == P) {
                                                c = T[k][1];
                                                c++;
                                                T[k][1] = c;
                                                k = materiales.size();
                                            }
                                        }
                                    }
                                    if (danhos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay daños en ese rango de fecha</td>");
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
                                    <td><b>Mes</b></td>
                                    <td><b>Cantidad Daños</b></td>
                                </tr>
                                <%
                                    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                                    int tamY[][] = new int[12][2];
                                    for (int i = 0; i < 12; i++) {
                                        tamY[i][0] = i;
                                    }
                                    for (int j = 0; j < 12; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < danhos.size(); k++) {
                                        int t = danhos.get(k).getFecha_d().get(Calendar.MONTH);
                                        for (int l = 0; l < 12; l++) {
                                            if (tamY[l][0] == t) {
                                                int cant = tamY[l][1];
                                                cant++;
                                                tamY[l][1] = cant;
                                            }
                                        }
                                    }
                                    for (int i = 0; i < 12; i++) {
                                        if (tamY[i][1] > 0) {
                                            out.print("<tr>");
                                            out.print("<td>" + meses[i] + "</td>");
                                            out.print("<td>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (o[0].equals("DanhoDia")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < danhos.size(); i++) {
                                        int P = danhos.get(i).getMat().getCodigo();
                                        for (int k = 0; k < materiales.size(); k++) {
                                            int c = 0;
                                            if (T[k][0] == P) {
                                                c = T[k][1];
                                                c++;
                                                T[k][1] = c;
                                                k = materiales.size();
                                            }
                                        }
                                    }
                                    if (danhos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay daños en ese rango de fecha</td>");
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
                                    <td><b>Día del mes</b></td>
                                    <td><b>Cantidad Daños</b></td>
                                </tr>
                                <%
                                    int tamY[][] = new int[32][2];
                                    for (int i = 0; i < 32; i++) {
                                        tamY[i][0] = i;
                                    }
                                    for (int j = 0; j < 32; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < danhos.size(); k++) {
                                        int t = danhos.get(k).getFecha_d().get(Calendar.DAY_OF_MONTH);
                                        for (int l = 0; l < 32; l++) {
                                            if (tamY[l][0] == t) {
                                                int cant = tamY[l][1];
                                                cant++;
                                                tamY[l][1] = cant;
                                            }
                                        }
                                    }
                                    for (int i = 0; i < 32; i++) {
                                        if (tamY[i][1] > 0) {
                                            out.print("<tr>");
                                            out.print("<td>" + i + "</td>");
                                            out.print("<td>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (o[0].equals("DanhoHora")) {%>
                                <tr>
                                    <td><b>Categoria Material</b></td>
                                    <td><b>Cantidad Material</b></td>
                                </tr>
                                <%
                                    int T[][] = new int[materiales.size()][2];
                                    for (int i = 0; i < materiales.size(); i++) {
                                        T[i][0] = materiales.get(i).getCodigo();
                                        T[i][1] = 0;
                                    }
                                    for (int i = 0; i < danhos.size(); i++) {
                                        int P = danhos.get(i).getMat().getCodigo();
                                        for (int k = 0; k < materiales.size(); k++) {
                                            int c = 0;
                                            if (T[k][0] == P) {
                                                c = T[k][1];
                                                c++;
                                                T[k][1] = c;
                                                k = materiales.size();
                                            }
                                        }
                                    }
                                    if (danhos.size() == 0) {
                                        out.print("<tr>");
                                        out.print("<td>No hay daños en ese rango de fecha</td>");
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
                                    <td><b>Hora del día</b></td>
                                    <td><b>Cantidad Daños</b></td>
                                </tr>
                                <%
                                        int tamY[][] = new int[24][2];
                                        for (int i = 0; i < 24; i++) {
                                            tamY[i][0] = i;
                                        }
                                        for (int j = 0; j < 24; j++) {
                                            tamY[j][1] = 0;
                                        }
                                        for (int k = 0; k < danhos.size(); k++) {
                                            Calendar cy = danhos.get(k).getFecha_d();
                                            int t = danhos.get(k).getFecha_d().get(Calendar.HOUR_OF_DAY);
                                            for (int l = 0; l < 24; l++) {
                                                if (tamY[l][0] == t) {
                                                    int cant = tamY[l][1];
                                                    cant++;
                                                    tamY[l][1] = cant;
                                                }
                                            }
                                        }
                                        for (int i = 0; i < 24; i++) {
                                            if (tamY[i][1] > 0) {
                                                out.print("<tr>");
                                                out.print("<td>" + i + "</td>");
                                                out.print("<td>" + tamY[i][1] + "</td>");
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
        error = "sin_permisos";
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>