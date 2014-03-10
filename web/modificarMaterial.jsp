<%-- 
    Document   : modificarMaterial
    Created on : 13-feb-2014, 22:59:39
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String ID = request.getParameter("id");
        try {
            Material mat = Gestor.getMaterial(Integer.parseInt(ID));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Material</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" src="js/calendar-en.js"></script>
        <script type="text/javascript" src="js/calendar-setup.js"></script>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Modificar Material</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarMaterial.jsp?accion=2" method="POST">
                    <table align="center" class="table table-hover">
                        <tr>
                            <td colspan="2" align="center">
                                <img src="QR/<%out.print(mat.getCodigo() + ".png");%>" alt="...">
                            </td>
                            <td colspan="2" align="center">
                                <img src="Imagenes/<%out.print(mat.getFoto_mat());%>" alt="..." width="200" height="200">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input hidden type="text" name="codigo" id="codigo" value="<%out.print(mat.getCodigo());%>">
                            </td>
                            <td>
                                <label class="control-label" for="tipo">Tipo de Elemento</label>
                            </td>
                            <td>
                                <%
                                    ArrayList<Tipo_material> data = Gestor.getTiposM();
                                %>
                                <select id="tipo" name="tipo">
                                    <%
                                        for (int i = 0; i < data.size(); i++) {
                                            out.print("<option ");
                                            if (mat.getTipo_mat().getId() == data.get(i).getId()) {
                                                out.print("selected ");
                                            }
                                            out.print("value='" + data.get(i).getId() + "'>" + data.get(i).getNombre() + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="marca">Marca</label>
                            </td>
                            <td>
                                <input  maxlength="50" type="text" id="marca" name="marca" value="<%out.print(mat.getMarca());%>">
                            </td>
                            <td>
                                <label class="control-label" for="numero">Número de Inventario</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="numero" name="numero" value="<%out.print(mat.getNum_inventario());%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="serial">Serial</label>
                            </td>
                            <td>
                                <input maxlength="50" type="text" id="serial" name="serial" value="<%out.print(mat.getSerial());%>">
                            </td>
                            <td>
                                <label class="control-label" for="estado">Estado actual del elemento</label>
                            </td>
                            <td>
                                <select id="estado" name="estado">
                                    <%int est = mat.getEstado();
                                        out.print("<option ");
                                        if (est == 0) {
                                            out.print("selected ");
                                        }
                                        out.print("value='0'>Activo</option>");
                                        out.print("<option ");
                                        if (est == 1) {
                                            out.print("selected ");
                                        }
                                        out.print("value='1'>Dado de baja</option>");
                                        out.print("<option ");
                                        if (est == 2) {
                                            out.print("selected ");
                                        }
                                        out.print("value='2'>Dañado</option>");
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="laboratorio">Laboratorio</label>
                            </td>
                            <td>
                                <%
                                    ArrayList<Laboratorio> data1 = Gestor.getLaboratorios();
                                %>
                                <select id="laboratorio" name="laboratorio">
                                    <%
                                        for (int i = 0; i < data1.size(); i++) {
                                            out.print("<option ");
                                            if (mat.getLab().getCodigo() == data1.get(i).getCodigo()) {
                                                out.print("selected ");
                                            }
                                            out.print("value='" + data1.get(i).getCodigo() + "'>" + data1.get(i).getNombre() + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <label class="control-label" for="disponibilidad">Disponibilidad</label>
                            </td>
                            <td>
                                <select id="disponibilidad" name="disponibilidad">
                                    <%int disp = mat.getDisponibilidad();
                                        out.print("<option ");
                                        if (disp == 0) {
                                            out.print("selected ");
                                        }
                                        out.print("value='0'>Activo</option>");
                                        out.print("<option ");
                                        if (disp == 1) {
                                            out.print("selected ");
                                        }
                                        out.print("value='1'>Dado de baja</option>");
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label" for="cal-field-1">Última fecha de Matenimiento</label>
                            </td>
                            <td>
                                <%
                                    String fecha;
                                    Calendar cal1 = mat.getUlt_fecha_mante();
                                    fecha = cal1.get(Calendar.DAY_OF_MONTH) + "/";
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    String m = "";
                                    if (mes < 10) {
                                        m += "0";
                                    }
                                    m += mes;
                                    fecha += m + "/";
                                    fecha += cal1.get(Calendar.YEAR) + "";
                                %>
                                <input type="text" id="cal-field-1" name="fecha" placeholder="dd/mm/AAAA" value="<%out.print(fecha);%>"/>
                                <button type="submit" id="cal-button-1"><span class="glyphicon glyphicon-calendar"></span></button>
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField: "cal-field-1",
                                        button: "cal-button-1",
                                        align: "Tr",
                                        ifFormat: "%d/%m/%Y"
                                    });
                                </script>

                            </td>
                            <td>
                                <label class="control-label" for="hora">Hora</label>
                                <select id="hora" name="hora">
                                    <%
                                        int hora = cal1.get(Calendar.HOUR_OF_DAY);
                                        for (int i = 0; i < 24; i++) {
                                            if (i < 10) {
                                                out.print("<option ");
                                                if (i == hora) {
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option ");
                                                if (i == hora) {
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>" + i + "</option>");
                                            }
                                        }
                                    %>
                                </select>
                                <label class="control-label" for="minutos">Minutos</label>
                                <select id="minutos" name="minutos">
                                    <%
                                        int minutos = cal1.get(Calendar.MINUTE);
                                        for (int i = 0; i < 60; i++) {
                                            if (i < 10) {
                                                out.print("<option ");
                                                if (i == minutos) {
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option ");
                                                if (i == minutos) {
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>" + i + "</option>");
                                            }

                                        }
                                    %>
                                </select>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="2">
                                <textarea maxlength="150" id="descripcion" name="descripcion" style='width:500px;'><%out.print(mat.getDescripcion());%></textarea>
                            </td>
                        </tr>  
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
                                    </div>

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <button class="btn btn-danger" type="button" onclick="location.href = 'generarQR.jsp?codigo=<%out.print(mat.getCodigo());%>'" style='width:150px;'>Generar Código QR</button>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'listarImagenes.jsp?codigo=<%out.print(mat.getCodigo());%>'" style='width:150px;'>Cambiar Imagen</button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-12 col-sm-1"></div>
        </div>
    </body>
</html>
<%} catch (Exception e) {
            response.sendRedirect("listarMateriales.jsp?accion=2");
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>