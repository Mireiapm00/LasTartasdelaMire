package p2;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.json.stream.JsonParser;
import javax.json.stream.JsonParser.Event;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        
        System.out.println(carritoJSON);
        
        if(jobj.size()> 0){
            JsonParser jsonParser = Json.createParser(new StringReader(carritoJSON));
            
            while(jsonParser.hasNext()){
                Event e = jsonParser.next();
                
                if(e == Event.KEY_NAME){
                    indice = jsonParser.getString();
                                        
                    if(indice.contains("id_producto")){
                        ProductoBD nuevo = new ProductoBD();
                        JsonObject prod = jobj.getJsonObject(indice);
                        
                        nuevo.setId(Integer.parseInt(prod.get("id_producto").toString()));
                        nuevo.setNombre(prod.get("nombre").toString());
                        nuevo.setPrecio(Float.parseFloat(prod.get("precio").toString()));
                        nuevo.setStock(Integer.parseInt(prod.get("stock").toString()));
                        
                        carrito.add(nuevo);
                        System.out.println(carrito);
                    }
                }
            }
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
