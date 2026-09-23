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