/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sipl.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sipl.db.Conexion;
import sipl.db.usuarioDAO;
import sipl.dominio.Usuario;

/**
 *
 * @author WM
 */
public class UsuarioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UsuarioServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Conexion con = new Conexion();
        usuarioDAO usuDAO = new usuarioDAO(con);
        Usuario usu = usuDAO.getUsuario("U00061264");
        Gson gson = new Gson();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
