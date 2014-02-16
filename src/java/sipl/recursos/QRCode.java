/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

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
    //private final String dir = "C:\\Users\\WM\\Pictures\\QR";

    public void QRmini(String data, String IMG_PATH) {
        int qr_image_width = 100;
        int qr_image_height = 100;
        String IMAGE_FORMAT = "png";
        // URL to be encoded

        // Encode URL in QR format
        BitMatrix matrix;
        Writer writer = new QRCodeWriter();
        try {
            matrix = writer.encode(data, BarcodeFormat.QR_CODE, qr_image_width, qr_image_height);
        } catch (WriterException e) {
            e.printStackTrace(System.err);
            return;
        }
        // Create buffered image to draw to
        BufferedImage image = new BufferedImage(qr_image_width,
                qr_image_height, BufferedImage.TYPE_INT_RGB);

        // Iterate through the matrix and draw the pixels to the image
        for (int y = 0; y < qr_image_height; y++) {
            for (int x = 0; x < qr_image_width; x++) {
                int grayValue = (matrix.get(x, y) ? 0 : 1) & 0xff;
                image.setRGB(x, y, (grayValue == 0 ? 0 : 0xFFFFFF));
            }
        }
        try (FileOutputStream qrCode = new FileOutputStream(dir + IMG_PATH + "mini.png")) {
            ImageIO.write(image, IMAGE_FORMAT, qrCode);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void QRMedium(String data, String IMG_PATH) {
        int qr_image_width = 250;
        int qr_image_height = 250;
        String IMAGE_FORMAT = "png";
        // URL to be encoded

        // Encode URL in QR format
        BitMatrix matrix;
        Writer writer = new QRCodeWriter();
        try {
            matrix = writer.encode(data, BarcodeFormat.QR_CODE, qr_image_width, qr_image_height);
        } catch (WriterException e) {
            e.printStackTrace(System.err);
            return;
        }
        // Create buffered image to draw to
        BufferedImage image = new BufferedImage(qr_image_width,
                qr_image_height, BufferedImage.TYPE_INT_RGB);

        // Iterate through the matrix and draw the pixels to the image
        for (int y = 0; y < qr_image_height; y++) {
            for (int x = 0; x < qr_image_width; x++) {
                int grayValue = (matrix.get(x, y) ? 0 : 1) & 0xff;
                image.setRGB(x, y, (grayValue == 0 ? 0 : 0xFFFFFF));
            }
        }
        try (FileOutputStream qrCode = new FileOutputStream(dir + IMG_PATH + "medium.png")) {
            ImageIO.write(image, IMAGE_FORMAT, qrCode);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void QRHigh(String data, String IMG_PATH) {
        int qr_image_width = 450;
        int qr_image_height = 450;
        String IMAGE_FORMAT = "png";
        // URL to be encoded

        // Encode URL in QR format
        BitMatrix matrix;
        Writer writer = new QRCodeWriter();
        try {
            matrix = writer.encode(data, BarcodeFormat.QR_CODE, qr_image_width, qr_image_height);
        } catch (WriterException e) {
            e.printStackTrace(System.err);
            return;
        }
        // Create buffered image to draw to
        BufferedImage image = new BufferedImage(qr_image_width,
                qr_image_height, BufferedImage.TYPE_INT_RGB);

        // Iterate through the matrix and draw the pixels to the image
        for (int y = 0; y < qr_image_height; y++) {
            for (int x = 0; x < qr_image_width; x++) {
                int grayValue = (matrix.get(x, y) ? 0 : 1) & 0xff;
                image.setRGB(x, y, (grayValue == 0 ? 0 : 0xFFFFFF));
            }
        }
        try (FileOutputStream qrCode = new FileOutputStream(dir + IMG_PATH + "high.png")) {
            ImageIO.write(image, IMAGE_FORMAT, qrCode);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(QRCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
