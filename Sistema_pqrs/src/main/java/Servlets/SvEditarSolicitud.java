/*

 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license

 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template

 */

package Servlets;


import com.mycompany.sistema_pqrs.Solicitud;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

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

@WebServlet(name = "SvEditarSolicitud", urlPatterns = {"/SvEditarSolicitud"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB

public class SvEditarSolicitud extends HttpServlet {


    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));
        
        int p_TipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));

        String titulo = request.getParameter("titulo");

        String mensaje = request.getParameter("mensaje");


        String estado = request.getParameter("estado");

        String respuesta = request.getParameter("respuesta");

        int tipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));
        
        // Verificar si se ha adjuntado un nuevo archivo
        Part filePart = request.getPart("archivo");
        String rutaArchivo = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Obtener el nombre del archivo
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

            // Guardar el archivo en la carpeta "archivos"
            String uploadPath = getServletContext().getRealPath("") + File.separator + "archivos";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // Ruta del archivo (ruta relativa)
            rutaArchivo = File.separator + fileName;
        } else {
            // Si no se ha adjuntado un nuevo archivo, utilizar la ruta del archivo anterior
            rutaArchivo = request.getParameter("rutaArchivoAnterior");
        }

        // Llamar a la función editarSolicitud
       Solicitud.editarSolicitud(idSolicitud, titulo, mensaje, rutaArchivo, estado, respuesta, p_TipoSolicitud);

        // Redirigir a la página de inicio o mostrar un mensaje de éxito
        response.sendRedirect("MisSolicitudes.jsp"); // o mostrar un mensaje de éxito


        Solicitud.editarSolicitud(idSolicitud, titulo, mensaje, rutaArchivo, estado, respuesta, tipoSolicitud);


        response.sendRedirect("solicitud.jsp"); // Redirect to the index page after editing the solicitud

    }

}