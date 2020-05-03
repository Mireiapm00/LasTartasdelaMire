package p2;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mireia
 */
public class Tramitacion extends HttpServlet {

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
                
        HttpSession sesion = request.getSession(true);
        List<ProductoBD> carrito = (List<ProductoBD>) sesion.getAttribute("carrito");
        
        String tipo_pago = (String) request.getParameter("formaPago");
        
        int idUsuario = (int) sesion.getAttribute("idUsuario");
        String direccion_envio = (String) sesion.getAttribute("direccion_envio");
        String poblacion = (String) sesion.getAttribute("poblacion");
        int cp = (int) sesion.getAttribute("cp");
        float importe_total = (float) sesion.getAttribute("importe");
        Date d = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/YYYY");
        String fecha = dateFormat.format(d);
        String tarjeta = "_";
        
        if(tipo_pago.equals("tarjeta")){
            tarjeta = (String) sesion.getAttribute("tarjeta");
        }
        
        AccesoBD con = new AccesoBD();
        
        if(!con.registrarPedidoBD(idUsuario, fecha, importe_total, direccion_envio, poblacion, cp, tipo_pago, tarjeta, "Tramitado")){
            response.sendError(5005, "Error al registrarPedido en la BD");
        }
        sesion.setAttribute("estadoPedido", "tramitado");
       
        
        /* quitar el stock de producto de la BD */
        int stock;
        
        try {
            for(ProductoBD p : carrito){
                stock = con.obtenerStockProductoBD(p.getId());
                stock -= p.getCantidad();
                con.actualizarStockProductoBD(p.getId(), stock); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(Tramitacion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        sesion.removeAttribute("formaPago");
        sesion.removeAttribute("idUsuario");
        sesion.removeAttribute("direccion_envio");
        sesion.removeAttribute("poblacion");
        sesion.removeAttribute("cp");
        sesion.removeAttribute("tarjeta");
        sesion.removeAttribute("importe");
        
        response.sendRedirect("pedidoFinalizado.jsp");
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
