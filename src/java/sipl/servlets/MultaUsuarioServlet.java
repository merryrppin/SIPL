/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sipl.db.Conexion;
import sipl.db.multaDAO;
import sipl.db.usuarioDAO;
import sipl.dominio.Multa;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class MultaUsuarioServlet extends HttpServlet {

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
        multaDAO mulDAO = new multaDAO(con);
        usuarioDAO usuDAO = new usuarioDAO(con);
        Usuario usu = usuDAO.getUsuario(codigo);
        Multa mul = mulDAO.getMultaUsu(codigo);
        if (usu != null) {
            if (mul == null) {
                out.print("<b>" + usu.getNombre() + " " + usu.getApellido() + " identificado con el código "
                        + usu.getCodigo() + " no tiene multas activas" + "</b>");
            } else {
                Calendar cal1 = mul.getFecha_multa();
                long tiempo2 = cal1.getTimeInMillis();
                tiempo2 += 259200000;
                Calendar cal2 = Calendar.getInstance();
                cal2.setTimeInMillis(tiempo2);
                int mes = cal2.get(Calendar.MONTH);
                mes++;
                out.print("<font color=\"red\"><b>" + usu.getNombre() + " " + usu.getApellido() + " identificado con el código "
                        + usu.getCodigo() + " tiene una multa que caducara el " + cal2.get(Calendar.YEAR)
                        + "/" + mes + "/" + cal2.get(Calendar.DAY_OF_MONTH) + " "
                        + cal2.get(Calendar.HOUR_OF_DAY) + ":" + cal2.get(Calendar.MINUTE)
                        + ":" + cal2.get(Calendar.SECOND) + "</b></font>");
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
