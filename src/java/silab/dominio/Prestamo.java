/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.dominio;

import java.util.Calendar;

/**
 *
 * @author Samy
 */
public class Prestamo {

    private int codigo;
    private String mat;
    private Usuario usu;
    private Calendar fecha_prestamo;
    private Calendar fecha_devolucion;
    private int estado;

    public Prestamo(int codigo, String mat, Usuario usu, Calendar fecha_prestamo, Calendar fecha_devolucion, int estado) {
        this.codigo = codigo;
        this.mat = mat;
        this.usu = usu;
        this.fecha_prestamo = fecha_prestamo;
        this.fecha_devolucion = fecha_devolucion;
        this.estado = estado;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getMat() {
        return mat;
    }

    public void setMat(String mat) {
        this.mat = mat;
    }

    public Usuario getUsu() {
        return usu;
    }

    public void setUsu(Usuario usu) {
        this.usu = usu;
    }

    public Calendar getFecha_prestamo() {
        return fecha_prestamo;
    }

    public void setFecha_prestamo(Calendar fecha_prestamo) {
        this.fecha_prestamo = fecha_prestamo;
    }

    public Calendar getFecha_devolucion() {
        return fecha_devolucion;
    }

    public void setFecha_devolucion(Calendar fecha_devolucion) {
        this.fecha_devolucion = fecha_devolucion;
    }

}
