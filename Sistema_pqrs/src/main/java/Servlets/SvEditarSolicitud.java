/*

 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license

 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template

 */

package Servlets;


import com.mycompany.sistema_pqrs.Solicitud;
import java.io.IOException;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


/**

 *

 * @author Acer

 */

@WebServlet(name = "SvEditarSolicitud", urlPatterns = {"/SvEditarSolicitud"})

public class SvEditarSolicitud extends HttpServlet {


    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        int idSolicitud = Integer.parseInt(request.getParameter("idSolicitud"));

        String titulo = request.getParameter("titulo");

        String mensaje = request.getParameter("mensaje");

        String rutaArchivo = request.getParameter("archivo");

        String estado = request.getParameter("estado");

        String respuesta = request.getParameter("respuesta");

        int tipoSolicitud = Integer.parseInt(request.getParameter("tipoSolicitud"));


        Solicitud.editarSolicitud(idSolicitud, titulo, mensaje, rutaArchivo, estado, respuesta, tipoSolicitud);


        response.sendRedirect("solicitud.jsp"); // Redirect to the index page after editing the solicitud

    }

}