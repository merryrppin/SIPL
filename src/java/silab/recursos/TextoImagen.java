package silab.recursos;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 *
 * @author WM
 */
public class TextoImagen {

    public void addTextoImagen(String dir, String text, int ubi) throws Exception {
        dir+=".png";
        BufferedImage image = null;
        try{
        image = ImageIO.read(new File(dir));
        }catch(IOException e){
            System.out.print(e);
        }
        Graphics g = image.getGraphics();
        g.setFont(g.getFont().deriveFont(17f));
        g.setColor(Color.black);
        g.drawString(text, ubi, 95);
        g.dispose();
        ImageIO.write(image, "png", new File(dir));
    }
}
