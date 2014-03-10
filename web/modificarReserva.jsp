<%-- 
    Document   : ModificarReserva
    Created on : 8/03/2014, 07:22:54 PM
    Author     : Samy
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
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2 || (user.getTipo_usuario() == 0 && user.getEstado() == 3)) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Reserva</title>
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
            function getDatos() {
                var code = $("#codigo").val();
                $("#nombre").load("UsuarioServlet", {Code: code});
                $("#materiales").load("MaterialesReservaServlet", {Code: code});
                $("#fechaReserva").load("FechaReservaServlet", {Code: code});
                return false;
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
                <h1>Modificar Reserva</h1>
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
                <form name="Reserva" class="form-horizontal" action="guardarPrestamo.jsp?accion=4" method="POST" <%if (user.getTipo_usuario() != 0) {%> onsubmit="return validarForm(this);"<%}%>>
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
                            <%
                                String cod = "";
                                String accion = request.getParameter("accion");
                                int a = 0;
                                try {
                                    a = Integer.parseInt(accion);
                                } catch (Exception e) {
                                }
                                if (a == 1) {
                                    cod = request.getParameter("codigo");
                                }
                            %>
                            <td>
                                <input type="text" id="codigo" name="codigo" 
                                       <%if (user.getTipo_usuario() != 0) {%>
                                       onchange="return getDatos();"
                                       <%if (cod.length() > 0 && cod != null) {
                                               out.print("value='" + cod + "'");
                                           }%>
                                       <%} else {
                                               out.print("value='" + user.getCodigo() + "'");
                                           }%>
                                       >
                            </td>
                            <td>
                                <label class="control-label" >Nombre</label>
                            </td>
                            <td id="nombre">
                                <%if (user.getTipo_usuario() == 0) {
                                        out.print(user.getNombre());
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
                                        <%if (user.getTipo_usuario() == 0) {
                                                Prestamo pre = Gestor.getPrestamoCodUsu(user.getCodigo());
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
                                                }
                                            }%>
                                    </tbody>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <%
                                if (user.getTipo_usuario() != 0) {
                            %>
                            <td>
                                <label class="control-label"> Fecha de reserva</label>
                            </td>
                            <td id="fechaReserva" colspan="2">

                            </td>
                            <%}%>
                            <td>
                                <%
                                    if (user.getTipo_usuario() != 0) {
                                %>
                                <button type="submit" class="btn btn-success" style='width:150px;'>Realizar Préstamo</button>
                                <%} else {%>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'darBajaReserva.jsp'" style='width:150px;'>Dar de baja reserva</button>
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <br><br>
                                <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
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
<%}%>