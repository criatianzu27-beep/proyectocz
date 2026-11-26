-- Roles, usuarios y privilegios (clase 10).
-- Revisar contrasenas y dependencias antes de ejecutar.
-- Este script presupone que las vistas, tablas y procedimiento ya existen.
USE proyectocz;

CREATE ROLE IF NOT EXISTS rol_consulta_proyectocz;
CREATE ROLE IF NOT EXISTS rol_operativo_proyectocz;
CREATE ROLE IF NOT EXISTS rol_admin_proyectocz;

GRANT SELECT ON proyectocz.vw_clientes_seguro TO rol_consulta_proyectocz;
GRANT SELECT ON proyectocz.vw_ordenes_detalle TO rol_consulta_proyectocz;
GRANT SELECT ON proyectocz.auditoria_clientes TO rol_consulta_proyectocz;
GRANT EXECUTE ON PROCEDURE proyectocz.sp_registrar_orden_proyectocz TO rol_operativo_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.clientes TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.equipos TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.ordenes_servicio TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.reparaciones TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.asignaciones TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.tecnicos TO rol_admin_proyectocz;
GRANT SELECT,INSERT,UPDATE,DELETE ON proyectocz.facturas TO rol_admin_proyectocz;
GRANT SELECT ON proyectocz.auditoria_clientes TO rol_admin_proyectocz;

-- Cambiar estas contrasenas demo antes de ejecutar en cualquier entorno real.
CREATE USER IF NOT EXISTS 'consulta_proyectocz'@'%' IDENTIFIED BY 'Consulta#2026Demo';
CREATE USER IF NOT EXISTS 'operativo_proyectocz'@'%' IDENTIFIED BY 'Operativo#2026Demo';
CREATE USER IF NOT EXISTS 'admin_proyectocz'@'%' IDENTIFIED BY 'Admin#2026Demo';
GRANT rol_consulta_proyectocz TO 'consulta_proyectocz'@'%';
GRANT rol_operativo_proyectocz TO 'operativo_proyectocz'@'%';
GRANT rol_admin_proyectocz TO 'admin_proyectocz'@'%';
SET DEFAULT ROLE rol_consulta_proyectocz FOR 'consulta_proyectocz'@'%';
SET DEFAULT ROLE rol_operativo_proyectocz FOR 'operativo_proyectocz'@'%';
SET DEFAULT ROLE rol_admin_proyectocz FOR 'admin_proyectocz'@'%';
ALTER USER 'operativo_proyectocz'@'%' WITH MAX_USER_CONNECTIONS 5;

SHOW GRANTS FOR rol_consulta_proyectocz;
SHOW GRANTS FOR rol_operativo_proyectocz;
SHOW GRANTS FOR rol_admin_proyectocz;
