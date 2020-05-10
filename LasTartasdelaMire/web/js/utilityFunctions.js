/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function comprobarCampoTarjeta(formaPago, tarjetaValue){

    var html = "";
    
    if(formaPago.value === "tarjeta"){
        if(tarjetaValue === " "){
            html += "<b>Número de tarjeta: </b><input type='number' required name='numTarjeta' pattern='[0-9]{16}' min='1111-1111-1111-1111' max='9999-9999-9999-9999' title='El numero de tarjeta debe tener 16 dígitos.'>";
        }
        else{
            html += "<b>Número de tarjeta: </b><input type='number' name='numTarjeta' pattern='[0-9]{16}' min='1111-1111-1111-1111' max='9999-9999-9999-9999' title='El numero de tarjeta debe tener 16 dígitos.' value='"+ tarjetaValue + "' >";
        }
    }
    else if(formaPago.value === "contrareembolso"){
        html += "<p><b>Recuerda que tienes que abonar el importe al recibir el pedido<b></p>";
    }
    
    document.getElementById("numeroTarjeta").innerHTML = html;
}