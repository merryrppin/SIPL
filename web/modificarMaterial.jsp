<%-- 
    Document   : modificarMaterial
    Created on : 13-feb-2014, 22:59:39
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String ID = request.getParameter("codigo");
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
                <h1>Modificar Material</h1>
            </div>
        </div>
        <br><br><br><br>
        <div class="row">
            <div class="col-xs-12 col-sm-1"></div>
            <div class="col-xs-12 col-sm-10">
                <form class="form-horizontal" action="modificarMaterial.jsp" method="POST">
                    <table align="center" class="table table-hover">
                        <tr>
                            <td></td>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input disabled="disabled" type="text" value="<%out.print(mat.getCodigo());%>">
                                <input hidden type="text" id="codigo" value="<%out.print(mat.getCodigo());%>">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Nombre</label>
                            </td>
                            <td>
                                <input type="text" id="nombre" name="nombre">
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
                                            out.print("<option value" + data.get(i).getId() + ">" + data.get(i).getNombre() + "</option>");
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
                                <input type="text" id="marca" name="marca">
                            </td>
                            <td>
                                <label class="control-label" for="numero">Número de Inventario</label>
                            </td>
                            <td>
                                <input type="text" id="numero" name="numero">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="serial">Serial</label>
                            </td>
                            <td>
                                <input type="text" id="serial" name="serial">
                            </td>
                            <td>
                                <label class="control-label" for="estado">Estado del elemento</label>
                            </td>
                            <td>
                                <select id="estado" name="estado">
                                    <option value="0">Activo</option>
                                    <option value="1">Dado de baja</option>
                                    <option value="2">Dañado</option>
                                    <option value="3">Reparado</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="control-label" for="cal-field-1">Última fecha de Matenimiento</label>
                            </td>
                            <td>
                                <input type="text" id="cal-field-1" name="fecha" placeholder="dd/mm/AAAA"/>
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
                                <label class="control-label" for="foto">Foto Material</label>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="2">
                                <textarea  id="descripcion" name="descripcion" style='width:500px;'></textarea>
                            </td>
                            <td>
                                <input type="file" id="foto" name="foto">
                            </td>
                        </tr>  
                        <tr>
                            <td colspan="4" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn-large btn-success">Guardar</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-12 col-sm-1"></div>
        </div>
    </body>
</html>
<%}else{
        response.sendRedirect("principal.jsp?error=sin_permisos");
}%>