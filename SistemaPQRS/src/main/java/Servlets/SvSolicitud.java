/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.SistemaPQRS.Solicitud;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Acer
 */
@WebServlet(name = "SvSolicitud", urlPatterns = {"/SvSolicitud"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SvSolicitud extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el ID de la solicitud a eliminar desde los parámetros de la URL
        int idSolicitud = Integer.parseInt(request.getParameter("id"));

        // Llamar a la función eliminarSolicitud con el ID de la solicitud
        Solicitud.eliminarSolicitud(idSolicitud);

        // Redirigir a la página principal o a donde desees después de eliminar la solicitud
        response.sendRedirect("misolicitud.jsp");

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

        Part filePart = request.getPart("archivoAdjunto");

        // Obtener el nombre del archivo
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Guardar el archivo en la carpeta "archivos"
        String uploadPath = getServletContext().getRealPath("") + File.separator + "archivos";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Check if a file was uploaded
        if (filePart != null && filePart.getSize() > 0) {
            
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                // Handle and log the exception
                System.err.println("Error uploading file: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error uploading file");
                return;
            }

            // Ruta del archivo (ruta relativa)
            String pdf = File.separator + fileName;

            // Insertar la solicitud en la base de datos
            Solicitud.crearSolicitud(idUsuario, tipoSolicitud, titulo, mensaje, pdf, fechaSolicitud);
        } else {
            // Insertar la solicitud en la base de datos sin un archivo adjunto
            Solicitud.crearSolicitud(idUsuario, tipoSolicitud, titulo, mensaje, null, fechaSolicitud);
        }

// Redirigir a una página de confirmación o a donde sea necesario
        response.sendRedirect("misolicitud.jsp");
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
