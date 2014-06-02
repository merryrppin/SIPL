/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.recursos;

import java.io.IOException;

/**
 *
 * @author WM
 */
public class RestoreMySQL {

    public String Restore(String direccion) throws InterruptedException {
        String resultado = null;
        int processComplete = 1;
        try {
            //Process child = Runtime.getRuntime().exec("cmd /c mysql --password=12345 --user=root --databases siprelab < " + direccion);
            Process runtimeProcess = Runtime.getRuntime().exec("mysql -u root -p 12345 -e source " +direccion);
            processComplete = runtimeProcess.waitFor();
        } catch (IOException e) {
            String error = "Error no se actualizo la DB por el siguiente motivo: " + e.getMessage();
        }
        if (processComplete == 1) {
                resultado = "Backup Fallido";
            } else if (processComplete == 0) {
                resultado = "Backup creado satisfactoriamente...";
            }
        return resultado;
    }

}
