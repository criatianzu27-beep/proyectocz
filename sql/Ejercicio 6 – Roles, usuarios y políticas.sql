-- Usa '%' porque tus cuentas anteriores se crearon con ese host.
-- Cambia estas contrasenas de demostracion por otras propias.
CREATE USER IF NOT EXISTS 'consulta_proyectocz'@'%' IDENTIFIED BY 'Consulta#2026Demo';
CREATE USER IF NOT EXISTS 'operativo_proyectocz'@'%' IDENTIFIED BY 'Operativo#2026Demo';
CREATE USER IF NOT EXISTS 'admin_proyectocz'@'%' IDENTIFIED BY 'Admin#2026Demo';
GRANT rol_consulta_proyectocz TO 'consulta_proyectocz'@'%';
GRANT rol_operativo_proyectocz TO 'operativo_proyectocz'@'%';
GRANT rol_admin_proyectocz TO 'admin_proyectocz'@'%';
SET DEFAULT ROLE rol_consulta_proyectocz FOR 'consulta_proyectocz'@'%';
SET DEFAULT ROLE rol_operativo_proyectocz FOR 'operativo_proyectocz'@'%';
SET DEFAULT ROLE rol_admin_proyectocz FOR 'admin_proyectocz'@'%';
ALTER USER 'consulta_proyectocz'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'operativo_proyectocz'@'%' WITH MAX_USER_CONNECTIONS 5;

-- Politica de contrasenas (ejecutar aparte si el plugin esta disponible):
-- INSTALL SONAME 'simple_password_check';
-- SHOW VARIABLES LIKE 'simple_password_check%';
-- CREATE USER 'prueba_debil_proyectocz'@'%' IDENTIFIED BY '12345'; -- debe fallar
-- Pruebas de permisos con conexiones separadas:
-- Consulta permitido: SELECT * FROM proyectocz.vw_clientes_seguro;
-- Consulta denegado: UPDATE proyectocz.clientes SET nombre='X' WHERE id_cliente=1;
-- Operativo permitido: CALL proyectocz.sp_registrar_orden_proyectocz(1,'No enciende');
-- Operativo denegado: INSERT INTO proyectocz.ordenes_servicio
-- (id_equipo,fecha_ingreso,problema_reportado,estado)
-- VALUES(1,CURRENT_DATE(),'Prueba','Pendiente');
-- Admin no debe borrar auditoria: DELETE FROM proyectocz.auditoria_clientes;

SHOW GRANTS FOR rol_consulta_proyectocz;
SHOW GRANTS FOR rol_operativo_proyectocz;
SHOW GRANTS FOR rol_admin_proyectocz;
SHOW GRANTS FOR 'consulta_proyectocz'@'%';
SHOW GRANTS FOR 'operativo_proyectocz'@'%';
SHOW GRANTS FOR 'admin_proyectocz'@'%';
SELECT user,host FROM mysql.user
WHERE user IN ('consulta_proyectocz','operativo_proyectocz','admin_proyectocz');

