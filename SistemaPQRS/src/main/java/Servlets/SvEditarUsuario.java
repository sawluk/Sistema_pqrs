/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.SistemaPQRS.SistemaPQRS;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Acer
 */
@WebServlet(name = "SvEditarUsuario", urlPatterns = {"/SvEditarUsuario"})
public class SvEditarUsuario extends HttpServlet {

    SistemaPQRS conectar = new SistemaPQRS();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        //recibimos los datos del formulario
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");
        String correo = request.getParameter("correo");

        try {
            //llamamos al metodo para editar el usuario
            conectar.editarUsuario(idUsuario, cedula, nombre, correo, contrasena);
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            request.setAttribute("error", "Error al actualizar el usuario: " + e.getMessage());
        }
        // Actualizamos los datos de la sesion
        HttpSession session = request.getSession();
        session.setAttribute("idUsuario", idUsuario);
        session.setAttribute("cedula", cedula);
        session.setAttribute("nombre", nombre);
        session.setAttribute("correo", correo);
        session.setAttribute("contrasena", contrasena);

        response.sendRedirect("index.jsp?success=edited");
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
