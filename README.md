# ProyectoCZ – Base de Datos para Gestión de Servicios Técnicos

## 1. Descripción del proyecto

**proyectocz** es un proyecto académico desarrollado en la asignatura Bases de Datos II. Su propósito es gestionar la información de un establecimiento de servicios técnicos mediante una base de datos relacional implementada en MariaDB.

La base de datos permite organizar información de clientes, equipos, órdenes de servicio, técnicos, reparaciones, asignaciones, facturas y estados, incorporando mecanismos de integridad, automatización, seguridad, auditoría y respaldo.

## 2. Tecnologías utilizadas

- MariaDB
- Docker
- Docker Compose
- MySQL Workbench
- SQL
- Bash
- Linux / WSL Ubuntu

## 3. Funcionalidades implementadas

- Gestión de clientes, equipos y órdenes de servicio.
- Organización de estados mediante una entidad centralizada.
- Registro del historial de cambios de estado.
- Procedimientos almacenados para consultas y operaciones.
- Funciones SQL para cálculos, clasificación y validaciones.
- Vistas para facilitar la consulta de información.
- Triggers para auditoría y registro automático de cambios.
- Roles y usuarios con permisos diferenciados.
- Protección y tratamiento de información sensible.
- Consultas de análisis y revisión de índices.
- Respaldo automatizado y restauración de prueba.

## 4. Requisitos

Para ejecutar o administrar el proyecto se requieren las siguientes herramientas:

- Docker instalado.
- Docker Compose.
- Linux, Ubuntu o WSL.
- MariaDB.
- MySQL Workbench, opcional para administrar y visualizar la base de datos.

## 5. Instalación

### Clonar el repositorio

```bash
git clone https://github.com/criatianzu27-beep/proyectocz.git
```

Ingresar al directorio del proyecto:

```bash
cd proyectocz
```

### Ejecución

El proyecto utiliza Docker para facilitar la ejecución del entorno de base de datos.

Los archivos de configuración y scripts SQL permiten preparar la base de datos, sus estructuras, datos y objetos programables, según los archivos disponibles en el repositorio.

La instalación debe realizarse siguiendo las instrucciones y archivos incluidos en el proyecto.

## 6. Base de datos

La base de datos principal del proyecto se denomina:

```sql
proyectocz
```

Entre las tablas que forman parte del sistema se encuentran:

- `clientes`
- `equipos`
- `ordenes_servicio`
- `facturas`
- `estados`
- `historial_estados`
- `tecnicos`
- `reparaciones`
- `asignaciones`
- `auditoria_clientes`
- `log_errores`
- `usuarios_seguridad`

Estas tablas permiten organizar la información del establecimiento y establecer relaciones entre los diferentes registros.

## 7. Objetos SQL implementados

### Procedimientos almacenados

Se implementaron procedimientos almacenados para apoyar las consultas, conteos, gestión y actualización de información relacionada con las órdenes de servicio.

### Funciones

Se desarrollaron funciones SQL para realizar cálculos, clasificaciones y validaciones relacionadas con los datos del sistema.

### Vistas

Se crearon vistas para facilitar la consulta de información relacionada y presentar datos de diferentes tablas de manera organizada.

### Triggers

Se implementaron triggers para automatizar determinados registros y apoyar los mecanismos de auditoría e historial de cambios.

## 8. Seguridad

El proyecto incorpora mecanismos de seguridad para administrar el acceso a la base de datos.

Se trabajaron roles de consulta, operación y administración con permisos diferenciados según las responsabilidades.

También se implementaron mecanismos relacionados con la validación de credenciales, protección de información sensible, enmascaramiento de datos y auditoría.

## 9. Transacciones y concurrencia

Se trabajaron operaciones transaccionales para revisar el comportamiento de la base de datos frente a operaciones que pueden confirmarse o revertirse.

Las pruebas de transacciones y concurrencia se documentan de acuerdo con las operaciones ejecutadas y verificadas durante el desarrollo del proyecto.

## 10. Optimización

Se realizaron consultas de análisis mediante `EXPLAIN` y revisión de índices para observar los planes de ejecución de consultas y los índices existentes en las tablas.

La comparación de rendimiento antes y después de modificaciones en índices constituye una actividad de análisis que debe sustentarse con mediciones verificadas.

## 11. Respaldo y recuperación

El proyecto incluye un script Bash orientado a realizar respaldos de la base de datos, comprimir los archivos generados y verificar su integridad.

También se trabajó la programación de respaldos y un simulacro de restauración en una base de datos independiente denominada `proyectocz_restaurada`.

La recuperación se verificó mediante la revisión de las tablas y la comparación de conteos de registros.

## 12. Pruebas y resultados

Las pruebas del proyecto se realizaron mediante consultas SQL y revisión de resultados en MariaDB.

Se verificaron diferentes elementos, entre ellos:

- Consultas de datos.
- Objetos SQL.
- Consultas relacionadas con estados.
- Conteos de registros.
- Permisos y roles.
- Respaldo y restauración.

Los resultados y evidencias de las pruebas permiten documentar el funcionamiento de los componentes desarrollados.

## 13. Atención a la retroalimentación

Durante el desarrollo se realizaron ajustes al modelo y a diferentes componentes de la base de datos, teniendo en cuenta las observaciones recibidas.

Entre los cambios realizados se destacan la centralización de estados mediante la tabla `estados`, la organización del historial de cambios, los ajustes en seguridad y la implementación de mecanismos de respaldo y recuperación.

## 14. Conclusiones

El proyecto permitió aplicar los conceptos estudiados en Bases de Datos II mediante la construcción y fortalecimiento de una base de datos relacional para la gestión de servicios técnicos.

Se trabajaron aspectos de diseño, integridad, programación SQL, seguridad, auditoría, consultas, índices y respaldo y recuperación, contribuyendo a una organización más estructurada de la información.

## 15. Autor

**Cristian Zuluaga Escalante**

Proyecto académico desarrollado para la asignatura **Bases de Datos II**.

Corporación de Estudios Tecnológicos del Norte del Valle – COTECNOVA.

## 16. Repositorio

GitHub:

https://github.com/criatianzu27-beep/proyectocz
