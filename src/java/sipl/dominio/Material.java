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
public class Material {
    private int codigo;
    private String descripcion;
    private int tipo_mat;
    private String marca;
    private String serial;
    private String foto_mat;
    private String num_inventario;
    private int estado;
    private Calendar ult_fecha_mante;
    private int disponibilidad;
    private Laboratorio lab;
    private String imagenqr;

    public Material(int codigo, String descripcion, int tipo_mat, String marca, String serial, String foto_mat, String num_inventario, int estado, Calendar ult_fecha_mante, int disponibilidad, Laboratorio lab, String imagenqr) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.tipo_mat = tipo_mat;
        this.marca = marca;
        this.serial = serial;
        this.foto_mat = foto_mat;
        this.num_inventario = num_inventario;
        this.estado = estado;
        this.ult_fecha_mante = ult_fecha_mante;
        this.disponibilidad = disponibilidad;
        this.lab = lab;
        this.imagenqr = imagenqr;
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

    public int getTipo_mat() {
        return tipo_mat;
    }

    public void setTipo_mat(int tipo_mat) {
        this.tipo_mat = tipo_mat;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getFoto_mat() {
        return foto_mat;
    }

    public void setFoto_mat(String foto_mat) {
        this.foto_mat = foto_mat;
    }

    public String getNum_inventario() {
        return num_inventario;
    }

    public void setNum_inventario(String num_inventario) {
        this.num_inventario = num_inventario;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Calendar getUlt_fecha_mante() {
        return ult_fecha_mante;
    }

    public void setUlt_fecha_mante(Calendar ult_fecha_mante) {
        this.ult_fecha_mante = ult_fecha_mante;
    }

    public int getDisponibilidad() {
        return disponibilidad;
    }

    public void setDisponibilidad(int disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    public Laboratorio getLab() {
        return lab;
    }

    public void setLab(Laboratorio lab) {
        this.lab = lab;
    }

    public String getImagenqr() {
        return imagenqr;
    }

    public void setImagenqr(String imagenqr) {
        this.imagenqr = imagenqr;
    }
     

   
    
}
