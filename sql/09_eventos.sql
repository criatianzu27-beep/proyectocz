-- Evento ev_resumen_ordenes_diario (implementado y probado recientemente)
-- Genera diariamente el resumen de ordenes por estado.
-- Requiere que exista resumen_ordenes_diario y su UNIQUE(fecha_resumen, estado).
USE proyectocz;

SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS ev_resumen_ordenes_diario;
DELIMITER $$
CREATE EVENT ev_resumen_ordenes_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2026-11-20 00:00:00'
ON COMPLETION PRESERVE
ENABLE
DO
BEGIN
    INSERT INTO resumen_ordenes_diario (fecha_resumen, estado, cantidad_ordenes)
    SELECT CURDATE(), e.nombre_estado, COUNT(o.id_orden)
    FROM estados e
    LEFT JOIN ordenes_servicio o ON o.id_estado = e.id_estado
    GROUP BY e.id_estado, e.nombre_estado
    ON DUPLICATE KEY UPDATE
        cantidad_ordenes = VALUES(cantidad_ordenes),
        fecha_registro = CURRENT_TIMESTAMP;
END$$
DELIMITER ;

-- Verificacion:
-- SHOW EVENTS FROM proyectocz;
-- SELECT * FROM resumen_ordenes_diario ORDER BY fecha_resumen DESC, estado;
