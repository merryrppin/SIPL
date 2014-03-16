<%-- 
    Document   : verPrestamo
    Created on : 12-mar-2014, 0:09:17
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Error_D er = null;
    try {
        error = request.getParameter("error");
    } catch (Exception e) {
    }
    er = Gestor.getError(error);
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 0) {
        Usuario usuario = Gestor.getUsuario(user.getCodigo());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Préstamo</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
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
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <style>
                    html,body{ background: #e0e0e0; }   
                </style>
                <h1>Ver Préstamo</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Material" class="form-horizontal" action="guardarPrestamo.jsp?accion=2" method="POST" onsubmit="return validarForm(this);">
                    <table class="table table-hover" align="center">
                        <tr>
                            <td>
                                <label class="control-label">Id del estudiante: </label>
                            </td>
                            <%
                                if (usuario.getEstado() == 2) {
                                    Prestamo pre = Gestor.getPrestamoCodUsu(usuario.getCodigo());
                            %>
                            <td>
                                <input type="text" disabled="disabled" value="<%out.print(usuario.getCodigo());%>">
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td id="nombre">
                                <input type="text" disabled="disabled" value="<%out.print(usuario.getNombre());%>">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Código elemento</th>
                                            <th>Tipo elemento</th>
                                            <th>Descripcion</th>
                                        </tr>
                                    </thead>
                                    <tbody id="materiales">
                                        <%
                                            if (pre != null) {
                                                Material mat;
                                                String[] materiales = pre.getMat().split(";");
                                                for (String materiale : materiales) {
                                                    mat = Gestor.getMaterial(Integer.parseInt(materiale));
                                                    out.print("<tr>");
                                                    out.print("<td>" + mat.getCodigo() + "</td>");
                                                    out.print("<td>" + mat.getTipo_mat().getNombre() + "</td>");
                                                    out.print("<td>" + mat.getDescripcion() + "</td>");
                                                    out.print("</tr>");
                                                }
                                            }%>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label"> Fecha de préstamo</label>
                            </td>
                            <td>
                                <%
                                    Calendar cal1 = pre.getFecha_prestamo();
                                    String fecha = cal1.get(Calendar.YEAR) + "-";
                                    int mes = cal1.get(Calendar.MONTH);
                                    mes++;
                                    fecha += mes + "-";
                                    fecha += cal1.get(Calendar.DAY_OF_MONTH);
                                    fecha += " " + cal1.get(Calendar.HOUR_OF_DAY);
                                    fecha += ":" + cal1.get(Calendar.MINUTE) + ":00";
                                %>
                                <input disabled="disabled" value="<%out.print(fecha);%>">
                            </td>
                            <td>
                                <label class="control-label"> Fecha de Devolución</label>
                            </td>
                            <td>
                                <%
                                    long tiempo = cal1.getTimeInMillis();
                                    tiempo += 259200000;
                                    Calendar cal2 = Calendar.getInstance();
                                    cal2.setTimeInMillis(tiempo);
                                    String fecha2 = cal2.get(Calendar.YEAR) + "-";
                                    int mes2 = cal2.get(Calendar.MONTH);
                                    mes2++;
                                    fecha2 += mes2 + "-";
                                    fecha2 += cal2.get(Calendar.DAY_OF_MONTH);
                                    fecha2 += " " + cal2.get(Calendar.HOUR_OF_DAY);
                                    fecha2 += ":" + cal2.get(Calendar.MINUTE) + ":00";
                                %>
                                <input disabled="disabled" value="<%out.print(fecha2);%>">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <br><br>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principalUsuario.jsp'" style='width:150px;'>Atrás</button>
                                <br><br>
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
            error = "prestamo_null";
        }
    } else {
        error = "sin_permisos";
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principalUsuario.jsp?error=" + error);
    }%>
