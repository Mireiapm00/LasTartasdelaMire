/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var carrito = null;
var canti = 0;  

function borrarCarrito(){
    localStorage.removeItem("carrito");
}

function actualizarCarrito() {
    localStorage.clear();
    localStorage.setItem("carrito", JSON.stringify(carrito));
}

function cargaInicialCarrito() {
    carrito = JSON.parse(localStorage.getItem("carrito"));
    canti = 0;
    
    if(carrito === null){
        carrito = new Object();
    }    
    else {
        var p;
        for(p in carrito){
            canti += carrito[p].cantidad;
        }
    }
    document.getElementById('carrito').innerHTML = " (" + canti + ")";
}

function devuelveCantidadTotalCarrito() {
    var total = 0, p;
    for(p in carrito){
        total += carrito[p].cantidad;
    }
    return total;
}

function anadirProductoCarrito (id_producto, nombre, precio, imagen, stock, descripcion) {

    var p, encontrado = 0;
    for(p in carrito){
        if(p === id_producto) {
            encontrado = 1;
            carrito[p].cantidad++;
        }
    }

    if(encontrado === 0){
        var product = new Object();
        product.id_producto = id_producto;   
        product.nombre = nombre;
        product.precio = precio;
        product.cantidad = 1;
        product.imagen = imagen;
        product.stock = stock;
        console.log(stock);
        product.descripcion = descripcion;

        carrito[id_producto] = product;
    }
    canti++;
    actualizarCarrito();
        
    document.getElementById('carrito').innerHTML = " (" + canti + ")";
}

function mostrarContenidoCarritoTable(){
    var html = "", i = 0, p;
        
    if(canti !== 0){
        html += "<thead><tr><th>Descripción</th><th>Unidades</th><th>Precio Unitario</th><th>Modificar Cantidad</th></tr></thead>";
        
        for(p in carrito){
            html += "<tr>";
            html += "<td>" + carrito[p].nombre + "</td>";
            html += "<td id='cantidad" +i+ "'> "+ carrito[p].cantidad + "</td>";
            html += "<td>" + carrito[p].precio + "</td>";
            html += "<td><input class=\"button1\" type='button' value='-' id='fila" + i + "' onclick='modificarCantidad(\"-\", \"" + p + "\")'><input class=\"button1\" type='button' value='+' onclick='modificarCantidad(\"+\", \"" + p + "\")'><input class=\"button1\" type='button' value='x' onclick='eliminarFila(this, \"" + p + "\")'></td>";
            html += "</tr>";
            i++;
        }
        
        html += "<tfoot>";
        html += "<tr>";
        html += "<td colspan='4' class='alineado'>";
        html += "<a onclick=\"Cargar('productos.jsp','cuerpo')\" class=\"button1\">Continuar comprando</a>";
        html += "<a onclick=\"ProcesarCarrito(carrito,'ProcesarPedido','cuerpo')\" class=\"button1\">Formalizar pedido</a>";
        html += "<form method=\"post\" onsubmit=\"ProcesarForm(this, 'CerrarSesion', 'cuerpo');return false\">";
        html += "<input type=\"submit\" class=\"button1\" value=\"Cerrar sesión\">";
        html += "</form>";
        html += "</td>";
        html += "</tr></tfoot>";
        
    }else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
    }
        
    return html;
}

function crearProductosCarritoPage (){
    var html = "";
    
    if(canti !== 0){
        html += mostrarContenidoCarritoTable();
    }
    else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
    }
    
    document.getElementById("carritoTable").innerHTML = html;
    document.getElementById("carrito").innerHTML = " (" + canti + ")";
    
}


function eliminarFila(row, id_producto) {
    var i = row.parentNode.parentNode.rowIndex;
    document.getElementById("carritoTable").deleteRow(i);
    //elimina el objeto
    delete carrito[id_producto];
    actualizarCarrito();
    
    //modifica la cantidad y Carrito menu
    canti = devuelveCantidadTotalCarrito();
    document.getElementById("carrito").innerHTML = " (" + canti + ")";
    
}

function modificarCantidad(tipo, id_producto) {
    var p;
        
    for(p in carrito){
        if(p === id_producto.toString()) {
            
            if(tipo.toString() === "-"){
                carrito[p].cantidad--;
                canti--;
                                
                if(parseInt(carrito[p].cantidad) === 0){
                    delete carrito[p];
                }
                
            }
            else {
                
                if(tipo.toString() === "+") {
                    carrito[p].cantidad++;
                    canti++;
                }
                else {
                    if(tipo.toString() === "x"){
                        delete(carrito[p]);
                        canti = devuelveCantidadTotalCarrito();
                    }
                }
            }
            break;            
        }
    }
    
    actualizarCarrito();
    crearProductosCarritoPage();
}
