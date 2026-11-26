-- Funciones reunidas de clases 8 y 10.
USE proyectocz;

-- EJERCICIO 1: Funcion para calcular descuento
DROP FUNCTION IF EXISTS fn_calcular_descuento;
DELIMITER $$
CREATE FUNCTION fn_calcular_descuento(
    p_precio DECIMAL(10,2),
    p_porcentaje DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF p_precio < 0 OR p_porcentaje < 0 OR p_porcentaje > 100 THEN
        RETURN NULL;
    END IF;
    RETURN ROUND(p_precio - (p_precio * p_porcentaje / 100), 2);
END$$
DELIMITER ;

-- Prueba: SELECT fn_calcular_descuento(100000, 10) AS precio_final;
-- Resultado esperado: 90000.00


-- EJERCICIO 2: Funcion para clasificar una edad
DROP FUNCTION IF EXISTS fn_clasificar_edad;
DELIMITER $$
CREATE FUNCTION fn_clasificar_edad(p_edad INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_edad < 0 THEN
        RETURN 'Edad no valida';
    ELSEIF p_edad < 12 THEN
        RETURN 'Niño';
    ELSEIF p_edad <= 17 THEN
        RETURN 'Adolescente';
    ELSEIF p_edad <= 59 THEN
        RETURN 'Adulto';
    ELSE
        RETURN 'Adulto mayor';
    END IF;
END$$
DELIMITER ;

-- Pruebas:
-- SELECT fn_clasificar_edad(8);
-- SELECT fn_clasificar_edad(15);
-- SELECT fn_clasificar_edad(30);
-- SELECT fn_clasificar_edad(65);


-- EJERCICIO 3: Funcion aplicada al proyecto
-- Calcula el total de una factura existente usando subtotal + iva.
-- La tabla facturas del modelo contiene id_factura, subtotal e iva.
DROP FUNCTION IF EXISTS fn_calcular_total_factura;
DELIMITER $$
CREATE FUNCTION fn_calcular_total_factura(p_id_factura INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_subtotal DECIMAL(10,2) DEFAULT NULL;
    DECLARE v_iva DECIMAL(10,2) DEFAULT NULL;

    SELECT subtotal, iva
      INTO v_subtotal, v_iva
      FROM facturas
     WHERE id_factura = p_id_factura
     LIMIT 1;

    IF v_subtotal IS NULL OR v_iva IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN ROUND(v_subtotal + v_iva, 2);
END$$
DELIMITER ;

-- Prueba: SELECT fn_calcular_total_factura(1) AS total_calculado;
-- Si no existe la factura 1, retorna NULL.
-- Comparar: SELECT id_factura, subtotal, iva, total FROM facturas;



DROP FUNCTION IF EXISTS fn_enmascarar_proyectocz;
DELIMITER $$
CREATE FUNCTION fn_enmascarar_proyectocz(p_texto VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
 IF p_texto IS NULL OR CHAR_LENGTH(p_texto)=0 THEN RETURN NULL;
 ELSEIF CHAR_LENGTH(p_texto)<=4 THEN RETURN REPEAT('*',CHAR_LENGTH(p_texto));
 ELSE RETURN CONCAT(REPEAT('*',CHAR_LENGTH(p_texto)-4),RIGHT(p_texto,4));
 END IF;
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS fn_validar_login_proyectocz;
DELIMITER $$
CREATE FUNCTION fn_validar_login_proyectocz(p_usuario VARCHAR(80), p_contrasena VARCHAR(255))
RETURNS TINYINT READS SQL DATA
BEGIN
 DECLARE v_sal CHAR(32);
 DECLARE v_hash CHAR(64);
 DECLARE v_activo TINYINT DEFAULT 0;
 SELECT sal, clave_hash, activo INTO v_sal, v_hash, v_activo
 FROM usuarios_seguridad WHERE nombre_usuario=p_usuario LIMIT 1;
 IF v_activo=1 AND v_hash=SHA2(CONCAT(p_contrasena,v_sal),256) THEN RETURN 1; END IF;
 RETURN 0;
END$$
DELIMITER ;

