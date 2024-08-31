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
	   Mostrar: Descripción de la Categoría, Cantidad de Productos
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








