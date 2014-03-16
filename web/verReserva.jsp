<%-- 
    Document   : verReserva
    Created on : 11-mar-2014, 22:25:08
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
        if (usuario.getEstado() == 3) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Reserva</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            function fijarURL(url, form) {
                if (form.codigo.value.length === 0) { //¿Tiene 0 caracteres?
                    form.codigo.focus();    // Damos el foco al control
                    alert('No has llenado el campo del código'); //Mostramos el mensaje
                    return false; //devolvemos el foco
                } else {
                    form.action = url;
                    form.submit();
                }
            }
            function validarForm(Prestamo) {
                if (Prestamo.codigo.value.length === 0 || /^\s+$/.test(Material.codigo.value)) {
                    Prestamo.codigo.focus();
                    alert('No has llenado el campo del codigo');
                    return false;
                }
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
                        <button type="button" class="btn btn-warning" onclick="location.href = 'principalUsuario.jsp'" data-dismiss="modal">Aceptar</button>
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
                <h1>Ver Reserva</h1>
                <br>
                <br>
                <br>
                <h5><b>Importante:</b> Tiene dos días de plazo para prestar los materiales con el monitor, la reserva <br>de materiales se inactivará automáticamente al 
                    finalizar dos días después de Guardar la reserva. </h5>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form name="Reserva" class="form-horizontal" action="guardarReserva.jsp?accion=2" method="POST" <%if (user.getTipo_usuario() != 0) {%> onsubmit="return validarForm(this);"<%}%>>
                    <table class="table table-hover" align="center">
                        <tr>
                            <td colspan="4">
                                <label class="control-label">
                                    Ingresar el código del estudiante para encontrar la reserva activa
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Id del estudiante: </label>
                            </td>
                            <td>
                                <input type="text" disabled="disabled" value="<%out.print(usuario.getCodigo());%>">
                                <input hidden type="text" id="codigo" name="codigo" value="<%out.print(usuario.getCodigo());%>">
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td id="nombre">
                                <%if (usuario.getTipo_usuario() == 0) {
                                        out.print(usuario.getNombre());
                                    }%>
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
                                            Reserva res = Gestor.getReservaCodUsu(usuario.getCodigo());
                                            if (res != null) {
                                                Material mat;
                                                String[] materiales = res.getMat().split(";");
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
                                <label class="control-label"> Fecha de reserva</label>
                            </td>
                            <td colspan="2">
                                <%
                                    Calendar cal1 = res.getFecha_reserva();
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
                                <button class="btn btn-danger" type="button" onclick="location.href = 'guardarReserva.jsp?accion=2'" style='width:150px;'>Dar de baja reserva</button>
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
            response.sendRedirect("principalUsuario.jsp?error=sin_reserva");
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principalUsuario.jsp?error=" + error);
    }%>