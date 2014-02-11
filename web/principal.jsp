<%-- 
    Document   : principal
    Created on : 11-feb-2014, 10:00:38
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="application" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
    } else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Principal</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <br><br><br><br><br><br><br>
        <div class="row"> 
            <div class="col-xs-6 col-sm-12">
                <ul class="nav nav-tabs" id="myTab" >
                    <li class="active"><a href="#Material" data-toggle="tab">Material<span class="badge">X</span></a></li>
                    <li><a href="#Usuario" data-toggle="tab">Usuario<span class="badge">X</span></a></li>
                    <li><a href="#Prestamo" data-toggle="tab">Préstamo<span class="badge">X</span></a></li>
                    <li><a href="#Multa" data-toggle="tab">Multa<span class="badge">X</span></a></li>
                    <li><a href="#Laboratorio" data-toggle="tab">Laboratorio<span class="badge">X</span></a></li>
                    <li><a href="#Estadistica" data-toggle="tab">Estadística<span class="badge">X</span></a></li>
                    <li><a href="#Backup" data-toggle="tab">Backup<span class="badge">X</span></a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="Material">
                        <h1>Material</h1>
                    </div>
                    <div class="tab-pane active" id="Usuario">
                        <h1>Usuario</h1>
                    </div>
                    <div class="tab-pane active" id="Prestamo">
                        <h1>Prestamo</h1>
                    </div>
                    <div class="tab-pane active" id="Multa">
                        <h1>Multa</h1>
                    </div>
                    <div class="tab-pane active" id="Laboratorio">
                        <h1>Laboratorio</h1>
                    </div>
                    <div class="tab-pane active" id="Estadistica">
                        <h1>Estadistica</h1>
                    </div>
                    <div class="tab-pane active" id="Backup">
                        <h1>Backup</h1>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    }
%>