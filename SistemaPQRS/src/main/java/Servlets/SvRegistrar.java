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

/**
 *
 * @author Acer
 */
@WebServlet(name = "SvRegistrar", urlPatterns = {"/SvRegistrar"})
public class SvRegistrar extends HttpServlet {

    SistemaPQRS conectar = new SistemaPQRS();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        System.out.println(idUsuario);
        //llamar al metodo para eliminar el usuario de la base de datos
        conectar.eliminarUsuario(idUsuario);
        request.getSession().invalidate();
        response.sendRedirect("index.jsp?success=deleted");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Recibir los parámetros del formulario
            String cedula = request.getParameter("cedula");
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");

            // Verificar si la cédula ya está registrada
            boolean valCedula = conectar.cedulaRegistrada(cedula);

            if (valCedula) {
                // Redirigir a la página de inicio con un parámetro de error
                response.sendRedirect("index.jsp?error=true");
                return;
            }

            // Llamamos al método para registrar al usuario en la base de datos
            conectar.registrarUsuario(cedula, nombre, correo, contrasena);

            // Redirigir a la página de inicio con un parámetro de éxito
            response.sendRedirect("index.jsp?success=true");
        } catch (Exception e) { // Manejar cualquier excepción
            e.printStackTrace(); // Esto imprimirá la traza de la excepción en la consola del servidor
            // Puedes manejar el error de otra manera, como mostrar un mensaje de error en la página
            response.getWriter().println("Error al agregar el usuario. Por favor, inténtelo de nuevo.");
            response.sendRedirect("index.jsp?success=false");
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
