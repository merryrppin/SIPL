/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.awt.HeadlessException;
import java.io.IOException;
import sipl.dominio.Gestor;
import sipl.dominio.VariableSis;

/**
 *
 * @author WM
 */
public class GenerarBackupMySQL {

    public String GenerarBackupMySQL(String nombre) {
        String resultado = "";
        Gestor gestor = new Gestor();
        VariableSis vs = gestor.getVariable(2);
        VariableSis vs2 = gestor.getVariable(1);
        VariableSis vs3 = gestor.getVariable(3);
        VariableSis vs4 = gestor.getVariable(4);
        String direccion = vs2.getDatos();
        String mysql = vs.getDatos() + "\\mysqldump";
        direccion += nombre;
        try {
            int processComplete;
            Process runtimeProcess = Runtime.getRuntime().exec(mysql
                    + " --opt --password=" + vs4.getDatos() + " --user=" + vs3.getDatos() + " --databases siprelab -r " + direccion);
            processComplete = runtimeProcess.waitFor();
            if (processComplete == 1) {
                resultado = "Backup Fallido";
            } else if (processComplete == 0) {
                resultado = "Backup creado satisfactoriamente...";
            }
        } catch (HeadlessException | IOException | InterruptedException e) {
            System.out.print(e);
        }
        return resultado;
    }

}
