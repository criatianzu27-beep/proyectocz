DROP VIEW IF EXISTS vw_clientes_seguro;
CREATE VIEW vw_clientes_seguro AS
SELECT id_cliente,nombre,
 fn_enmascarar_proyectocz(documento) AS documento_mascarado,
 fn_enmascarar_proyectocz(telefono) AS telefono_mascarado
FROM clientes;

DROP VIEW IF EXISTS vw_ordenes_detalle;
CREATE VIEW vw_ordenes_detalle AS
SELECT os.id_orden,os.fecha_ingreso,os.problema_reportado,os.estado,os.fecha_entrega,
 e.id_equipo,e.tipo_equipo,e.marca,e.modelo,c.id_cliente,c.nombre AS nombre_cliente
FROM ordenes_servicio os
JOIN equipos e ON e.id_equipo=os.id_equipo
JOIN clientes c ON c.id_cliente=e.id_cliente;
-- Pruebas: SELECT * FROM vw_clientes_seguro; SELECT * FROM vw_ordenes_detalle;

