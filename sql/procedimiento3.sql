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