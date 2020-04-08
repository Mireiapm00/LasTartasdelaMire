/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Mireia
 */
package p2;

import java.sql.*;
import java.util.*;

public class AccesoBD {
    
    private static AccesoBD instanciaUnica = null;
    private Connection conexionBD = null;
    
    /* Garantiza que solo hay una instancia de esta clase */
    public static AccesoBD getInstance() {
        if(instanciaUnica == null){
            instanciaUnica = new AccesoBD();
        }
        return instanciaUnica;
    }
    
    /* Conexion a la BD */
    public AccesoBD() {
        abrirConexionBD();
    }
    
    public void abrirConexionBD() {
        if(conexionBD == null){
            String nombreConexionBD = "jdbc:mysql://localhost/bdcakeshop";
            
            try {
                //root y sin clave: usuario por defecto que crea XAMPP
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexionBD = DriverManager.getConnection(nombreConexionBD, "root", "");
            }
            catch (ClassNotFoundException | SQLException e){
                System.out.println("No se ha podido conectar a la BBDD");
            }
            
        }
    }
    
    /* Funcion para comprobar; se puede quitar... */
    public boolean comprobarAcceso() {
        abrirConexionBD();
        return conexionBD != null;
    }
    
    public void cerrarConexionBD() {
        if(conexionBD != null) {
            try {
                conexionBD.close();
                conexionBD = null;
            }
            catch(Exception e) {
                System.out.println("No se ha completado la desconexion");
            }
        }
        
    }
    
    public List<ProductoBD> obtenerProductosBD() {
        abrirConexionBD();
        
        ArrayList<ProductoBD> productos = new ArrayList<>();
        
        ProductoBD producto;
        
        ResultSet resultados = null;
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            
            con = "SELECT * FROM productos";
            
            resultados = s.executeQuery(con);
            
            while (resultados.next()){
                producto = new ProductoBD(); //campos que dependeran de la consulta realizada y campos de la BBDD
                producto.setId(resultados.getInt("codigo"));
                producto.setDescripcion(resultados.getString("descripcion"));
                producto.setPrecio(resultados.getFloat("precio"));
                producto.setStock(resultados.getInt("existencias"));
                producto.setImagen(resultados.getString("imagen"));
                productos.add(producto);
                
            }
        }
        catch(Exception e) {
            System.out.println("Error ejecutando la consulta a la BBDD.");
        }
        return productos;
    }
    
}
