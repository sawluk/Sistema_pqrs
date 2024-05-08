/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistema_pqrs.Solicitud;
import com.mycompany.sistema_pqrs.Solicitud;
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
@WebServlet(name = "SvSolicitud", urlPatterns = {"/SvSolicitud"})
public class SvSolicitud extends HttpServlet {

    Solicitud p = new Solicitud();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el ID de la solicitud a eliminar desde los parámetros de la URL
        int idSolicitud = Integer.parseInt(request.getParameter("id"));

        // Llamar a la función eliminarSolicitud con el ID de la solicitud
        Solicitud.eliminarSolicitud(idSolicitud);

        // Redirigir a la página principal o a donde desees después de eliminar la solicitud
        response.sendRedirect("solicitud.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String mensaje = request.getParameter("mensaje");
        int tipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        LocalDateTime fechaSolicitud = LocalDateTime.now();
        String rutaArchivo = ""; // Aquí puedes agregar lógica para manejar el archivo adjunto si es necesario

        System.out.println(titulo);
        System.out.println(mensaje);
        System.out.println(tipoSolicitud);
        System.out.println(idUsuario);

        // Insertar la solicitud en la base de datos
        Solicitud.crearSolicitud(idUsuario, tipoSolicitud, titulo, mensaje, rutaArchivo, fechaSolicitud);

        // Redirigir a una página de confirmación o a donde sea necesario
        response.sendRedirect("usuario.jsp");

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
