/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.dominio;

/**
 *
 * @author WM
 */
public class VariableSis {

    private int id;
    private String Datos;
    private String Descripcion;

    public VariableSis(int id, String Datos, String Descripcion) {
        this.id = id;
        this.Datos = Datos;
        this.Descripcion = Descripcion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDatos() {
        return Datos;
    }

    public void setDatos(String Datos) {
        this.Datos = Datos;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

}
