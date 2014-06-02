/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import sipl.dominio.Gestor;
import sipl.dominio.VariableSis;

/**
 *
 * @author WM
 */
public class AplicarRestore {

    public String AplicarRestoreMySQL(String nombre) {
        String resultado = "";
        Gestor gestor = new Gestor();
        VariableSis vs = gestor.getVariable(2);
        VariableSis vs3 = gestor.getVariable(3);
        VariableSis vs4 = gestor.getVariable(4);
        String mysql = vs.getDatos() + "mysql";

        String[] executeCmd = new String[]{mysql, "--user=" + vs3.getDatos(), "--password=" + vs4.getDatos(), "-e", "source " + nombre};

        Process runtimeProcess;
        try {

            runtimeProcess = Runtime.getRuntime().exec(executeCmd);
            int processComplete = runtimeProcess.waitFor();

            if (processComplete == 0) {
                resultado = "Restore aplicado satisfactoriamente";
            } else {
                resultado = "Ha ocurrido un error";
            }
        } catch (Exception ex) {
            resultado = ex.getMessage();
        }

        return resultado;
    }
}
