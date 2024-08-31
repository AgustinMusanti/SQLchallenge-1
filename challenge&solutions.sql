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
