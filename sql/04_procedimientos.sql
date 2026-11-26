-- Procedimiento 1
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

-- Procedimiento 2
DELIMITER //

CREATE PROCEDURE contar_ordenes(
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM ordenes_servicio;
END //

DELIMITER ;

-- Procedimiento 3

DELIMITER //

CREATE PROCEDURE actualizar_estado_orden(
    IN p_id_orden INT,
    INOUT p_estado VARCHAR(45)
)
BEGIN
    UPDATE ordenes_servicio
    SET estado = p_estado
    WHERE id_orden = p_id_orden;

    SELECT estado
    INTO p_estado
    FROM ordenes_servicio
    WHERE id_orden = p_id_orden;
END //

DELIMITER ;