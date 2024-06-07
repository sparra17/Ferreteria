Use Ferreteria

select * from Roles

update Roles
set
	FechaCreacion = GETDATE()


select * from Usuarios

update Usuarios
set
	FechaCreacion = GETDATE()




create procedure SP_AccesoUsuarios
@Correo varchar(100),
@Contrasena varchar(50)
as
begin
	select * from Usuarios
	where
	Correo = @Correo
	and Contrasena = @Contrasena
	and Estado = 1
end
go

exec SP_AccesoUsuarios 'jesusparra@gmail.com', 123456 



select * from Categorias

insert into Categorias values
('Electricidad',GETDATE(),1),
('Construccion',GETDATE(),1),
('Plomeria',GETDATE(),1)


/*----------------------------------*/

-----CRUD CATEGORIAS-----  
-----Listar las Categorias-----  
ALTER procedure SP_ListarCategorias  
as  
begin  
 select 
	 idCategoria,
	 Categoria,
	 convert(varchar,FechaCreacion,103) as FechaCreacion,
	 Estado
 from Categorias  
 where Estado = 1  
end 

update Categorias
set Estado=1

select * from Unidades
insert into Unidades values
('Pieza',GETDATE(),1), ('Caja',GETDATE(),1), ('Kilo',GETDATE(),1), ('Bulto',GETDATE(),1)



SP_HELPTEXT SP_ListarCategorias
CREATE procedure SP_ListarCategorias    
as    
begin    
 select   
  idCategoria,  
  Categoria,  
  convert(varchar,FechaCreacion,103) as FechaCreacion,  
  Estado  
 from Categorias    
 where Estado = 1    
end 

SP_HELPTEXT SP_ListarUnidades

-----CRUD Unidades-----  
-----Listar las Unidades-----  
ALTER procedure SP_ListarUnidades  
as  
begin  
 select 
 idUnidad,
 Unidad,
 convert(varchar,FechaCreacion,103) as FechaCreacion,
 Estado
 from Unidades  
 where Estado = 1  
end


---------------
select * from Clientes


insert into Clientes values
('Publico','General','','NU','Ni�os Heroes #1 Juan Lucas','4111568181','ferrematerialeschuy@gmail.com','XEXX010101HNEXXXA4','XAXX010101000',GETDATE(),1)


--------------------------------------
select * from Proveedores

insert into Proveedores values
('Truper','Santiago Nu�ez','TRP011108DJ5','4641572156','Ponciano Vega','ventas@truper.com',GETDATE(),1)

SP_HELPTEXT SP_ListarProveedores
----CRUD Proveedores-----  
-----Listar los Proveedores-----  
alter procedure SP_ListarProveedores  
as  
begin  
 select
 idProveedor,
 Proveedor,
 NombreContacto,
 RFC,
 Telefono,
 Direccion,
 Correo,
 convert(varchar,FechaCreacion,103) as FechaCreacion,
 Estado
 from Proveedores  
 where Estado = 1  
end

-------------------------------------
select * from Productos

insert into Productos values
('17560','Silicon Blanco','Silicon Blanco. Con uso en Vidrio, aluminio, ceamica, porcelana, madera, hierro, etc.',1,3,1,82,99,24,'15/11/2025','',GETDATE(),'1')


SP_HELPTEXT SP_ListarProductos
-----CRUD Productos-----  
-----Listar los Productos-----  
ALTER procedure SP_ListarProductos  
as  
begin  
 SELECT        
 Productos.idProducto, 
 Productos.Codigo, 
 Productos.NombreProducto, 
 Productos.Descripcion, 
 Productos.idProveedor, 
 Productos.idCategoria, 
 Productos.idUnidad, 
 Productos.PCompra, 
 Productos.PVenta, 
 Productos.Stock, 
 Productos.FechaVencimiento, 
 Productos.Imagen, 
 Productos.FechaCreacion, 
 Productos.Estado, 
 Proveedores.Proveedor, 
 Categorias.Categoria, 
 Unidades.Unidad
FROM            
Productos INNER JOIN
Proveedores ON Productos.idProveedor = Proveedores.idProveedor INNER JOIN
Categorias ON Productos.idCategoria = Categorias.irdCategoria INNER JOIN
Unidades ON Productos.idUnidad = Unidades.idUnidad
 where PRODUCTOS.Estado = 1  
end  


alter procedure SP_ListarProductos
as
begin
 SELECT
 pr.idProducto,
 pr.Codigo,
 pr.NombreProducto,
 pr.Descripcion,
 pr.idProveedor,
 pr.idCategoria,
 pr.idUnidad,
 pr.PCompra,
 pr.PVenta,
 pr.Stock,
 convert(varchar,pr.FechaVencimiento,103) as FechaVencimiento,
 pr.Imagen,
 convert(varchar,pr.FechaCreacion,103) as FechaCreacion,
 pr.Estado,
 pv.Proveedor,
 c.Categoria,
 u.Unidad
FROM
Productos as pr INNER JOIN
Proveedores as pv ON pr.idProveedor = pv.idProveedor INNER JOIN
Categorias as c ON pr.idCategoria = c.idCategoria INNER JOIN
Unidades as u ON pr.idUnidad = u.idUnidad
 where pr.Estado = 1
end
go

------------------------------
select * from Usuarios

select * from Roles

insert into Roles values ('Vendedor',GETDATE(),1),('Repartidor',GETDATE(),1)

SP_HELPTEXT SP_InsertNUsuarios


-----CRUD Usuarios-----  
-----Listar los Usuarios-----  
alter procedure SP_ListarUsuarios  
as  
begin  
 SELECT        
 U.idUsuario, 
 U.Nombre, 
 U.Paterno, 
 U.Materno, 
 U.idRol, 
 U.Sexo, 
 U.Direccion, 
 U.Telefono, 
 U.CURP, 
 U.RFC, 
 U.Correo, 
 U.Contrasena, 
 convert(varchar,U.FechaCreacion,103) as FechaCreacion,
 U.Estado, 
 r.Rol
FROM            
 Usuarios as U INNER JOIN
 Roles as R ON U.idRol = R.idRol 
 where U.Estado = 1  
end  


  
  
-----Registrar Nuevo Usuario-----  
alter procedure SP_InsertNUsuarios  
@Nombre varchar(100),  
@Paterno varchar(50),  
@Materno varchar(50),  
@idRol int,  
@Sexo varchar(2),  
@Direccion varchar(100),  
@Telefono varchar(10),  
@CURP varchar(18),  
@RFC varchar(13),  
@Correo varchar(100),  
@Contrasena varchar(50)  
as  
begin  
 insert into Usuarios  
 (Nombre,Paterno,Materno,idRol,Sexo,Direccion,Telefono,CURP,RFC,Correo,Contrasena,FechaCreacion,Estado)  
 values  
 (@Nombre,@Paterno,@Materno,@idRol,@Sexo,@Direccion,@Telefono,@CURP,@RFC,@Correo,@Contrasena,GETDATE(),1)  
end 


alter table Usuarios
alter column Sexo varchar(2) not null

update Usuarios
set
	Estado = 1


--------------------------
select * from Menu

create table Menu(
idMenu int not null identity primary key,
Menu varchar(150) not null,
Ruta varchar(250) not null,
Identificador varchar(150) not null,
FechaCreacion datetime,
Estado int not null,
)
go

insert into Menu values
('Inicio'			,'../home/'			,'inicio'		,GETDATE(),1),
('Usuario'			,'../MntUsuario/'	,'mntusuario'	,GETDATE(),1),
('Rol'				,'../MntRol/'		,'mntrol'		,GETDATE(),1),
('Producto'			,'../MntProducto/'	,'mntproducto'	,GETDATE(),1),
('Categoria'		,'../MntCategoria/'	,'mntcategoria'	,GETDATE(),1),
('Proveedor'		,'../MntProveedor/'	,'mntproveedor'	,GETDATE(),1),
('Cliente'			,'../MntCliente/'	,'mntcliente'	,GETDATE(),1),
('Unidad De Medida'	,'../MntUndMedida/'	,'mntundmedida'	,GETDATE(),1)


create table MenuDetalle(
idMenuDetalle int not null identity primary key,
idMenu int not null,
idRol int not null,
Permiso varchar(2) not null,
FechaCreacion datetime,
Estado int not null,
constraint FK_MenuDetalleMenu foreign key (idMenu) references Menu(idMenu),
constraint FK_MenuDetalleRol foreign key (idRol) references Roles(idRol)
)
go

select * from MenuDetalle

insert into MenuDetalle values
(1,1,'No',GETDATE(),1),
(2,1,'No',GETDATE(),1),
(3,1,'No',GETDATE(),1),
(4,1,'No',GETDATE(),1),
(5,1,'No',GETDATE(),1),
(6,1,'No',GETDATE(),1),
(7,1,'No',GETDATE(),1),
(8,1,'No',GETDATE(),1),

(1,2,'No',GETDATE(),1),
(2,2,'No',GETDATE(),1),
(3,2,'No',GETDATE(),1),
(4,2,'No',GETDATE(),1),
(5,2,'No',GETDATE(),1),
(6,2,'No',GETDATE(),1),
(7,2,'No',GETDATE(),1),
(8,2,'No',GETDATE(),1),

(1,3,'No',GETDATE(),1),
(2,3,'No',GETDATE(),1),
(3,3,'No',GETDATE(),1),
(4,3,'No',GETDATE(),1),
(5,3,'No',GETDATE(),1),
(6,3,'No',GETDATE(),1),
(7,3,'No',GETDATE(),1),
(8,3,'No',GETDATE(),1)


select * from MenuDetalle

create procedure SP_ListarMenu
@idRol int
as begin
SELECT
MD.idMenuDetalle, 
MD.idMenu, 
MD.idRol, 
MD.Permiso, 
MD.FechaCreacion, 
MD.Estado,
M.Menu,
M.Ruta,
M.Identificador
FROM            
MenuDetalle as MD INNER JOIN
Menu as M on MD.idMenu = M.idMenu
where
MD.idRol = @idRol
end
go


create procedure SP_UpdateMenuS
	@idMenuDetalle int
as
begin
	update MenuDetalle
	set
	Permiso = 'Si'
	where
	idMenuDetalle = @idMenuDetalle
end
go

create procedure SP_UpdateMenuN
	@idMenuDetalle int
as
begin
	update MenuDetalle
	set
	Permiso = 'No'
	where
	idMenuDetalle = @idMenuDetalle
end
go

alter table Menu
add Grupo varchar(150)
go

alter table Menu
add FechaCreacion datetime
go

alter table Menu
add Estado int
go

select * from Menu

update Menu
set
	FechaCreacion = GETDATE()

	update Menu
set
	Estado = 1


alter table Menu
alter column FechaCreacion datetime not null
go

alter table Menu
alter column Estado int not null
go

alter table Menu
alter column Grupo varchar(150) not null
go

SP_HELPTEXT SP_ListarMenu

alter procedure SP_ListarMenu  
@idRol int  
as begin  
SELECT  
MD.idMenuDetalle,   
MD.idMenu,   
MD.idRol,   
MD.Permiso,   
MD.FechaCreacion,   
MD.Estado,  
M.Menu,  
M.Ruta,  
M.Identificador,
M.Grupo
FROM              
MenuDetalle as MD INNER JOIN  
Menu as M on MD.idMenu = M.idMenu  
where  
MD.idRol = @idRol  
end 


select * from usuarios
select * from Menu
select * from MenuDetalle

----------------Compra-------------------------
insert into Menu values
('Nueva Compra'	,'../MntCompra/'	,'mntcompra'	,'Compra',GETDATE(),1),
('Lista Compra'	,'../ListaCompra/'	,'listacompra'	,'Compra',GETDATE(),1),

('Nueva Venta'	,'../MntVenta/'		,'mntventa'		,'Venta',GETDATE(),1),
('Lista Venta'	,'../ListaVenta/'	,'listaventa'	,'Venta',GETDATE(),1)

update MenuDetalle
set
 FechaCreacion = GETDATE()
 where
 FechaCreacion is null

 ----------------Compra----------------------
select * from Proveedores
select * from Productos
select * from Unidades

sp_helptext SP_ListarProductos

CREATE procedure SP_ListarProductosCat
@idCategoria int
as  
begin  
 SELECT  
 pr.idProducto,  
 pr.Codigo,  
 pr.NombreProducto,  
 pr.Descripcion,  
 pr.idProveedor,  
 pr.idCategoria,  
 pr.idUnidad,  
 pr.PCompra,  
 pr.PVenta,  
 pr.Stock,  
 convert(varchar,pr.FechaVencimiento,103) as FechaVencimiento,  
 pr.Imagen,  
 convert(varchar,pr.FechaCreacion,103) as FechaCreacion,  
 pr.Estado,  
 pv.Proveedor,  
 c.Categoria,  
 u.Unidad  
FROM  
Productos as pr INNER JOIN  
Proveedores as pv ON pr.idProveedor = pv.idProveedor INNER JOIN  
Categorias as c ON pr.idCategoria = c.idCategoria INNER JOIN  
Unidades as u ON pr.idUnidad = u.idUnidad  
 where
 pr.idCategoria = @idCategoria
 and pr.Estado = 1  
end

sp_helptext SP_ListarProductosID
  
  
-----Listar los Productos Por ID-----  
alter procedure SP_ListarProductosID  
@idProducto int  
as  
begin  
  SELECT  
 pr.idProducto,  
 pr.Codigo,  
 pr.NombreProducto,  
 pr.Descripcion,  
 pr.idProveedor,  
 pr.idCategoria,  
 pr.idUnidad,  
 pr.PCompra,  
 pr.PVenta,  
 pr.Stock,  
 convert(varchar,pr.FechaVencimiento,103) as FechaVencimiento,  
 pr.Imagen,  
 convert(varchar,pr.FechaCreacion,103) as FechaCreacion,  
 pr.Estado,  
 pv.Proveedor,  
 c.Categoria,  
 u.Unidad  
FROM  
Productos as pr INNER JOIN  
Proveedores as pv ON pr.idProveedor = pv.idProveedor INNER JOIN  
Categorias as c ON pr.idCategoria = c.idCategoria INNER JOIN  
Unidades as u ON pr.idUnidad = u.idUnidad  
 where pr.idProducto = @idProducto  
end

-------------COMPRA-------------------
create table Compras(
idCompra int not null identity primary key,
idProveedor int not null,
RFC varchar(13),
Direccion varchar(100) not null,
NombreContacto varchar(100) not null,
Subtotal numeric(18,2),
IVA numeric(18,2),
Descuento numeric(18,2),
Total numeric(18,2),
idUsuario int not null,
FechaCreacion datetime,
Estado int not null
)
go

select * from compras

alter procedure SP_InCompras
@idUsuario int
as
begin
set nocount on
	insert into Compras
	(idUsuario,Estado)
	values
	(@idUsuario,2)

	select idCompra from Compras where idCompra = @@IDENTITY
set nocount off
end
go



alter table Compras
alter column idProveedor int
go

alter table Compras
alter column Direccion varchar(100)
go

alter table Compras
alter column NombreContacto varchar(100)
go

select * from compras

truncate table compras


create table DetalleCompra(
idDetCompra int not null identity primary key,
idCompra int,
idProducto int,
PCompra numeric (18,2),
Cantidad numeric (18,2),
Total numeric (18,2),
FechaCreacion datetime,
Estado int
)
go

select * from DetalleCompra where idCompra = 20
select * from Compras


-- Actualizar productos con el mismo id y agregar en la cantidad
alter procedure SP_InDetCompra
@idCompra int,
@idProducto int,
@PCompra numeric(18,2),
@Cantidad int
as
begin

	DECLARE @idExistente int;
	DECLARE @Estado int;

	SELECT @idExistente = idProducto,@Estado = Estado
    FROM DetalleCompra
    WHERE idCompra = @idCompra AND idProducto = @idProducto;

	if @idExistente = @idProducto and @Estado = 1
	begin
		UPDATE DetalleCompra
        SET Cantidad = Cantidad + @Cantidad,
		Total = Total + (@PCompra * @Cantidad)
		WHERE idCompra = @idCompra AND idProducto = @idProducto;
	end
		else if @idExistente = @idProducto and @Estado = 0
		begin
			UPDATE DetalleCompra
			SET Estado = 1, Cantidad = @Cantidad,
			Total = @PCompra * @Cantidad
			WHERE idCompra = @idCompra AND idProducto = @idProducto;
		end
	else
	begin
		insert DetalleCompra
		(idCompra,idProducto,PCompra,Cantidad,Total,FechaCreacion,Estado)
		values
		(@idCompra,@idProducto,@PCompra,@Cantidad,@PCompra*@Cantidad,GETDATE(),1)
	end
end
go



create procedure SP_ListarDetCompra
@idCompra int
as
begin
select       
	deco.idDetCompra,
	prd.Codigo,
	prd.NombreProducto,
	prd.Descripcion,
	cat.Categoria,
	und.Unidad,
	prd.PCompra,
	convert(varchar,prd.FechaVencimiento,103) as FechaVencimiento,
	deco.Cantidad, 
    deco.Total,
	deco.idCompra,
	deco.idProducto,
	deco.PCompra
from           
	DetalleCompra as deco INNER JOIN
    Productos as prd ON deco.idProducto = prd.idProducto INNER JOIN
    Proveedores as prv ON prd.idProveedor = prv.idProveedor INNER JOIN
    Categorias as cat ON prd.idCategoria = cat.idCategoria INNER JOIN
    Unidades as und ON prd.idUnidad = und.idUnidad
where
	deco.idCompra = @idCompra
	and deco.Estado = 1
end
go

alter procedure SP_DeleteCompra
	@idDetCompra int
as
begin
	update DetalleCompra
	set Estado = 0
	where idDetCompra=@idDetCompra
end
go


select * from DetalleCompra where idCompra = 11 and Estado=1
select * from Compras where idCompra = 11

alter procedure SP_USubTot
	@idCompra int
as
begin
set nocount on
	update Compras
	set
		Subtotal = (select sum(Total) as SubtotalCompra from DetalleCompra where idCompra = @idCompra and Estado=1),
		IVA = (select sum(Total) * 0.16 as SubtotalCompra from DetalleCompra where idCompra = @idCompra and Estado=1),
		Total = (select sum(Total) as SubtotalCompra from DetalleCompra where idCompra = @idCompra and Estado=1) + (select sum(Total) * 0.16 as SubtotalCompra from DetalleCompra where idCompra = @idCompra and Estado=1)
	where
		idCompra = @idCompra

	select Subtotal,IVA,Descuento,Total from Compras where idCompra = @idCompra
set nocount off
end
go

select sum(Total) * 0.16 as SubtotalCompra from DetalleCompra where idCompra = 11 and Estado=1



select * from DetalleCompra
select * from Compras

select *from Usuarios

truncate table DetalleCompra
truncate table Compras

select * from Proveedores

alter procedure SP_UpCompras
@idCompra int,
@idProveedor int,
@RFC varchar(13),
@Direccion varchar(100),
@NombreContacto varchar(100)
as
begin
	update Compras
	set
		idProveedor = @idProveedor,
		RFC = @RFC,
		Direccion = @Direccion,
		NombreContacto = @NombreContacto,
		FechaCreacion = GETDATE(),
		Estado = 1
	where
	idCompra = @idCompra
end
go

create procedure SP_ListCatProv

as
begin
SELECT idCategoria, Categoria
            FROM Categorias INNER JOIN
			Proveedores pc ON idCategoria = idCategoria
            WHERE pc.idProveedor = $idProveedor
end

select idCategoria, Categoria, idProveedor from Productos


alter procedure SP_ListarCategoriasProv
@idCategoria int,
@idProveedor int
as
begin
	SELECT       
	Categorias.idCategoria,
	Categorias.Categoria,
	Categorias.FechaCreacion,
	Categorias.Estado,
	Proveedores.idProveedor,
	Proveedores.Proveedor
FROM            Categorias CROSS JOIN
                         Proveedores
	where idCategoria = @idCategoria
	and idProveedor = @idProveedor
end
go

select * from Usuarios
select * from Clientes

SP_ListDatos 4
alter procedure SP_ListDatos
@idCompra int
as
begin
SELECT
	com.idCompra,
	com.idProveedor,
	com.RFC,
	com.Direccion,
	com.NombreContacto,
	com.Subtotal,
	com.IVA,
	com.Descuento,
	com.Total,
	com.idUsuario,
	convert(varchar,com.FechaCreacion,103) as FechaCreacion,  
	com.Estado,
	cli.Direccion AS DireccionCli,
	FORMAT (cli.Telefono, '(###)-###-##-##') as Telefono,
    cli.Correo,
	usu.Nombre,
	usu.Paterno,
	usu.Materno,
	usu.idRol,
	usu.Direccion AS DireccionUsu,
	usu.Telefono AS TelefonoUsu,
	usu.Correo as CorreoUsu,
	rol.Rol
FROM
	Compras AS com INNER JOIN
    Usuarios as usu ON com.idUsuario = usu.idUsuario INNER JOIN
    Roles as rol ON usu.idRol = rol.idRol CROSS JOIN
    Clientes AS cli
WHERE
	com.idCompra = 1 
	and cli.CURP='XEXX010101HNEXXXA4'
end
go

select * from Compras
select * from DetalleCompra
-------------------------------------------
alter procedure SP_ListCompr
as
begin
SELECT
	com.idCompra,
	com.idProveedor,
	prv.Proveedor,
	com.RFC,
	com.Direccion,
	com.NombreContacto,
	com.Subtotal,
	com.IVA,
	com.Descuento,
	com.Total,
	com.idUsuario,
	convert(varchar,com.FechaCreacion,103) as FechaCreacion,  
	com.Estado,
	cli.Direccion AS DireccionCli,
	FORMAT (cli.Telefono, '(###)-###-##-##') as Telefono,
    cli.Correo,
	usu.Nombre,
	usu.Paterno,
	usu.Materno,
	usu.idRol,
	usu.Direccion AS DireccionUsu,
	usu.Telefono AS TelefonoUsu,
	usu.Correo as CorreoUsu,
	rol.Rol
FROM
	Compras AS com INNER JOIN
    Usuarios as usu ON com.idUsuario = usu.idUsuario INNER JOIN
	Proveedores as prv on prv.idProveedor = com.idProveedor inner join
    Roles as rol ON usu.idRol = rol.idRol CROSS JOIN
    Clientes AS cli
where com.Estado=1 and cli.CURP='XEXX010101HNEXXXA4'
end
go


--------------------------------------------------------
select * from DetalleCompra
select * from Compras

select * from Productos

select * from DetalleCompra where idCompra = 4



alter procedure SP_SumStock
@idCompra int
as
begin
set nocount on
	declare @id_registro int
	declare @idProducto int
	declare @Cantidad int

		declare cur cursor for select idDetCompra from DetalleCompra where idCompra = @idCompra
		open cur
		fetch next from cur into @id_registro
		while @@FETCH_STATUS = 0
			begin
				select @idProducto = idProducto from DetalleCompra where idDetCompra = @id_registro
				select @Cantidad = Cantidad from DetalleCompra where idDetCompra = @id_registro
			
				update Productos
				set Stock = Stock + @Cantidad
				where idProducto = @idProducto

				fetch next from cur into @id_registro
			end
		close cur
		deallocate cur
set nocount off
end
go

---------------------------------------------
sp_helptext SP_UpCompras

alter procedure SP_UpCompras  
@idCompra int,  
@idProveedor int,  
@RFC varchar(13),  
@Direccion varchar(100),  
@NombreContacto varchar(100)  
as  
begin  
 update Compras  
 set  
  idProveedor = @idProveedor,  
  RFC = @RFC,  
  Direccion = @Direccion,  
  NombreContacto = @NombreContacto,  
  FechaCreacion = GETDATE(),  
  Estado = 1  
 where  
 idCompra = @idCompra

 declare @id_registro int
	declare @idProducto int
	declare @Cantidad int

		declare cur cursor for select idDetCompra from DetalleCompra where idCompra = @idCompra
		open cur
		fetch next from cur into @id_registro
		while @@FETCH_STATUS = 0
			begin
				select @idProducto = idProducto from DetalleCompra where idDetCompra = @id_registro
				select @Cantidad = Cantidad from DetalleCompra where idDetCompra = @id_registro
			
				update Productos
				set Stock = Stock + @Cantidad
				where idProducto = @idProducto

				fetch next from cur into @id_registro
			end
		close cur
		deallocate cur
end  

--*****************************
sp_helptext SP_InsertNProductos

alter procedure SP_InsertNProductos  
@Codigo varchar(15),    
@NombreProducto varchar(100),    
@idProveedor int,    
@idCategoria int,    
@idUnidad int,    
@PCompra numeric (7,2),    
@PVenta numeric (7,2),    
@Stock numeric (7,2),    
@FechaVencimiento date,
@Descripcion varchar(150), 
@Imagen varchar(max)    
as    
begin  
 BEGIN TRANSACTION;  
  
 DECLARE @CodExistente varchar(15);  
  
 SELECT @CodExistente = Codigo  
    FROM Productos  
 WHERE Codigo = @Codigo;  
  
 if @CodExistente is not null  
 begin  
  UPDATE Productos  
        SET Stock = Stock + @Stock  
  WHERE Codigo = @Codigo;  
 end  
		
 else  
 begin  
   insert into Productos    
  (Codigo,NombreProducto,idProveedor,idCategoria,idUnidad,PCompra,PVenta,Stock,FechaVencimiento,Descripcion,Imagen,FechaCreacion,Estado)    
  values    
  (@Codigo,@NombreProducto,@idProveedor,@idCategoria,@idUnidad,@PCompra,@PVenta,@Stock,@FechaVencimiento,@Descripcion,@Imagen,GETDATE(),1)  
 end  
 COMMIT TRANSACTION;  
end  


sp_helptext SP_UpdateProductos
  
-----Actualizar Producto-----  
alter procedure SP_UpdateProductos  
@idProducto int,  
@Codigo varchar(15),  
@NombreProducto varchar(100),  
@idProveedor int,  
@idCategoria int,  
@idUnidad int,  
@PCompra numeric (7,2),  
@PVenta numeric (7,2),  
@Stock numeric (7,2),  
@FechaVencimiento date,
@Descripcion varchar(150),  
@Imagen varchar(max)  
as  
begin  
 update Productos  
 set  
  Codigo = @Codigo,  
  NombreProducto = @NombreProducto,   
  idProveedor = @idProveedor,  
  idCategoria = @idCategoria,  
  idUnidad = @idUnidad,  
  PCompra = @PCompra,  
  PVenta = @PVenta,  
  Stock = @Stock,  
  FechaVencimiento = @FechaVencimiento,
  Descripcion = @Descripcion, 
  Imagen = @Imagen  
 where idProducto = @idProducto  
end  


select * from Productos

--------------------------- VENTAS
select * from Clientes

select * from Venta
select * from Compras

select * from DetalleCompra
select * from DetalleVenta


-------------------
