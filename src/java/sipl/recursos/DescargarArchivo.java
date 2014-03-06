/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

/**
 *
 * @author WM
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class DescargarArchivo {

    public void downloadFile(String url_file, String ubicacion, String nombre) {

        String url = url_file;
        String name = nombre;
        String folder = ubicacion;
        File dir = new File(folder);
        if (!dir.exists()) {
            if (!dir.mkdir()) {
                return;
            }
        }
        File file = new File(folder + name);
        try {
            URLConnection conn = new URL(url).openConnection();
            conn.connect();
            try (InputStream in = conn.getInputStream(); OutputStream out = new FileOutputStream(file)) {
                int b = 0;
                while (b != -1) {
                    b = in.read();

                    if (b != -1) {
                        out.write(b);
                    }
                }
            }
        } catch (MalformedURLException e) {
        } catch (IOException e) {
        }
    }
}
