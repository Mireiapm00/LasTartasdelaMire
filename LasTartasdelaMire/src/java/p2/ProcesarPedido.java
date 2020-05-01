package p2;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.StringReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.json.stream.JsonParser;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mireia
 */
public class ProcesarPedido extends HttpServlet {

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
        List <ProductoBD> carrito = new ArrayList();
        String carritoJSON = request.getParameter("carrito");
        String indice;
        JsonReader jsonReader = Json.createReader(new StringReader(carritoJSON));
        JsonObject jobj = jsonReader.readObject();
                
        if (jobj.size() > 0) {
            JsonParser jsonParser = Json.createParser(new StringReader(carritoJSON));
            while (jsonParser.hasNext()) {
                JsonParser.Event e = jsonParser.next();
                if (e == JsonParser.Event.KEY_NAME) {
                    {
                        indice = jsonParser.getString();
                        
                        if (!indice.equals("id_producto") && !indice.equals("nombre") && !indice.equals("cantidad") && !indice.equals("precio")
                                && !indice.equals("imagen") && !indice.equals("descripcion") && !indice.equals("stock")){
                            ProductoBD nuevo = new ProductoBD();
                            JsonObject prod = jobj.getJsonObject(indice);

                            nuevo.setId(Integer.parseInt(indice));
                            nuevo.setNombre(prod.get("nombre").toString());
                            nuevo.setDescripcion(prod.get("descripcion").toString());
                            nuevo.setStock((int)10);
                            nuevo.setPrecio((float)100.0);
                            nuevo.setCantidad(Integer.parseInt(prod.get("cantidad").toString()));
                            nuevo.setImagen(prod.get("imagen").toString());
                            carrito.add(nuevo);
                        }
                    }
                }
            }
        }
        
        
        HttpSession sesion = request.getSession(true);
        sesion.setAttribute("carrito", carrito);
        String usuario = (String) sesion.getAttribute("usuario");
        
        AccesoBD con = new AccesoBD();
        boolean ok = true;
        
        for(ProductoBD p: carrito){
            try {
                if(p.getCantidad() > con.obtenerStockProductoBD(p.getId())){
                    ok = false;
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProcesarPedido.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if(ok){
            if(usuario != null)
                response.sendRedirect("resguardo.jsp");
            else {
                response.sendRedirect("usuario_login.jsp");
            }
        }
        else {
            sesion.setAttribute("mensajeProducto", "Algunos productos del carrito están agotados");
            response.sendRedirect("carrito.jsp");
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

/*
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
/*            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println(jobj);
            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
        }*/