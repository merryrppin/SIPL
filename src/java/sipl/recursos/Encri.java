/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.security.MessageDigest;

/**
 *
 * @author WM
 */
public class Encri {

    public String encriptarMD5(String palabra) {
        String pe = "";
        try {
            pe = hash(palabra);
        } catch (Exception e) {
            throw new Error("Error: Al encriptar el password");
        }
        return pe;
    }

    private String hash(String clear) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] b = md.digest(clear.getBytes());
        int size = b.length;
        StringBuffer h = new StringBuffer(size);
        for (int i = 0; i < size; i++) {
            int u = b[i] & 255;
            if (u < 16) {
                h.append("0" + Integer.toHexString(u));
            } else {
                h.append(Integer.toHexString(u));
            }
        }
        return h.toString();
    }
}
