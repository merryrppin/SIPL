/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import sipl.dominio.Tipo_material;

/**
 *
 * @author Wilmar
 */
public class Graficar {

    public void TipoMaterialBarras(ArrayList<Tipo_material> TM, String direccion) throws IOException {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for (int i = 0; i < TM.size(); i++) {
            Tipo_material mat = TM.get(i);
            dataset.addValue(mat.getCantidad(), "" + mat.getCantidad(), "" + mat.getId());
        }
        JFreeChart chart = ChartFactory.createBarChart("Cantidad de materiales por categoría", "Categoría(Y)", "Cantidad(X)", dataset, PlotOrientation.HORIZONTAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 800, 400);
        } catch (IOException e) {
            System.out.println("Error al abrir el archivo");
        }
    }

    public void TipoMaterial(ArrayList<Tipo_material> TM, String direccion) throws IOException {
        DefaultPieDataset data = new DefaultPieDataset();
        for (int i = 0; i < TM.size(); i++) {
            data.setValue("Cat." + TM.get(i).getId(), TM.get(i).getCantidad());
        }
        JFreeChart chart = ChartFactory.createPieChart("Cantidad de materiales por categoría", data, true, true, true);
        try {
            ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 500, 500);
        } catch (IOException e) {
            System.out.println("Error al abrir el archivo");
        }
    }

    public void draw_bar(int[] values, int[] fecha, int n, String direccion) {
        try {
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();

            for (int j = 0; j < n; j++) {
                dataset.addValue(values[j], "" + fecha[j], "x");
            }
            JFreeChart chart = ChartFactory.createLineChart("Assets", "X", "Y", dataset, PlotOrientation.VERTICAL, true, true, true);
            try {
                ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 500, 500);
            } catch (IOException e) {
                System.out.println("Error al abrir el archivo");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
