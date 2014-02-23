<%-- 
    Document   : verificarMulta
    Created on : 22-feb-2014, 22:12:28
    Author     : WM
--%>

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
        String codigo = request.getParameter("codigo");
        try {
            a = Integer.parseInt(accion);
            if (a == 1) {
                try {
                    Gestor.generarQR(codigo, direccion);
                } catch (Exception e) {
                    error = "QR_error";
                }
                try {
                    if (foto == null && foto.length() == 0) {
                        foto = "ninguna";
                    }
                } catch (Exception e) {
                    foto = "ninguna";
                }
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
                }
                if (numero.length() == 0 || numero == null) {
                    numero = " ";
                }
                if (marca.length() == 0 || marca == null) {
                    marca = "ninguna";
                }
                if (serial.length() == 0 || serial == null) {
                    serial = "ninguna";
                }
                try {
                    int h = Integer.parseInt(hora);
                    if (h < 10) {
                        hora = "0" + h;
                    }
                    int m = Integer.parseInt(minutos);
                    if (m < 10) {
                        minutos = "0" + m;
                    }
                    String[] f = fecha.split("/");
                    String fe = f[2] + "-" + f[1] + "-" + f[0];
                    fe += " " + hora + ":" + minutos + ":00";
                    Calendar cal = Calendar.getInstance();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    try {
                        Date myDate = sdf.parse(fe);
                        cal.setTime(myDate);
                    } catch (Exception e) {
                        error = "error_fecha";
                    }
                    Material mat = new Material(Integer.parseInt(codigo), descripcion, Gestor.getTipoM(Integer.parseInt(tipo)),
                            marca, serial, foto, numero, Integer.parseInt(estado), cal, Integer.parseInt(disponibilidad),
                            Gestor.getLaboratorio(Integer.parseInt(laboratorio)), direccion);
                    if (Gestor.addMaterial(mat) == true) {
                        Tipo_material tip = Gestor.getTipoM(Integer.parseInt(tipo));
                        int disp=tip.getDisponibilidad();
                        int can=tip.getCantidad();
                        can++;
                        if(Integer.parseInt(estado)==0 || Integer.parseInt(estado) == 3){
                            disp++;
                        }
                        tip.setDisponibilidad(disp);
                        tip.setCantidad(can);
                        Gestor.updateTipoMat(tip);
                        response.sendRedirect("listarMateriales.jsp?accion=1");
                    } else {
                        error = "no_agrego";
                    }
                } catch (Exception e) {
                    error = "fecha_error";
                }
            } else if (a == 2) {
                
                
                
                
                
                try {
                    Gestor.generarQR(codigo, direccion);
                } catch (Exception e) {
                    error = "QR_error";
                }
                try {
                    if (foto == null && foto.length() == 0) {
                        foto = "ninguna";
                    }
                } catch (Exception e) {
                    foto = "ninguna";
                }
                if (descripcion.length() == 0 || descripcion == null) {
                    descripcion = "ninguna";
                }
                if (numero.length() == 0 || numero == null) {
                    numero = " ";
                }
                if (marca.length() == 0 || marca == null) {
                    marca = "ninguna";
                }
                if (serial.length() == 0 || serial == null) {
                    serial = "ninguna";
                }
                try {
                    int h = Integer.parseInt(hora);
                    if (h < 10) {
                        hora = "0" + h;
                    }
                    int m = Integer.parseInt(minutos);
                    if (m < 10) {
                        minutos = "0" + m;
                    }
                    String[] f = fecha.split("/");
                    String fe = f[2] + "-" + f[1] + "-" + f[0];
                    fe += " " + hora + ":" + minutos + ":00";
                    Calendar cal = Calendar.getInstance();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    try {
                        Date myDate = sdf.parse(fe);
                        cal.setTime(myDate);
                    } catch (Exception e) {
                        error = "error_fecha";
                    }
                    Material mat = new Material(Integer.parseInt(codigo), descripcion, Gestor.getTipoM(Integer.parseInt(tipo)),
                            marca, serial, foto, numero, Integer.parseInt(estado), cal, Integer.parseInt(disponibilidad),
                            Gestor.getLaboratorio(Integer.parseInt(laboratorio)), direccion);
                    if (Gestor.updateMaterial(mat) == true) {
                        response.sendRedirect("listarMateriales.jsp?accion=1");
                    } else {
                        error = "no_agrego";
                    }
                } catch (Exception e) {
                    error = "fecha_error";
                }
            
                
                
                
                
                
                
                
                
            }
        } catch (Exception e) {
            error = "sin_accion";
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("agregarMaterial.jsp?" + error);
    }
%>

