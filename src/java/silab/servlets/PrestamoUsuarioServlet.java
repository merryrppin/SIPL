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
import sipl.db.prestamoDAO;
import sipl.db.usuarioDAO;
import sipl.dominio.Prestamo;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class PrestamoUsuarioServlet extends HttpServlet {

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
        String codigo = request.getParameter("Code");
        Conexion con = new Conexion();
        prestamoDAO preDAO = new prestamoDAO(con);
        usuarioDAO usuDAO = new usuarioDAO(con);
        Usuario usu = usuDAO.getUsuario(codigo);
        Prestamo pre = preDAO.getPrestamoCodUsu(codigo);
        if (usu != null) {
            if (pre == null) {
                out.print("<b>" + usu.getNombre() + " " + usu.getApellido() + " identificado con el código "
                        + usu.getCodigo() + " no tiene préstamos activos" + "</b>");
            } else {
                out.print("<font color=\"red\"><b>" + usu.getNombre() + " " + usu.getApellido() + " identificado con el código "
                        + usu.getCodigo() + " tiene un préstamo que aún no ha regresado</b></font>");
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
