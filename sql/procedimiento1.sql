DELIMITER //

CREATE PROCEDURE consultar_ordenes_estado(
    IN p_estado VARCHAR(45)
)
BEGIN
    SELECT
        o.id_orden,
        o.estado,
        o.fecha_ingreso,
        o.fecha_entrega,
        e.tipo_equipo,
        e.marca,
        e.modelo,
        c.nombre AS cliente
    FROM ordenes_servicio o
    INNER JOIN equipos e
        ON o.id_equipo = e.id_equipo
    INNER JOIN clientes c
        ON e.id_cliente = c.id_cliente
    WHERE o.estado = p_estado;
END //

DELIMITER ;