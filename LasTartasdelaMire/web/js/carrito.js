/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var carrito = null;
var canti = 0;  


function devuelveCantidadCarrito() {
    var i = 0;
    for(p in carrito){
        i++;
    }
    return i;
}

function devuelveCantidadTotalCarrito() {
    var i = 0;
    for(p in carrito){
        i += carrito[p].cantidad;
    }
    return i;
}


function cargaInicialCarrito() {
    carrito = JSON.parse(localStorage.getItem("carrito"));
    
    /*console.log("CARGA INICIAL: ");
    for(p in carrito){
        console.log("ID: " + carrito[p].id_producto + " NOMBRE: " + carrito[p].nombre + " CANTIDAD: " + carrito[p].cantidad);
    }*/
    
    if(carrito === null){
        carrito = new Object();
        //console.log("Carrito creado");
    }    
}

function actualizarCarrito() {
    localStorage.clear();
    localStorage.setItem("carrito", JSON.stringify(carrito));
    
    /*console.log("ACTUALIZA: ");
    for(p in carrito){
        console.log("ID: " + carrito[p].id_producto + " NOMBRE: " + carrito[p].nombre + " CANTIDAD: " + carrito[p].cantidad);
    }*/
}

function anadirProductoCarrito (id_producto, nombre, precio) {

    var p, encontrado = 0;

    for(p in carrito){
        if(p === id_producto) {
            encontrado = 1;
            carrito[p].cantidad++;
            canti++;
            document.getElementById('carrito').innerHTML = " (" + carrito[p].cantidad++; + ")";
        }
    }

    if(encontrado === 0){
        var product = new Object();
        product.id_producto = id_producto;   
        product.nombre = nombre;
        product.precio = precio;
        product.cantidad = 1;

        carrito[id_producto] = product;
        canti++;
        document.getElementById('carrito').innerHTML = " (" + canti + ")";
    }

    actualizarCarrito();
}

function crearProductosCarritoPage (){
    
    var html = "";
    
    html += "<table>";
    
    if(devuelveCantidadCarrito() !== 0){
        
        html += mostrarContenidoCarritoTable();
        
        document.getElementById("carritoTable").innerHTML = html;
        document.getElementById("carrito").innerHTML = " (" + canti + ")";
    }
    else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
        html += "</table>";
        document.getElementById("carritoTable").innerHTML = html;
    }
    
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

function mostrarContenidoCarritoTable(){
    var html="", i = 0, p;
    canti = 0;
    
    html += "<table>";
    if(devuelveCantidadCarrito() !== 0){
        html += "<thead><tr><th>Descripción</th><th>Unidades</th><th>Precio</th><th>Modificar Cantidad</th></tr></thead>";
        
        for(p in carrito){
            html += "<tr>";
            html += "<td>" + carrito[p].nombre + "</td>";
            html += "<td id='cantidad" +i+ "'> "+ carrito[p].cantidad + "</td>";
            html += "<td>" + carrito[p].precio + "</td>";
            html += "<td><input class=\"button1\" type='button' value='-' id='fila" + i + "' onclick='modificarCantidad(\"-\", \"" + p + "\")'><input class=\"button1\" type='button' value='+' onclick='modificarCantidad(\"+\", \"" + p + "\")'><input class=\"button1\" type='button' value='x' onclick='eliminarFila(this, \"" + p + "\")'></td>";
            html += "</tr>";
            i++;
            canti = canti + carrito[p].cantidad;
        }
        
        html += "<tfoot>";
        html += "<tr>";
        html += "<td colspan='4' class='alineado'>";
        html += "<a onclick=\"Cargar('productos.html','cuerpo')\" class=\"button1\">Continuar comprando</a>";
        html += "<a onclick=\"Cargar('resumen_pedido.html','cuerpo')\" class=\"button1\">Formalizar pedido</a>";
        html += "<a onclick=\"Cargar('usuario_login.html','cuerpo')\" class=\"button1\">Cerrar sesión</a>";
        html += "</td>";
        html += "</tr></tfoot></table>";
        
    }else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
    }
    
    html += "</table>";
    
    return html;
}

function modificarCantidad(tipo, id_producto) {
    var p, i = 0;
        
    for(p in carrito){
        if(p === id_producto.toString()) {
            
            if(tipo.toString() === "-"){
                carrito[p].cantidad--;
                //console.log("<br>CantidadActual " + carrito[p].cantidad.toString() + " Tipo " + tipo + "CantiACTUALIZADA" + carrito[p].cantidad);
                document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;
                canti--;
                document.getElementById("carrito").innerHTML = " (" + canti + ")";
                
                if(parseInt(carrito[p].cantidad) === 0){
                    delete carrito[p];
                    actualizarCarrito();
                    var html = mostrarContenidoCarritoTable();
                    document.getElementById("carritoTable").innerHTML = html;
                }
                
            }
            else if(tipo.toString() === "+") {
                carrito[p].cantidad++;
                //console.log("CantidadActual " + carrito[p].cantidad.toString() + " Tipo " + tipo + "CantiACTUALIZADA" + carrito[p].cantidad);
                document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;
                canti++;
                document.getElementById("carrito").innerHTML = " (" + canti + ")";
            }
            break;            
        }
        i++;
    }
    
    actualizarCarrito();
    
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