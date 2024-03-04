DROP DATABASE IF EXISTS empire;
CREATE DATABASE empire;
USE empire;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20),
apellidos VARCHAR (30),
es_socio BOOLEAN default false,
categoria_favorita_juego VARCHAR(40)
);

DESCRIBE cliente;

CREATE TABLE torneo(
id_torneo INT PRIMARY KEY AUTO_INCREMENT,
precio_entrada DECIMAL(6,2),
precio_premio DECIMAL(6,2),
descuento DECIMAL (6,2),
categoria_juego VARCHAR (30),
nombre VARCHAR(30)
);

DESCRIBE torneo;

CREATE TABLE producto(
id_producto INT PRIMARY KEY AUTO_INCREMENT,
nombre_producto VARCHAR(40),
categoria_juego VARCHAR(40),
descuento INT,
precio DECIMAL(6,2),
id_torneo INT,
CONSTRAINT fk_torneo_producto FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

DESCRIBE producto;

CREATE TABLE proveedor(
id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
nombre_proveedor VARCHAR(20),
empresa VARCHAR(20),
es_socio BOOLEAN default false
);

DESCRIBE proveedor;



CREATE TABLE juego(
id_cliente INT,
id_torneo INT,
fecha_torneo DATE,
PRIMARY KEY(id_cliente, id_torneo, fecha_torneo),
CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
CONSTRAINT fk_torneo FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo)
);

DESCRIBE juego;

CREATE TABLE compra(
id_cliente INT,
id_producto INT,
fecha_compra DATE,
PRIMARY KEY(id_cliente, id_producto, fecha_compra),
CONSTRAINT fk_cliente_compra FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

DESCRIBE compra;

CREATE TABLE provision(
id_proveedor INT,
id_producto INT,
fecha_provision DATE,
PRIMARY KEY(id_proveedor, id_producto, fecha_provision),
CONSTRAINT fk_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
CONSTRAINT fk_producto_provision FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

DESCRIBE provision;

INSERT INTO cliente(nombre, apellidos, es_socio, categoria_favorita_juego)
VALUES ('David', 'Marin Lopez', true, 'Miniaturas'),
('Pepe', 'Dominguez Castro', false, 'Magic'),
('Ruben', 'Rodriguez Almegri', true, 'Juegos de mesa'),
('Elmencio', 'Pardu Sanchez', true, 'FunkoPop'),
('Pancho', 'Varona Argüez', true, 'Magic'),
('Rodrigo', 'Quesada Antunez', true, 'Magic');

SELECT * FROM cliente;

INSERT INTO torneo(precio_entrada, precio_premio, descuento, categoria_juego, nombre)
VALUES (10, 50, 5, 'Miniaturas', 'Final Four Warhammer 40.000'),
(20, 100, 3.5, 'Magic', 'Grand Prix Copenaghe'),
(5, 80, 1.5, 'Juego de mesa', 'Sounds of Demacia'),
(5, 1000, 10, 'Magic', 'Pro Tour Espana'),
(15, 250, 5.7, 'Magic', 'Grand Prix Espana'),
(150, 25, 10.2, 'Juego de mesa', 'Sinsentido 2024'),
(230, 120, 6.2, 'Magic', 'Buyout Spain');

SELECT * FROM torneo;


INSERT INTO producto(nombre_producto, categoria_juego, descuento, precio, id_torneo)
VALUES ('Descent', 'Juego de mesa', 15, 100, 3),
('Dominaria Remastered', 'Magic', 5, 90.70, 5),
('Ravnica Legends', 'Magic', 5, 80.5,2),
('Lord of Tales', 'Magic', 2, 63.5,7),
('Runaterra', 'Magic', 2, 75.2,5),
('Ejercito terrano', 'Miniaturas', 10, 120.80, 1),
('Miles Morales', 'Funko', 0, 12.99,3);


SELECT * FROM producto;

INSERT INTO proveedor(nombre_proveedor, empresa, es_socio)
VALUES('Juan', 'Sagitario S.A', true),
('David', 'Almensa S.L', false),
('Alonso', 'Copinsa S.A', false),
('Horacio', 'Almagro S.A', false),
('Javier', 'Eretium S.L', false),
('Rafael', 'Copinsa S.A', false),
('Arturo', 'Jupiter S.L', false);

SELECT * FROM proveedor;

INSERT INTO juego(id_cliente, id_torneo, fecha_torneo)
VALUES(1,1, '2024-02-14'),
(2,2, '2024-02-14'),
(3,4, '2024-03-20'),
(4,6, '2024-03-20'),
(5,4, '2024-03-20'),
(6,5, '2024-05-25');

SELECT * FROM juego;

INSERT INTO compra(id_cliente, id_producto, fecha_compra)
VALUES (1, 4, '2024-03-03'),
(2, 1, '2024-02-15'),
(3, 3, '2024-01-03'),
(4, 2, '2024-01-05'),
(5, 1, '2024-04-04'),
(6, 3, '2024-02-19');



SELECT * FROM compra;

INSERT INTO provision (id_proveedor, id_producto, fecha_provision)
VALUES (1, 1, '2023-12-02'),
(2, 2, '2023-11-15'),
(3, 3, '2024-01-20'),
(4, 4, '2024-01-22'),
(5, 5, '2024-01-05'),
(6, 6, '2023-12-12'),
(7, 7, '2023-12-20');
SELECT * FROM provision;
