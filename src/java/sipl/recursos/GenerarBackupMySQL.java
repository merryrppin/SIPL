/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.awt.HeadlessException;
import java.io.IOException;

/**
 *
 * @author WM
 */
public class GenerarBackupMySQL {

    public String GenerarBackupMySQL(String direccion) {
        String resultado="";
        try {
            int processComplete;
            Process runtimeProcess = Runtime.getRuntime().exec("C:\\Program Files (x86)\\MySQL\\MySQL Server 5.5\\bin\\mysqldump "
                    + "--opt --password=12345 --user=root --databases siprelab -r "+direccion);
            processComplete = runtimeProcess.waitFor();
            if (processComplete == 1) {
                resultado="Backup Fallido";
            } else if (processComplete == 0) {
                resultado="Backup creado satisfactoriamente...";
            }
        } catch (HeadlessException | IOException | InterruptedException e) {            
        }
        return resultado;
    }

}
