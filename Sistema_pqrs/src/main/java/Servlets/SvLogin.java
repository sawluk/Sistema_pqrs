/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.sistema_pqrs.Sistema_PQRS;
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

    // Llamar al método obtenerInformacionUsuario
    String[] informacionUsuario = conectar.obtenerInformacionUsuario(cedula, contrasena);
    
    if (informacionUsuario != null) {

        // Si las credenciales son válidas, almacenar el id, rol y nombre en la sesión
        HttpSession session = request.getSession();
        session.setAttribute("idusuario", informacionUsuario[0]);
        session.setAttribute("nombreu", informacionUsuario[1]);

        // Obtener el rol del usuario desde informacionUsuario
        String rol = informacionUsuario[2];

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
    } else {
        // Si las credenciales no son válidas, redirigir de vuelta al formulario de inicio de sesión con un mensaje de error
        response.sendRedirect("index.jsp?errorP=true"); // Puedes redirigir a una página de error o al formulario de inicio de sesión nuevamente
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
