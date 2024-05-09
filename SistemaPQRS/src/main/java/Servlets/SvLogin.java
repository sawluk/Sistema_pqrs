/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import com.mycompany.SistemaPQRS.SistemaPQRS;
import java.io.IOException;
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

    SistemaPQRS conectar = new SistemaPQRS();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Obtener la sesión actual sin crear una nueva si no existe

        if (session != null) {
            session.invalidate(); // Invalidar la sesión actual
        }

        // Redirigir a la página de inicio
        response.sendRedirect("index.jsp");
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    String cedula = request.getParameter("cedula");
    String contrasena = request.getParameter("contrasenia");

    // Llamar al método obtenerInformacionUsuario
    String[] informacionUsuario = conectar.ingresar(cedula, contrasena);
    
    if (informacionUsuario != null) {
            // Si las credenciales son válidas, almacenar el id, rol y nombre en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("idUsuario", informacionUsuario[0]); // El id está en la posición 0// El rol está en la posición 1
            session.setAttribute("nombre", informacionUsuario[2]); // El nombre está en la posición 2
            
            String rol = informacionUsuario[1];
            if(rol.equals("Usuario")){
                // Redirigir a la página de inicio
            response.sendRedirect("usuario.jsp");
            }else{
                response.sendRedirect("admin.jsp");
            }

            
        } else {
            // Si las credenciales no son válidas, redirigir de vuelta al formulario de inicio de sesión con un mensaje de error
            response.sendRedirect("index.jsp?errorP=true");
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
