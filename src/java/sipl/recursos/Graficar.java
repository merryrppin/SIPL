/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package sipl.recursos;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import sipl.dominio.Tipo_material;

/**
 *
 * @author WM
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

    public boolean TipoMaterial(ArrayList<Tipo_material> TM, String direccion) throws IOException {
        boolean flag=false;
        DefaultPieDataset data = new DefaultPieDataset();
        for (int i = 0; i < TM.size(); i++) {
            data.setValue("Cat." + TM.get(i).getId(), TM.get(i).getCantidad());
        }
        JFreeChart chart = ChartFactory.createPieChart("Cantidad de materiales por categoría", data, true, true, true);
        try {
            ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 500, 500);
            flag=true;
        } catch (IOException e) {
            System.out.println("Error al abrir el archivo");
        }
        return flag;
    }

    public void Prestamos(int[] values, int[] fecha, int n, String direccion, String tiempo, String titulo) {
        try {
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            for (int j = 0; j < n; j++) {
                dataset.addValue(values[j], "Cantidad de Préstamos", "" + fecha[j]);
            }
            JFreeChart chart = ChartFactory.createLineChart(titulo, tiempo, "Cantidad", dataset, PlotOrientation.VERTICAL, true, true, true);
            try {
                ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 700, 500);
            } catch (IOException e) {
                System.out.println("Error al abrir el archivo");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public void Multas(int[] values, int[] fecha, int n, String direccion, String tiempo, String titulo) {
        try {
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            for (int j = 0; j < n; j++) {
                dataset.addValue(values[j], "Cantidad de Multas", "" + fecha[j]);
            }
            JFreeChart chart = ChartFactory.createLineChart(titulo, tiempo, "Cantidad", dataset, PlotOrientation.VERTICAL, true, true, true);
            try {
                ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 700, 500);
            } catch (IOException e) {
                System.out.println("Error al abrir el archivo");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void PrestamosY(int[][] values, int n, String direccion, String tiempo, String titulo) {
        try {
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            for (int j = 0; j < n; j++) {
                dataset.addValue(values[j][1], "Cantidad de Préstamos", "" + values[j][0]);
            }
            JFreeChart chart = ChartFactory.createLineChart(titulo, tiempo, "Cantidad", dataset, PlotOrientation.VERTICAL, true, true, true);
            try {
                ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 500, 500);
            } catch (IOException e) {
                System.out.println("Error al abrir el archivo");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    
    

    public void PrestamosY_Barra(int[][] values, int n, String direccion, String tiempo, String titulo) {
        //Crear el dataset...
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for (int i = 1; i < n; i++) {
            if (n != 0) {
                dataset.addValue(values[i][1], "Cantidad de Préstamos", "" + values[i][0]);
            }
        }
        JFreeChart chart = ChartFactory.createBarChart(titulo, tiempo, "Cantidad", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 500, 500);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

}

