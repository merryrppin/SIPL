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
import sipl.db.prestamoDAO;
import sipl.dominio.Material;
import sipl.dominio.Prestamo;

/**
 *
 * @author WM
 */
public class MaterialesPrestamoServlet extends HttpServlet {

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
        prestamoDAO preDAO = new prestamoDAO(con);
        String codigo = request.getParameter("Code");
        Prestamo pre = preDAO.getPrestamoCodUsu(codigo);
        if (pre != null) {
            Material mat;
            String[] materiales = pre.getMat().split(";");
            for (String materiale : materiales) {
                mat = matDAO.getMaterial(Integer.parseInt(materiale));
                out.print("<tr>");
                out.print("<td>" + mat.getCodigo() + "</td>");
                out.print("<td>" + mat.getTipo_mat().getNombre() + "</td>");
                out.print("<td>" + mat.getDescripcion() + "</td>");
                out.print("</tr>");
            }
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
