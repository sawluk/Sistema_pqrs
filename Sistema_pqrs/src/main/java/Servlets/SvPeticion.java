/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistema_pqrs.Peticiones;
import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Acer
 */
@WebServlet(name = "SvPeticion", urlPatterns = {"/SvPeticion"})
public class SvPeticion extends HttpServlet {
    

    Peticiones p = new Peticiones();
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
        
        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String mensaje = request.getParameter("mensaje");
        int idtipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));
        int idusuario = Integer.parseInt(request.getParameter("idUsuario"));
        LocalDateTime fechaSolicitud = LocalDateTime.now();
        String rutaArchivo = ""; // Aquí puedes agregar lógica para manejar el archivo adjunto si es necesario

        p.almacenarDatosSolicitud(idusuario, idtipoSolicitud, titulo, mensaje, rutaArchivo , fechaSolicitud);
        
        //response.sendRedirect("peticiones.jsp?success=true");
   
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
