-- Pruebas de verificacion de objetos y datos
USE proyectocz;

SHOW TABLES;
SELECT COUNT(*) AS clientes FROM clientes;
SELECT COUNT(*) AS equipos FROM equipos;
SELECT COUNT(*) AS ordenes FROM ordenes_servicio;
SELECT COUNT(*) AS facturas FROM facturas;
SELECT * FROM vw_clientes_seguro LIMIT 10;
SELECT * FROM vw_ordenes_detalle LIMIT 10;
-- Pruebas de funciones (si fueron instaladas):
-- SELECT fn_calcular_descuento(100000,10) AS precio_final;
-- SELECT fn_clasificar_edad(15) AS clasificacion;
-- SELECT fn_enmascarar_proyectocz('123456789') AS dato_enmascarado;
-- Prueba de EXPLAIN para indice de fecha:
EXPLAIN SELECT * FROM ordenes_servicio WHERE fecha_ingreso >= '2026-11-01' AND fecha_ingreso < '2026-12-01';
