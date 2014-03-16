<%-- 
    Document   : guardarReserva
    Created on : 8/03/2014, 11:43:13 PM
    Author     : Samy
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
    Usuario usu = Gestor.getUsuario(user.getCodigo());
    String accion = request.getParameter("accion");
    int a = 0;
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (usu.getTipo_usuario() == 0) {
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
        if (a == 1) {
            Usuario usuario = Gestor.getUsuario(user.getCodigo());
            if (usuario != null) {
                if (usuario.getEstado() == 2) {
                    error = "usuario_prestamo";
                } else if (usuario.getEstado() == 3) {
                    error = "usuario_reserva";
                } else if (usuario.getEstado() == 4) {
                    error = "usuario_multa";
                } else if (usuario.getEstado() == 1) {
                    error = "usuario_inactivo";
                } else if (usuario.getEstado() == 0) {
                    Calendar cal = Calendar.getInstance();
                    long i = cal.getTimeInMillis();
                    Calendar cal2 = Calendar.getInstance();
                    cal2.setTimeInMillis(i);
                    int dia = cal.get(Calendar.DAY_OF_MONTH);
                    dia += 3;
                    cal2.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), dia);
                    String materiales = "";
                    int disp = 0;
                    int esta = 0;
                    Material mate1 = null, mate2 = null, mate3 = null,
                            mate4 = null, mate5 = null;
                    try {
                        if (mat1 != null && mat1.length() > 0) {
                            mate1 = Gestor.getMaterial(Integer.parseInt(mat1));
                            materiales += mat1;
                            if (mate1.getDisponibilidad() == 1) {
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
                            if (mate2.getDisponibilidad() == 1) {
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
                            if (mate3.getDisponibilidad() == 1) {
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
                            if (mate4.getDisponibilidad() == 1) {
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
                            if (mate5.getDisponibilidad() == 1) {
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
                        Reserva res = new Reserva(0, usu, 0, cal, materiales);
                        boolean flag = false;
                        if (mate1 != null || mate2 != null || mate3 != null || mate4 != null
                                || mate5 != null) {
                            flag = true;
                        }
                        if (error.length() > 0) {
                            flag = false;
                        }
                        if (flag == true) {
                            Gestor.addReserva(res);
                            try {
                                if (mat1 != null && mat1.length() > 0) {
                                    mate1.setDisponibilidad(2);
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
                                    mate2.setDisponibilidad(2);
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
                                    mate3.setDisponibilidad(2);
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
                                    mate4.setDisponibilidad(2);
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
                                    mate5.setDisponibilidad(2);
                                    Gestor.updateMaterial(mate5);
                                    Tipo_material tip = mate5.getTipo_mat();
                                    int d = tip.getDisponibilidad();
                                    d--;
                                    tip.setDisponibilidad(d);
                                    Gestor.updateTipoMat(tip);
                                }
                            } catch (Exception e) {
                            }
                            usuario.setEstado(3);
                            Gestor.updateUsuario(usuario);
                            response.sendRedirect("principalUsuario.jsp");
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
            Usuario usuario = Gestor.getUsuario(user.getCodigo());
            if (usuario != null) {
                if (usuario.getEstado() == 3) {
                    Reserva res = Gestor.getReservaCodUsu(user.getCodigo());
                    String[] materiales = res.getMat().split(";");
                    for (int i = 0; i < materiales.length; i++) {
                        try {
                            Material mat = Gestor.getMaterial(Integer.parseInt(materiales[i]));
                            Tipo_material tip = mat.getTipo_mat();
                            mat.setDisponibilidad(0);
                            mat.setEstado(0);
                            Gestor.updateMaterial(mat);
                            int cati = tip.getDisponibilidad();
                            cati++;
                            tip.setDisponibilidad(cati);
                            Gestor.updateTipoMat(tip);
                        } catch (Exception e) {
                            error = "material_inexistente";
                        }
                    }
                    usuario.setEstado(0);
                    Gestor.updateUsuario(usuario);
                    res.setEstado(1);
                    Gestor.updateReserva(res);
                    response.sendRedirect("principalUsuario.jsp");
                } else {
                    error = "sin_reserva";
                }
            } else {
                error = "usuario_inexistente";
            }
        }
    } else {
        response.sendRedirect("principal.jsp?error=sin_permisos");
    }
    if (error != null && error.length() > 0) {
        response.sendRedirect("principalUsuario.jsp?error=" + error);
    }
%>
