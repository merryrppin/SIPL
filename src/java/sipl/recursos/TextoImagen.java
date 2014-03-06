package sipl.recursos;

import java.applet.Applet;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;

/**
 *
 * @author WM
 */
public class TextoImagen extends Applet {

    public void addTextoImagen(String dir, String text, int ubi) throws Exception {
        dir+=".png";
        BufferedImage image = null;
        try{
        image = ImageIO.read(new File(dir));
        }catch(Exception e){
            System.out.print(e);
        }
        //final BufferedImage image = ImageIO.read(new URL(dir));
        //"http://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png"));
        Graphics g = image.getGraphics();
        g.setFont(g.getFont().deriveFont(17f));
        g.setColor(Color.black);
        g.drawString(text, ubi, 95);
        g.dispose();
        ImageIO.write(image, "png", new File(dir));
    }
}
