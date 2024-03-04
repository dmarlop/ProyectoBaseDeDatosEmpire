-- CONSULTAS SIMPLES
USE empire;
-- Tabla clientes
/*
1º De los clientes se desea saber su nombre y su primer apellido.
*/

SELECT CONCAT(nombre," ", SUBSTRING_INDEX(apellidos, " ", 1)) FROM cliente;

/*
2º Se desea tambien saber el segundo apellido de los que son socios
*/

SELECT SUBSTRING_INDEX(apellidos, " ", -1) FROM cliente WHERE es_socio = true;

/*
3º Se desea saber la categoría favorita de los clientes cuyo nombre contenga una A.
*/
SELECT categoria_favorita_juego FROM cliente WHERE nombre LIKE '%a%';

-- Tabla Torneos

/*
1º De los torneos se desea saber el id de aquellos que son rentables, es decir, si dan mas premio del que cuesta la entrada
*/ 
SELECT id_torneo FROM torneo WHERE precio_premio < precio_entrada;

/*
2ºse desea saber también el nombre de los torneos cuya categoría sea Magic
*/

SELECT nombre FROM torneo WHERE categoria_juego = 'Magic';

/*
3º Se desea conocer si poseen o no descuento y de cuanto es.

*/
SELECT nombre, descuento FROM torneo WHERE categoria_juego = 'Magic';



-- Tabla Producto
/*
1º De los productos se desea saber el ID y el nombre de aquellos productos que contienen la letra A
*/
SELECT id_producto, nombre_producto FROM producto WHERE categoria_juego LIKE '%a%';


/*
2º Además, se deseará saber los que tienen descuento (Añadir esa información a la consulta anterior)
*/
SELECT id_producto, nombre_producto FROM producto WHERE categoria_juego LIKE '%a%' AND descuento != 0;


/*
3º Se desea conocer de qué productos hay torneos y además, valen mas de 50 euros ordenado por precio
*/
SELECT * FROM producto;

SELECT * FROM producto WHERE id_torneo != 0 AND precio > 50 ORDER BY precio;


-- Tabla proveedor

/*
1º Se desea conocer la información de los proveedores cuya empresa sea una S.L
*/
SELECT * FROM proveedor WHERE empresa LIKE '%S.L%';

/*
2º Se desea conocer el ID de los proveedores que además, son socios de la tienda
*/
SELECT id_proveedor FROM proveedor WHERE es_socio = true;

/*
3º Se desean saber todos los datos de los proveedores que son socios y que trabajan en una S.A
*/
SELECT *  FROM proveedor WHERE es_socio = true AND empresa LIKE '%S.A';

/*
CONSULTAS COMPLEJAS

/*
1º Obtener el nombre y apellido de los clientes que han comprado productos de la categoría "Magic".
*/
SELECT c.nombre, apellidos FROM cliente c 
JOIN compra co ON c.id_cliente = co.id_cliente 
JOIN producto p ON p.id_producto = co.id_producto
WHERE p.categoria_juego = 'Magic'; 

/*
2º Mostrar el nombre y precio de los productos comprados por clientes socios.
*/
SELECT DISTINCT p.nombre_producto, precio FROM producto p
JOIN compra co ON p.id_producto = co.id_producto
JOIN cliente cli ON cli.id_cliente = co.id_cliente
WHERE es_socio = true;

/*
3º Calcular el precio total pagado por cada cliente en compras realizadas en febrero de 2024.
*/
SELECT precio, cli.id_cliente AS cliente FROM producto p 
JOIN compra co ON co.id_producto = p.id_producto
JOIN cliente cli ON cli.id_cliente = p.id_producto
GROUP BY cli.id_cliente;

/*
4º Listar los productos comprados por clientes que han participado en torneos de la categoría "Magic".
*/
SELECT DISTINCT p.id_producto FROM compra co JOIN cliente cli ON cli.id_cliente = co.id_cliente
JOIN juego j ON j.id_cliente = cli.id_cliente
JOIN torneo t ON t.id_torneo = j.id_torneo
JOIN producto p ON co.id_producto = p.id_producto
WHERE t.categoria_juego = 'Magic';

/*
5º Obtener el nombre de los clientes que no son socios y que han comprado productos de la categoría "Juego de mesa".
*/
SELECT cli.nombre FROM cliente cli 
JOIN compra co ON co.id_cliente = cli.id_cliente
JOIN producto p ON co.id_producto = p.id_producto
WHERE cli.es_socio = false 
AND p.categoria_juego LIKE 'Juego de mesa';



/*
6º Calcular el descuento promedio aplicado en los torneos.
*/
SELECT AVG(descuento) FROM torneo;

/*
7º Mostrar el nombre de los proveedores que no son socios y que han abastecido productos de la categoría "Funko".
*/
 SELECT p.nombre_proveedor FROM proveedor p 
 JOIN provision pro ON pro.id_proveedor = p.id_proveedor
 JOIN producto prod ON prod.id_producto = pro.id_producto
 WHERE es_socio = 0 AND categoria_juego LIKE 'Funko';

/*
8º Contar la cantidad de torneos de la categoría "Magic" en los que ha participado cada cliente.
*/
SELECT COUNT(*) FROM juego j 
JOIN torneo tor ON tor.id_torneo = j.id_torneo
WHERE categoria_juego LIKE 'Magic';

/*
9º Obtener el nombre de los torneos que tienen un precio de entrada superior al precio promedio de todos los torneos.
*/
SELECT nombre FROM torneo WHERE precio_entrada > (SELECT AVG(precio_entrada) FROM torneo);

/*
10º Calcular el monto total de premios otorgados en los torneos de la categoría "Magic".
*/

SELECT SUM(precio_premio) FROM torneo;