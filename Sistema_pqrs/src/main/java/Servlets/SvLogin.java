/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistema_pqrs.Sistema_PQRS;
import com.mycompany.sistema_pqrs.Sistema_PQRS.NombreYRolUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    Sistema_PQRS conectar = new Sistema_PQRS();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cedula = request.getParameter("cedula");
        String contrasena = request.getParameter("contrasenia");
        

        // Obtener la información del usuario
    NombreYRolUsuario informacionUsuario = conectar.obtenerInformacionUsuario(cedula, contrasena);

    // Acceder al nombre y al rol del usuario
    String nombre = informacionUsuario.getNombre();
    String rol = informacionUsuario.getRol();

    // Establecer el nombre del usuario en la sesión
    request.getSession().setAttribute("nombreu", nombre);

// Redirigir al usuario según su rol
if (rol.equals("Admin")) {
    // Redirigir al usuario a la página de administrador
    response.sendRedirect("admin.jsp");
} else if (rol.equals("Usuario")) {
    // Redirigir al usuario a la página de usuario 
    response.sendRedirect("usuario.jsp");
} else {
    // Mostrar un mensaje de error o manejar de otra manera según corresponda
    response.getWriter().println(rol);
    response.sendRedirect("index.jsp");
}

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
