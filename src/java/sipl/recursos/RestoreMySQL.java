/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.io.IOException;

/**
 *
 * @author WM
 */
public class RestoreMySQL {

    public String Restore(String direccion) {
        String resultado = "";
        String error = "";
        try {
            Process child = Runtime.getRuntime().exec("cmd /c mysql --password=12345 --user=root --databases siprelab < " + direccion);
        } catch (IOException e) {
            error = "Error no se actualizo la DB por el siguiente motivo: " + e.getMessage();
        }
        if (error.length() == 0) {
            resultado = "Base de Datos Actualizada";
            return resultado;
        } else {
            return error;
        }
    }

}
