USE proyectocz;

DELIMITER //

CREATE TRIGGER tr_historial_estado
AFTER UPDATE ON ordenes_servicio
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN

        INSERT INTO historial_estados
        (
            estado_anterior,
            estado_nuevo,
            fecha_cambio,
            id_orden
        )
        VALUES
        (
            OLD.estado,
            NEW.estado,
            NOW(),
            NEW.id_orden
        );

    END IF;
END //

DELIMITER ;