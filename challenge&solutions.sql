## Agustin Musanti - BluePatagon

use blue_patagon;

/*
	1) Obtener el listado de todos los productos ordenados por Nombre del Producto.
           Mostrar: Nombre del Producto, Precio Unitario
*/

        SELECT    producto_nombre AS 'Nombre del producto',
                  precio_unitario AS 'Precio unitario'
		
        FROM      productos
		
        ORDER BY  producto_nombre;


/*
	2) Obtener el listado de la cantidad total de unidades para cada pedido  
	   Mostrar: Pedido, Cantidad
*/

        SELECT     pedido_id     AS 'Pedido',
		   SUM(cantidad) AS 'Cantidad'
		
        FROM       pedidos_detalle
		
        GROUP BY   pedido_id;


/*
	3) Obtener el listado de todos los productos cuyo precio unitario se encuentre entre 100 y 150
	   Mostrar: Nombre del Producto
*/

        SELECT  producto_nombre AS 'Nombre del producto'
		
        FROM    productos
		
        WHERE   precio_unitario BETWEEN 100 AND 150;


/*
	4) Obtener el mayor descuento realizado en algún pedido
	   Mostrar: Descuento
*/

        SELECT MAX(descuento) AS 'Descuento'
		
        FROM   pedidos_detalle;


/*
	5) Obtener el listado de todos los pedidos realizados en el año 2021
	   Mostrar: Todos los campos de Pedido
*/

        SELECT      *
		
        FROM        pedidos
		
        WHERE       YEAR  (pedido_fecha) = 1998;


/*
	6) Obtener la cantidad de productos que tiene cada categoría. 
	   Mostrar: Nombre de la Categoría, Cantidad de Productos
*/

        SELECT     c.categoria_nombre   AS 'Categoría', 
		   COUNT(p.producto_id) AS 'Cantidad de productos'
		
        FROM       categorias c
		
        LEFT JOIN  productos p ON c.categoria_id = p.categoria_id
		
        GROUP BY   c.categoria_nombre;


/*
	7) Obtener el listado  de todos los empleados cuyo nombre comienzan con 'T'.
	   Mostrar: Nombre y Apellido del Empleado (En la misma columna)
*/

        SELECT CONCAT(e.empleado_nombre, ' ', e.empleado_apellido) AS 'Nombre y apellido del empleado'
		
        FROM   empleados e
		
        WHERE  e.empleado_nombre LIKE 'T%';


/*
	8) Obtener el nombre del producto cuyo precio unitario sea el mayor
	   Mostrar: Nombre del Producto, Precio Unitario
*/

        SELECT    producto_nombre AS 'Nombre del producto', 
		  precio_unitario AS 'Precio unitario'
		
        FROM      productos
		
        ORDER BY  precio_unitario DESC
		
        LIMIT 1;


/*
	9) Crear un Stored Procedure 'Actualiza_Precio’' que aumente en un 10% el valor de los precios unitarios
*/

        DELIMITER //

        CREATE PROCEDURE Actualiza_Precio()
        BEGIN
        
        UPDATE productos
        SET precio_unitario = precio_unitario * 1.10;
        END //

        DELIMITER ;

        -- Antes de realizar la "call" a este procedimiento almacenado desactivamos el modo de actualización segura temporalmente

        SET SQL_SAFE_UPDATES = 0;

        -- Ahora si podemos ejecutar nuestro procedimiento almacenado

        CALL Actualiza_Precio();


/*
	10) Crear un Stored Procedure 'Actualiza_Descuento’' para que reciba por parámetro un valor de 
            descuento a realizar y lo sume al ya existente, sólo a los pedidos de los clientes de Portugal y Brasil.
*/

        DROP PROCEDURE IF EXISTS Actualiza_Descuento;

        DELIMITER //
        CREATE PROCEDURE Actualiza_Descuento(IN incremento DECIMAL(5,2))
        BEGIN
        UPDATE pedidos_detalle dp
        INNER JOIN pedidos p ON dp.pedido_id = p.pedido_id
        INNER JOIN clientes c ON p.cliente_id = c.cliente_id
        SET dp.descuento = dp.descuento + incremento
        WHERE c.cliente_pais IN ('Portugal', 'Brasil');
        END //
        DELIMITER ;        
 
        CALL Actualiza_Descuento(0.05); -- Por ejemplo, si queremos sumar un 5% al descuento actual


/*
	11) Listar la cantidad de unidades en stock para cada uno de los productos que pertenecen a una categoría
	    Mostrar: Nombre de la categoría, Cantidad de unidades en stock
*/

        SELECT      c.categoria_nombre    AS "Categoría",
                    SUM(p.unidades_stock) AS "Cantidad de Unidades en Stock"
		
        FROM        productos p
		
        INNER JOIN  categorias c ON p.categoria_id = c.categoria_id
		
        GROUP BY    c.categoria_nombre;


/*
	12) Listar todos los productos y la categoría a la que pertenecen.
            Para las categorías desconocidas informar 'Sin Categoría'.
            Mostrar: Nombre del Producto, Nombre de la Categoría
*/

        SELECT     p.producto_nombre   AS "Nombre del Producto",
                   COALESCE(c.categoria_nombre, 'Sin Categoría') AS "Nombre de la Categoría"
		
	FROM       productos p
		
	LEFT JOIN  categorias c ON p.categoria_id = c.categoria_id;


/*
	13) Listar las regiones que aún no cuenten con un proveedor
	Mostrar : Nombre de la Región
*/

        SELECT     r.region_nombre AS 'Nombre de la region'
		
        FROM       region r
		
        LEFT JOIN  proveedores p ON r.region_id = p.proveedor_region
		
        WHERE      p.proveedor_id IS NULL;


/*
	14) Listar los clientes que no entraron en mora
	    Mostrar: Nombre del cliente, Contacto del cliente
*/

        SELECT     c.cliente_nombre   AS 'Nombre del cliente',
                   c.cliente_contacto AS 'Contacto del cliente'
		
        FROM       clientes c
		
        LEFT JOIN  clientes_morosos cm ON c.cliente_id = cm.cliente_id
		
        WHERE      cm.cliente_id IS NULL;


/*
	15) Listar el monto total de mora de los clientes Bay y Maria Anders
		Mostrar: Monto total de mora (De ambos clientes)
*/

        SELECT COALESCE(SUM(cm.mora), 0) AS Monto_Total_de_Mora
		
        FROM   clientes_morosos cm
		
        JOIN   clientes c ON cm.cliente_id = c.cliente_id
		
        WHERE  c.cliente_nombre IN ('Bay', 'Maria Anders');


