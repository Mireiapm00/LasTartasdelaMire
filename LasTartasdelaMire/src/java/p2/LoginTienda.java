/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p2;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mireia
 */
public class LoginTienda extends HttpServlet {

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
        
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
                
        HttpSession sesion = request.getSession(true);
        
        AccesoBD con = AccesoBD.getInstance();
        
        if((usuario != null) && (clave != null)){
            
            if(con.comprobarUsuarioBD(usuario, clave)){
                sesion.setAttribute("usuario", usuario);
                response.sendRedirect("op_usuario.jsp");
            }
            else { //usuario/clave no existe en BD
                if(con.comprobarUsuarioAdminBD(usuario, clave)){
                    sesion.setAttribute("admin", usuario);
                    //response.sendRedirect("enviar a la pagina de administrador");
                }
                else {
                    sesion.setAttribute("mensaje", "Usuario y/o clave incorrectos");
                    response.sendRedirect("usuario_login.jsp");
                }
                
            }
        }
        else {
            sesion.setAttribute("mensaje", "Falta introducir el usuario o la clave");
        }
        //response.sendRedirect("usuario_login.jsp");
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
