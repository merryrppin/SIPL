<%-- 
    Document   : login
    Created on : 09-feb-2014, 22:49:34
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <div class="row">
            <br><br><br><br><br>
            <div class="col-xs-6 col-sm-6">
                <style>
          html,body{ background: #e0e0e0; }   
               </style>
               <h2 align="center"><b>Bienvenid@ al SILAB - Sistema de Información de Laboratorios</b></h2>
                <br><br><br>
                <form class="form-horizontal" action="validar.jsp" method="POST">
                    <table align="center">
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="login">Usuario</label>
                                    <div class="controls">
                                        <input type="text" id="login" placeholder="Usuario" name="login">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="passwd">Contraseña</label>
                                    <div class="controls">
                                        <input type="password" id="passwd" placeholder="Contraseña" name="passwd">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <div align="center" class="controls">
                                        <br>
                                        <button type="submit" class="btn btn-warning"><b>Ingresar</b></button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="col-xs-6 col-sm-6">
                <br>   
                <table align="center">
                    <tr>
                        <td>
                            <img src="img/unab12.png" width="400" height="290" alt=".." class="img-rounded">
                        </td>
                    </tr>
                </table>
                
            </div>
        </div>
    </body>
</html>