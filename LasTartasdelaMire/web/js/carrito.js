/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var carrito = null;
var canti = 0;  

function cargaInicialCarrito() {
    carrito = JSON.parse(localStorage.getItem("carrito"));
    
    if(carrito === null){
        carrito = new Object();
        console.log("Carrito creado");
    }    
}

function actualizarCarrito() {
    localStorage.clear();
    localStorage.setItem("carrito", JSON.stringify(carrito));
}

function anadirProductoCarrito (id_producto, nombre, precio) {

    var p, encontrado = 0;

    for(p in carrito){
        if(p === id_producto) {
            encontrado = 1;
            carrito[p].cantidad++;
            /*console.log(carrito[p].id_producto + " " + carrito[p].nombre + " " + carrito[p].cantidad );*/
            document.getElementById('carrito').innerHTML = " (" + (canti+=carrito[p].cantidad) + ")";
        }
    }

    if(encontrado === 0){
        var product = new Object();
        product.id_producto = id_producto;   
        product.nombre = nombre;
        product.precio = precio;
        product.cantidad = 1;

        /*console.log("El producto añadido: " + product);*/


        carrito[id_producto] = product;
        document.getElementById('carrito').innerHTML = " (" + (canti+=product.cantidad) + ")";
    }

    actualizarCarrito();

}

function crearProductosCarritoPage (){

    var p, html = "", i = 0;
    
    html += "<table>";
    
    if(carrito !== null || localStorage.length !== 0){
        
        html += "<thead><tr><th>Descripción</th><th>Unidades</th><th>Precio</th><th>Modificar Cantidad</th></tr></thead>";
        for(p in carrito){
            html += "<tr>";
            html += "<td>" + carrito[p].nombre + "</td>";
            html += "<td id='cantidad" +i+ "'> "+ carrito[p].cantidad + "</td>";
            html += "<td>" + carrito[p].precio + "</td>";
            html += "<td> <input class=\"button1\" type='button' value='-' onclick='modificarCantidad(\"-\", \"" + p + "\")'><input class=\"button1\" type='button' value='+' onclick='modificarCantidad(\"+\", \"" + p + "\")'></td>";
            html += "</tr>";
        }

        html += "<tfoot>";
        html += "<tr>";
        html += "<td colspan='4' class='alineado'>";
        html += "<a onclick=\"Cargar('productos.html','cuerpo')\" class=\"button1\">Continuar comprando</a>";
        html += "<a onclick=\"Cargar('resumen_pedido.html','cuerpo')\" class=\"button1\">Formalizar pedido</a>";
        html += "<a onclick=\"Cargar('usuario_login.html','cuerpo')\" class=\"button1\">Cerrar sesión</a>";
        html += "</td>";
        html += "</tr></tfoot></table>";

        document.getElementById("carritoTable").innerHTML = html;
    }
    else {
        html += "<tr><td><img src='images/logos/iconocarrito.png' alt='Carrito'/></td></tr>";
        html += "<tr><td>El carrito está vacio</td></tr>";
        html += "</table>";
        document.getElementById("carritoTable").innerHTML = html;
    }
    
}


function modificarCantidad(tipo, id_producto) {
    var p, i = 0;
        
    for(p in carrito){
        if(p === id_producto.toString()) {
            
            var cantidad = document.getElementById('cantidad'+i).textContent;
            
            if(tipo.toString() === "-"){
                if(parseInt(cantidad) === 0){
                    delete carrito[p];
                    /* ELiminar tambien la tabla  y poner carrito vacio si carrito lenght/localStorage === 0*/
                }
                
                carrito[p].cantidad--;
                
                console.log("CantidadActual " + carrito[p].cantidad.toString() + " Tipo " + tipo + "CantiACTUALIZADA" + carrito[p].cantidad);
                document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;
            }
            else if(tipo.toString() === "+") {
                
                carrito[p].cantidad++;
                
                console.log("CantidadActual " + carrito[p].cantidad.toString() + " Tipo " + tipo + "CantiACTUALIZADA" + carrito[p].cantidad);
                
                document.getElementById('cantidad'+i).innerHTML = carrito[p].cantidad;
            }
            break;            
        }
        i++;
    }
    actualizarCarrito();
    
}