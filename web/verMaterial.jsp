<%-- 
    Document   : verMaterial
    Created on : 22-feb-2014, 23:39:54
    Author     : WM
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
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
        <title>Ver Material</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" src="js/calendar-en.js"></script>
        <script type="text/javascript" src="js/calendar-setup.js"></script>
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
    <body>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Ver Material</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarMaterial.jsp?accion=2" method="POST" onsubmit="return validarForm(this);">
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
                            <td>
                                <label>Codigo</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getCodigo());%>">
                            </td>
                            <td>
                                <label>Tipo de Elemento</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getTipo_mat().getNombre());%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Marca</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getMarca());%>">
                            </td>
                            <td>
                                <label>Número de Inventario</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getNum_inventario());%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Serial</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getSerial());%>">
                            </td>
                            <td>
                                <label>Estado actual del elemento</label>
                            </td>
                            <%
                                String estado = "";
                                if (mat.getEstado() == 0) {
                                    estado = "Activo";
                                } else if (mat.getEstado() == 0) {
                                    estado = "Dado de baja";
                                } else if (mat.getEstado() == 0) {
                                    estado = "Dañado";
                                } else if (mat.getEstado() == 0) {
                                    estado = "Reparado";
                                } else {
                                    estado = "Error";
                                }
                            %>
                            <td><input disabled="disabled" type="text" value="<%out.print(estado);%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Laboratorio</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getLab().getNombre());%>">
                            </td>
                            <td>
                                <label>Disponibilidad</label>
                            </td>
                            <td>
                                <%
                                    String disp = "";
                                    if (mat.getEstado() == 0) {
                                        disp = "Libre";
                                    } else if (mat.getEstado() == 0) {
                                        disp = "Prestado";
                                    } else {
                                        estado = "Error";
                                    }
                                %>
                                <input disabled="disabled" type="text" value="<%out.print(disp);%>">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <label>Última fecha de Matenimiento</label>
                            </td>
                            <td>
                                <%
                                    Calendar cal1 = mat.getUlt_fecha_mante();
                                    int year = cal1.get(Calendar.YEAR);
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    int dia = cal1.get(Calendar.DAY_OF_MONTH);
                                    int hora = cal1.get(Calendar.HOUR_OF_DAY);
                                    int min = cal1.get(Calendar.MINUTE);
                                    String fecha = year + "-" + mes + "-" + dia + " " + hora + ":" + min + ":00";
                                %>
                                <input disabled="disabled" type="text" value="<%out.print(fecha);%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Descripción</label>
                            </td>
                            <td colspan="3">
                                <textarea disabled="disabled" maxlength="150" id="descripcion" name="descripcion" style='width:500px;'><%out.print(mat.getDescripcion());%></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4" align="center">
                                <button  type="button" class="btn btn-default"><span class='glyphicon glyphicon-qrcode'></span> Tutorial descargar y redimensionar QR</button>
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