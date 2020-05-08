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
    
    public boolean modificarUsuarioBD(String[] datos, int id, String direccion){
        abrirConexionBD();
        
        boolean ok = false;
        try{
            String con;
            Statement s = conexionBD.createStatement();
            if(direccion == null){
                con = "UPDATE usuarios SET nombre=\"" + datos[0] + "\", apellidos=\"" + datos[1] +
                        "\", tlf=\"" + datos[2] + "\", poblacion=\"" + datos[3] + "\", provincia=\"" + datos[4] +
                         "\", cp=\"" + datos[5] + "\", password=\"" + datos[6] + "\", usuario=\"" + datos[7] + 
                        "\", domicilio=\"" + datos[8] + "\", tarjeta=\"" + datos[9] + "\" WHERE id=" + id + ";"; 
            }else{
                con = "UPDATE usuarios SET  poblacion=\"" + datos[3] + "\", provincia=\"" + datos[4] +
                         "\", cp=\"" + datos[5] + "\", domicilio=\"" + datos[8] + "\" WHERE id=" + id + ";";
            }
            s.executeUpdate(con);
            ok = true;
        }catch(Exception e){
            System.out.println("Error al completar la consulta.");
        }
        
        return ok;
    }
    
    public boolean registrarUsuarioBD(String[] datos) {
        abrirConexionBD();
        boolean ok = false;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO usuarios(nombre, apellidos, tlf, poblacion, provincia, cp, password, usuario, domicilio, tarjeta)"
                    + " VALUES (\"" + datos[0] + "\",\"" + datos[1] + "\", " + datos[2] + ",\"" + datos[3] + "\", \"" 
                    + datos[4] + "\", " + datos[5] + ",\"" + datos[6] + "\", \""  + datos[7] + "\",\""
                    + datos[8] + "\", \"" + datos[9] + "\")";
            
            s.executeUpdate(con);
            ok = true;

        }catch(SQLException e){
            System.out.println("Error al insertar en la BBDD");
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
                    + poblacion + "\", " + cp + ", \"" + tipo_pago + "\" ,\"" + tarjeta + "\", \"" + estado + "\");";
            s.executeUpdate(con);
            ok = true;
        }
        catch(SQLException e){
            System.out.println("Error al insertar en la BBDD");
        }
        
        return ok;
    }
    
    public boolean registrarDetallePedidoBD(int id_pedido, int id_producto, int unidades, float precio_unitario){
        boolean ok = false;
        abrirConexionBD();
        
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "INSERT INTO detalles_pedido(id_pedido, id_producto, unidades, precio_unitario)"
                    + "VALUES (" + id_pedido + ", " + id_producto + ", " + unidades + ", " + precio_unitario + ");";
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
    
    public ResultSet obtenerDetallesPedidoBD(int id_pedido){
        abrirConexionBD();

        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT * FROM detalles_pedido WHERE id_pedido=" + id_pedido + ";";
            resultados = s.executeQuery(con);
        }
        catch(Exception e){
            System.out.println("Error al completar la consulta");
        }
                
        return resultados;
        
    }
    
    public boolean eliminarPedidoUsuarioBD(String estado, int id_pedido){
        abrirConexionBD();
        boolean ok =false;
        ResultSet resultados = null;
        ArrayList<Integer> list = new ArrayList<Integer>();
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "UPDATE pedidos SET estado=\"" + estado + "\" WHERE id_pedido=" + id_pedido + ";";
            s.executeUpdate(con);
            if(estado.equals("Cancelado")){
                con = "SELECT id_producto, unidades FROM detalles_pedido dp INNER JOIN pedidos p ON dp.id_pedido = p.id_pedido WHERE p.id_pedido=" + id_pedido + ";";
                resultados = s.executeQuery(con);
                while(resultados.next()){
                    list.add(resultados.getInt("id_producto"));
                    list.add(resultados.getInt("unidades"));
                }
                
                for(int i = 0; i < list.size(); i = i + 2 ){
                    con = "UPDATE productos SET stock = stock + " + list.get(i + 1)
                            + " WHERE id_producto= " + list.get(i) + ";";
                    s.executeUpdate(con);
                }
            }
            ok = true;

        }
        catch(Exception e){
            System.out.println("Error al actualizar la BBDD");
        }
        
        return ok;
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
    
    int obtenerIdUltimoPedidoBD() throws SQLException {
        abrirConexionBD();

        int id_pedido = 0;
        ResultSet resultados = null;
        try {
            String con;
            Statement s = conexionBD.createStatement();
            con = "SELECT id_pedido FROM pedidos ORDER BY id_pedido desc LIMIT 1;";
            resultados = s.executeQuery(con);
        }
        catch(Exception e){
            System.out.println("Error al completar la consulta");
        }
        
        if(resultados != null){
            resultados.next();
            id_pedido = resultados.getInt("id_pedido");
        }
                
        return id_pedido;
    }
    
}


