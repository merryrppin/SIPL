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
public class Danho {

    private int codigo;
    private String descripcion;
    private Material mat;
    private Usuario usu;
    private Calendar fecha_d;
    private Usuario usu_rd;
    int estado;

    public Danho(int codigo, String descripcion, Material mat, Usuario usu, Calendar fecha_d, Usuario usu_rd, int estado) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.mat = mat;
        this.usu = usu;
        this.fecha_d = fecha_d;
        this.usu_rd = usu_rd;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Material getMat() {
        return mat;
    }

    public void setMat(Material mat) {
        this.mat = mat;
    }

    public Usuario getUsu() {
        return usu;
    }

    public void setUsu(Usuario usu) {
        this.usu = usu;
    }

    public Calendar getFecha_d() {
        return fecha_d;
    }

    public void setFecha_d(Calendar fecha_d) {
        this.fecha_d = fecha_d;
    }

    public Usuario getUsu_rd() {
        return usu_rd;
    }

    public void setUsu_rd(Usuario usu_rd) {
        this.usu_rd = usu_rd;
    }
}
