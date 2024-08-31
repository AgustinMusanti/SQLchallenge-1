## Agustin Musanti - BluePatagon

use blue_patagon;

/*
	1) Obtener el listado de todos los productos ordenados por Nombre del Producto.
           Mostrar: Nombre del Producto, Precio Unitario
*/

        SELECT    producto_nombre AS Nombre_del_Producto,
                  precio_unitario AS Precio_Unitario
		
        FROM      productos
		
        ORDER BY  producto_nombre;


/*
	2) Obtener el listado de la cantidad total de unidades para cada pedido  
	   Mostrar: Pedido, Cantidad
*/

        SELECT     pedido_id     AS Pedido,
		   SUM(cantidad) AS Cantidad
		
        FROM       pedidos_detalle
		
        GROUP BY   pedido_id;


/*
	3) Obtener el listado de todos los productos cuyo precio unitario se encuentre entre 100 y 150
	   Mostrar: Nombre del Producto
*/

        SELECT  producto_nombre AS Nombre_del_Producto
		
        FROM    productos
		
        WHERE   precio_unitario BETWEEN 100 AND 150;


/*
	4) Obtener el mayor descuento realizado en algún pedido
	   Mostrar: Descuento
*/

        SELECT MAX(descuento) AS Descuento
		
        FROM   pedidos_detalle;







