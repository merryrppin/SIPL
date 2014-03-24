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
        String mat1 = request.getParameter("mat1");
        String mat2 = request.getParameter("mat2");
        String mat3 = request.getParameter("mat3");
        String mat4 = request.getParameter("mat4");
        String mat5 = request.getParameter("mat5");
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
                    String materiales = "";
                    int disp = 0;
                    int esta = 0;
                    Material mate1 = null, mate2 = null, mate3 = null,
                            mate4 = null, mate5 = null;
                    try {
                        if (mat1 != null && mat1.length() > 0) {
                            mate1 = Gestor.getMaterial(Integer.parseInt(mat1));
                            materiales += mat1;
                            if (mate1.getDisponibilidad() != 0) {
                                disp++;
                            }
                            if (mate1.getEstado() == 1 || mate1.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                        error = "material_inexistente";
                    }
                    try {
                        if (mat2 != null && mat2.length() > 0) {
                            mate2 = Gestor.getMaterial(Integer.parseInt(mat2));
                            materiales += ";" + mat2;
                            if (mate2.getDisponibilidad() != 0) {
                                disp++;
                            }
                            if (mate2.getEstado() == 1 || mate2.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                        error = "material_inexistente";
                    }
                    try {
                        if (mat3 != null && mat3.length() > 0) {
                            mate3 = Gestor.getMaterial(Integer.parseInt(mat3));
                            materiales += ";" + mat3;
                            if (mate3.getDisponibilidad() != 0) {
                                disp++;
                            }
                            if (mate3.getEstado() == 1 || mate3.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                        error = "material_inexistente";
                    }
                    try {
                        if (mat4 != null && mat4.length() > 0) {
                            mate4 = Gestor.getMaterial(Integer.parseInt(mat4));
                            materiales += ";" + mat4;
                            if (mate4.getDisponibilidad() != 0) {
                                disp++;
                            }
                            if (mate4.getEstado() == 1 || mate4.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                        error = "material_inexistente";
                    }
                    try {
                        if (mat5 != null && mat5.length() > 0) {
                            mate5 = Gestor.getMaterial(Integer.parseInt(mat5));
                            materiales += ";" + mat5;
                            if (mate5.getDisponibilidad() != 0) {
                                disp++;
                            }
                            if (mate5.getEstado() == 1 || mate5.getEstado() == 2) {
                                esta++;
                            }
                        }
                    } catch (Exception e) {
                        error = "material_inexistente";
                    }
                    if (disp == 0 && esta == 0) {
                        Prestamo pre = new Prestamo(0, materiales, Gestor.getUsuario(codigo), cal, cal, 0);
                        boolean flag = false;
                        if (mate1 != null || mate2 != null || mate3 != null || mate4 != null
                                || mate5 != null) {
                            flag = true;
                        }
                        if (error.length() > 0) {
                            flag = false;
                        }
                        if (flag == true) {
                            try {
                                if (mat1 != null && mat1.length() > 0) {
                                    mate1.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate1);
                                    Tipo_material tip = mate1.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);

                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat2 != null && mat2.length() > 0) {
                                    mate2.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate2);
                                    Tipo_material tip = mate2.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat3 != null && mat3.length() > 0) {
                                    mate3.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate3);
                                    Tipo_material tip = mate3.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat4 != null && mat4.length() > 0) {
                                    mate4.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate4);
                                    Tipo_material tip = mate4.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (Exception e) {
                            }
                            try {
                                if (mat5 != null && mat5.length() > 0) {
                                    mate5.setDisponibilidad(1);
                                    Gestor.updateMaterial(mate5);
                                    Tipo_material tip = mate5.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (Exception e) {
                            }
                            usuario.setEstado(2);
                            Gestor.updateUsuario(usuario);
                            Gestor.addPrestamo(pre);
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
            if (usuario.getEstado() == 2) {
                Prestamo pre = null;
                pre = Gestor.getPrestamoCodUsu(codigo);
                if (pre != null) {
                    String[] cadena = pre.getMat().split(";");
                    Material mate1 = null, mate2 = null, mate3 = null,
                            mate4 = null, mate5 = null;
                    if (cadena.length >= 1) {
                        try {
                            mate1 = Gestor.getMaterial(Integer.parseInt(cadena[0]));
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    if (cadena.length >= 2) {
                        try {
                            mate2 = Gestor.getMaterial(Integer.parseInt(cadena[1]));
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    if (cadena.length >= 3) {
                        try {
                            mate3 = Gestor.getMaterial(Integer.parseInt(cadena[2]));
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    if (cadena.length >= 4) {
                        try {
                            mate4 = Gestor.getMaterial(Integer.parseInt(cadena[3]));
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    if (cadena.length >= 5) {
                        try {
                            mate5 = Gestor.getMaterial(Integer.parseInt(cadena[4]));
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    try {
                        if (mate1 != null) {
                            mate1.setDisponibilidad(0);
                            Gestor.updateMaterial(mate1);
                            Tipo_material tip = mate1.getTipo_mat();
                            int d = tip.getDisponibilidad();
                            d++;
                            tip.setDisponibilidad(d);
                            Gestor.updateTipoMat(tip);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mate2 != null) {
                            mate2.setDisponibilidad(0);
                            Gestor.updateMaterial(mate2);
                            Tipo_material tip = mate2.getTipo_mat();
                            int d = tip.getDisponibilidad();
                            d++;
                            tip.setDisponibilidad(d);
                            Gestor.updateTipoMat(tip);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mate3 != null) {
                            mate3.setDisponibilidad(0);
                            Gestor.updateMaterial(mate3);
                            Tipo_material tip = mate3.getTipo_mat();
                            int d = tip.getDisponibilidad();
                            d++;
                            tip.setDisponibilidad(d);
                            Gestor.updateTipoMat(tip);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mate4 != null) {
                            mate4.setDisponibilidad(0);
                            Gestor.updateMaterial(mate4);
                            Tipo_material tip = mate4.getTipo_mat();
                            int d = tip.getDisponibilidad();
                            d++;
                            tip.setDisponibilidad(d);
                            Gestor.updateTipoMat(tip);
                        }
                    } catch (Exception e) {
                    }
                    try {
                        if (mate5 != null) {
                            mate5.setDisponibilidad(0);
                            Gestor.updateMaterial(mate5);
                            Tipo_material tip = mate5.getTipo_mat();
                            int d = tip.getDisponibilidad();
                            d++;
                            tip.setDisponibilidad(d);
                            Gestor.updateTipoMat(tip);
                        }
                    } catch (Exception e) {
                    }
                    usuario.setEstado(0);
                    Calendar cal = Calendar.getInstance();
                    Calendar cal2 = pre.getFecha_prestamo();
                    long time1 = cal.getTimeInMillis();
                    long time2 = cal2.getTimeInMillis();
                    long dias3 = 259200000;
                    time1 -= dias3;
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
        response.sendRedirect("principal.jsp?" + error);
    }
%>