/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.recursos;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.time.Day;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import sipl.dominio.Tipo_material;

/**
 *
 * @author Wilmar
 */
public class Graficar {

    //public static void main(String[]args)
    public void linea(int V[]) {
        TimeSeries pop = new TimeSeries("Personal FIS", Day.class);
        int N[] = new int[13];
        for (int i = 1; i < 12; i++) {
            N[i] = ((int) (Math.random() * 500));
        }
        for (int i = 1; i < 13; i++) {
            //pop.add(new Day(1, i , 2011), N[i]);
            pop.add(new Day(1, i, 2011), V[i]);
        }
        TimeSeriesCollection dataset = new TimeSeriesCollection();
        dataset.addSeries(pop);
        JFreeChart chart = ChartFactory.createTimeSeriesChart("Cantidad de entradas por Meses", "Fecha", "Veces", dataset, true, true, false);
        XYPlot plot = chart.getXYPlot();
        DateAxis axis = (DateAxis) plot.getDomainAxis();
        axis.setDateFormatOverride(new SimpleDateFormat("dd-MM-yy"));
        try {

            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\Meses.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
//ChartFrame frame = new ChartFrame("Gráfico Time Series", chart);
//frame.pack();
//frame.setVisible(true);
    }

    public void persona(int V[], int n) throws IOException {
        DefaultPieDataset data = new DefaultPieDataset();
        for (int i = 1; i < n; i++) {
            data.setValue("ID " + i, V[i]);
        }
        JFreeChart chart = ChartFactory.createPieChart("Grafico por entradas del personal", data, true, true, true);
//JFreeChart chart = ChartFactory.createPieChart3D("Gráfico", data, true, true, true);

        try {
            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\personas.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.out.println("Error al abrir el archivo");
        }

//ChartFrame frame = new ChartFrame("Mi primer chart", chart);
//frame.pack();
//frame.setVisible(true);
    }

    public void Entradas_Persona(int V[], String N) {
        //Crear el dataset...
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for (int i = 1; i < V.length; i++) {
            if (V[i] != 0) {
                dataset.addValue(V[i], "ID", "" + i);
            }
        }
        JFreeChart chart = ChartFactory.createBarChart(" Entradas de Todas las Personas ", "", "# Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {

            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\Todos.jpg"), chart, 1024, 800);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

    public void E_Persona(int f, String N) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        dataset.addValue(f, "" + f, "" + N);

        JFreeChart chart = ChartFactory.createBarChart(" " + N + " ", "", "# Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {

            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\Barras.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

    public void Fecha_1(int f, String N) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        dataset.addValue(f, "" + f, "" + N);

        JFreeChart chart = ChartFactory.createBarChart(" " + N + " ", "", "# Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {

            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\Fecha1.jpg"), chart, 600, 400);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

    public void Hora(int V, String r) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        dataset.addValue(V, "" + V, "N° de Entradas entre las " + r);
        JFreeChart chart = ChartFactory.createBarChart(" Todos los usuarios ", "", "N° Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\hora.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

    public void Hora_ind(int V, String r, String d) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        dataset.addValue(V, "" + V, "N° de Entradas entre las " + r);
        JFreeChart chart = ChartFactory.createBarChart(" " + d + " ", "", "N° Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\hora.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }

    public void Todo(String V, int dia, int mes, int year, int cant, String time) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        dataset.addValue(cant, "" + cant, "N° de entradas entre las " + time + " del día " + dia + " del mes " + mes + " del año " + year + " de " + V);
        JFreeChart chart = ChartFactory.createBarChart(" " + V + " ", "", "N° Entradas", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File("C:\\Users\\Wilmar\\Documents\\NetBeansProjects\\Bases_De_Datos\\web\\todo.jpg"), chart, 800, 600);
        } catch (IOException e) {
            System.err.println("Error al crear al chart.");
        }
    }
    public void TipoMaterial(ArrayList<Tipo_material> TM, String direccion) throws IOException {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for(int i=0;i<TM.size();i++){
            Tipo_material mat = TM.get(i);
            dataset.addValue(mat.getCantidad(), ""+mat.getCantidad(), ""+mat.getId());
        }
        JFreeChart chart = ChartFactory.createBarChart("Grafico por cantidad de Materiales", "", "Grafico por cantidad de Materiales", dataset, PlotOrientation.VERTICAL, true, true, false);
        try {
            ChartUtilities.saveChartAsJPEG(new File(direccion), chart, 450, 350);
        } catch (IOException e) {
            System.out.println("Error al abrir el archivo");
        }
    }

}
