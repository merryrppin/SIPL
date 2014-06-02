/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.recursos;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.Writer;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;

/**
 *
 * @author WM
 */
public class QRCode {

    private final String dir = "";

    public void QR(String data, String IMG_PATH) {
        int qr_image_width = 100;
        int qr_image_height = 100;
        String IMAGE_FORMAT = "png";
        BitMatrix matrix;
        Writer writer = new QRCodeWriter();
        try {
            matrix = writer.encode(data, BarcodeFormat.QR_CODE, qr_image_width, qr_image_height);
        } catch (WriterException e) {
            e.printStackTrace(System.err);
            return;
        }
        BufferedImage image = new BufferedImage(qr_image_width,
                qr_image_height, BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < qr_image_height; y++) {
            for (int x = 0; x < qr_image_width; x++) {
                int grayValue = (matrix.get(x, y) ? 0 : 1) & 0xff;
                image.setRGB(x, y, (grayValue == 0 ? 0 : 0xFFFFFF));
            }
        }
        try (FileOutputStream qrCode = new FileOutputStream(dir + IMG_PATH + ".png")) {
            ImageIO.write(image, IMAGE_FORMAT, qrCode);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
