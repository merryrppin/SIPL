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
        String dias = request.getParameter("dias");
        String mat1 = request.getParameter("mat1");
        String mat2 = request.getParameter("mat2");
        String mat3 = request.getParameter("mat3");
        String mat4 = request.getParameter("mat4");
        String mat5 = request.getParameter("mat5");
        String laboratorio = request.getParameter("laboratorio");
        try {
            a = Integer.parseInt(accion);
        } catch (Exception e) {
            error = "sin_accion";
        }
        if (a == 1) {
            Usuario usuario = Gestor.getUsuario(codigo);
            if (usuario != null) {
                if (usuario.getEstado() == 2) {
                    error= "usuario_prestamo";
                } else if (usuario.getEstado() == 3) {
                    error= "usuario_reserva";
                } else if (usuario.getEstado() == 4) {
                    error= "usuario_multa";
                } else if (usuario.getEstado() == 1) {
                    error = "usuario_inactivo";
                } else if (usuario.getEstado() == 0) {
                    Calendar cal = Calendar.getInstance();
                    long i = cal.getTimeInMillis();
                    Calendar cal2 = Calendar.getInstance();
                    cal2.setTimeInMillis(i);
                    int dia = cal.get(Calendar.DAY_OF_MONTH);
                    dia += Integer.parseInt(dias);
                    cal2.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), dia);
                    String materiales = "";
                    int disp = 0;
                    int esta = 0;
                    Material mate1 = null, mate2 = null, mate3 = null,
                            mate4 = null, mate5 = null;
                    try {
                        if (mat1.length() > 0 && mat1 != null) {
                            materiales += mat1;
                            mate1 = Gestor.getMaterial(Integer.parseInt(mat1));
                            if (mate1.getDisponibilidad() == 1) {
                                disp++;
                            }
                            if (mate1.getEstado() == 1 || mate1.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat2.length() > 0 && mat2 != null) {
                            materiales += ";" + mat2;
                            mate2 = Gestor.getMaterial(Integer.parseInt(mat2));
                            if (mate2.getDisponibilidad() == 1) {
                                disp++;
                            }
                            if (mate2.getEstado() == 1 || mate2.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat3.length() > 0 && mat3 != null) {
                            materiales += ";" + mat3;
                            mate3 = Gestor.getMaterial(Integer.parseInt(mat3));
                            if (mate3.getDisponibilidad() == 1) {
                                disp++;
                            }
                            if (mate3.getEstado() == 1 || mate3.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat4.length() > 0 && mat4 != null) {
                            materiales += ";" + mat4;
                            mate4 = Gestor.getMaterial(Integer.parseInt(mat4));
                            if (mate4.getDisponibilidad() == 1) {
                                disp++;
                            }
                            if (mate4.getEstado() == 1 || mate4.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat5.length() > 0 && mat5 != null) {
                            materiales += ";" + mat5;
                            mate5 = Gestor.getMaterial(Integer.parseInt(mat5));
                            if (mate5.getDisponibilidad() == 1) {
                                disp++;
                            }
                            if (mate5.getEstado() == 1 || mate5.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                    }
                    if (disp == 0 && esta == 0) {
                        Prestamo pre = new Prestamo(0, materiales, Gestor.getUsuario(codigo), cal, cal2,0);
                        if (Gestor.addPrestamo(pre) == true) {
                            try {
                                if (mat1.length() > 0 && mat1 != null) {
                                    mate1.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate1);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat2.length() > 0 && mat2 != null) {
                                    mate2.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate2);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat3.length() > 0 && mat3 != null) {
                                    mate3.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate3);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat4.length() > 0 && mat4 != null) {
                                    mate4.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate4);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat5.length() > 0 && mat5 != null) {
                                    mate5.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate5);
                                }
                            } catch (Exception e) {
                            }
                            usuario.setEstado(2);
                            Gestor.updateUsuario(usuario);
                            response.sendRedirect("listarPrestamos.jsp?accion=1");
                        } else {
                            error = "no_agrego";
                        }
                    } else {
                        error = "materiales_Ndisp";
                    }
                } else {
                    error = "error";
                }
            } else {
                error = "usuario_inexistente";
            }
        } else if (a == 2) {
            Usuario usu = Gestor.getUsuario(codigo);
            if(usu.getEstado()==2){
                Prestamo pre=null;
                pre = Gestor.getPrestamoCodUsu(codigo);
                if(pre!=null){
                    String [] cadena = pre.getMat().split(";");
                    Material mate1 = null, mate2 = null, mate3 = null,
                            mate4 = null, mate5 = null;
                    if(cadena.length==1){
                        mate1=Gestor.getMaterial(Integer.parseInt(cadena[0]));
                    }
                    if(cadena.length==2){
                        mate2=Gestor.getMaterial(Integer.parseInt(cadena[1]));
                    }
                    if(cadena.length==3){
                        mate3=Gestor.getMaterial(Integer.parseInt(cadena[2]));
                    }
                    if(cadena.length==4){
                        mate4=Gestor.getMaterial(Integer.parseInt(cadena[3]));
                    }
                    if(cadena.length==5){
                        mate5=Gestor.getMaterial(Integer.parseInt(cadena[4]));
                    }
                    try {
                        if (mat1.length() > 0 && mat1 != null) {
                            mate1 = Gestor.getMaterial(Integer.parseInt(mat1));
                            mate1.setDisponibilidad(0);
                            Gestor.updateMaterial(mate1);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat2.length() > 0 && mat2 != null) {
                            mate2 = Gestor.getMaterial(Integer.parseInt(mat2));
                            mate2.setDisponibilidad(0);
                            Gestor.updateMaterial(mate2);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat3.length() > 0 && mat3 != null) {
                            mate3 = Gestor.getMaterial(Integer.parseInt(mat3));
                            mate3.setDisponibilidad(0);
                            Gestor.updateMaterial(mate3);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat4.length() > 0 && mat4 != null) {
                            mate4 = Gestor.getMaterial(Integer.parseInt(mat4));
                            mate4.setDisponibilidad(0);
                            Gestor.updateMaterial(mate4);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mat5.length() > 0 && mat5 != null) {
                            mate5 = Gestor.getMaterial(Integer.parseInt(mat5));
                            mate5.setDisponibilidad(0);
                            Gestor.updateMaterial(mate5);
                        }
                    } catch (Exception e) {
                    }
                    usu.setEstado(0);
                    Calendar cal = Calendar.getInstance();
                    Calendar cal2=pre.getFecha_prestamo();
                    long time1 = cal.getTimeInMillis();
                    long time2 = cal2.getTimeInMillis();
                    long dias3=259200000;
                    time2-=dias3;
                    if(time2>time1){
                        usu.setEstado(4);
                        Multa mul = new Multa(0, usu, cal, 0, 3);
                        Gestor.addMulta(mul);
                    }
                    Gestor.updateUsuario(usu);
                    pre.setEstado(1);
                    Gestor.updatePrestamo(pre);
                    response.sendRedirect("principal.jsp");
                }else{
                    error="prestamo_null";
                }              
            }else{
                error="NO_prestamo";
            }
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error.length() > 0) {
        response.sendRedirect("modificarPrestamo.jsp?" + error);
    }
%>

