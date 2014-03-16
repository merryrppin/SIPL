<%-- 
    Document   : graficarM
    Created on : 9/03/2014, 04:20:24 PM
    Author     : Samy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<!DOCTYPE html>
<%
    String error = "";
    Error_D er = null;
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    er = Gestor.getError(error);
%>
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
            <%if (error != null && error.length() > 0) {%>
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
            <%}
            %>
        </script>
    </head>
    <body>
        <%if (error != null && error.length() > 0) {%>
        <div id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-warning"><%out.print(er.getMensaje());%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" onclick="location.href = 'principal.jsp'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <%
            Usuario user = (Usuario) session.getAttribute("user");
            Usuario usu = Gestor.getUsuario(user.getCodigo());
            String accion = request.getParameter("accion");
            String orden = request.getParameter("orden");
            int a = 0;
            if (user == null) {
                response.sendRedirect("login.jsp?error=No_usuario");
            } else if (usu.getTipo_usuario() == 2 || usu.getTipo_usuario() == 1) {
                try {
                    a = Integer.parseInt(accion);
                } catch (Exception e) {
                    a = 0;
                }
                String direccion = Gestor.getVariable(1).getDatos();
                direccion += "/Grafica/";
                if (a == 2) {
                    String titulo = "Multas entre el  ";
                    String fecha = request.getParameter("fecha");
                    String fecha2 = request.getParameter("fecha2");
                    String f[] = fecha.split("/");
                    String fe = f[2] + "/" + f[1] + "/" + f[0] + " 00:00:00";
                    String f2[] = fecha2.split("/");
                    String fe2 = f2[2] + "/" + f2[1] + "/" + f2[0] + " 23:59:59";
                    titulo += fecha + " al " + fecha2;
                    ArrayList<Multa> datam = Gestor.getMultasFecha(fe, fe2);
                    String rango = request.getParameter("rango");
                    if (rango.equals("Anho")) {
                        int rest;
                        rest = Integer.parseInt(f2[2]) - Integer.parseInt(f[2]);
                        rest++;
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "YM.jpg";
                        int[][] y = new int[rest][2];
                        int y1 = Integer.parseInt(f[2]);
                        for (int i = 0; i < rest; i++) {
                            y[i][0] = y1;
                            y1++;
                        }
                        for (int j = 0; j < rest; j++) {
                            y[j][1] = 0;
                        }
                        for (int k = 0; k < datam.size(); k++) {
                            int t = datam.get(k).getFecha_multa().get(Calendar.YEAR);
                            for (int l = 0; l < rest; l++) {
                                if (y[l][0] == t) {
                                    int cant = y[l][1];
                                    cant++;
                                    y[l][1] = cant;
                                }
                            }
                        }
                        Gestor.GraficarMultasYear(y, rest, direccion, "Años", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=MultasAnho;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "YM.jpg");
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
                        for (int k = 0; k < datam.size(); k++) {
                            int t = datam.get(k).getFecha_multa().get(Calendar.MONTH);
                            int cant = values[t];
                            cant++;
                            values[t] = cant;
                        }
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "MM.jpg";
                        Gestor.GraficarMultas(values, tiempo, 12, direccion, "Mes", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=MultasMes;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "MM.jpg");
                    } else if (rango.equals("Dia")) {
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "DM.jpg";
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
                        for (int k = 0; k < datam.size(); k++) {
                            int t = datam.get(k).getFecha_multa().get(Calendar.DAY_OF_MONTH);
                            int gj = t;
                            gj--;
                            int cant = values[gj];
                            cant++;
                            values[gj] = cant;
                        }
                        Gestor.GraficarMultas(values, tiempo, 31, direccion, "Dia", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=MultasDia;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "DM.jpg");
                    } else if (rango.equals("Hor")) {
                        Calendar cal = Calendar.getInstance();
                        String nom = (cal.get(Calendar.YEAR) + "" + cal.get(Calendar.MONTH) + ""
                                + cal.get(Calendar.DAY_OF_MONTH) + "" + cal.get(Calendar.HOUR_OF_DAY) + "" + cal.get(Calendar.MINUTE)
                                + cal.get(Calendar.SECOND));
                        direccion += nom + "HM.jpg";
                        int[] values = new int[24];
                        int[] tiempo = new int[24];
                        for (int i = 0; i < 24; i++) {
                            tiempo[i] = i;
                        }
                        for (int j = 0; j < 24; j++) {
                            values[j] = 0;
                        }
                        for (int k = 0; k < datam.size(); k++) {
                            int t = datam.get(k).getFecha_multa().get(Calendar.HOUR_OF_DAY);
                            int cant = values[t];
                            cant++;
                            values[t] = cant;
                        }
                        Gestor.GraficarMultas(values, tiempo, 24, direccion, "Horas", titulo);
                        response.sendRedirect("paginaCarga.jsp?orden=MultasHora;" + f2[2] + ";" + f2[1] + ";" + f2[0] + ";" + f[2] + ";" + f[1] + ";" + f[0] + ";" + nom + "HM.jpg");
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
                    if (o[0].equals("MultasAnho")) {
                        titulo = "Reporte de Multas por año";
                    } else if (o[0].equals("MultasMes")) {
                        titulo = "Reporte de Multas por mes";
                    } else if (o[0].equals("MultasDia")) {
                        titulo = "Reporte de Multas por día";
                    } else if (o[0].equals("MultasHora")) {
                        titulo = "Reporte de Multas por Hora";
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
                                <%  if (o[0].equals("MultasAnho")) {%>
                                <tr>
                                    <td colspan='2'>  <b>Año</b></td>
                                    <td colspan='2'><b>Cantidad Multas</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Multa> multas = Gestor.getMultasFecha(f1, f2);
                                    ArrayList<Usuario> usuarios = Gestor.getUsuarios();
                                    int dif = Integer.parseInt(o[1]) - Integer.parseInt(o[4]);
                                    dif++;
                                    String codusuarios[] = new String[usuarios.size()];
                                    int canMult[] = new int[usuarios.size()];
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        codusuarios[i] = usuarios.get(i).getCodigo();
                                        canMult[i] = 0;
                                    }
                                    for (int i = 0; i < multas.size(); i++) {
                                        for (int j = 0; j < usuarios.size(); j++) {
                                            if (codusuarios[j].equals(multas.get(i).getUsu().getCodigo())) {
                                                canMult[j]++;
                                                j = usuarios.size();
                                            }
                                        }
                                    }
                                    int tamY[][] = new int[dif][2];
                                    int u = Integer.parseInt(o[4]);
                                    for (int i = 0; i < dif; i++) {
                                        tamY[i][0] = u;
                                        u++;
                                    }
                                    for (int j = 0; j < dif; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < multas.size(); k++) {
                                        int t = multas.get(k).getFecha_multa().get(Calendar.YEAR);
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
                                            out.print("<td colspan='2'>" + tamY[i][0] + "</td>");
                                            out.print("<td colspan='2'>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }

                                %><tr>
                                    <td><b>Usuario</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Apellidos</b></td>
                                    <td><b>Cantidad Multas</b></td>
                                </tr> <%                                    for (int i = 0; i < usuarios.size(); i++) {
                                        if (canMult[i] > 0) {
                                            Usuario usuario1 = Gestor.getUsuario(codusuarios[i]);
                                            out.print("<tr>");
                                            out.print("<td>" + codusuarios[i] + "</td>");
                                            out.print("<td>" + usuario1.getNombre() + "</td>");
                                            out.print("<td>" + usuario1.getApellido() + "</td>");
                                            out.print("<td>" + canMult[i] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (o[0].equals("MultasMes")) {%>
                                <tr>
                                    <td colspan='2'><b>Mes</b></td>
                                    <td colspan='2'><b>Cantidad Multas</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Usuario> usuarios = Gestor.getUsuarios();
                                    ArrayList<Multa> multas = Gestor.getMultasFecha(f1, f2);
                                    String[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                                    String codusuarios[] = new String[usuarios.size()];
                                    int canMult[] = new int[usuarios.size()];
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        codusuarios[i] = usuarios.get(i).getCodigo();
                                        canMult[i] = 0;
                                    }
                                    for (int i = 0; i < multas.size(); i++) {
                                        for (int j = 0; j < usuarios.size(); j++) {
                                            if (codusuarios[j].equals(multas.get(i).getUsu().getCodigo())) {
                                                canMult[j]++;
                                                j = usuarios.size();
                                            }
                                        }
                                    }
                                    int tamY[][] = new int[12][2];
                                    for (int i = 0; i < 12; i++) {
                                        tamY[i][0] = i;
                                    }
                                    for (int j = 0; j < 12; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < multas.size(); k++) {
                                        int t = multas.get(k).getFecha_multa().get(Calendar.MONTH);
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
                                            out.print("<td colspan='2'>" + meses[i] + "</td>");
                                            out.print("<td colspan='2'>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %><tr>
                                    <td><b>Usuario</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Apellidos</b></td>
                                    <td><b>Cantidad Multas</b></td>
                                </tr> <%                                    for (int i = 0; i < usuarios.size(); i++) {
                                        if (canMult[i] > 0) {
                                            Usuario usuario1 = Gestor.getUsuario(codusuarios[i]);
                                            out.print("<tr>");
                                            out.print("<td>" + codusuarios[i] + "</td>");
                                            out.print("<td>" + usuario1.getNombre() + "</td>");
                                            out.print("<td>" + usuario1.getApellido() + "</td>");
                                            out.print("<td>" + canMult[i] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                } else if (o[0].equals("MultasDia")) {%>
                                <tr>
                                    <td colspan='2'><b>Día del mes</b></td>
                                    <td colspan='2'><b>Cantidad Multas</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Usuario> usuarios = Gestor.getUsuarios();
                                    ArrayList<Multa> multas = Gestor.getMultasFecha(f1, f2);
                                    String codusuarios[] = new String[usuarios.size()];
                                    int canMult[] = new int[usuarios.size()];
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        codusuarios[i] = usuarios.get(i).getCodigo();
                                        canMult[i] = 0;
                                    }
                                    for (int i = 0; i < multas.size(); i++) {
                                        for (int j = 0; j < usuarios.size(); j++) {
                                            if (codusuarios[j].equals(multas.get(i).getUsu().getCodigo())) {
                                                canMult[j]++;
                                                j = usuarios.size();
                                            }
                                        }
                                    }
                                    int tamY[][] = new int[32][2];
                                    for (int i = 0; i < 32; i++) {
                                        tamY[i][0] = i;
                                    }
                                    for (int j = 0; j < 32; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < multas.size(); k++) {
                                        int t = multas.get(k).getFecha_multa().get(Calendar.DAY_OF_MONTH);
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
                                %><tr>
                                    <td><b>Usuario</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Apellidos</b></td>
                                    <td><b>Cantidad Multas</b></td>
                                </tr> <% for (int x = 0; x < usuarios.size(); x++) {
                                                if (canMult[x] > 0) {
                                                    Usuario usuario1 = Gestor.getUsuario(codusuarios[x]);
                                                    out.print("<tr>");
                                                    out.print("<td>" + codusuarios[x] + "</td>");
                                                    out.print("<td>" + usuario1.getNombre() + "</td>");
                                                    out.print("<td>" + usuario1.getApellido() + "</td>");
                                                    out.print("<td>" + canMult[x] + "</td>");
                                                    out.print("</tr>");
                                                }
                                            }
                                        }
                                    }
                                } else if (o[0].equals("MultasHora")) {%>
                                <tr>
                                    <td colspan='2'><b>Hora del día</b></td>
                                    <td colspan='2'><b>Cantidad Préstamos</b></td>
                                </tr>
                                <%
                                    String f1 = o[4] + "/" + o[5] + "/" + o[6] + " 00:00:00";
                                    String f2 = o[1] + "/" + o[2] + "/" + o[3] + " 23:59:59";
                                    ArrayList<Usuario> usuarios = Gestor.getUsuarios();
                                    ArrayList<Multa> multas = Gestor.getMultasFecha(f1, f2);
                                    String codusuarios[] = new String[usuarios.size()];
                                    int canMult[] = new int[usuarios.size()];
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        codusuarios[i] = usuarios.get(i).getCodigo();
                                        canMult[i] = 0;
                                    }
                                    for (int i = 0; i < multas.size(); i++) {
                                        for (int j = 0; j < usuarios.size(); j++) {
                                            if (codusuarios[j].equals(multas.get(i).getUsu().getCodigo())) {
                                                canMult[j]++;
                                                j = usuarios.size();
                                            }
                                        }
                                    }
                                    int tamY[][] = new int[24][2];
                                    for (int i = 0; i < 24; i++) {
                                        tamY[i][0] = i;
                                    }
                                    for (int j = 0; j < 24; j++) {
                                        tamY[j][1] = 0;
                                    }
                                    for (int k = 0; k < multas.size(); k++) {
                                        int t = multas.get(k).getFecha_multa().get(Calendar.HOUR_OF_DAY);
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
                                            out.print("<td colspan='2'>" + i + "</td>");
                                            out.print("<td colspan='2'>" + tamY[i][1] + "</td>");
                                            out.print("</tr>");
                                        }
                                    }
                                %><tr>
                                    <td><b>Usuario</b></td>
                                    <td><b>Nombre</b></td>
                                    <td><b>Apellidos</b></td>
                                    <td><b>Cantidad Multas</b></td>
                                </tr> <%                                    for (int i = 0; i < usuarios.size(); i++) {
                                            if (canMult[i] > 0) {
                                                Usuario usuario1 = Gestor.getUsuario(codusuarios[i]);
                                                out.print("<tr>");
                                                out.print("<td>" + codusuarios[i] + "</td>");
                                                out.print("<td>" + usuario1.getNombre() + "</td>");
                                                out.print("<td>" + usuario1.getApellido() + "</td>");
                                                out.print("<td>" + canMult[i] + "</td>");
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
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>