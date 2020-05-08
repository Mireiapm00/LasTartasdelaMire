<%-- 
    Document   : registrarse
    Created on : 08-may-2020, 16:10:42
    Author     : arant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function validar_clave(){
                var clave = document.f1.c6.value;
                var clave_repe = document.f1.c6_repe.value;
                if(clave === clave_repe){
                    ProcesarForm(f1, 'RegistroUsuario', 'cuerpo');
                    return true;
                }else{
                    alert("Las contraseñas deben de coincidir.");
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <h2>Regístrate </h2>
       
        <form method="post" onsubmit="ProcesarForm(this, 'RegistroUsuario', 'cuerpo'); return false">
        <table class="registrarTable">
            <thead>
                <tr><th colspan="1" style="padding-bottom: 10%;">Introduce la siguiente información:</th></tr>
            </thead>
            <tbody>
                <tr>
                    <td><label for="user">Usuario</label></td>
                    <td><input id="user" type="text" name="r7" required autofocus></td>
                </tr>
                <tr>
                    <td><label for="pass">Contraseña: </label></td>
                    <td><input id="pass" type="password" name="r6" required></td>
                </tr>
                <tr>
                    <td><label for="pass">Repite la contraseña: </label></td>
                    <td><input id="pass" type="password" name="r6_repe" required></td>
                </tr>
                <tr>
                    <td><label for="nombre">Nombre</label></td>
                    <td><input id="nombre" type="text" name="r0" pattern="[A-Za-z]{0,50}" required></td>
                </tr>
                <tr>
                    <td><label for="apell">Apellidos</label></td>
                    <td><input id="apell" type="text" name="r1" required></td>
                </tr>
                <tr>
                    <td><label for="dom">Domicilio:</label></td>
                    <td><input id="dom" type="text" name="r8" required></td>
                </tr>
                <tr>
                    <td><label for="pob">Población</label></td>
                    <td><input id="pob" type="text" name="r3" required></td>
                </tr>
                <tr>
                    <td><label for="pro">Provincia</label></td>
                    <td><input id="pro" type="text" name="r4" pattern="[A-Za-z]{0,50}" required></td>
                </tr>
                <tr>
                    <td><label for="cp">CP</label></td>
                    <td><input id="cp" type="text" name="r5" required></td>
                </tr>
                <tr>
                    <td><label for="tarj">Tarjeta (opcional):</label></td>
                    <td><input id="tarj" type="number" name="r9" pattern="[0-9]{16}"></td>
                </tr>
                <tr>
                    <td><label for="tlf">Teléfono</label></td>
                    <td><input id="tlf" type="tel" name="r2" pattern="[0-9]{9}" required></td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2">
                     <input class="button2" type="submit" value="Registrarse"/>
                     <input class="button2" type="reset" value="Cancelar" onclick="Cargar('usuario_login.jsp', 'cuerpo')"/>
                   </td>
                </tr>
            </tfoot>
        </table>
        </form>
    </body>
</html>
