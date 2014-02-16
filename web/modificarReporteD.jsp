<%-- 
    Document   : modificarReporteD
    Created on : 16/02/2014, 03:58:57 PM
    Author     : Samy
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        String ID = request.getParameter("id");
        int cod = Integer.parseInt(ID);
        Danho dan = Gestor.getDanho(cod);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Reporte Daño</title>
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript" src="js/calendar.js"></script>
        <script type="text/javascript" src="js/calendar-en.js"></script>
        <script type="text/javascript" src="js/calendar-setup.js"></script>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <style>
          html,body{ background: #e0e0e0; }   
               </style>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12" align="center">
                <h1>Modificar Reporte Daño</h1>
            </div>
        </div>
        <br><br>
        <div class="row">
            <div class="col-xs-6 col-sm-3"></div>
            <div class="col-xs-12 col-sm-6">


                <form class="form-horizontal" action="guardarReporteD.jsp?accion=2" method="POST">
                    <table align="center"   class="table table-hover">
                        <tr>
                            <td>
                                <label class="control-label" for="codigo">Codigo</label>
                            </td>
                            <td>
                                <input hidden type="text" id="codigo" name="codigo" value="<%out.print(dan.getCodigo());%>">
                                <input disabled="disabled" type="text" value="<%out.print(dan.getCodigo());%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="descripcion">Descripción</label>
                            </td>
                            <td colspan="3">
                                <textarea  maxlength="150" id="descripcion" name="descripcion" style='width:500px;'><%out.print(dan.getDescripcion());%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Código Material</label>
                            </td>
                            <td>
                                <input maxlength="10" type="text" id="nombre" name="nombre" value="<%out.print(dan.getMat().getCodigo());%>">
                            </td>
                        </tr> 
                        <tr>
                            <td>
                                <label class="control-label" for="nombre">Código Usuario</label>
                            </td>
                            <td>
                                <input maxlength="10" type="text" id="nombre" name="nombre" value="<%out.print(dan.getUsu().getCodigo());%>">
                            </td>
                        </tr> 
                        <tr>
                            <td>
                                <label class="control-label" for="cal-field-1">Fecha Daño</label>
                            </td>
                         <td>
                                <%
                                String fecha;
                                Calendar cal1=dan.getFecha_d();
                                fecha=cal1.get(Calendar.DAY_OF_MONTH)+"/";
                                int mes=cal1.get(Calendar.MONTH);
                                mes++;
                                String m="";
                                if(mes<10){
                                    m+="0";
                                }
                                m+=mes;
                                fecha+=m+"/";
                                fecha+=cal1.get(Calendar.YEAR)+"";
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
                                int hora=cal1.get(Calendar.HOUR_OF_DAY);
                                        for (int i = 0; i < 24; i++) {
                                            if (i < 10) {
                                                out.print("<option ");
                                                if(i==hora){
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option "); 
                                                if(i==hora){
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
                                                if(i==minutos){
                                                    out.print("selected ");
                                                }
                                                out.print("value='" + i + "'>0" + i + "</option>");
                                            } else {
                                                out.print("<option ");
                                                if(i==minutos){
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
                                <label class="control-label" for="nombre">Estado</label>
                            </td>
                            <td>
                                <input maxlength="1" type="text" id="nombre" name="nombre" value="<%out.print(dan.getEstado());%>">
                            </td>
                        </tr> 

                        <tr>
                            <td colspan="2" align="center"> 
                                <div class="control-group">
                                    <div class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-success" style='width:150px;'>Guardar</button>
                                    </div>
                                    
                                </div>
                            </td>
                            <td colspan="2" align="center">
                                <br>
                            <button class="btn btn-danger" type="button" onclick="location.href = 'principal.jsp'" style='width:150px;'>Atrás</button>
                        </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-3"></div>
        </div>
    </body>
</html>
<%} else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }%>