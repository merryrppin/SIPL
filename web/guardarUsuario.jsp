<%-- 
    Document   : guardarUsuario
    Created on : 12/02/2014, 11:26:39 PM
    Author     : Samy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sipl.dominio.*"%>
<jsp:useBean id="Gestor" scope="session" class="sipl.dominio.Gestor" />
<%
    Usuario user = (Usuario) session.getAttribute("user");
    String accion = request.getParameter("accion");
    int a = 0;
    String error = "";
    if (user == null) {
        response.sendRedirect("login.jsp?error=No_usuario");
    } else if (user.getTipo_usuario() == 1 || user.getTipo_usuario() == 2) {
        try {
            String codigo = request.getParameter("codigo");
            String tipo = request.getParameter("tipo");
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            String apellidos = request.getParameter("apellidos");
            String estado = request.getParameter("estado");
            String correo = request.getParameter("correo");
            String observaciones = request.getParameter("observaciones");
            a = Integer.parseInt(accion);
            if (a == 1) {
                if (codigo != null && codigo.length() > 0 && nombre != null
                        && nombre.length() > 0 && apellidos != null && apellidos.length() > 0) {
                    long tel = 0;
                    int tip, est;
                    if (telefono.length() > 0 && telefono != null) {
                        try {
                            tel = Long.parseLong(telefono);
                        } catch (Exception e) {
                            error = "telefono_incorrecto";
                            tel = -1;
                        }
                    }
                    try {
                        tip = Integer.parseInt(tipo);
                    } catch (Exception e) {
                        tip = 0;
                    }
                    est = Integer.parseInt(estado);
                    String clave = Gestor.encriptar(codigo);
                    if (tel > -1) {
                        Usuario usu = new Usuario(codigo, nombre, apellidos, tel, correo, est, tip, observaciones, clave);
                        if (Gestor.addUsuario(usu) == true) {
                            response.sendRedirect("listarUsuarios.jsp?accion=1");
                        } else {
                            error = "usuario_no_agregado";
                        }
                    } else {
                        error = "telefono_invalido";
                    }
                } else {
                    error = "datos_incompletos";
                }
            } else if (a == 2) {
                if (nombre != null && nombre.length() > 0 && apellidos != null && apellidos.length() > 0) {
                    long tel = 0;
                    int est;
                    if (telefono.length() > 0 && telefono != null) {
                        try {
                            tel = Long.parseLong(telefono);
                        } catch (Exception e) {
                            error = "telefono_incorrecto";
                            tel = -1;
                        }
                    }
                    Usuario u = Gestor.getUsuario(codigo);
                    if (u.getTipo_usuario() != 2) {
                        est = Integer.parseInt(estado);
                    } else {
                        est = 0;
                    }
                    if (tel > -1) {
                        u.setTelefono(tel);
                        u.setEstado(est);
                        u.setNombre(nombre);
                        u.setApellido(apellidos);
                        u.setObservaciones(observaciones);
                        u.setCorreo(correo);
                        if (Gestor.updateUsuario(u) == true) {
                            response.sendRedirect("listarUsuarios.jsp?accion=2");
                        } else {
                            error = "usuario_no_modificado";
                        }
                    } else {
                        error = "telefono_invalido";
                    }
                } else {
                    error = "datos_incompletos";
                }
            } else if ((a == 3 || a == 4 || a == 5) && user.getTipo_usuario() == 2) {
                String ID = request.getParameter("id");
                Usuario usu = Gestor.getUsuario(ID);
                if (a == 3) {
                    usu.setTipo_usuario(0);
                } else if (a == 4) {
                    usu.setTipo_usuario(1);
                } else if (a == 5) {
                    usu.setTipo_usuario(2);
                }
                Gestor.updateUsuario(usu);
                response.sendRedirect("asignarPrivilegios.jsp");
            } else if (a == 6) {
                String ID = request.getParameter("codigo");
                Usuario usu = Gestor.getUsuario(ID);
                String clave = request.getParameter("clave1");
                String c = Gestor.encriptar(clave);
                usu.setClave(c);
                Gestor.updateUsuario(usu);
                response.sendRedirect("modificarUsuario.jsp?id=" + ID);
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