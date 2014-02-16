<%-- 
    Document   : guardarMaterial
    Created on : 14-feb-2014, 0:32:24
    Author     : WM
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.Exception"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    String error = "";
    Usuario user = (Usuario) session.getAttribute("user");
    String accion = request.getParameter("accion");
    int a = 0;
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 2) {
        try {
            a = Integer.parseInt(accion);
            if (a == 1) {
                String codigo = request.getParameter("codigo");
                String tipo = request.getParameter("tipo");
                String marca = request.getParameter("marca");
                String numero = request.getParameter("numero");
                String serial = request.getParameter("serial");
                String estado = request.getParameter("estado");
                String fecha = request.getParameter("fecha");
                String foto = request.getParameter("foto");
                String descripcion = request.getParameter("descripcion");
                String laboratorio = request.getParameter("laboratorio");
                String disponibilidad = request.getParameter("disponibilidad");
                String hora = request.getParameter("hora");
                String minutos = request.getParameter("minutos");
                String direccion = "C:/Users/WM/Desktop/QR/" + codigo;
                try{
                    Gestor.generarQR(codigo, direccion);
                }catch(Exception e){
                    error="QR_error";
                }
                if(foto.length()==0 || foto == null){
                    foto="ninguna";
                }
                if(descripcion.length()==0 || descripcion == null){
                    descripcion="ninguna";
                }
                if(numero.length()==0 || numero == null){
                    numero=" ";
                }
                if(marca.length()==0 || marca == null){
                    marca="ninguna";
                }
                if(serial.length()==0 || serial == null){
                    serial="ninguna";
                }
                fecha += hora+":"+minutos+":00";
                DateFormat formatter;
                formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                Calendar myGDate = new GregorianCalendar();
                try {
                    Date myDate = formatter.parse(
                            fecha);
                    myGDate.setTime(myDate);
                } catch (Exception e) {
                    error= "error_fecha";
                }
                Material mat = new Material(Integer.parseInt(codigo), descripcion, Gestor.getTipoM(Integer.parseInt(tipo)),
                        marca, serial, foto, numero, Integer.parseInt(estado), myGDate, Integer.parseInt(disponibilidad),
                        Gestor.getLaboratorio(Integer.parseInt(laboratorio)), direccion);
                if (Gestor.addMaterial(mat) == true) {
                    response.sendRedirect("listarMateriales.jsp?accion=1");
                } else {
                    error="no_agrego";
                }
            } else if (a == 2) {

            }
        } catch (Exception e) {
            error = "sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("principal.jsp?" + error);
    }
%>
