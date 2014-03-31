<%-- 
    Document   : guardarPrestamo
    Created on : 23-feb-2014, 1:42:51
    Author     : WM
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    } else if (user.getTipo_usuario() == 2 || user.getTipo_usuario() == 1) {
        String codigo = request.getParameter("codigo");
        String m1 = request.getParameter("mat1");
        String m2 = request.getParameter("mat2");
        String m3 = request.getParameter("mat3");
        String m4 = request.getParameter("mat4");
        String m5 = request.getParameter("mat5");
        String m6 = request.getParameter("mat6");
        String m7 = request.getParameter("mat7");
        String m8 = request.getParameter("mat8");
        String m9 = request.getParameter("mat9");
        String m10 = request.getParameter("mat10");
        String m11 = request.getParameter("mat11");
        String m12 = request.getParameter("mat12");
        String m13 = request.getParameter("mat13");
        String m14 = request.getParameter("mat14");
        String m15 = request.getParameter("mat15");
        String dia = request.getParameter("dia");
        try {
            a = Integer.parseInt(accion);
        } catch (Exception e) {
            error = "sin_accion";
        }
        Usuario usuario = Gestor.getUsuario(codigo);
        if (a == 1) {
            if (usuario != null) {
                if (usuario.getEstado() == 2) {
                    error = "usuario_prestamo";
                } else if (usuario.getEstado() == 3) {
                    usuario.setEstado(2);
                    Gestor.updateUsuario(usuario);
                    Reserva res = Gestor.getReservaCodUsu(codigo);
                    Calendar cal = Calendar.getInstance();
                    Prestamo pres = new Prestamo(0, res.getMat(), res.getUsu(), cal, cal, 0);
                    String[] mates = res.getMat().split(";");
                    for (int i = 0; i < mates.length; i++) {
                        Material mat = Gestor.getMaterial(Integer.parseInt(mates[i]));
                        mat.setDisponibilidad(1);
                        Gestor.updateMaterial(mat);
                    }
                    Gestor.addPrestamo(pres);
                    res.setEstado(1);
                    Gestor.updateReserva(res);
                    response.sendRedirect("listarPrestamos.jsp");
                } else if (usuario.getEstado() == 4) {
                    error = "usuario_multa";
                } else if (usuario.getEstado() == 1) {
                    error = "usuario_inactivo";
                } else if (usuario.getEstado() == 0) {
                    Calendar cal = Calendar.getInstance();
                    Calendar cal2 = Calendar.getInstance();
                    Usuario usu = Gestor.getUsuario(codigo);
                    String cod_materiales ="";
                    if(m1!=null && m1.length()>0){
                        cod_materiales+=m1+";";
                    }
                    if(m2!=null && m2.length()>0){
                        cod_materiales+=m2+";";
                    }
                    if(m3!=null && m3.length()>0){
                        cod_materiales+=m3+";";
                    }
                    if(m4!=null && m4.length()>0){
                        cod_materiales+=m4+";";
                    }
                    if(m5!=null && m5.length()>0){
                        cod_materiales+=m5+";";
                    }
                    if(m6!=null && m6.length()>0){
                        cod_materiales+=m6+";";
                    }
                    if(m7!=null && m7.length()>0){
                        cod_materiales+=m7+";";
                    }
                    if(m8!=null && m8.length()>0){
                        cod_materiales+=m8+";";
                    }
                    if(m9!=null && m9.length()>0){
                        cod_materiales+=m9+";";
                    }
                    if(m10!=null && m10.length()>0){
                        cod_materiales+=m10+";";
                    }
                    if(m11!=null && m11.length()>0){
                        cod_materiales+=m11+";";
                    }
                    if(m12!=null && m12.length()>0){
                        cod_materiales+=m12+";";
                    }
                    if(m13!=null && m13.length()>0){
                        cod_materiales+=m13+";";
                    }
                    if(m14!=null && m14.length()>0){
                        cod_materiales+=m14+";";
                    }
                    if(m15!=null && m15.length()>0){
                        cod_materiales+=m15+";";
                    }
                    int disp = 0;
                    int esta = 0;
                    String mates[] = cod_materiales.split(";");
                    try {
                        for (String mate : mates) {
                            Material mat = Gestor.getMaterial(Integer.parseInt(mate));
                            if (mat != null) {
                                if (mat.getDisponibilidad() != 0) {
                                    disp++;
                                }
                                if (mat.getEstado() == 1 || mat.getEstado() == 2) {
                                    esta++;
                                }
                            }
                        }
                        long fecha_act = cal2.getTimeInMillis();
                        int dias = Integer.parseInt(dia);
                        long fecha2 = dias * 86400000;
                        fecha_act += fecha2;
                        cal2.setTimeInMillis(fecha_act);
                        if (disp == 0 && esta == 0) {
                            Prestamo pre = new Prestamo(0, cod_materiales, usu, cal, cal2, 0);
                            for (String mate : mates) {
                                Material mat = Gestor.getMaterial(Integer.parseInt(mate));
                                mat.setDisponibilidad(1);
                                Gestor.updateMaterial(mat);
                                Tipo_material tip = mat.getTipo_mat();
                                int d = tip.getDisponibilidad();
                                d--;
                                tip.setDisponibilidad(d);
                                Gestor.updateTipoMat(tip);
                            }
                            usu.setEstado(2);
                            Gestor.updateUsuario(usu);
                            Gestor.addPrestamo(pre);
                            response.sendRedirect("listarPrestamos.jsp?accion=1");
                        } else {
                            error = "materiales_Ndisp";
                        }
                    } catch (NumberFormatException e) {
                        error = "material_inexistente";
                    }
                } else {
                    error = "error";
                }
            } else {
                error = "usuario_inexistente";
            }
        } else if (a == 2) {
            if (usuario.getEstado() == 2) {
                Prestamo pre = null;
                pre = Gestor.getPrestamoCodUsu(codigo);
                if (pre != null) {
                        String[] cadena = pre.getMat().split(";");
                        for (String cadena1 : cadena) {
                            try {
                                Material mat = Gestor.getMaterial(Integer.parseInt(cadena1));
                                if (mat != null) {
                                    mat.setDisponibilidad(0);
                                    Gestor.updateMaterial(mat);
                                    Tipo_material tip = mat.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d++;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (NumberFormatException e) {
                                error = "material_inexistente";
                            }
                        }
                        usuario.setEstado(0);
                        
                    Calendar cal = Calendar.getInstance();
                    Calendar cal2 = pre.getFecha_devolucion();
                    long time1 = cal.getTimeInMillis();
                    long time2 = cal2.getTimeInMillis();
                    int m = 0;
                    if (time1 > time2) {
                        usuario.setEstado(4);
                        Multa mul = new Multa(0, usuario, cal, 0, 3);
                        Gestor.addMulta(mul);
                        m++;
                    }
                    pre.setEstado(1);
                    pre.setFecha_devolucion(cal);
                    Gestor.updateUsuario(usuario);
                    Gestor.updatePrestamo(pre);
                    if (m > 0) {%>
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
                        <h4 class="modal-title">Multa</h4>
                    </div>
                    <div class="modal-body">
                        <p>El usuario no ha devuelto los materiales a tiempo</p>
                        <p class="text-warning"><small>Se ha generado una multa</small></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" onclick="location.href = 'listarPrestamos.jsp'" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>  
<%} else {
                        response.sendRedirect("listarPrestamos.jsp");
                    }
                } else {
                    error = "prestamo_null";
                }
            } else {
                error = "NO_prestamo";
            }
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principal.jsp?error=" + error);
    }
%>