<%-- 
    Document   : variable
    Created on : 08-mar-2014, 17:52:45
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String direccion = this.getServletContext().getRealPath("/Grafica/");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <img src="Grafica/20142715565DY.jpg" alt="iman">
        <h1><%out.print(direccion);%></h1>
    </body>
</html>
