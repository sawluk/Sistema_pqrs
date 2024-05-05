<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file= "templates/headeradmin.jsp" %>

    
        <!-- Header-->
        <header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
            <div class="masthead-content">
                <div class="container px-5">
                    <h2> Lista de solicitudes </h2>
                </div>
            </div>
            <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
            <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
            <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
            <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
        </header>
        
        <section id="scroll">
            <div class="container px-5">

            </div>
        </section>