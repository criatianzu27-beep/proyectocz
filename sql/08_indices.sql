-- Optimización e índice de fecha (clase 13).
-- El índice puede existir ya: verifica SHOW INDEX antes de crear.
USE proyectocz;

-- CREATE INDEX idx_ordenes_fecha_ingreso ON ordenes_servicio(fecha_ingreso);

SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

ANALYZE
SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

-- Indice creado para búsquedas por rango de fechas.
-- Ya existe en la base trabajada; no descomentar al repetir el script.
-- CREATE INDEX idx_ordenes_fecha_ingreso
-- ON ordenes_servicio (fecha_ingreso);

-- DESPUES: possible_keys=idx_ordenes_fecha_ingreso,
-- key=NULL, type=ALL; r_rows=10012, r_filtered=88.40%,
-- tiempo=0.009 s. El rango anual devuelve muchas filas.
EXPLAIN
SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

ANALYZE
SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

-- Prueba de rango más selectivo (noviembre 2026).
-- type=range, key=idx_ordenes_fecha_ingreso, rows=504,
-- r_rows=504, r_filtered=100%, tiempo=0.002 s.
EXPLAIN
SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-11-01'
  AND fecha_ingreso < '2026-12-01';

ANALYZE
SELECT *
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-11-01'
  AND fecha_ingreso < '2026-12-01';

-- =========================================================
-- CONSULTA 2: JOIN ORDENES + EQUIPOS + CLIENTES
-- Usa índices existentes en las columnas de relacion.
-- EXPLAIN: equipos ALL (10); clientes eq_ref PRIMARY;
-- ordenes ref fk_ordenes_servicio_equipos1_idx.
-- ANALYZE r_rows: equipos=10, clientes=1, ordenes=1001.20.
-- Tiempo mostrado: 0.033 s.
-- =========================================================
EXPLAIN
SELECT os.id_orden, os.fecha_ingreso, os.problema_reportado,
       e.tipo_equipo, e.marca, e.modelo,
       c.nombre AS nombre_cliente
FROM ordenes_servicio os
INNER JOIN equipos e ON os.id_equipo = e.id_equipo
INNER JOIN clientes c ON e.id_cliente = c.id_cliente;

ANALYZE
SELECT os.id_orden, os.fecha_ingreso, os.problema_reportado,
       e.tipo_equipo, e.marca, e.modelo,
       c.nombre AS nombre_cliente
FROM ordenes_servicio os
INNER JOIN equipos e ON os.id_equipo = e.id_equipo
INNER JOIN clientes c ON e.id_cliente = c.id_cliente;

-- =========================================================
-- CONSULTA 3: ORDER BY DE ORDENES
-- EXPLAIN: ALL, key=NULL, Using filesort.
-- ANALYZE: r_rows=10012, tiempo=0.017 s.
-- =========================================================
EXPLAIN
SELECT id_orden, fecha_ingreso, problema_reportado, id_equipo
FROM ordenes_servicio
ORDER BY fecha_ingreso DESC;

ANALYZE
SELECT id_orden, fecha_ingreso, problema_reportado, id_equipo
FROM ordenes_servicio
ORDER BY fecha_ingreso DESC;

-- Prueba adicional LIMIT 100: ALL, Using filesort,
-- ANALYZE r_rows=100, tiempo=0.005 s.
EXPLAIN
SELECT id_orden, fecha_ingreso, problema_reportado, id_equipo
FROM ordenes_servicio
ORDER BY fecha_ingreso DESC
LIMIT 100;

ANALYZE
SELECT id_orden, fecha_ingreso, problema_reportado, id_equipo
FROM ordenes_servicio
ORDER BY fecha_ingreso DESC
LIMIT 100;

-- =========================================================
-- CONSULTA 4: JOIN FACTURAS + ORDENES + ESTADOS
-- EXPLAIN: facturas ALL (10); estados eq_ref PRIMARY;
-- ordenes eq_ref PRIMARY. ANALYZE r_rows=10,1,1.
-- Tiempo mostrado: 0.003 s.
-- =========================================================
EXPLAIN
SELECT f.id_factura, f.fecha_factura, f.subtotal, f.iva,
       f.total, os.id_orden,
       es.nombre_estado AS estado_factura
FROM facturas f
INNER JOIN ordenes_servicio os ON f.id_orden = os.id_orden
INNER JOIN estados es ON f.id_estado = es.id_estado
WHERE f.fecha_factura >= '2026-01-01'
  AND f.fecha_factura < '2027-01-01';

ANALYZE
SELECT f.id_factura, f.fecha_factura, f.subtotal, f.iva,
       f.total, os.id_orden,
       es.nombre_estado AS estado_factura
FROM facturas f
INNER JOIN ordenes_servicio os ON f.id_orden = os.id_orden
INNER JOIN estados es ON f.id_estado = es.id_estado
WHERE f.fecha_factura >= '2026-01-01'
  AND f.fecha_factura < '2027-01-01';

-- =========================================================
-- CONSULTA 5: ORDER BY DE FACTURAS
-- EXPLAIN: ALL, key=NULL, Using filesort.
-- ANALYZE: r_rows=10, tiempo=0.001 s.
-- =========================================================
EXPLAIN
SELECT id_factura, fecha_factura, total, id_orden
FROM facturas
ORDER BY fecha_factura DESC;

ANALYZE
SELECT id_factura, fecha_factura, total, id_orden
FROM facturas
ORDER BY fecha_factura DESC;

-- =========================================================
-- REESCRITURA: EVITAR FUNCION SOBRE COLUMNA INDEXADA
-- Original YEAR(fecha_ingreso): ALL, key=NULL;
-- r_rows=10012, r_filtered=88.40%, tiempo=0.005 s.
-- =========================================================
EXPLAIN
SELECT id_orden, fecha_ingreso, id_equipo
FROM ordenes_servicio
WHERE YEAR(fecha_ingreso) = 2026;

ANALYZE
SELECT id_orden, fecha_ingreso, id_equipo
FROM ordenes_servicio
WHERE YEAR(fecha_ingreso) = 2026;

-- Reescritura por rango: possible_keys reconoce el índice,
-- pero key=NULL y type=ALL por la baja selectividad anual.
-- r_rows=10012, r_filtered=88.40%, tiempo=0.005 s.
EXPLAIN
SELECT id_orden, fecha_ingreso, id_equipo
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

ANALYZE
SELECT id_orden, fecha_ingreso, id_equipo
FROM ordenes_servicio
WHERE fecha_ingreso >= '2026-01-01'
  AND fecha_ingreso < '2027-01-01';

-- =========================================================
-- REVISION DE INDICES Y ESTADISTICAS
-- No se encontraron indices duplicados evidentes.
-- Se conservan los indices de PK y relaciones.
-- =========================================================
SHOW INDEX FROM ordenes_servicio;
SHOW INDEX FROM facturas;
SHOW INDEX FROM equipos;
SHOW INDEX FROM estados;

ANALYZE TABLE ordenes_servicio;
