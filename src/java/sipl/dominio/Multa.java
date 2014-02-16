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
public class Multa {

    private int codigo;
    private Usuario usu;
    private Calendar fecha_multa;
    private int estado_multa;
    private int tiempo_multa;

    public Multa(int codigo, Usuario usu, Calendar fecha_multa, int estado_multa, int tiempo_multa) {
        this.codigo = codigo;
        this.usu = usu;
        this.fecha_multa = fecha_multa;
        this.estado_multa = estado_multa;
        this.tiempo_multa = tiempo_multa;
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

    public Calendar getFecha_multa() {
        return fecha_multa;
    }

    public void setFecha_multa(Calendar fecha_multa) {
        this.fecha_multa = fecha_multa;
    }

    public int getEstado_multa() {
        return estado_multa;
    }

    public void setEstado_multa(int estado_multa) {
        this.estado_multa = estado_multa;
    }

    public int getTiempo_multa() {
        return tiempo_multa;
    }

    public void setTiempo_multa(int tiempo_multa) {
        this.tiempo_multa = tiempo_multa;
    }

}
