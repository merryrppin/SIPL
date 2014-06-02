/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package silab.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sipl.db.Conexion;
import sipl.db.materialDAO;
import sipl.db.reservaDAO;
import sipl.dominio.Material;
import sipl.dominio.Reserva;

/**
 *
 * @author WM
 */
public class ReservaUsuarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Conexion con = new Conexion();
        materialDAO matDAO = new materialDAO(con);
        reservaDAO resDAO = new reservaDAO(con);
        String codigo = request.getParameter("Code");
        Reserva res = resDAO.getReservaCodUsu(codigo);
        if (res != null) {
            Material mat;
            String[] materiales = res.getMat().split(";");
            out.print("<table class='table table-striped'>");
            out.print("<tr>");
            out.print("<td>");
            out.print("</td>");
            out.print("<td>");
            out.print("<label class='control-label'>Tipo de Elemento</label>");
            out.print("</td>");
            out.print("<td>");
            out.print("<label class='control-label'>Descripción del Elemento</label>");
            out.print("</td>");
            out.print("</tr>");
            for (String materiale : materiales) {
                mat = matDAO.getMaterial(Integer.parseInt(materiale));
                out.print("<tr>");
                out.print("<td>" + mat.getCodigo() + "</td>");
                out.print("<td>" + mat.getTipo_mat().getNombre() + "</td>");
                out.print("<td>" + mat.getDescripcion() + "</td>");
                out.print("</tr>");
            }
            out.print("</table>");
        } else {
            out.print("<table class='table table-striped' id='tablaMats'>");
            out.print("<tr>");
            out.print("<th><button onClick=\"return addInput('dynamicInput');\"><span class=\"glyphicon glyphicon-plus-sign\"></span></button><label class=\"control-label\">Código del Elemento</label></th>");
            out.print("<th><label class=\"control-label\">Tipo de Elemento</label></th>");
            out.print("<th><label class=\"control-label\">Descripción del Elemento</label></th>");
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td>");
            out.print("<table class=\"table table-striped\">");
            out.print("<tbody  id=\"dynamicInput\">");
            out.print("<tr>");
            out.print("<td>");
            out.print("<input type=\"text\" name=\"mat1\" id=\"mat1\" onchange=\"return getMaterial1();\">");
            out.print("</td>");
            out.print("</tr>");
            out.print("</tbody>");
            out.print("</table>");
            out.print("</td>");
            out.print("<td colspan=\"2\">");
            out.print("<table class=\"table table-striped\" id=\"materialito\">");
            out.print("<tbody>");
            out.print("<tr id=\"r1\"></tr>");
            out.print("<tr id=\"r2\"></tr>");
            out.print("<tr id=\"r3\"></tr>");
            out.print("<tr id=\"r4\"></tr>");
            out.print("<tr id=\"r5\"></tr>");
            out.print("</tbody>");
            out.print("</table>");
            out.print("</td>");
            out.print("</tr>");
            out.print("</table>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
