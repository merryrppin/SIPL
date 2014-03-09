<%-- 
    Document   : backup
    Created on : 28-feb-2014, 2:03:53
    Author     : WM
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error="";
    String accion="";
    int a=0;
    try{
        accion=request.getParameter("accion");
        a=Integer.parseInt(accion);
    }catch(Exception e){
        error="sin_accion";
    }
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
       error = "No_usuario";
       
    } else if (user.getTipo_usuario() == 2) {
        if(a==1){
        Calendar cal = Calendar.getInstance();
        int Y = cal.get(Calendar.YEAR);
        int M = cal.get(Calendar.MONTH);
        M++;
        int D = cal.get(Calendar.DAY_OF_MONTH);
        int h = cal.get(Calendar.HOUR_OF_DAY);
        int m = cal.get(Calendar.MINUTE);
        int s = cal.get(Calendar.SECOND);
        String nombre = "\\backup";
        nombre += Y + "-" + M + "-" + D + "_" + h + "-" + m + "-" + s;
        nombre += ".sql";
        String resultado = Gestor.GenerarBackup(nombre);
        response.sendRedirect("backup.jsp?accion=2");
        }else if(a==2){
            
        }
}else {
        error = "sin_permisos";
    }
if(error.length()>0){
    response.sendRedirect("principal.jsp?error="+error);
}
%>