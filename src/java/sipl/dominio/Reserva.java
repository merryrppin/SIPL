/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.dominio;

import java.util.Calendar;

/**
 *
 * @author Samy
 */
public class Reserva {

    private int codigo;
    private Usuario usu;
    private int estado;
    private Calendar fecha_reserva;
    private String mat;

    public Reserva(int codigo, Usuario usu, int estado, Calendar fecha_reserva, String mat) {
        this.codigo = codigo;
        this.usu = usu;
        this.estado = estado;
        this.fecha_reserva = fecha_reserva;
        this.mat = mat;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public Usuario getUsu() {
        return usu;
    }

    public void setUsu(Usuario usu) {
        this.usu = usu;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Calendar getFecha_reserva() {
        return fecha_reserva;
    }

    public void setFecha_reserva(Calendar fecha_reserva) {
        this.fecha_reserva = fecha_reserva;
    }

    public String getMat() {
        return mat;
    }

    public void setMat(String mat) {
        this.mat = mat;
    }

}
