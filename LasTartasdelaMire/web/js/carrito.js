/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var carrito = null;
var canti = 0;  


function actualizarCarrito() {
    localStorage.clear();
    localStorage.setItem("carrito", JSON.stringify(carrito));
    
    /*console.log("ACTUALIZA: ");
    for(p in carrito){
        console.log("ID: " + carrito[p].id_producto + " NOMBRE: " + carrito[p].nombre + " CANTIDAD: " + carrito[p].cantidad);
    }*/
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

function anadirProductoCarrito (id_producto, nombre, precio) {

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

        carrito[id_producto] = product;
    }
    canti++;
    actualizarCarrito();
    
    document.getElementById('carrito').innerHTML = " (" + canti + ")";
}

function mostrarContenidoCarritoTable(){
    var html = "", i = 0, p;
    
    //html += "<table>";Q
    
    if(canti !== 0){
        html += "<thead><tr><th>Descripción</th><th>Unidades</th><th>Precio</th><th>Modificar Cantidad</th></tr></thead>";
        
        for(p in carrito){
            html += "<tr>";
            html += "<td>" + carrito[p].nombre + "</td>";
            html += "<td id='cantidad" +i+ "'> "+ carrito[p].cantidad + "</td>";
            html += "<td>" + carrito[p].precio + "</td>";
            html += "<td><input class=\"button1\" type='button' value='-' id='fila" + i + "' onclick='modificarCantidad(\"-\", \"" + p + "\")'><input class=\"button1\" type='button' value='+' onclick='modificarCantidad(\"+\", \"" + p + "\")'><input class=\"button1\" type='button' value='x' onclick='eliminarFila(this, \"" + p + "\")'></td>";
            html += "</tr>";
            i++;
            //canti = canti + carrito[p].cantidad;Q
        }
        
        html += "<tfoot>";
        html += "<tr>";
        html += "<td colspan='4' class='alineado'>";
        html += "<a onclick=\"Cargar('productos.html','cuerpo')\" class=\"button1\">Continuar comprando</a>";
        html += "<a onclick=\"Cargar('resumen_pedido.html','cuerpo')\" class=\"button1\">Formalizar pedido</a>";
        html += "<a onclick=\"Cargar('usuario_login.html','cuerpo')\" class=\"button1\">Cerrar sesión</a>";
        html += "</td>";
        html += "</tr></tfoot>";
        
    }else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
    }
    
    //html += "</table>";Q
    
    return html;
}

function crearProductosCarritoPage (){
    var html = "";
    
    //html += "<table>";Q
    
    if(canti !== 0){
        html += mostrarContenidoCarritoTable();
    }
    else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
        //html += "</table>";Q
        // document.getElementById("carritoTable").innerHTML = html;Q
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
    var p, i = 0;
        
    for(p in carrito){
        if(p === id_producto.toString()) {
            
            if(tipo.toString() === "-"){
                carrito[p].cantidad--;
                canti--;
                
                //document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;Q
                
                //document.getElementById("carrito").innerHTML = " (" + canti + ")";Q
                
                if(parseInt(carrito[p].cantidad) === 0){
                    delete carrito[p];
                    //actualizarCarrito();Q
                    //var html = mostrarContenidoCarritoTable();Q
                    //document.getElementById("carritoTable").innerHTML = html;Q
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
                //console.log("CantidadActual " + carrito[p].cantidad.toString() + " Tipo " + tipo + "CantiACTUALIZADA" + carrito[p].cantidad);
                //document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;Q
                //document.getElementById("carrito").innerHTML = " (" + canti + ")";Q
            }
            break;            
        }
        //i++;Q
    }
    
    actualizarCarrito();
    crearProductosCarritoPage();
}


function formalizarCompra() {
    
    var html = mostrarContenidoCarritoTable();
    
    console.log(html + document.getElementById("div_tabla"));
    
    html += "<tfoot>";
    html += "<tr><td colspan='' class='alineado'>";
    html += "<a onclick='Cargar('check_pedido.html','cuerpo')' class='button2'>Formalizar compra</a>";
    html += "<a onclick='Cargar('carrito.html','cuerpo')' class='button2'> Cancelar compra</a>";
    html += "</td></tr></tfoot>";
    
    
    
    document.getElementById("div_tabla").innerHTML = html;
    
    
}