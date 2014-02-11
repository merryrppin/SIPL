<%-- 
    Document   : logout
    Created on : 11-feb-2014, 13:39:48
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
session.invalidate();
response.sendRedirect("login.jsp");
%>
