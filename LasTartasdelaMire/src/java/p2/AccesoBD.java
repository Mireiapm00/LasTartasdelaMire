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
                producto.setId(resultados.getInt("id_producto"));
                producto.setNombre(resultados.getString("nombre"));
                producto.setDescripcion(resultados.getString("descripcion"));
                producto.setPrecio(resultados.getFloat("precio"));
                producto.setStock(resultados.getInt("stock"));
                producto.setImagen(resultados.getString("imagen"));
                productos.add(producto);
                
            }
        }
        catch(Exception e) {
            System.out.println("Error ejecutando la consulta a la BBDD.");
        }
        return productos;
    }

    boolean comprobarUsuarioBD(String usuario, String clave) {
        abrirConexionBD();
        
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT * FROM `usuarios` WHERE usuario='" + usuario + "' and password='" + clave + "'";
            resultados = s.executeQuery(con);
            if(resultados.next()){
                return true;
            }
            else {
                return false;
            }
        }
        catch(Exception e){
            System.out.println("No se ha completado la petición");
            return false;
        }
    }
    
    
    public List<UsuarioBD> obtenerUsuariosGestionBD(){
        abrirConexionBD();
        
        ArrayList<UsuarioBD> usuarios = new ArrayList<>();
        UsuarioBD usuario;
        
        ResultSet resultados = null;
        
        try{
            String con;
            Statement s = conexionBD.createStatement();
            
            con = "SELECT usuario, password FROM usuarios";
            resultados = s.executeQuery(con);
            
            while(resultados.next()){
                usuario = new UsuarioBD();
                usuario.setPassword(resultados.getString("password"));
                usuario.setUsuario(resultados.getString("usuario"));
                usuarios.add(usuario);
            }
        }
        catch(Exception e){
            System.out.println("Error ejecutando la consulta a la BBDD.");
        }
        
        return usuarios;
    }
        
    boolean comprobarUsuarioAdminBD(String usuario, String clave) {
        abrirConexionBD();
        
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT * FROM administracion WHERE usuario='" + usuario + "' and password='" + clave + "'";
            resultados = s.executeQuery(con);
            if(resultados.next()){
                return true;
            }
            else {
                return false;
            }
        }
        catch(Exception e){
            System.out.println("No se ha completado la petición");
            return false;
        }
    }
    
    public ResultSet obtenerUsuarioBD(String usuario){
        abrirConexionBD();

        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT * FROM usuarios WHERE usuario=\"" + usuario + "\"";
            resultados = s.executeQuery(con);
        }
        catch(Exception e){
            System.out.println("Error al completar la consulta");
        }
                
        return resultados;
    }
    
    public boolean modificarUsuarioBD(String[] datos, int id){
        abrirConexionBD();
        
        boolean ok = false;
        try{
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE usuarios SET nombre=\"" + datos[0] + "\", apellidos=\"" + datos[1] +
                    "\", tlf=\"" + datos[2] + "\", poblacion=\"" + datos[3] + "\", provincia=\"" + datos[4] +
                     "\", cp=\"" + datos[5] + "\", password=\"" + datos[6] + "\", usuario=\"" + datos[7] + 
                    "\", domicilio=\"" + datos[8] + "\", tarjeta=\"" + datos[9] + "\" WHERE id=" + id + ";"; 
            s.executeUpdate(con);
            ok = true;
        }catch(Exception e){
            System.out.println("Error al completar la consulta.");
        }
        
        return ok;
    }

    int obtenerStockProductoBD(int id) throws SQLException {
        abrirConexionBD();
        int stock = 0;
        
        ResultSet resultados = null;
        try{
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT stock FROM productos WHERE id_producto=" + id + ";";
            resultados = s.executeQuery(con);
        }
        catch (Exception e){
            System.out.println("Error al completar la consulta");
        }
        
        if(resultados != null){
            resultados.next();
            stock = resultados.getInt("stock");
        }
        
        return stock;
    }

    public boolean registrarPedidoBD(int idUsuario, String fecha, float importe_total, String direccion_envio, 
            String poblacion, int cp, String tipo_pago, String tarjeta, String estado) {
        boolean ok = false;
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO pedidos(usuario, fecha, importe, direccion_envio, poblacion, codigo_postal, tipo_pago, numero_tarjeta, estado)"
                    + " VALUES (" + idUsuario + ",STR_TO_DATE('" + fecha + "', '%d/%m/%Y')," + importe_total + ", \"" + direccion_envio + "\", \"" 
                    + poblacion + "\", " + cp + ", \"" + tipo_pago + "\" ,\"" + tarjeta + "\", \"" + estado + "\")";
            s.executeUpdate(con);
            ok = true;
        }
        catch(SQLException e){
            System.out.println("Error al insertar en la BBDD");
        }
        
        return ok;
    }

    public void actualizarStockProductoBD(int id, int stock) {
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE productos SET stock = " + stock + " WHERE id_producto=" + id + ";";
            s.executeUpdate(con);
        }
        catch(Exception e){
            System.out.println("Error al actualizar la BBDD");
        }        
    }
    
    
    public ResultSet obtenerPedidosUsuarioBD(int id){
        abrirConexionBD();

        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_pedido, fecha, importe, estado FROM pedidos WHERE usuario=" + id + ";";
            resultados = s.executeQuery(con);
        }
        catch(Exception e){
            System.out.println("Error al completar la consulta");
        }
                
        return resultados;
    }
    
    public ResultSet obtenerUltimoPedidoBD() {
        abrirConexionBD();

        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT * FROM pedidos ORDER BY id_pedido desc LIMIT 1;";
            resultados = s.executeQuery(con);
        }
        catch(Exception e){
            System.out.println("Error al completar la consulta");
        }
                
        return resultados;
    }
    
}


