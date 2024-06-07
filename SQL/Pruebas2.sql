select * from MenuDetalle where idRol = 1
select * from MenuDetalle where idRol = 2
select * from Roles

sp_helptext SP_ListarMenu

CREATE procedure SP_ListarMenu    
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



--Al insertar un nuevo rol le proporciona los permisos
alter trigger TR_InsertPermiso
on Roles
for insert
as
set nocount on;
	declare @idRol int
	select @idRol = idRol from inserted
	insert into MenuDetalle values
	(1,@idRol,'No',GETDATE(),1),
	(2,@idRol,'No',GETDATE(),1),
	(3,@idRol,'No',GETDATE(),1),
	(4,@idRol,'No',GETDATE(),1),
	(5,@idRol,'No',GETDATE(),1),
	(6,@idRol,'No',GETDATE(),1),
	(7,@idRol,'No',GETDATE(),1),
	(8,@idRol,'No',GETDATE(),1),
	(12,@idRol,'No',GETDATE(),1),
	(13,@idRol,'No',GETDATE(),1),
	(14,@idRol,'No',GETDATE(),1),
	(15,@idRol,'No',GETDATE(),1),
	(19,@idRol,'No',GETDATE(),1)
go

select * from Menu
insert into Menu values ('Ganancias', '../Ganancias/','ganancias','Ganancias',GETDATE(),1)

select * from MenuDetalle
update MenuDetalle
set FechaCreacion = GETDATE()
where FechaCreacion is NULL

select * from Clientes

sp_helptext SP_InVenta

--Crer el id venta
create procedure SP_InVenta
@idUsuario int
as
begin
	insert into Venta
	(idUsuario,Estado)
	values
	(@idUsuario,2)

	select idVenta from Venta where idVenta = @@IDENTITY
end
go

select * from Venta

SP_ListarProductos

---------------------------------------
create table Venta(
idVenta int not null identity primary key,
idCliente int,
CliRFC varchar(13),
CliTelefono varchar(10),
CliDireccion varchar(100),
CliCorreo varchar(100),
Subtotal numeric(18,2) default 0,
IVA numeric(18,2) default 0,
Descuento numeric(18,2) default 0,
Total numeric(18,2) default 0,
idUsuario int not null,
FechaCreacion datetime,
Estado int not null
)
go


select * from Venta
--Crer el id venta

alter procedure SP_InTempVenta
@idUsuario int
as
begin
set nocount on
	insert into Venta
	(idUsuario,Estado)
	values
	(@idUsuario,2)

	select idVenta from Venta where idVenta = @@IDENTITY
set nocount off
end
go

SP_InTempVenta 1


Use Ferreteria

create table DetalleVenta(
idDetVenta int not null identity primary key,
idVenta int,
idProducto int,
PVenta numeric (18,2),
DetCantidad float,
DetTotal numeric (18,2),
FechaCreacion datetime,
Estado int
)
go

select * from DetalleVenta
select * from Productos where Estado = 1



--Listaqdo de venta
create procedure SP_ListarDetVenta
@idVenta int
as
begin
	SELECT
	dv.idDetVenta,
	prod.Codigo,
	prod.NombreProducto,
	cat.Categoria,
	und.Unidad,
	dv.PVenta, 
	prod.FechaVencimiento, 
	dv.DetCantidad,
	dv.DetTotal,
	dv.idProducto,
	dv.idVenta
FROM
	DetalleVenta as dv INNER JOIN
    Productos as prod ON dv.idProducto = prod.idProducto INNER JOIN
    Categorias as cat ON prod.idCategoria = cat.idCategoria INNER JOIN
    Unidades as und ON prod.idUnidad = und.idUnidad
where
	dv.idVenta = @idVenta
	and dv.Estado = 1
end
go


create procedure SP_Delete 

sp_helptrigger TR_InsertProducto

select * from sys.triggers


--Eliminar detalle de venta
create procedure SP_DeleteDetVenta
	@idDetVenta int
as
begin
	update DetalleVenta
	set Estado = 0
	where idDetVenta=@idDetVenta
end
go




--insertar detalle venta
ALTER PROCEDURE SP_InsertDetVenta
@idVenta INT,
@idProducto INT,
@PVenta NUMERIC(18,2),
@DetCantidad FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar si el producto ya existe con estado activo
        IF EXISTS (SELECT 1 FROM DetalleVenta WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 1)
        BEGIN
            -- Actualizar cantidad y total si el producto ya existe y está activo
            UPDATE DetalleVenta
            SET DetCantidad = DetCantidad + @DetCantidad,
                DetTotal = PVenta * (DetCantidad + @DetCantidad)
            WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 1;
        END
        ELSE
        BEGIN
            -- Verificar si el producto existe pero está inactivo
            IF EXISTS (SELECT 1 FROM DetalleVenta WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 0)
            BEGIN
                -- Actualizar estado a activo, cantidad y total si el producto está inactivo
                UPDATE DetalleVenta
                SET Estado = 1,
                    DetCantidad = @DetCantidad,
                    DetTotal = @PVenta * @DetCantidad
                WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 0;
            END
            ELSE
            BEGIN
                -- Insertar una nueva fila si el producto no existe
                INSERT INTO DetalleVenta (idVenta, idProducto, PVenta, DetCantidad, DetTotal, FechaCreacion, Estado)
                VALUES (@idVenta, @idProducto, @PVenta, @DetCantidad, @PVenta * @DetCantidad, GETDATE(), 1);
            END
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW;
    END CATCH;

    SET NOCOUNT OFF;
END;
GO


select * from DetalleVenta where idVenta = 37
select * from Venta where idVenta = 37


--Calcular y actualizar detalle de venta
alter PROCEDURE SP_UpdateSubTotalVenta
    @idVenta INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Subtotal DECIMAL(18, 2);
    DECLARE @IVA DECIMAL(18, 2);
    DECLARE @Descuento DECIMAL(18, 2);

    DECLARE @Total DECIMAL(18, 2);

    -- Calcular Subtotal
    SELECT @Subtotal = SUM(DetTotal)
    FROM DetalleVenta
    WHERE idVenta = @idVenta AND Estado = 1;

    -- Calcular IVA
    SET @IVA = @Subtotal * 0.16;

    -- Calcular Descuento: 5% para productos con cantidad >= 5
	update DetalleVenta
	set DescuentoProducto = CASE 
                              WHEN DetCantidad >= 5 THEN DetTotal * 0.03 
                              ELSE 0 
                            END
    WHERE idVenta = @idVenta AND Estado = 1;

	
    -- Calcular Descuento total basado en el campo DescuentoProducto actualizado
    SELECT @Descuento = SUM(DescuentoProducto)
    FROM DetalleVenta
    WHERE idVenta = @idVenta AND Estado = 1;

    -- Calcular Total
    SET @Total = @Subtotal - @Descuento;

    -- Actualizar la tabla Venta
    UPDATE Venta
    SET Subtotal = @Subtotal,
        IVA = @IVA,
        Descuento = @Descuento,
        Total = @Total
    WHERE idVenta = @idVenta;

	select Subtotal,IVA,Descuento,Total from Venta where idVenta = @idVenta
    SET NOCOUNT OFF;
END;
GO

truncate table venta
truncate table detalleventa


select * from DetalleVenta 
select * from Venta

select * from Clientes


--Guardar Venta
ALTER PROCEDURE SP_GuardarVenta
@idVenta INT,  
@idCliente INT,  
@CliRFC VARCHAR(13),  
@CliTelefono VARCHAR(10),
@CliDireccion VARCHAR(100),  
@CliCorreo VARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;

    -- Actualizar la tabla Venta
    UPDATE Venta  
    SET  
        idCliente = @idCliente,  
        CliRFC = @CliRFC,
        CliTelefono = @CliTelefono,
        CliDireccion = @CliDireccion,  
        CliCorreo = @CliCorreo,  
        FechaCreacion = GETDATE(),  
        Estado = 1  
    WHERE  
        idVenta = @idVenta;

    DECLARE @id_registro INT;
    DECLARE @idProducto INT;
    DECLARE @Cantidad INT;

    DECLARE cur CURSOR FOR 
    SELECT idDetVenta 
    FROM DetalleVenta 
    WHERE idVenta = @idVenta AND Estado = 1;  -- Solo seleccionar los productos con Estado = 1

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_registro;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @idProducto = idProducto, @Cantidad = DetCantidad 
        FROM DetalleVenta 
        WHERE idDetVenta = @id_registro;

        -- Actualizar el stock solo si el estado es 1
        UPDATE Productos
        SET Stock = Stock - @Cantidad
        WHERE idProducto = @idProducto;

        FETCH NEXT FROM cur INTO @id_registro;
    END

    CLOSE cur;
    DEALLOCATE cur;


    SET NOCOUNT OFF;
END  
GO




select * from Productos
update Productos
set Stock = 100
where Estado = 1

SP_ListarVenta 17
alter procedure SP_ListarVenta
@idVenta int
as
begin
SET NOCOUNT ON
	SELECT
		ven.idVenta, 
		ven.idCliente, 
		ven.CliRFC, 
		ven.CliTelefono, 
		ven.CliDireccion, 
		ven.CliCorreo, 
		ven.Subtotal, 
		ven.IVA, 
		ven.Descuento, 
		ven.Total, 
		ven.idUsuario, 
		CONVERT(varchar, ven.FechaCreacion, 103) AS FechaCreacion, 
		ven.Estado, 
		usu.Nombre, 
		usu.Paterno, 
		usu.Materno, 
		usu.Correo, 
		usu.Telefono, 
		rol.Rol, 
		cli.Nombre AS NombreC, 
		cli.Paterno AS PaternoC, 
		cli.Materno AS MaternoC
	FROM            
		Venta AS ven INNER JOIN
		Usuarios AS usu ON ven.idUsuario = usu.idUsuario INNER JOIN
		Roles AS rol ON usu.idRol = rol.idRol INNER JOIN
		Clientes as cli ON ven.idCliente = cli.idCliente
	WHERE ven.idVenta = @idVenta
SET NOCOUNT OFF
end
go


select * from Venta where Estado = 1

create procedure SP_ListarTodaVenta

as
begin
SET NOCOUNT ON
	SELECT
		ven.idVenta, 
		ven.idCliente, 
		ven.CliRFC, 
		ven.CliTelefono, 
		ven.CliDireccion, 
		ven.CliCorreo, 
		ven.Subtotal, 
		ven.IVA, 
		ven.Descuento, 
		ven.Total, 
		ven.idUsuario, 
		CONVERT(varchar, ven.FechaCreacion, 103) AS FechaCreacion, 
		ven.Estado, 
		usu.Nombre, 
		usu.Paterno, 
		usu.Materno, 
		usu.Correo, 
		usu.Telefono, 
		rol.Rol, 
		cli.Nombre AS NombreC, 
		cli.Paterno AS PaternoC, 
		cli.Materno AS MaternoC
	FROM            
		Venta AS ven INNER JOIN
		Usuarios AS usu ON ven.idUsuario = usu.idUsuario INNER JOIN
		Roles AS rol ON usu.idRol = rol.idRol INNER JOIN
		Clientes as cli ON ven.idCliente = cli.idCliente
	WHERE ven.Estado = 1
SET NOCOUNT OFF
end
go

select * from Menu

sp_helptext SP_AccesoUsuarios
  
  
-----ACCESO-----  
alter procedure SP_AccesoUsuarios  
@Correo varchar(100),  
@Contrasena varchar(50)  
as  
begin  
 SELECT        
 Usuarios.idUsuario, 
 Usuarios.Nombre, 
 Usuarios.Paterno, 
 Usuarios.Materno, 
 Usuarios.idRol, 
 Usuarios.Sexo, 
 Usuarios.Direccion, 
 Usuarios.Telefono, 
 Usuarios.CURP, 
 Usuarios.RFC, 
 Usuarios.Correo, 
 Usuarios.Contrasena, 
Usuarios.FechaCreacion, 
Usuarios.Estado,
Roles.Rol
FROM            
Usuarios INNER JOIN
Roles ON Usuarios.idRol = Roles.idRol 
 where  
 Correo = @Correo  
 and Contrasena = @Contrasena  
 and Usuarios.Estado = 1  
end 


select * from MenuDetalle


use ferreteria

select * from Usuarios inner join Roles on Usuarios.idRol = Roles.idRol


select * from Productos where Estado = 1
select COUNT (idProducto) AS CANTIDAD from Productos where Estado = 1

alter procedure SP_Contar
as
begin
	SELECT 
    (SELECT COUNT(idProducto) FROM Productos WHERE Estado = 1) AS CantidadProductos,
    (SELECT COUNT(idCategoria) FROM Categorias WHERE Estado = 1) AS CantidadCategorias,
    (SELECT COUNT(idCliente) FROM Clientes WHERE Estado = 1) AS CantidadClientes,
    (SELECT COUNT(idProveedor) FROM Proveedores WHERE Estado = 1) AS CantidadProveedores
end


use Ferreteria
select * from Venta where Estado = 1

UPDATE Venta
SET FechaCreacion = '2024-05-24T15:53:36.293'
WHERE idVenta = 15;
go

select * from 
alter procedure SP_VentaDias
as
begin
select
top 7
CONVERT(varchar,FechaCreacion,103) as FechaCreacion,
sum(Total) as Total
from Venta
where Estado = 1
group by CONVERT(varchar,FechaCreacion,103), CAST(FechaCreacion AS DATE)
order by CAST(FechaCreacion AS DATE) DESC
end


-------------------Ganancias
select * from Venta where Estado = 1 and idVenta = 12
select * from DetalleVenta where Estado = 1 and idVenta = 12


use Ferreteria
select * from Venta where idVenta = 61
select * from DetalleVenta where idVenta = 61
select * from Venta where idVenta = 63
select * from DetalleVenta where idVenta = 63
select * from Productos where idProducto = 4
select * from Productos where idProducto = 24

------------ganancias
ALTER TABLE Venta ADD Ganancias money
ALTER TABLE DetalleVenta ADD Ganancias money
go




sp_helptext SP_InsertDetVenta

ALTER PROCEDURE SP_InsertDetVenta  
    @idVenta INT,  
    @idProducto INT,  
    @PVenta NUMERIC(18,2),  
    @DetCantidad FLOAT  
AS  
BEGIN  
    SET NOCOUNT ON; 

    DECLARE @Ganancias MONEY
    DECLARE @PCompra NUMERIC(18,2) 

    -- Selecciona el precio de compra del producto
    SELECT @PCompra = PCompra FROM Productos WHERE idProducto = @idProducto;

    BEGIN TRY  
        BEGIN TRANSACTION;  

        -- Verificar si el producto ya existe con estado activo  
        IF EXISTS (SELECT 1 FROM DetalleVenta WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 1)  
        BEGIN  
            -- Actualizar cantidad, total y ganancias si el producto ya existe y está activo 
            UPDATE DetalleVenta  
            SET DetCantidad = DetCantidad + @DetCantidad,  
                DetTotal = @PVenta * (DetCantidad + @DetCantidad),
                Ganancias = (@PVenta * (DetCantidad + @DetCantidad)) - (@PCompra * (DetCantidad + @DetCantidad))
            WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 1;  
        END  
        ELSE  
        BEGIN  
            -- Verificar si el producto existe pero está inactivo  
            IF EXISTS (SELECT 1 FROM DetalleVenta WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 0)  
            BEGIN  
                -- Actualizar estado a activo, cantidad, total y ganancias si el producto está inactivo  
                UPDATE DetalleVenta  
                SET Estado = 1,  
                    DetCantidad = @DetCantidad,  
                    DetTotal = @PVenta * @DetCantidad,
                    Ganancias = (@PVenta * @DetCantidad) - (@PCompra * @DetCantidad)
                WHERE idVenta = @idVenta AND idProducto = @idProducto AND Estado = 0;  
            END  
            ELSE  
            BEGIN  
                -- Insertar una nueva fila si el producto no existe  
                INSERT INTO DetalleVenta (idVenta, idProducto, PVenta, DetCantidad, DetTotal, FechaCreacion, Estado, Ganancias)  
                VALUES (@idVenta, @idProducto, @PVenta, @DetCantidad, @PVenta * @DetCantidad, GETDATE(), 1, (@PVenta * @DetCantidad) - (@PCompra * @DetCantidad));  
            END  
        END  

        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  

        THROW;  
    END CATCH;  

    SET NOCOUNT OFF;  
END;  
go


-------------------------
--Guardar Venta
ALTER PROCEDURE SP_GuardarVenta
@idVenta INT,  
@idCliente INT,  
@CliRFC VARCHAR(13),  
@CliTelefono VARCHAR(10),
@CliDireccion VARCHAR(100),  
@CliCorreo VARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;
	DECLARE @Ganancias MONEY
    DECLARE @Descuento NUMERIC(18,2) 

    -- Actualizar la tabla Venta
    UPDATE Venta  
    SET  
        idCliente = @idCliente,  
        CliRFC = @CliRFC,
        CliTelefono = @CliTelefono,
        CliDireccion = @CliDireccion,  
        CliCorreo = @CliCorreo,  
        FechaCreacion = GETDATE(),  
        Estado = 1  
    WHERE  
        idVenta = @idVenta;

    DECLARE @id_registro INT;
    DECLARE @idProducto INT;
    DECLARE @Cantidad INT;

    DECLARE cur CURSOR FOR 
    SELECT idDetVenta 
    FROM DetalleVenta 
    WHERE idVenta = @idVenta AND Estado = 1;  -- Solo seleccionar los productos con Estado = 1

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_registro;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @idProducto = idProducto, @Cantidad = DetCantidad 
        FROM DetalleVenta 
        WHERE idDetVenta = @id_registro;

        -- Actualizar el stock solo si el estado es 1
        UPDATE Productos
        SET Stock = Stock - @Cantidad
        WHERE idProducto = @idProducto;

        FETCH NEXT FROM cur INTO @id_registro;
    END

    CLOSE cur;
    DEALLOCATE cur;

	select @Ganancias = SUM(Ganancias) from DetalleVenta WHERE idVenta = @idVenta AND Estado = 1
	select @Descuento = Descuento from Venta WHERE idVenta = @idVenta AND Estado = 1
	update Venta
	set Ganancias = @Ganancias - Descuento
	WHERE  
        idVenta = @idVenta;


    SET NOCOUNT OFF;
END  
GO


---Ganancia del dia
CREATE TABLE GananciasDiarias (
	idGanancia int primary key identity,
    Ganancia money,
	Fecha Date
)
go

------------------------------Trigger para insertar en Ganancias Diarias
alter TRIGGER TR_InGananciaDiaria
ON Venta
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar las ganancias diarias solo cuando el estado cambie de 2 a 1
    INSERT INTO GananciasDiarias (Ganancia, Fecha)
    SELECT i.Ganancias, CONVERT(VARCHAR, GETDATE(), 103)     
    FROM inserted i INNER JOIN deleted d
    ON i.idVenta = d.idVenta
    WHERE i.Estado = 1 and i.Ganancias is not null

END
GO


-------------------------------

select * from GananciasDiarias
select * from Venta where idVenta = 75
select * from DetalleVenta where idVenta = 75
select * from Productos where idProducto = 18

use Ferreteria

SP_GananciaDiaria'2024-06-02'
alter procedure SP_GananciaDiaria
@Fecha Date
as
begin

    select @Fecha AS Fecha, SUM(Ganancia) as Ganancia FROM GananciasDiarias WHERE Fecha = @Fecha

end
go

select sum(Ganancias) from Venta WHERE CAST(FechaCreacion AS DATE) = '2024-06-03'
select Ganancia from GananciasDiarias where Fecha = '2024-06-02'
select* from GananciasDiarias
select * from Venta

---------------------------------------------------------------------------------------
sp_helptext SP_GuardarVenta

Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alter PROCEDURE SP_GuardarVenta
@idVenta INT,  
@idCliente INT,  
@CliRFC VARCHAR(13),  
@CliTelefono VARCHAR(10),
@CliDireccion VARCHAR(100),  
@CliCorreo VARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

		DECLARE @Ganancias MONEY
		DECLARE @Descuento NUMERIC(18,2) 

		-- Actualizar la tabla Venta
		UPDATE Venta  
		SET  
			idCliente = @idCliente,  
			CliRFC = @CliRFC,
			CliTelefono = @CliTelefono,
			CliDireccion = @CliDireccion,  
			CliCorreo = @CliCorreo,  
			FechaCreacion = GETDATE(),  
			Estado = 1  
		WHERE  
			idVenta = @idVenta;

		DECLARE @id_registro INT;
		DECLARE @idProducto INT;
		DECLARE @Cantidad INT;

		DECLARE cur CURSOR FOR 
		SELECT idDetVenta 
		FROM DetalleVenta 
		WHERE idVenta = @idVenta AND Estado = 1;  -- Solo seleccionar los productos con Estado = 1

		OPEN cur;
		FETCH NEXT FROM cur INTO @id_registro;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @idProducto = idProducto, @Cantidad = DetCantidad 
			FROM DetalleVenta 
			WHERE idDetVenta = @id_registro;

			-- Actualizar el stock solo si el estado es 1
			UPDATE Productos
			SET Stock = Stock - @Cantidad
			WHERE idProducto = @idProducto;

			FETCH NEXT FROM cur INTO @id_registro;
		END

		CLOSE cur;
		DEALLOCATE cur;

		select @Ganancias = SUM(Ganancias) from DetalleVenta WHERE idVenta = @idVenta AND Estado = 1
		select @Descuento = Descuento from Venta WHERE idVenta = @idVenta AND Estado = 1
		update Venta
		set Ganancias = @Ganancias - Descuento
		WHERE  
			idVenta = @idVenta;

		COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW;
    END CATCH;

    SET NOCOUNT OFF;
END  
go

--------Checar que triggers hay
SELECT * FROM sys.triggers;



-------------------------------
create table AProductos
(
idAproductos int identity primary key,
idProducto int,
Fecha date,
Accion varchar(25),
APrecioCompra money,
NPrecioCompra money,
APrecioVenta money,
NPrecioVenta money,
AStock money,
NStock money
)
go

select * from AProductos
select * from Productos

---Trigger Cambio de Precio---
alter trigger TR_CambioPrecioVenta
on Productos
for update
as
begin
	set nocount off
		declare @idProducto int, @APVenta money, @NPVenta money,@APCompra money, @NPCompra money
		
		select @idProducto = idProducto from inserted
		select @NPVenta =  PVenta from inserted
		select @APVenta =  PVenta from deleted

		select @NPCompra =  PCompra from inserted
		select @APCompra =  PCompra from deleted

		-- Verificar si hubo cambios en PVenta o PCompra
		IF (@APVenta <> @NPVenta) OR (@APCompra <> @NPCompra)
		BEGIN
			INSERT INTO AProductos (idProducto, Fecha, Accion, APrecioCompra, NPrecioCompra, APrecioVenta, NPrecioVenta) 
			VALUES (@idProducto, GETDATE(), 'Cambio de Precio', @APCompra, @NPCompra, @APVenta, @NPVenta);
		END

	set nocount off
end
go

----------------------------------------
alter view Cambios
as
SELECT
AP.idAproductos, 
AP.idProducto, 
P.NombreProducto, 
AP.Fecha, 
AP.Accion, 
AP.APrecioCompra, 
AP.NPrecioCompra, 
AP.APrecioVenta, 
AP.NPrecioVenta
FROM AProductos as AP INNER JOIN
Productos as P ON AP.idProducto = P.idProducto

select * from Cambios


------------------
use ferreteria
select * from Productos
select * from DetalleVenta where idVenta=100
select * from Venta where idVenta=100


alter view GananciaxProducto
as
SELECT
DV.idVenta,
FORMAT(DV.FechaCreacion, 'yyyy-MM-dd HH:mm') AS FechaCreacion,
P.NombreProducto,
P.PCompra ,
DV.PVenta, 
DV.DetCantidad,
DV.DetTotal,
DV.DescuentoProducto,
(DV.Ganancias - DV.DescuentoProducto) as GananciasXP
FROM DetalleVenta as DV INNER JOIN
Productos P ON DV.idProducto = P.idProducto
WHERE DV.Estado = 1

select * from GananciaxProducto ORDER BY idVenta DESC
select * from DetalleVenta