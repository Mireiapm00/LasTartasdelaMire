/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p2;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author arant
 */
public class ModificarDatosUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AccesoBD con = new AccesoBD();
        HttpSession sesion = request.getSession(true);
        
        String direccion = (String) sesion.getAttribute("origen_resguardo");
        //String bmodificar = (String) request.getParameter("bModificar");
        
        String[] datos = new String[10];
        int id = (int)sesion.getAttribute("id_usuario");
         

        if(direccion != null)
        {
            for(int i = 3; i < 6; i++)
                datos[i] = request.getParameter("c" + i);
            datos[8] = request.getParameter("c" + 8);
            con.modificarUsuarioBD(datos, id, direccion);
            response.sendRedirect(direccion);
            
        }
        else
        {
            for(int i = 0; i < 10; i++)
                datos[i] = request.getParameter("c" + i);
            
            con.modificarUsuarioBD(datos, id, direccion);
            response.sendRedirect("op_usuario.jsp");
            
        }
       
        
    }

     

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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
