-- Empezamos creando la base de datos para la empresa de renta de peliculas. 
CREATE DATABASE sakilacampus;

-- entramos a la base de datos
USE sakilacampus;

-- empezamos creando las tablas que contendra la base de datos, empezaremos por el almacen.


-- se crea la tabla para identificar cada pais 
CREATE TABLE pais(
	id_pais SMALLINT unsigned PRIMARY KEY,
	nombre varchar (50),
	ultima_actualizacion timestamp
);


-- se crea la tabla para las cuidades que tienen los almacenes 
CREATE TABLE ciudad(
	id_ciudad SMALLINT UNSIGNED PRIMARY KEY,
	nombre varchar(50),
	id_pais SMALLINT UNSIGNED,
	ultima_actualizacion timestamp,
	CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);


-- se crean las direcciones de cada una de las sucursoales.
CREATE TABLE direccion(
	id_direccion SMALLINT unsigned PRIMARY KEY,
	direcion varchar (50),
	direccion2 varchar(50),
	distrito varchar(20),
	id_ciudad SMALLINT unsigned,
	codigo_postal varchar(10),
	telefono varchar (20),
	ultima_actualizacion timestamp,
	CONSTRAINT fk_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
	);


-- tabla para los almacenes 
CREATE TABLE almacen(
	id_almacen TINYINT unsigned PRIMARY KEY,
	id_empleado_jefe TINYINT unsigned,
	id_direccion SMALLINT unsigned,
	ultima_actualizacion timestamp,
	CONSTRAINT fk_almacen FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
	);


-- seguimos creando ahora a los empleados de los almacenes 
CREATE TABLE  empleado(
	id_empleado TINYINT UNSIGNED PRIMARY KEY,
	nombre varchar(45),
	apellidos varchar (45),
	id_direccion SMALLINT UNSIGNED,
	imagen BLOB,
	email varchar(50),
	id_almacen TINYINT UNSIGNED,
	activo TINYINT(1),
	username varchar(16),
	password varchar(40),
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
	CONSTRAINT f_emple FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);
	
-- creamos la tabla para el idioma 
CREATE TABLE idioma(
	id_idioma TINYINT UNSIGNED PRIMARY KEY,
	nombre varchar(20),
	ultima_actualizacion timestamp
);




-- creamos la tabla para las peliculas
CREATE TABLE pelicula(
	id_pelicula SMALLINT unsigned PRIMARY KEY,
	titulo varchar(250),
	descripcion text,
	anyo_lanzamiento year,
	id_idioma TINYINT UNSIGNED,
	id_idioma_original TINYINT UNSIGNED,
	duracion_alquiler TINYINT UNSIGNED,
	rental_rate decimal(4,2),
	duracion SMALLINT UNSIGNED,
	replacement_cost decimal(5,2),
	clasificacion enum('G','PG', 'PG-13', 'R', 'NC-17'),
	caracteristicas_especiales SET('trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes'),
	ultima_actualizacion timestamp,
	CONSTRAINT fk_idioma FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
	FOREIGN KEY (clasificacion) REFERENCES categoria(id_categoria)
	);

	-- creamos la tabla para el inventario 
CREATE TABLE inventario(
	id_inventartio MEDIUMINT UNSIGNED PRIMARY KEY,
	id_pelicula SMALLINT UNSIGNED,
	id_almacen tinyint UNSIGNED,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
	CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

	-- CREAMOS LAS TABLAS PARA LAS CATEGORIAS 
	CREATE TABLE categoria(
	id_categoria TINYINT UNSIGNED PRIMARY KEY,
	nombre varchar (25),
	ultima_actualizacion timestamp
	);

	-- creamos la tabla que une categorias con peliculas para quitar la informacion muchos a muchos 
	CREATE TABLE pelicula_categoria (
	id_pelicula SMALLINT UNSIGNED, 
	id_categoria TINYINT UNSIGNED,
	ultima_actualizacion timestamp, 
	CONSTRAINT fk_catego FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
	FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
	);

	-- CREAMOS LA TABLA PARA LOS ACTORES DE LAS PELICULAS
CREATE TABLE actor (
	id_actor SMALLINT UNSIGNED PRIMARY KEY,
	nombre varchar(45),
	apellidos varchar(45),
	ultima_actualizacion timestamp
);

-- creamos la relacion entre la tabla actores y peliculas 
CREATE TABLE pelicula_actor(
	id_actor SMALLINT UNSIGNED,
	id_pelicula SMALLINT UNSIGNED,
	ultima_actulizacion timestamp 
	);

-- CREAMOS LA TABLA PARA EL CLIENTE 
CREATE TABLE cliente(
	id_cliente SMALLINT UNSIGNED PRIMARY KEY,
	id_almacen TINYINT UNSIGNED,
	nombre varchar(45),
	apellidos varchar(45),
	email varchar(50),
	id_direccion SMALLINT UNSIGNED,
	activo TINYINT(1),
	fecha_creacion DATETIME,
	ultima_actualizacion timestamp,
	FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
	FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

-- creamos la tabla para alquilar las peliculas 
CREATE TABLE alquiler(
	id_alquiler INT UNIQUE PRIMARY KEY,
	fecha_alquiler datetime,
	id_inventario MEDIUMINT UNSIGNED,
	id_cliente SMALLINT UNSIGNED, 
	fecha_devolucion DATETIME,
	id_empleado TINYINT UNSIGNED,
	ultima_actualizacion timestamp,
	CONSTRAINT fk_inventario FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventartio),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);


-- se hace la tabla para realizar los pagos
CREATE TABLE pago(
	id_pago SMALLINT UNSIGNED PRIMARY KEY,
	id_cliente SMALLINT UNSIGNED,
	id_empleado TINYINT UNSIGNED, 
	id_alquiler INT,
	total decimal(5,2),
	fecha_pago DATETIME,
	ultima_actualizacion timestamp, 
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
	FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);


-- se crea la tabla del texto que no esta conectada a nada 
CREATE TABLE film_text (
	film_id SMALLINT,
	title varchar(255),
	descripcion text
);



