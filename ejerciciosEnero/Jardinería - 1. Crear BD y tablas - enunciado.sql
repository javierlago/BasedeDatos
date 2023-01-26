#--------------------------------------------------------------------------------------------
#	CREACIÓN Y USO DE LA BASE DE DATOS 'Jardineria'
#----------------------------------------------------------------------------------------
drop database if exists Jardineria;
create database Jardineria;
use Jardineria;
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'oficina'
#--------------------------------------------------------------------------------------------
#		oficinaID			cadena de texto 10, no nulo
#		ciudad				cadena de texto 30, no nulo
#		pais				cadena de texto 50, no nula
#		region				cadena de texto 50, no nula
#		CP					cadena de texto 10, no nula
#		telefono			cadena de texto 20, no nula
#		linea_direccion1	cadena de texto 50, no nulo
#		linea_direccion2	cadena de texto 50, por defecto nulo
#
#		Clave primaria		oficinaID
#--------------------------------------------------------------------------------------------
create table oficina(
oficinaID						varchar(10) 		not null,
ciudad							varchar(30)			not null,
pais							varchar(50)			not null,
region							varchar(50) 		not null,
CP				                varchar(10)			not null,
telefono		                varchar(20)			not null,
linea_direccion1				varchar(10)		    not null,
linea_direccion2                varchar(20)			not null,
primary key(oficinaID)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'empleado'
#--------------------------------------------------------------------------------------------
#		empleadoID		entero
#		nombre			cadena de caracteres 50
#		apellido1		cadena de caracteres 50
#		apellido2		cadena de caracteres 50, puede no existir para algún empleado
#		extension		cadena de caracteres 10
#		email			cadena de caracteres 100
#		oficina			cadena de caracteres 10
#		jefe			entero, nulo por defecto
#		puesto			cadena de caracteres 50
#
#		Clave primaria		empleadoID
#		clave foránea		oficina		enlace con la tabla oficina
#		clave foránea		jefe		enlace con la tabla empleado		
#--------------------------------------------------------------------------------------------
create table empleado(
empleadoID					int,
nombre						varchar(50)		not null,
apellido1					varchar(50)		not null,
apellido2					varchar(50)		not null,
extension					varchar(10)		not null,
email						varchar(100)	not null,
oficina						varchar(10)		not null,
jefe						int      		null,
puesto						varchar(50)		null,
primary key(empleadoID),
foreign key(oficina) references oficina(oficinaID),
foreign key(jefe) references empleado(empleadoID)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'gama_producto'
#--------------------------------------------------------------------------------------------
#		gama				cadena de caracteres 50
#		descripcion_texto	cadena de caracteres
#		descripcion_html	cadena de caracteres
#		imagen				cadena de caracteres 256
#
#		Clave primaria		gama
#--------------------------------------------------------------------------------------------
create table gama_producto(
gama						varchar(50),
descripcion_texto			char,	
descripcion_html			char,
imagen						varchar(256),
primary key(gama)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'cliente'
#--------------------------------------------------------------------------------------------
#		clienteID				entero
#		nombre_cliente			cadena de caracteres 50
#		nombre_contacto			cadena de caracteres 30 -> puede no haber
#		apellido_contacto		cadena de caracteres 50 -> puede no haber
#		telefono				cadena de caracteres 15
#		fax						cadena de caracteres 15
#		linea_direccion1		cadena de caracteres 50
#		linea_direccion2		cadena de caracteres 50 -> puede no haber
#		ciudad					cadena de caracteres 50
#		region					cadena de caracteres 50
#		pais					cadena de caracteres 50
#		CP						cadena de caracteres 10
#		representante_ventas	entero -> puede no haber
#		limite_credito			valor decimal (15,2) -> puede no haber
#
#		Clave primaria		clienteID
#		clave foránea		representante_ventas	enlace con la tabla empleado		
#--------------------------------------------------------------------------------------------
create table cliente(
clienteID						int,	
nombre_cliente					varchar(50),
nombre_contacto					varchar(30),
apellido_contacto				varchar(50),
telefono			            varchar(15),
fax								varchar(15),
linea_direccion1	            varchar(50),
linea_direccion2				varchar(50),
ciudad				            varchar(50),
region							varchar(50),
pais				            varchar(50),
CP								varchar(10),
representante_ventas			int,
limite_credito					float,
primary key(ClienteID),							
foreign key(representante_ventas) references empleado(empleadoID)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'pedido'
#--------------------------------------------------------------------------------------------
#		pedidoID				entero
#		fecha_pedido			fecha
#		fecha_esperada			fecha
#		fecha_entrega			fecha -> puede ser nulo
#		estado					cadena de caracteres 15
#		comentarioa				cadena de caracteres
#		cliente					entero, no nulo
#
#		Clave primaria		pedidoID
#		clave foránea		cliente		enlace con la tabla cliente
#--------------------------------------------------------------------------------------------
create table pedido(
pedidoID					int,
fecha_pedido				date,
fecha_esperada				date,
fecha_entrega				date,
estado						varchar(15),
comentarioa					char,	
cliente						int,	
primary key(pedidoID),
foreign key (cliente) references cliente(clienteID)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'PRODUCTO'
#--------------------------------------------------------------------------------------------
#		productoID				cadena de caracteres 15
#		nombre					cadena de caracteres 70
#		gama					cadena de caracteres 50
#		dimensiones				cadena de caracteres 25 -> puede ser nulo
#		proveedor				cadena de caracteres 50 -> puede ser nulo
#		descripcion				cadena de caracteres	-> puede ser nulo
#		cantidad_en_stock		entero pequeño, no nulo
#		precio_venta			numérico 15 y 2 decimales
#		precio_proveedor		numérico 15 y 2 decimales
#
#		Clave primaria		productoID
#		clave foránea		gama		enlace con la tabla gama_producto
#--------------------------------------------------------------------------------------------
create table producto(
productoID				varchar(15),	
nombre					varchar(70),
gama					varchar(50),
dimensiones				varchar(25),
proveedor				varchar(50),
descripcion				text,
cantidad_en_stock		smallint		not null,
precio_venta			decimal(15,2)			not null,					
precio_proveedor		decimal(15,2)			not null,	
primary key(productoID),
foreign key(gama) references gama_producto(gama)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'detalle_pedido'
#--------------------------------------------------------------------------------------------
#		pedidoID				entero
#		productoID				cadena de caracteres 15
#		cantidad				entero
#		precio_unidad			numérico 15 y 2 decimales
#		linea					entero pequeño, no nulo
#
#		Clave primaria		pedidoID, productoID
#		clave foránea		productoID		enlace con la tabla producto
#		clave foránea		pedidoID		enlace con la tabla pedido
#--------------------------------------------------------------------------------------------
create table detalle_pedido(
pedidoID			int,
productoID			varchar(15)		not null,
cantidad			int				not null,
precio_unidad		decimal(15,2)   not null,
linea				smallint		not null,
primary key(pedidoID,productoID),
foreign key(productoID) references producto(productoID),
foreign key(pedidoID) references pedido(pedidoID)
);
#--------------------------------------------------------------------------------------------
#	CREACIÓN DE LA TABLA 'pago'
#--------------------------------------------------------------------------------------------
#		clienteID				entero
#		forma_pago				cadena de caracteres 40
#		transaccion				cadena de caracteres 50
#		fecha_pago				fecha -> puede ser nulo
#		total					numérico 15 y 2 decimales
#
#		Clave primaria		clienteID, transaccion
#		clave foránea		clienteID		enlace con la tabla cliente
#--------------------------------------------------------------------------------------------
create table pago(
clienteID 				int,	
forma_pago				varchar(40),
transaccion				varchar(50),
fecha_pago				date,
total					decimal(15,2),
primary key(clienteID,transaccion),
foreign key(clienteID) references cliente(clienteID)
);
#--------------------------------------------------------------------------------------------
#	DICCIONARIO DE DATOS
#--------------------------------------------------------------------------------------------
