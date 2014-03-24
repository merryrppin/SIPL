<%-- 
    Document   : verMulta
    Created on : 24-mar-2014, 16:14:17
    Author     : WM
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Gestor.desactivarMultas();
    Gestor.desactivarReservas();
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
        Usuario usu = Gestor.getUsuario(user.getCodigo());
        if (usu.getEstado() == 3) {
            try {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Reserva</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <table align="center" class="table table-hover">
                    <%
                        Multa mul = Gestor.getMultaUsu(usu.getCodigo());
                    %>
                    <tr>
                        <td>
                            <label class="control-label">Código Usuario</label>
                        </td>
                        <td>
                            <label class="control-label"><%out.print(usu.getCodigo());%></label>
                        </td>
                        <td>
                            <label class="control-label">Nombre Usuario</label>
                        </td>
                        <td>
                            <label class="control-label"><%out.print(usu.getNombre());%></label>
                        </td>
                        <td>
                            <label class="control-label">Apellidos Usuario</label>
                        </td>
                        <td>
                            <label class="control-label"><%out.print(usu.getApellido());%></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="control-label">Fecha Multa</label>
                        </td>
                        <td>
                            <%
                                Calendar cal = mul.getFecha_multa();
                                String fecha = cal.get(Calendar.YEAR) + "-";
                                int mes = cal.get(Calendar.MONTH);
                                mes++;
                                fecha += mes + "-";
                                fecha += cal.get(Calendar.DAY_OF_MONTH);
                                fecha += " " + cal.get(Calendar.HOUR_OF_DAY);
                                fecha += ":" + cal.get(Calendar.MINUTE) + ":00";
                                Calendar cal2 = Calendar.getInstance();
                                long tiempo= cal.getTimeInMillis();
                                tiempo+=259200000;
                                cal2.setTimeInMillis(tiempo);
                                String fecha2 = cal2.get(Calendar.YEAR) + "-";
                                int mes2 = cal2.get(Calendar.MONTH);
                                mes2++;
                                fecha2 += mes2 + "-";
                                fecha2 += cal2.get(Calendar.DAY_OF_MONTH);
                                fecha2 += " " + cal2.get(Calendar.HOUR_OF_DAY);
                                fecha2 += ":" + cal2.get(Calendar.MINUTE) + ":00";
                            %>
                            <label class="control-label"><%out.print(fecha);%></label>
                        </td>
                        <td>
                            <label class="control-label">Fecha Finalización Multa</label>
                        </td>
                        <td>
                            <label class="control-label"><%out.print(fecha2);%></label>
                        </td>
                        <td colspan="2">
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principalUsuario.jsp'" style='width:150px;'>Atrás</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-xs-12 col-sm-1"></div>
        </div>
    </body>
</html>
<%} catch (Exception e) {
                response.sendRedirect("principalUsuario.jsp?error=error");
            }
        } else {
            response.sendRedirect("principalUsuario.jsp?error=sin_reserva");
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>
