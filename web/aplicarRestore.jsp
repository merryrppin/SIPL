<%-- 
    Document   : aplicarRestore
    Created on : 19-feb-2014, 18:06:48
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    String accion = request.getParameter("accion");
    int a = 0;
    try {
        a = Integer.parseInt(accion);
    } catch (Exception e) {
        error = "sin_accion";
    }
    String mov="restore.jsp";
    String x = "";
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        if (a == 1) {
            String resto = request.getParameter("id");
            String dir = Gestor.getVariable(1).getDatos();
            dir += "Backup\\";
            dir += resto;
            x = Gestor.AplicarRestore(dir);
            if(x.equals("Restore aplicado satisfacoriamente")){
                mov="logout.jsp";
            }
        }else if(a == 2){
            
        }
        if (x != null && x.length() > 0) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script type="text/javascript">
            $(document).ready(function() {
                $("#myModal").modal('show');
            });
        </script>
    </head>
    <body>
        <div id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Restore</h4>
                    </div>
                    <div class="modal-body">
                        <p><%out.print(x);%></p>
                        <p class="text-warning"><small>Presione Aceptar para continuar</small></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" onclick="location.href = '<%out.print(mov);%>'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>  
<%}
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>