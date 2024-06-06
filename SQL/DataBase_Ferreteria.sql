USE [master]
GO
/****** Object:  Database [Ferreteria]    Script Date: 06/06/2024 04:14:36 p. m. ******/
CREATE DATABASE [Ferreteria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ferreteria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Ferreteria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ferreteria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Ferreteria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Ferreteria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ferreteria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ferreteria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ferreteria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ferreteria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ferreteria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ferreteria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ferreteria] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Ferreteria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ferreteria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ferreteria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ferreteria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ferreteria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ferreteria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ferreteria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ferreteria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ferreteria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Ferreteria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ferreteria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ferreteria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ferreteria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ferreteria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ferreteria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ferreteria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ferreteria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Ferreteria] SET  MULTI_USER 
GO
ALTER DATABASE [Ferreteria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ferreteria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ferreteria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ferreteria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Ferreteria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Ferreteria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Ferreteria] SET QUERY_STORE = OFF
GO
USE [Ferreteria]
GO
/****** Object:  Table [dbo].[AProductos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AProductos](
	[idAproductos] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NULL,
	[Fecha] [date] NULL,
	[Accion] [varchar](25) NULL,
	[APrecioCompra] [money] NULL,
	[NPrecioCompra] [money] NULL,
	[APrecioVenta] [money] NULL,
	[NPrecioVenta] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[idAproductos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](15) NOT NULL,
	[NombreProducto] [varchar](100) NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[idProveedor] [int] NOT NULL,
	[idCategoria] [int] NOT NULL,
	[idUnidad] [int] NOT NULL,
	[PCompra] [numeric](7, 2) NOT NULL,
	[PVenta] [numeric](7, 2) NOT NULL,
	[Stock] [numeric](7, 2) NOT NULL,
	[FechaVencimiento] [date] NULL,
	[Imagen] [varchar](max) NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Cambios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Cambios]
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
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[idDetVenta] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NULL,
	[idProducto] [int] NULL,
	[PVenta] [numeric](18, 2) NULL,
	[DetCantidad] [float] NULL,
	[DetTotal] [numeric](18, 2) NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NULL,
	[Ganancias] [money] NULL,
	[DescuentoProducto] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[idDetVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GananciaxProducto]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[GananciaxProducto]
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
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Paterno] [varchar](50) NOT NULL,
	[Materno] [varchar](50) NULL,
	[Sexo] [varchar](2) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [bigint] NULL,
	[Correo] [varchar](100) NOT NULL,
	[CURP] [varchar](18) NOT NULL,
	[RFC] [varchar](13) NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GananciasDiarias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GananciasDiarias](
	[idGanancia] [int] IDENTITY(1,1) NOT NULL,
	[Ganancia] [money] NULL,
	[Fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idGanancia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[idMenu] [int] IDENTITY(1,1) NOT NULL,
	[Menu] [varchar](150) NOT NULL,
	[Ruta] [varchar](250) NOT NULL,
	[Identificador] [varchar](150) NOT NULL,
	[Grupo] [varchar](150) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuDetalle]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuDetalle](
	[idMenuDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idMenu] [int] NOT NULL,
	[idRol] [int] NOT NULL,
	[Permiso] [varchar](2) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMenuDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[idProveedor] [int] IDENTITY(1,1) NOT NULL,
	[Proveedor] [varchar](100) NOT NULL,
	[NombreContacto] [varchar](100) NOT NULL,
	[RFC] [varchar](13) NULL,
	[Telefono] [varchar](10) NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[Rol] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unidades]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unidades](
	[idUnidad] [int] IDENTITY(1,1) NOT NULL,
	[Unidad] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUnidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Paterno] [varchar](50) NOT NULL,
	[Materno] [varchar](50) NULL,
	[idRol] [int] NOT NULL,
	[Sexo] [varchar](2) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [varchar](10) NULL,
	[CURP] [varchar](18) NOT NULL,
	[RFC] [varchar](13) NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contrasena] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[CliRFC] [varchar](13) NULL,
	[CliTelefono] [varchar](10) NULL,
	[CliDireccion] [varchar](100) NULL,
	[CliCorreo] [varchar](100) NULL,
	[Subtotal] [numeric](18, 2) NULL,
	[IVA] [numeric](18, 2) NULL,
	[Descuento] [numeric](18, 2) NULL,
	[Total] [numeric](18, 2) NULL,
	[idUsuario] [int] NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[Estado] [int] NOT NULL,
	[Ganancias] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AProductos] ON 

INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (1, 19, CAST(N'2024-06-02' AS Date), N'Cambio de Precio', 18.0000, 180.0000, 180.0000, 220.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (2, 25, CAST(N'2024-06-02' AS Date), N'Cambio de Precio', 20.0000, 20.0000, 25.0000, 30.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (3, 18, CAST(N'2024-06-02' AS Date), N'Cambio de Precio', 14.0000, 1100.0000, 19.0000, 1500.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (4, 14, CAST(N'2024-06-02' AS Date), N'Cambio de Precio', 185.0000, 185.0000, 225.0000, 225.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (5, 2, CAST(N'2024-06-02' AS Date), N'Cambio de Precio', 225.0000, 225.0000, 269.0000, 269.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (6, 19, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 180.0000, 180.0000, 220.0000, 220.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (7, 4, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 15.0000, 15.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (8, 24, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 15.0000, 15.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (9, 15, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 10.0000, 10.0000, 17.0000, 17.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (10, 19, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 180.0000, 180.0000, 220.0000, 220.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (11, 2, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 225.0000, 225.0000, 269.0000, 269.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (12, 14, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 185.0000, 185.0000, 225.0000, 225.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (13, 3, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 18.0000, 18.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (14, 14, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 185.0000, 185.0000, 225.0000, 225.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (15, 2, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 225.0000, 225.0000, 269.0000, 269.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (16, 3, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 18.0000, 18.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (17, 4, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 15.0000, 15.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (18, 24, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 15.0000, 15.0000, 22.0000, 22.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (19, 14, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 185.0000, 185.0000, 225.0000, 225.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (20, 19, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 180.0000, 180.0000, 220.0000, 220.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (21, 20, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 150.0000, 150.0000, 99.0000, 99.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (22, 21, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 10.0000, 10.0000, 180.0000, 180.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (23, 20, CAST(N'2024-06-03' AS Date), N'Cambio de Precio', 150.0000, 150.0000, 99.0000, 175.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (24, 1, CAST(N'2024-06-04' AS Date), N'Cambio de Precio', 1000.0000, 1000.0000, 1000.0000, 1200.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (25, 21, CAST(N'2024-06-04' AS Date), N'Cambio de Precio', 10.0000, 100.0000, 180.0000, 180.0000)
INSERT [dbo].[AProductos] ([idAproductos], [idProducto], [Fecha], [Accion], [APrecioCompra], [NPrecioCompra], [APrecioVenta], [NPrecioVenta]) VALUES (26, 22, CAST(N'2024-06-04' AS Date), N'Cambio de Precio', 150.0000, 150.0000, 150.0000, 170.0000)
SET IDENTITY_INSERT [dbo].[AProductos] OFF
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (1, N'Electricidad', CAST(N'2024-04-29T20:15:14.097' AS DateTime), 1)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (2, N'Construccion', CAST(N'2024-04-29T20:15:14.097' AS DateTime), 1)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (3, N'Plomeria', CAST(N'2024-04-29T20:15:14.097' AS DateTime), 1)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (4, N'Test1', CAST(N'2024-05-01T19:20:26.933' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (5, N'Test2', CAST(N'2024-05-01T19:21:27.230' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (6, N'Test', CAST(N'2024-05-01T19:21:35.193' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (7, N'Plomeriaa', CAST(N'2024-05-01T19:44:27.543' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (8, N'Test', CAST(N'2024-05-01T19:44:32.040' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (9, N'Test2', CAST(N'2024-05-01T19:44:36.657' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (10, N'Test2', CAST(N'2024-05-01T19:44:48.357' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (11, N'Test2', CAST(N'2024-05-01T19:44:52.117' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (12, N'Tes', CAST(N'2024-05-01T19:44:58.993' AS DateTime), 0)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (13, N'Materiales Pesados', CAST(N'2024-05-21T18:35:06.880' AS DateTime), 1)
INSERT [dbo].[Categorias] ([idCategoria], [Categoria], [FechaCreacion], [Estado]) VALUES (14, N'Pintura', CAST(N'2024-05-23T08:47:32.430' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([idCliente], [Nombre], [Paterno], [Materno], [Sexo], [Direccion], [Telefono], [Correo], [CURP], [RFC], [FechaCreacion], [Estado]) VALUES (1, N'Publico', N'General', N'', N'NU', N'Niños Heroes #1 Juan Lucas', 4111568181, N'ferrematerialeschuy@gmail.com', N'XEXX010101HNEXXXA4', N'XAXX010101000', CAST(N'2024-05-02T20:20:14.023' AS DateTime), 1)
INSERT [dbo].[Clientes] ([idCliente], [Nombre], [Paterno], [Materno], [Sexo], [Direccion], [Telefono], [Correo], [CURP], [RFC], [FechaCreacion], [Estado]) VALUES (2, N'Salvador', N'Parra', N'Diaz', N'H', N'Guerrero', 4451524239, N's.parradiaz@ugto.mx', N'PADS000517HGTRZLA6', N'PADS000517HGT', CAST(N'2024-05-02T21:24:12.780' AS DateTime), 1)
INSERT [dbo].[Clientes] ([idCliente], [Nombre], [Paterno], [Materno], [Sexo], [Direccion], [Telefono], [Correo], [CURP], [RFC], [FechaCreacion], [Estado]) VALUES (3, N'Alison', N'Leon', N'Parra', N'M', N'Guerrero', 4451524277, N'tes2a@gmail.com', N'LEPA000517HGTRZL55', N'LEPA000517HGT', CAST(N'2024-05-03T19:22:02.090' AS DateTime), 1)
INSERT [dbo].[Clientes] ([idCliente], [Nombre], [Paterno], [Materno], [Sexo], [Direccion], [Telefono], [Correo], [CURP], [RFC], [FechaCreacion], [Estado]) VALUES (4, N'Gustavo', N'Martinez', N'', N'H', N'Vicente G #87', 7789631452, N'gustavomtz@gmail.com', N'GMPA000517HGTRZL55', N'GMPA000517HGT', CAST(N'2024-05-21T18:38:52.960' AS DateTime), 1)
INSERT [dbo].[Clientes] ([idCliente], [Nombre], [Paterno], [Materno], [Sexo], [Direccion], [Telefono], [Correo], [CURP], [RFC], [FechaCreacion], [Estado]) VALUES (5, N'Víctor', N'Vázquez', N'', N'H', N'Miguel Hidalgo #23 Juan Lucas', 9182234746, N'victor2726@gmail.com', N'VVDA000517HGTRZL76', N'VVDA000517HG5', CAST(N'2024-05-23T08:53:38.670' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[DetalleVenta] ON 

INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (1, 1, 2, CAST(269.00 AS Numeric(18, 2)), 3, CAST(807.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:00:03.127' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (2, 1, 3, CAST(22.00 AS Numeric(18, 2)), 2, CAST(44.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:00:42.417' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (3, 2, 3, CAST(22.00 AS Numeric(18, 2)), 10, CAST(220.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:02:13.787' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (4, 2, 4, CAST(16.00 AS Numeric(18, 2)), 4, CAST(64.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:02:32.873' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (5, 3, 3, CAST(22.00 AS Numeric(18, 2)), 10, CAST(220.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:03:34.800' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (6, 3, 4, CAST(16.00 AS Numeric(18, 2)), 20, CAST(320.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:03:39.900' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (7, 3, 14, CAST(220.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:10:23.740' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (8, 4, 3, CAST(22.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:10:51.970' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (9, 6, 14, CAST(220.00 AS Numeric(18, 2)), 5, CAST(1100.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:11:56.817' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (10, 7, 3, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:16:31.647' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (11, 9, 3, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:17:41.397' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (12, 11, 3, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:48:39.167' AS DateTime), 1, NULL, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (13, 11, 4, CAST(16.00 AS Numeric(18, 2)), 12, CAST(192.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:48:48.180' AS DateTime), 1, NULL, 5.7600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (14, 12, 14, CAST(220.00 AS Numeric(18, 2)), 2, CAST(440.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:51:32.417' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (15, 13, 4, CAST(16.00 AS Numeric(18, 2)), 15, CAST(240.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:54:02.440' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (16, 15, 14, CAST(220.00 AS Numeric(18, 2)), 7, CAST(1540.00 AS Numeric(18, 2)), CAST(N'2024-05-22T15:57:13.387' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (17, 16, 14, CAST(220.00 AS Numeric(18, 2)), 6, CAST(1320.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:01:57.677' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (18, 17, 14, CAST(220.00 AS Numeric(18, 2)), 9, CAST(1980.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:07:43.070' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (19, 22, 14, CAST(220.00 AS Numeric(18, 2)), 105, CAST(23100.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:15:51.350' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (20, 24, 14, CAST(220.00 AS Numeric(18, 2)), 110, CAST(24200.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:19:39.653' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (21, 25, 3, CAST(22.00 AS Numeric(18, 2)), 120, CAST(2640.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:20:45.010' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (22, 26, 14, CAST(220.00 AS Numeric(18, 2)), 500, CAST(110000.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:22:41.610' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (23, 30, 14, CAST(220.00 AS Numeric(18, 2)), 500, CAST(110000.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:27:00.857' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (24, 31, 14, CAST(220.00 AS Numeric(18, 2)), 149, CAST(32780.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:32:00.233' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (25, 31, 3, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:33:02.237' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (26, 31, 4, CAST(16.00 AS Numeric(18, 2)), 24, CAST(384.00 AS Numeric(18, 2)), CAST(N'2024-05-22T16:33:11.353' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (27, 32, 14, CAST(220.00 AS Numeric(18, 2)), 5, CAST(1100.00 AS Numeric(18, 2)), CAST(N'2024-05-22T19:07:38.087' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (28, 32, 3, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-05-22T19:07:44.853' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (29, 32, 4, CAST(16.00 AS Numeric(18, 2)), 15, CAST(240.00 AS Numeric(18, 2)), CAST(N'2024-05-22T19:07:55.750' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (30, 36, 14, CAST(220.00 AS Numeric(18, 2)), 75, CAST(16500.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:02:13.380' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (31, 36, 3, CAST(22.00 AS Numeric(18, 2)), 63, CAST(1386.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:02:23.220' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (32, 36, 4, CAST(16.00 AS Numeric(18, 2)), 99, CAST(1584.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:02:32.873' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (33, 36, 1, CAST(1000.00 AS Numeric(18, 2)), 100, CAST(100000.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:02:49.547' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (34, 37, 14, CAST(220.00 AS Numeric(18, 2)), 25, CAST(5500.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:04:49.740' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (35, 37, 3, CAST(22.00 AS Numeric(18, 2)), 1, CAST(22.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:05:06.213' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (36, 38, 3, CAST(22.00 AS Numeric(18, 2)), 10, CAST(220.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:10:06.663' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (37, 38, 4, CAST(16.00 AS Numeric(18, 2)), 30, CAST(480.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:10:14.850' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (38, 38, 14, CAST(220.00 AS Numeric(18, 2)), 2, CAST(440.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:10:19.980' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (39, 39, 14, CAST(220.00 AS Numeric(18, 2)), 100, CAST(22000.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:11:06.360' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (40, 39, 6, CAST(360.00 AS Numeric(18, 2)), 100, CAST(36000.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:11:17.940' AS DateTime), 0, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (41, 39, 3, CAST(22.00 AS Numeric(18, 2)), 1, CAST(22.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:11:28.313' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (42, 40, 14, CAST(220.00 AS Numeric(18, 2)), 5, CAST(1100.00 AS Numeric(18, 2)), CAST(N'2024-05-22T23:27:11.710' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (43, 43, 15, CAST(17.00 AS Numeric(18, 2)), 5, CAST(85.00 AS Numeric(18, 2)), CAST(N'2024-05-23T08:54:01.833' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (44, 43, 3, CAST(22.00 AS Numeric(18, 2)), 2, CAST(44.00 AS Numeric(18, 2)), CAST(N'2024-05-23T08:55:19.613' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (45, 43, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-05-23T08:56:00.380' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (46, 49, 14, CAST(225.00 AS Numeric(18, 2)), 1, CAST(225.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:39:05.917' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (47, 49, 3, CAST(22.00 AS Numeric(18, 2)), 3, CAST(66.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:39:32.563' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (48, 49, 2, CAST(269.00 AS Numeric(18, 2)), 2, CAST(538.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:39:37.210' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (49, 50, 15, CAST(17.00 AS Numeric(18, 2)), 2, CAST(34.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:40:27.273' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (50, 50, 20, CAST(99.00 AS Numeric(18, 2)), 3, CAST(297.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:40:46.593' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (51, 50, 23, CAST(145.00 AS Numeric(18, 2)), 4, CAST(580.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:41:03.420' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (52, 50, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:41:21.860' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (53, 52, 1, CAST(1000.00 AS Numeric(18, 2)), 3, CAST(3000.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:43:02.200' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (54, 54, 2, CAST(269.00 AS Numeric(18, 2)), 10, CAST(2690.00 AS Numeric(18, 2)), CAST(N'2024-05-30T14:45:49.773' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (55, 56, 14, CAST(225.00 AS Numeric(18, 2)), 5, CAST(1125.00 AS Numeric(18, 2)), CAST(N'2024-05-31T11:38:22.113' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (56, 58, 4, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-06-01T17:05:46.417' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (57, 58, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T17:06:03.087' AS DateTime), 1, NULL, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (58, 60, 4, CAST(22.00 AS Numeric(18, 2)), 2, CAST(44.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:11:40.763' AS DateTime), 1, 14.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (59, 60, 24, CAST(22.00 AS Numeric(18, 2)), 3, CAST(66.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:12:31.857' AS DateTime), 1, 21.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (60, 61, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:56:31.490' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (61, 61, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:56:38.513' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (62, 62, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:59:49.867' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (63, 62, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T18:59:55.817' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (64, 63, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-06-01T19:02:28.360' AS DateTime), 0, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (65, 63, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T19:02:36.113' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (66, 63, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-01T19:02:40.013' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (67, 64, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T20:52:01.093' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (68, 64, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T20:52:03.040' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (69, 65, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T20:59:04.330' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (70, 65, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T20:59:06.543' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (71, 66, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T21:10:14.160' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (72, 66, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T21:10:17.537' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (73, 68, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T21:12:59.520' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (74, 68, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T21:13:01.897' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (75, 69, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:01:37.200' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (76, 69, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:01:39.673' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (77, 70, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:10:48.220' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (78, 70, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:10:50.207' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (79, 71, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:12:45.503' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (80, 71, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:12:47.183' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (81, 73, 18, CAST(14.00 AS Numeric(18, 2)), 5, CAST(70.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:42:01.867' AS DateTime), 1, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (82, 74, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:45:04.607' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (83, 74, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-01T22:45:08.737' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (84, 75, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:02:00.970' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (85, 75, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:02:02.880' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (86, 76, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:05:21.370' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (87, 76, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:05:23.517' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (88, 77, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:07:11.197' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (89, 77, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:07:13.490' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (90, 78, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:07:58.793' AS DateTime), 0, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (91, 78, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:08:05.183' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (92, 78, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:08:07.147' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (93, 79, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:09:54.877' AS DateTime), 1, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (94, 79, 4, CAST(22.00 AS Numeric(18, 2)), 3, CAST(66.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:10:06.407' AS DateTime), 1, 21.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (95, 80, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:10:58.447' AS DateTime), 0, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (96, 80, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:11:07.040' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (97, 80, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:11:09.173' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (98, 82, 18, CAST(14.00 AS Numeric(18, 2)), 1, CAST(14.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:34:06.060' AS DateTime), 1, 0.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (99, 82, 19, CAST(180.00 AS Numeric(18, 2)), 1, CAST(180.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:34:09.440' AS DateTime), 1, 162.0000, 33.7500)
GO
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (100, 82, 20, CAST(99.00 AS Numeric(18, 2)), 1, CAST(99.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:34:11.537' AS DateTime), 1, -51.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (101, 84, 4, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:47:37.083' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (102, 84, 24, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:47:39.007' AS DateTime), 1, 28.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (103, 85, 4, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:48:20.873' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (104, 85, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-02T09:48:23.303' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (105, 87, 14, CAST(225.00 AS Numeric(18, 2)), 23, CAST(5175.00 AS Numeric(18, 2)), CAST(N'2024-06-02T20:32:37.140' AS DateTime), 1, 920.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (106, 87, 2, CAST(269.00 AS Numeric(18, 2)), 3, CAST(807.00 AS Numeric(18, 2)), CAST(N'2024-06-02T20:33:13.137' AS DateTime), 1, 132.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (107, 89, 19, CAST(220.00 AS Numeric(18, 2)), 5, CAST(1100.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:02:30.517' AS DateTime), 1, 200.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (108, 90, 4, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:03:40.160' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (109, 90, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:03:42.250' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (110, 90, 15, CAST(17.00 AS Numeric(18, 2)), 5, CAST(85.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:03:52.820' AS DateTime), 1, 35.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (111, 91, 19, CAST(220.00 AS Numeric(18, 2)), 7, CAST(1540.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:06:00.570' AS DateTime), 1, 280.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (112, 91, 2, CAST(269.00 AS Numeric(18, 2)), 3, CAST(807.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:06:09.100' AS DateTime), 1, 132.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (113, 91, 14, CAST(225.00 AS Numeric(18, 2)), 5, CAST(1125.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:06:13.833' AS DateTime), 1, 200.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (114, 92, 3, CAST(22.00 AS Numeric(18, 2)), 4, CAST(88.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:14:43.000' AS DateTime), 1, 16.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (115, 92, 14, CAST(225.00 AS Numeric(18, 2)), 5, CAST(1125.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:14:57.097' AS DateTime), 1, 200.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (116, 92, 2, CAST(269.00 AS Numeric(18, 2)), 5, CAST(1345.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:15:08.140' AS DateTime), 1, 220.0000, 40.3500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (117, 94, 3, CAST(22.00 AS Numeric(18, 2)), 10, CAST(220.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:25:58.603' AS DateTime), 1, 40.0000, 6.6000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (118, 94, 4, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:26:07.223' AS DateTime), 1, 56.0000, 5.2800)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (119, 94, 24, CAST(22.00 AS Numeric(18, 2)), 8, CAST(176.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:26:09.723' AS DateTime), 1, 56.0000, 5.2800)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (120, 95, 14, CAST(225.00 AS Numeric(18, 2)), 7, CAST(1575.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:29:26.783' AS DateTime), 1, 280.0000, 47.2500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (121, 95, 19, CAST(220.00 AS Numeric(18, 2)), 7, CAST(1540.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:29:31.470' AS DateTime), 1, 280.0000, 46.2000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (122, 97, 20, CAST(99.00 AS Numeric(18, 2)), 3, CAST(297.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:32:39.970' AS DateTime), 1, -153.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (123, 97, 21, CAST(180.00 AS Numeric(18, 2)), 5, CAST(900.00 AS Numeric(18, 2)), CAST(N'2024-06-03T11:32:44.220' AS DateTime), 1, 850.0000, 27.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (124, 99, 3, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:24:09.300' AS DateTime), 1, 20.0000, 3.3000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (125, 99, 4, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:24:10.993' AS DateTime), 1, 35.0000, 3.3000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (126, 99, 24, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:24:12.553' AS DateTime), 1, 35.0000, 3.3000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (127, 100, 19, CAST(220.00 AS Numeric(18, 2)), 3, CAST(660.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:41:26.903' AS DateTime), 1, 120.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (128, 100, 20, CAST(175.00 AS Numeric(18, 2)), 3, CAST(525.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:41:34.430' AS DateTime), 1, 75.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (129, 100, 25, CAST(30.00 AS Numeric(18, 2)), 2.5, CAST(75.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:41:52.307' AS DateTime), 1, 25.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (130, 100, 18, CAST(1500.00 AS Numeric(18, 2)), 0.5, CAST(750.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:42:09.923' AS DateTime), 1, 200.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (131, 100, 3, CAST(22.00 AS Numeric(18, 2)), 5, CAST(110.00 AS Numeric(18, 2)), CAST(N'2024-06-03T12:42:31.200' AS DateTime), 1, 20.0000, 3.3000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (132, 103, 19, CAST(220.00 AS Numeric(18, 2)), 3, CAST(660.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:04.383' AS DateTime), 1, 120.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (133, 103, 14, CAST(225.00 AS Numeric(18, 2)), 5, CAST(1125.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:09.823' AS DateTime), 1, 200.0000, 33.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (134, 103, 2, CAST(269.00 AS Numeric(18, 2)), 4, CAST(1076.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:15.123' AS DateTime), 1, 176.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (135, 104, 3, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:31.713' AS DateTime), 1, 24.0000, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (136, 104, 4, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:49.023' AS DateTime), 1, 42.0000, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (137, 104, 24, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:55:50.867' AS DateTime), 1, 42.0000, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (138, 106, 15, CAST(17.00 AS Numeric(18, 2)), 2, CAST(34.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:58:13.900' AS DateTime), 1, 14.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (139, 106, 1, CAST(1200.00 AS Numeric(18, 2)), 5, CAST(6000.00 AS Numeric(18, 2)), CAST(N'2024-06-04T13:58:30.077' AS DateTime), 1, 1000.0000, 180.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (140, 108, 19, CAST(220.00 AS Numeric(18, 2)), 5, CAST(1100.00 AS Numeric(18, 2)), CAST(N'2024-06-04T14:06:41.993' AS DateTime), 1, 200.0000, 33.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (141, 110, 25, CAST(30.00 AS Numeric(18, 2)), 1, CAST(30.00 AS Numeric(18, 2)), CAST(N'2024-06-04T14:24:46.583' AS DateTime), 1, 10.0000, 0.0000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (142, 114, 23, CAST(145.00 AS Numeric(18, 2)), 5, CAST(725.00 AS Numeric(18, 2)), CAST(N'2024-06-05T22:10:13.160' AS DateTime), 1, 125.0000, 21.7500)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (143, 122, 4, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-06-06T15:52:29.897' AS DateTime), 1, 42.0000, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (144, 124, 4, CAST(22.00 AS Numeric(18, 2)), 6, CAST(132.00 AS Numeric(18, 2)), CAST(N'2024-06-06T16:07:35.000' AS DateTime), 1, 42.0000, 3.9600)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (145, 126, 19, CAST(220.00 AS Numeric(18, 2)), 6, CAST(1320.00 AS Numeric(18, 2)), CAST(N'2024-06-06T16:11:30.410' AS DateTime), 1, 240.0000, 39.6000)
INSERT [dbo].[DetalleVenta] ([idDetVenta], [idVenta], [idProducto], [PVenta], [DetCantidad], [DetTotal], [FechaCreacion], [Estado], [Ganancias], [DescuentoProducto]) VALUES (146, 127, 19, CAST(220.00 AS Numeric(18, 2)), 6, CAST(1320.00 AS Numeric(18, 2)), CAST(N'2024-06-06T16:11:52.100' AS DateTime), 1, 240.0000, 39.6000)
SET IDENTITY_INSERT [dbo].[DetalleVenta] OFF
GO
SET IDENTITY_INSERT [dbo].[GananciasDiarias] ON 

INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (1, 56.0000, CAST(N'2024-06-02' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (2, 63.4000, CAST(N'2024-06-02' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (3, 896.7500, CAST(N'2024-06-02' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (4, 896.7500, CAST(N'2024-06-02' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (5, 167.0000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (6, 95.8500, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (7, 532.0500, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (8, 361.9000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (9, 134.8400, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (10, 466.5500, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (11, 670.0000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (12, 80.1000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (13, 436.7000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (14, 436.7000, CAST(N'2024-06-03' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (23, 103.2500, CAST(N'2024-06-05' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (24, 103.2500, CAST(N'2024-06-05' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (30, 200.4000, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (31, 200.4000, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[GananciasDiarias] ([idGanancia], [Ganancia], [Fecha]) VALUES (32, 200.4000, CAST(N'2024-06-06' AS Date))
SET IDENTITY_INSERT [dbo].[GananciasDiarias] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (1, N'Inicio', N'../home/', N'inicio', N'Inicio', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (2, N'Usuario', N'../MntUsuario/', N'mntusuario', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (3, N'Rol', N'../MntRol/', N'mntrol', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (4, N'Producto', N'../MntProducto/', N'mntproducto', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (5, N'Categoria', N'../MntCategoria/', N'mntcategoria', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (6, N'Proveedor', N'../MntProveedor/', N'mntproveedor', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (7, N'Cliente', N'../MntCliente/', N'mntcliente', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (8, N'Unidad De Medida', N'../MntUndMedida/', N'mntundmedida', N'Mantenimiento', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (12, N'Nueva Compra', N'../MntCompra/', N'mntcompra', N'Compra', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (13, N'Lista Compra', N'../ListaCompra/', N'listacompra', N'Compra', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (14, N'Nueva Venta', N'../MntVenta/', N'mntventa', N'Venta', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (15, N'Lista Venta', N'../ListaVenta/', N'listaventa', N'Venta', CAST(N'2024-05-16T18:07:22.507' AS DateTime), 1)
INSERT [dbo].[Menu] ([idMenu], [Menu], [Ruta], [Identificador], [Grupo], [FechaCreacion], [Estado]) VALUES (19, N'Ganancias', N'../Ganancias/', N'ganancias', N'Ganancias', CAST(N'2024-05-21T18:49:41.193' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuDetalle] ON 

INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (1, 1, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (2, 2, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (3, 3, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (4, 4, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (5, 5, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (6, 6, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (7, 7, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (8, 8, 1, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (9, 1, 2, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (10, 2, 2, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (11, 3, 2, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (12, 4, 2, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (13, 5, 2, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (14, 6, 2, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (15, 7, 2, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (16, 8, 2, N'Si', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (17, 1, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (18, 2, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (19, 3, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (20, 4, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (21, 5, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (22, 6, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (23, 7, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (24, 8, 3, N'No', CAST(N'2024-05-06T20:43:40.470' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (26, 12, 1, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (27, 13, 1, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (28, 14, 1, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (29, 15, 1, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (31, 12, 2, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (32, 13, 2, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (33, 14, 2, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (34, 15, 2, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (35, 12, 3, N'No', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (36, 13, 3, N'No', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (37, 14, 3, N'No', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (38, 15, 3, N'Si', CAST(N'2024-05-08T21:51:41.687' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (39, 1, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (40, 2, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (41, 3, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (42, 4, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (43, 5, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (44, 6, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (45, 7, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (46, 8, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (47, 12, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (48, 13, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (49, 14, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (50, 15, 9, N'Si', CAST(N'2024-05-21T18:28:00.963' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (51, 19, 1, N'Si', CAST(N'2024-05-21T18:56:21.967' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (52, 19, 2, N'No', CAST(N'2024-05-21T18:56:21.967' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (53, 19, 3, N'No', CAST(N'2024-05-21T18:56:21.967' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (54, 19, 9, N'Si', CAST(N'2024-05-21T18:56:21.967' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (55, 1, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (56, 2, 10, N'No', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (57, 3, 10, N'No', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (58, 4, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (59, 5, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (60, 6, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (61, 7, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (62, 8, 10, N'No', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (63, 12, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (64, 13, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (65, 14, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (66, 15, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (67, 19, 10, N'Si', CAST(N'2024-05-22T13:41:33.210' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (68, 1, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (69, 2, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (70, 3, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (71, 4, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (72, 5, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (73, 6, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (74, 7, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (75, 8, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (76, 12, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (77, 13, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (78, 14, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (79, 15, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (80, 19, 11, N'No', CAST(N'2024-05-23T08:39:20.060' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (81, 1, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (82, 2, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (83, 3, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (84, 4, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (85, 5, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (86, 6, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (87, 7, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (88, 8, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (89, 12, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (90, 13, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (91, 14, 12, N'No', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (92, 15, 12, N'Si', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
INSERT [dbo].[MenuDetalle] ([idMenuDetalle], [idMenu], [idRol], [Permiso], [FechaCreacion], [Estado]) VALUES (93, 19, 12, N'Si', CAST(N'2024-06-06T15:44:12.040' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[MenuDetalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (1, N'11740', N'Carretilla 4.5', N'Llanta neumática reforzada con rin de 3 aspas', 1, 2, 1, CAST(1000.00 AS Numeric(7, 2)), CAST(1200.00 AS Numeric(7, 2)), CAST(237.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), N'612016822.jpg', CAST(N'2024-05-16T14:26:32.923' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (2, N'17161', N'Pala cuadrada T-2000', N'Cabeza de acero al carbono, mango de madera con puño en Y', 1, 2, 1, CAST(225.00 AS Numeric(7, 2)), CAST(269.00 AS Numeric(7, 2)), CAST(73.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T14:29:39.027' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (3, N'47937', N'Placa Lisboa 1 ventana', N'Color blanco', 8, 1, 1, CAST(18.00 AS Numeric(7, 2)), CAST(22.00 AS Numeric(7, 2)), CAST(54.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T14:41:18.460' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (4, N'47940', N'Interruptor sencillo', N'color blanco ', 8, 1, 1, CAST(15.00 AS Numeric(7, 2)), CAST(22.00 AS Numeric(7, 2)), CAST(51.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T14:42:28.183' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (5, N'49090', N'Llave de nariz', N'cierre de compresión, entrada de 1/2', 2, 3, 1, CAST(74.00 AS Numeric(7, 2)), CAST(89.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T14:45:29.200' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (6, N'664574', N'Soldadura Blanda 50/50', N'Aleación 50% estaño 50% plomo', 2, 3, 1, CAST(320.00 AS Numeric(7, 2)), CAST(360.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(N'2025-10-25' AS Date), NULL, CAST(N'2024-05-16T14:52:16.650' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (9, N'1705', N'Coladera', N'Coladera con reja', 2, 2, 1, CAST(72.00 AS Numeric(7, 2)), CAST(80.00 AS Numeric(7, 2)), CAST(510.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T20:26:14.663' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (10, N'1706', N'prueba', N'prueba', 1, 2, 3, CAST(100.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T20:57:52.300' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (11, N'1111', N'test', N'10', 1, 1, 1, CAST(10.00 AS Numeric(7, 2)), CAST(10.00 AS Numeric(7, 2)), CAST(10.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T21:01:44.903' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (12, N'11111', N'test', N'222', 1, 1, 4, CAST(222.00 AS Numeric(7, 2)), CAST(222.00 AS Numeric(7, 2)), CAST(5222.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-16T21:02:15.447' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (13, N'16843', N'Pinzas De Punta Alargada', N'Pinzas de electricista ', 2, 1, 1, CAST(115.00 AS Numeric(7, 2)), CAST(145.00 AS Numeric(7, 2)), CAST(400.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-21T18:30:48.660' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (14, N'11114', N'Cemento ', N'Cemento gris ', 9, 13, 4, CAST(185.00 AS Numeric(7, 2)), CAST(225.00 AS Numeric(7, 2)), CAST(44.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-21T20:37:01.530' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (15, N'77141', N'Brocha de 1/2', N'Para Cualquier tipo de pintura', 10, 14, 1, CAST(10.00 AS Numeric(7, 2)), CAST(17.00 AS Numeric(7, 2)), CAST(1.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T08:49:22.430' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (16, N'141414', N'Prueba', N'Prueba', 2, 3, 3, CAST(100.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(100.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T12:50:14.873' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (17, N'001', N'dgdrhrtjh', N'777', 9, 3, 2, CAST(777.00 AS Numeric(7, 2)), CAST(777.00 AS Numeric(7, 2)), CAST(777.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), N'630335290.jpg', CAST(N'2024-05-23T12:56:09.803' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (18, N'10101', N'Arena', N'Test', 9, 13, 8, CAST(1100.00 AS Numeric(7, 2)), CAST(1500.00 AS Numeric(7, 2)), CAST(10.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T13:00:38.640' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (19, N'2', N'Mortero', N'test', 9, 13, 4, CAST(180.00 AS Numeric(7, 2)), CAST(220.00 AS Numeric(7, 2)), CAST(58.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), N'1105985606.jpg', CAST(N'2024-05-23T13:05:33.007' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (20, N'3', N'Tribi', N'vdgsbgs', 9, 13, 3, CAST(150.00 AS Numeric(7, 2)), CAST(175.00 AS Numeric(7, 2)), CAST(0.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T13:07:33.160' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (21, N'4', N'jhvaxsd', N'Test', 8, 2, 9, CAST(100.00 AS Numeric(7, 2)), CAST(180.00 AS Numeric(7, 2)), CAST(5.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T13:11:34.180' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (22, N'5', N'jsdbcs', N'prueba', 9, 2, 3, CAST(150.00 AS Numeric(7, 2)), CAST(170.00 AS Numeric(7, 2)), CAST(10.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-05-23T13:31:43.513' AS DateTime), 0)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (23, N'159633', N'Martillo', N'Mango de Goma', 1, 2, 1, CAST(120.00 AS Numeric(7, 2)), CAST(145.00 AS Numeric(7, 2)), CAST(1.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), N'', CAST(N'2024-05-28T20:37:29.813' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (24, N'47941', N'Interruptor de escalera', N'Para uso en exterior e interior', 8, 1, 1, CAST(15.00 AS Numeric(7, 2)), CAST(22.00 AS Numeric(7, 2)), CAST(63.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-06-01T17:04:53.710' AS DateTime), 1)
INSERT [dbo].[Productos] ([idProducto], [Codigo], [NombreProducto], [Descripcion], [idProveedor], [idCategoria], [idUnidad], [PCompra], [PVenta], [Stock], [FechaVencimiento], [Imagen], [FechaCreacion], [Estado]) VALUES (25, N'00007', N'clavos', N'Cambio', 9, 2, 3, CAST(20.00 AS Numeric(7, 2)), CAST(30.00 AS Numeric(7, 2)), CAST(47.00 AS Numeric(7, 2)), CAST(N'1900-01-01' AS Date), NULL, CAST(N'2024-06-02T18:07:36.760' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (1, N'Truper', N'Santiago Nuñez', N'TRP011108DJ5', N'4641572156', N'Ponciano Vega', N'ventas@truper.com', CAST(N'2024-05-03T21:05:17.513' AS DateTime), 1)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (2, N'Pretul', N'Armando Luna', N'PTL1000517HGT', N'5510786324', N'5 de mayo', N'pretulventas@pretul.com', CAST(N'2024-05-03T21:45:11.703' AS DateTime), 1)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (3, N'TEST', N'TEST', N'TEST', N'TEST', N'TEST', N'TEST', CAST(N'2024-05-03T21:57:44.417' AS DateTime), 0)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (4, N'Vere', N'Viridiana', N'VLML000517HGT', N'1536781495', N'Donato Hernandez', N'vere@prueba@gmail.com', CAST(N'2024-05-03T21:59:51.473' AS DateTime), 0)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (7, N'VOLTECK', N'Santiago Nuñez', N'PAML000517HGT', N'4451524298', N'Donato Hernandez', N'vere@prueba@gmail.com', CAST(N'2024-05-16T14:34:46.930' AS DateTime), 0)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (8, N'VOLTECK', N'Luis Gonzalez', N'VL3579145931K', N'1453657892', N'Puebla 15', N'ventas@voltec.com', CAST(N'2024-05-16T14:38:53.430' AS DateTime), 1)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (9, N'Cemento', N'Manuel Perez', N'YYYYYYYYYYYYY', N'4451322525', N'Miguel Hidalgo #1', N'manuelperez@gmail.com', CAST(N'2024-05-21T18:36:28.520' AS DateTime), 1)
INSERT [dbo].[Proveedores] ([idProveedor], [Proveedor], [NombreContacto], [RFC], [Telefono], [Direccion], [Correo], [FechaCreacion], [Estado]) VALUES (10, N'Berel', N'German Mendoza', N'BERE2487369HY', N'4113681427', N'5 de Mayo -Yuriria Centro', N'vntasberel@gmail.com', CAST(N'2024-05-23T08:47:13.503' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (1, N'Administrador', CAST(N'2024-04-26T12:48:55.987' AS DateTime), 1)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (2, N'Vendedor', CAST(N'2024-05-05T17:05:06.487' AS DateTime), 1)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (3, N'Repartidor', CAST(N'2024-05-05T17:05:06.487' AS DateTime), 1)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (4, N'Test', CAST(N'2024-05-05T18:13:11.467' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (5, N'Test2', CAST(N'2024-05-05T18:14:34.523' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (6, N'Test5', CAST(N'2024-05-05T18:14:49.920' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (7, N'SupervisoR', CAST(N'2024-05-21T18:13:34.117' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (8, N'Supervisor', CAST(N'2024-05-21T18:14:02.500' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (9, N'Supervisor', CAST(N'2024-05-21T18:28:00.950' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (10, N'Supervisora', CAST(N'2024-05-22T13:41:33.193' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (11, N'Supervisor', CAST(N'2024-05-23T08:39:20.050' AS DateTime), 0)
INSERT [dbo].[Roles] ([idRol], [Rol], [FechaCreacion], [Estado]) VALUES (12, N'Supervisora', CAST(N'2024-06-06T15:44:12.030' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Unidades] ON 

INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (1, N'Pieza', CAST(N'2024-05-01T20:48:42.963' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (2, N'Caja', CAST(N'2024-05-01T20:48:42.963' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (3, N'Kilo', CAST(N'2024-05-01T20:48:42.963' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (4, N'Bultos', CAST(N'2024-05-01T20:48:42.963' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (5, N'test2', CAST(N'2024-05-01T21:12:35.163' AS DateTime), 0)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (6, N'test3', CAST(N'2024-05-01T21:14:21.593' AS DateTime), 0)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (7, N'Metros', CAST(N'2024-05-12T14:22:49.880' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (8, N'Toneladas', CAST(N'2024-05-21T18:40:59.137' AS DateTime), 1)
INSERT [dbo].[Unidades] ([idUnidad], [Unidad], [FechaCreacion], [Estado]) VALUES (9, N'Litro', CAST(N'2024-05-23T08:45:33.033' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Unidades] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuario], [Nombre], [Paterno], [Materno], [idRol], [Sexo], [Direccion], [Telefono], [CURP], [RFC], [Correo], [Contrasena], [FechaCreacion], [Estado]) VALUES (1, N'Jesus', N'Parra', N'Leon', 1, N'H', N'Benito Juarez #115', N'4452158660', N'PALJ1111111111111A', N'PALJ11111111A', N'jesusparra@gmail.com', N'Parra0502', CAST(N'2024-04-26T12:54:00.070' AS DateTime), 1)
INSERT [dbo].[Usuarios] ([idUsuario], [Nombre], [Paterno], [Materno], [idRol], [Sexo], [Direccion], [Telefono], [CURP], [RFC], [Correo], [Contrasena], [FechaCreacion], [Estado]) VALUES (2, N'Juan', N'Lopez', N'Moreno', 3, N'H', N'Calle Morelia #7', N'3357609150', N'JULM000517TRTRZLY7', N'JULM000517TRT', N'juanlopez@gmail.com', N'Moreno17', CAST(N'2024-05-05T17:32:42.110' AS DateTime), 0)
INSERT [dbo].[Usuarios] ([idUsuario], [Nombre], [Paterno], [Materno], [idRol], [Sexo], [Direccion], [Telefono], [CURP], [RFC], [Correo], [Contrasena], [FechaCreacion], [Estado]) VALUES (5, N'Jorge', N'Nuñez', N'Luna', 3, N'H', N'Miguel Hidalgo #77', N'4452154298', N'JONL000517TRZRZLR0', N'JONL000517TRZ', N'jorgeluna99@gmail.com', N'Nunez09', CAST(N'2024-05-05T17:43:30.170' AS DateTime), 1)
INSERT [dbo].[Usuarios] ([idUsuario], [Nombre], [Paterno], [Materno], [idRol], [Sexo], [Direccion], [Telefono], [CURP], [RFC], [Correo], [Contrasena], [FechaCreacion], [Estado]) VALUES (6, N'Migue', N'Martinez', N'Martinez', 1, N'H', N'Guanajuato 18', N'4457850232', N'MMNL000517TRZRZLR0', N'MML1000517HGT', N'miguel@gmail.com', N'Martinez18', CAST(N'2024-05-21T18:12:50.040' AS DateTime), 0)
INSERT [dbo].[Usuarios] ([idUsuario], [Nombre], [Paterno], [Materno], [idRol], [Sexo], [Direccion], [Telefono], [CURP], [RFC], [Correo], [Contrasena], [FechaCreacion], [Estado]) VALUES (7, N'Ana', N'Leon', N'Leon', 2, N'M', N'Niños Heroes #33', N'4451484849', N'ALDA000517HGTRZL74', N'ALDS000517HRZ', N'analeon@gmail.com', N'Leon2024', CAST(N'2024-05-23T08:38:22.107' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (1, NULL, NULL, NULL, NULL, NULL, CAST(807.00 AS Numeric(18, 2)), CAST(129.12 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(807.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (2, NULL, NULL, NULL, NULL, NULL, CAST(44.00 AS Numeric(18, 2)), CAST(7.04 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(44.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (3, NULL, NULL, NULL, NULL, NULL, CAST(540.00 AS Numeric(18, 2)), CAST(86.40 AS Numeric(18, 2)), CAST(27.00 AS Numeric(18, 2)), CAST(513.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (4, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (5, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (6, NULL, NULL, NULL, NULL, NULL, CAST(1100.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), CAST(55.00 AS Numeric(18, 2)), CAST(1045.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (7, NULL, NULL, NULL, NULL, NULL, CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(8.80 AS Numeric(18, 2)), CAST(167.20 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (8, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (9, NULL, NULL, NULL, NULL, NULL, CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(8.80 AS Numeric(18, 2)), CAST(167.20 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (10, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (11, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(324.00 AS Numeric(18, 2)), CAST(51.84 AS Numeric(18, 2)), CAST(9.72 AS Numeric(18, 2)), CAST(314.28 AS Numeric(18, 2)), 1, CAST(N'2024-05-22T15:48:51.077' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (12, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(440.00 AS Numeric(18, 2)), CAST(70.40 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(440.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-22T15:51:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (13, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(240.00 AS Numeric(18, 2)), CAST(38.40 AS Numeric(18, 2)), CAST(12.00 AS Numeric(18, 2)), CAST(228.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-23T15:51:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (14, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-23T15:52:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (15, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(1540.00 AS Numeric(18, 2)), CAST(246.40 AS Numeric(18, 2)), CAST(77.00 AS Numeric(18, 2)), CAST(1463.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-24T15:53:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (16, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(1320.00 AS Numeric(18, 2)), CAST(211.20 AS Numeric(18, 2)), CAST(66.00 AS Numeric(18, 2)), CAST(1254.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-24T15:54:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (17, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(1980.00 AS Numeric(18, 2)), CAST(316.80 AS Numeric(18, 2)), CAST(99.00 AS Numeric(18, 2)), CAST(1881.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-24T15:55:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (18, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (19, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (20, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (21, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (22, NULL, NULL, NULL, NULL, NULL, CAST(23100.00 AS Numeric(18, 2)), CAST(3696.00 AS Numeric(18, 2)), CAST(1155.00 AS Numeric(18, 2)), CAST(21945.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (23, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (24, NULL, NULL, NULL, NULL, NULL, CAST(24200.00 AS Numeric(18, 2)), CAST(3872.00 AS Numeric(18, 2)), CAST(1210.00 AS Numeric(18, 2)), CAST(22990.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (25, NULL, NULL, NULL, NULL, NULL, CAST(2640.00 AS Numeric(18, 2)), CAST(422.40 AS Numeric(18, 2)), CAST(132.00 AS Numeric(18, 2)), CAST(2508.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (26, NULL, NULL, NULL, NULL, NULL, CAST(110000.00 AS Numeric(18, 2)), CAST(17600.00 AS Numeric(18, 2)), CAST(5500.00 AS Numeric(18, 2)), CAST(104500.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (27, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (28, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (29, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (30, NULL, NULL, NULL, NULL, NULL, CAST(110000.00 AS Numeric(18, 2)), CAST(17600.00 AS Numeric(18, 2)), CAST(5500.00 AS Numeric(18, 2)), CAST(104500.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (31, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(560.00 AS Numeric(18, 2)), CAST(89.60 AS Numeric(18, 2)), CAST(28.00 AS Numeric(18, 2)), CAST(532.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-25T15:43:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (32, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(1450.00 AS Numeric(18, 2)), CAST(232.00 AS Numeric(18, 2)), CAST(72.50 AS Numeric(18, 2)), CAST(1377.50 AS Numeric(18, 2)), 1, CAST(N'2024-05-25T15:44:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (33, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (34, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (35, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (36, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(19470.00 AS Numeric(18, 2)), CAST(3115.20 AS Numeric(18, 2)), CAST(973.50 AS Numeric(18, 2)), CAST(18496.50 AS Numeric(18, 2)), 1, CAST(N'2024-05-25T15:45:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (37, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(22.00 AS Numeric(18, 2)), CAST(3.52 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(22.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-26T15:43:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (38, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(700.00 AS Numeric(18, 2)), CAST(112.00 AS Numeric(18, 2)), CAST(35.00 AS Numeric(18, 2)), CAST(665.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-26T15:44:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (39, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(22.00 AS Numeric(18, 2)), CAST(3.52 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(22.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-26T15:45:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (40, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(1100.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), CAST(55.00 AS Numeric(18, 2)), CAST(1045.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-27T15:43:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (41, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 5, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (42, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (43, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(217.00 AS Numeric(18, 2)), CAST(34.72 AS Numeric(18, 2)), CAST(4.25 AS Numeric(18, 2)), CAST(212.75 AS Numeric(18, 2)), 1, CAST(N'2024-05-27T15:44:36.293' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (45, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (46, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (47, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (48, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (49, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(829.00 AS Numeric(18, 2)), CAST(132.64 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(829.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-30T14:39:46.697' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (50, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(925.00 AS Numeric(18, 2)), CAST(148.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(925.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-30T14:41:05.963' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (51, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (52, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(3000.00 AS Numeric(18, 2)), CAST(480.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(3000.00 AS Numeric(18, 2)), 1, CAST(N'2024-05-30T14:43:09.673' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (53, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (54, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(2690.00 AS Numeric(18, 2)), CAST(430.40 AS Numeric(18, 2)), CAST(134.50 AS Numeric(18, 2)), CAST(2555.50 AS Numeric(18, 2)), 1, CAST(N'2024-05-30T14:45:59.703' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (55, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (56, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(1125.00 AS Numeric(18, 2)), CAST(180.00 AS Numeric(18, 2)), CAST(56.25 AS Numeric(18, 2)), CAST(1068.75 AS Numeric(18, 2)), 1, CAST(N'2024-05-31T11:38:51.513' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (57, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (58, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(264.00 AS Numeric(18, 2)), CAST(42.24 AS Numeric(18, 2)), CAST(8.80 AS Numeric(18, 2)), CAST(255.20 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T17:06:22.890' AS DateTime), 1, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (59, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (60, NULL, NULL, NULL, NULL, NULL, CAST(110.00 AS Numeric(18, 2)), CAST(17.60 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(110.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (61, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(198.00 AS Numeric(18, 2)), CAST(31.68 AS Numeric(18, 2)), CAST(3.30 AS Numeric(18, 2)), CAST(194.70 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T18:57:56.443' AS DateTime), 1, 59.7000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (62, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T19:00:04.250' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (63, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(198.00 AS Numeric(18, 2)), CAST(31.68 AS Numeric(18, 2)), CAST(3.30 AS Numeric(18, 2)), CAST(194.70 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T19:03:50.517' AS DateTime), 1, 59.7000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (64, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T20:52:24.807' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (65, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T20:59:22.783' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (66, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T21:10:57.070' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (67, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (68, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T21:13:50.733' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (69, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T22:02:05.667' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (70, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T22:11:03.510' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (71, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T22:12:59.427' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (72, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (73, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(70.00 AS Numeric(18, 2)), CAST(11.20 AS Numeric(18, 2)), CAST(2.10 AS Numeric(18, 2)), CAST(67.90 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T22:42:34.797' AS DateTime), 1, -2.1000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (74, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(198.00 AS Numeric(18, 2)), CAST(31.68 AS Numeric(18, 2)), CAST(3.30 AS Numeric(18, 2)), CAST(194.70 AS Numeric(18, 2)), 1, CAST(N'2024-06-01T22:45:19.190' AS DateTime), 1, 59.7000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (75, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:02:16.350' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (76, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:05:57.610' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (77, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:07:20.730' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (78, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:08:32.050' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (79, NULL, NULL, NULL, NULL, NULL, CAST(80.00 AS Numeric(18, 2)), CAST(12.80 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(80.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (80, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:11:51.137' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (81, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (82, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(293.00 AS Numeric(18, 2)), CAST(46.88 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(293.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:34:16.197' AS DateTime), 1, 111.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (83, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (84, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(176.00 AS Numeric(18, 2)), CAST(28.16 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:47:44.550' AS DateTime), 1, 56.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (85, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(220.00 AS Numeric(18, 2)), CAST(35.20 AS Numeric(18, 2)), CAST(6.60 AS Numeric(18, 2)), CAST(213.40 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T09:48:33.260' AS DateTime), 1, 63.4000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (86, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (87, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(5982.00 AS Numeric(18, 2)), CAST(957.12 AS Numeric(18, 2)), CAST(155.25 AS Numeric(18, 2)), CAST(5826.75 AS Numeric(18, 2)), 1, CAST(N'2024-06-02T20:34:36.693' AS DateTime), 1, 896.7500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (88, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (89, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(1100.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), CAST(33.00 AS Numeric(18, 2)), CAST(1067.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:02:37.247' AS DateTime), 1, 167.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (90, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(305.00 AS Numeric(18, 2)), CAST(48.80 AS Numeric(18, 2)), CAST(9.15 AS Numeric(18, 2)), CAST(295.85 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:04:01.407' AS DateTime), 1, 95.8500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (91, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(3472.00 AS Numeric(18, 2)), CAST(555.52 AS Numeric(18, 2)), CAST(79.95 AS Numeric(18, 2)), CAST(3392.05 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:06:17.680' AS DateTime), 1, 532.0500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (92, 2, N'PADS000517HGT', N'4451524239', N'Guerrero', N's.parradiaz@ugto.mx', CAST(2558.00 AS Numeric(18, 2)), CAST(409.28 AS Numeric(18, 2)), CAST(74.10 AS Numeric(18, 2)), CAST(2483.90 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:15:24.637' AS DateTime), 1, 361.9000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (93, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (94, 4, N'GMPA000517HGT', N'7789631452', N'Vicente G #87', N'gustavomtz@gmail.com', CAST(572.00 AS Numeric(18, 2)), CAST(91.52 AS Numeric(18, 2)), CAST(17.16 AS Numeric(18, 2)), CAST(554.84 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:26:16.963' AS DateTime), 1, 134.8400)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (95, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(3115.00 AS Numeric(18, 2)), CAST(498.40 AS Numeric(18, 2)), CAST(93.45 AS Numeric(18, 2)), CAST(3021.55 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:29:41.470' AS DateTime), 1, 466.5500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (96, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (97, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(1197.00 AS Numeric(18, 2)), CAST(191.52 AS Numeric(18, 2)), CAST(27.00 AS Numeric(18, 2)), CAST(1170.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T11:32:50.333' AS DateTime), 1, 670.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (98, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (99, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(330.00 AS Numeric(18, 2)), CAST(52.80 AS Numeric(18, 2)), CAST(9.90 AS Numeric(18, 2)), CAST(320.10 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T12:24:15.510' AS DateTime), 1, 80.1000)
GO
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (100, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(2120.00 AS Numeric(18, 2)), CAST(339.20 AS Numeric(18, 2)), CAST(3.30 AS Numeric(18, 2)), CAST(2116.70 AS Numeric(18, 2)), 1, CAST(N'2024-06-03T12:42:38.033' AS DateTime), 1, 436.7000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (101, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (102, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (103, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(2861.00 AS Numeric(18, 2)), CAST(457.76 AS Numeric(18, 2)), CAST(33.75 AS Numeric(18, 2)), CAST(2827.25 AS Numeric(18, 2)), 1, CAST(N'2024-06-04T13:55:22.973' AS DateTime), 1, 462.2500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (104, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(396.00 AS Numeric(18, 2)), CAST(63.36 AS Numeric(18, 2)), CAST(11.88 AS Numeric(18, 2)), CAST(384.12 AS Numeric(18, 2)), 1, CAST(N'2024-06-04T13:55:59.497' AS DateTime), 1, 96.1200)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (105, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (106, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(6034.00 AS Numeric(18, 2)), CAST(965.44 AS Numeric(18, 2)), CAST(180.00 AS Numeric(18, 2)), CAST(5854.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-04T13:58:37.780' AS DateTime), 1, 834.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (107, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (108, 5, N'VVDA000517HG5', N'9182234746', N'Miguel Hidalgo #23 Juan Lucas', N'victor2726@gmail.com', CAST(1100.00 AS Numeric(18, 2)), CAST(176.00 AS Numeric(18, 2)), CAST(33.00 AS Numeric(18, 2)), CAST(1067.00 AS Numeric(18, 2)), 7, CAST(N'2024-06-04T14:06:43.977' AS DateTime), 1, 167.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (109, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 7, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (110, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(30.00 AS Numeric(18, 2)), CAST(4.80 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(30.00 AS Numeric(18, 2)), 1, CAST(N'2024-06-04T14:24:54.097' AS DateTime), 1, 10.0000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (111, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (112, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (113, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (114, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(725.00 AS Numeric(18, 2)), CAST(116.00 AS Numeric(18, 2)), CAST(21.75 AS Numeric(18, 2)), CAST(703.25 AS Numeric(18, 2)), 1, CAST(N'2024-06-05T22:10:16.167' AS DateTime), 1, 103.2500)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (115, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (116, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (117, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (118, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (119, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (120, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (121, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 7, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (122, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(132.00 AS Numeric(18, 2)), CAST(21.12 AS Numeric(18, 2)), CAST(3.96 AS Numeric(18, 2)), CAST(128.04 AS Numeric(18, 2)), 1, CAST(N'2024-06-06T15:53:26.307' AS DateTime), 1, 38.0400)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (123, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (124, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(132.00 AS Numeric(18, 2)), CAST(21.12 AS Numeric(18, 2)), CAST(3.96 AS Numeric(18, 2)), CAST(128.04 AS Numeric(18, 2)), 1, CAST(N'2024-06-06T16:07:37.430' AS DateTime), 1, 38.0400)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (125, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (126, 3, N'LEPA000517HGT', N'4451524277', N'Guerrero', N'tes2a@gmail.com', CAST(1320.00 AS Numeric(18, 2)), CAST(211.20 AS Numeric(18, 2)), CAST(39.60 AS Numeric(18, 2)), CAST(1280.40 AS Numeric(18, 2)), 1, CAST(N'2024-06-06T16:11:33.090' AS DateTime), 1, 200.4000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (127, 1, N'XAXX010101000', N'4111568181', N'Niños Heroes #1 Juan Lucas', N'ferrematerialeschuy@gmail.com', CAST(1320.00 AS Numeric(18, 2)), CAST(211.20 AS Numeric(18, 2)), CAST(39.60 AS Numeric(18, 2)), CAST(1280.40 AS Numeric(18, 2)), 1, CAST(N'2024-06-06T16:11:55.027' AS DateTime), 1, 200.4000)
INSERT [dbo].[Venta] ([idVenta], [idCliente], [CliRFC], [CliTelefono], [CliDireccion], [CliCorreo], [Subtotal], [IVA], [Descuento], [Total], [idUsuario], [FechaCreacion], [Estado], [Ganancias]) VALUES (128, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 1, NULL, 2, NULL)
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Clientes__CAFFA85EA3F6E4F6]    Script Date: 06/06/2024 04:14:37 p. m. ******/
ALTER TABLE [dbo].[Clientes] ADD UNIQUE NONCLUSTERED 
(
	[RFC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Clientes__F46C4CBF8CE90C73]    Script Date: 06/06/2024 04:14:37 p. m. ******/
ALTER TABLE [dbo].[Clientes] ADD UNIQUE NONCLUSTERED 
(
	[CURP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Proveedo__CAFFA85E0E3546AA]    Script Date: 06/06/2024 04:14:37 p. m. ******/
ALTER TABLE [dbo].[Proveedores] ADD UNIQUE NONCLUSTERED 
(
	[RFC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__CAFFA85E33A95D61]    Script Date: 06/06/2024 04:14:37 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[RFC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__F46C4CBFBCFCEEFC]    Script Date: 06/06/2024 04:14:37 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[CURP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT ((0)) FOR [Subtotal]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT ((0)) FOR [IVA]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT ((0)) FOR [Descuento]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[MenuDetalle]  WITH CHECK ADD  CONSTRAINT [FK_MenuDetalleMenu] FOREIGN KEY([idMenu])
REFERENCES [dbo].[Menu] ([idMenu])
GO
ALTER TABLE [dbo].[MenuDetalle] CHECK CONSTRAINT [FK_MenuDetalleMenu]
GO
ALTER TABLE [dbo].[MenuDetalle]  WITH CHECK ADD  CONSTRAINT [FK_MenuDetalleRol] FOREIGN KEY([idRol])
REFERENCES [dbo].[Roles] ([idRol])
GO
ALTER TABLE [dbo].[MenuDetalle] CHECK CONSTRAINT [FK_MenuDetalleRol]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_ProductosCategorias] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_ProductosCategorias]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_ProductosProveedores] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_ProductosProveedores]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_ProductosUnidades] FOREIGN KEY([idUnidad])
REFERENCES [dbo].[Unidades] ([idUnidad])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_ProductosUnidades]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_UruariosRoles] FOREIGN KEY([idRol])
REFERENCES [dbo].[Roles] ([idRol])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_UruariosRoles]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD CHECK  (([Sexo]='NU' OR [Sexo]='M' OR [Sexo]='H'))
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD CHECK  (([Stock]>=(0)))
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD CHECK  (([Sexo]='NU' OR [Sexo]='M' OR [Sexo]='H'))
GO
/****** Object:  StoredProcedure [dbo].[SP_AccesoUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AccesoUsuarios]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_CambioContUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----CAMBIO DE CONTRASENA-----
create procedure [dbo].[SP_CambioContUsuarios]
@idUsuario int,
@Contrasena varchar(50)
as
begin
	update Usuarios
	set Contrasena = @Contrasena
	where idUsuario = @idUsuario
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Contar]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Contar]
as
begin
	SELECT 
    (SELECT COUNT(idProducto) FROM Productos WHERE Estado = 1) AS CantidadProductos,
    (SELECT COUNT(idCategoria) FROM Categorias WHERE Estado = 1) AS CantidadCategorias,
    (SELECT COUNT(idCliente) FROM Clientes WHERE Estado = 1) AS CantidadClientes,
    (SELECT COUNT(idProveedor) FROM Proveedores WHERE Estado = 1) AS CantidadProveedores
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteCategorias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Categorias-----
create procedure [dbo].[SP_DeleteCategorias]
@idCategoria int
as
begin
	update Categorias
	set Estado = 0
	where idCategoria = @idCategoria
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteClientes]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Clientes-----
create procedure [dbo].[SP_DeleteClientes]
@idCliente int
as
begin
	update Clientes
	set Estado = 0
	where idCliente = @idCliente
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteDetVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_DeleteDetVenta]
	@idDetVenta int
as
begin
	update DetalleVenta
	set Estado = 0
	where idDetVenta=@idDetVenta
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProductos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Productos-----
create procedure [dbo].[SP_DeleteProductos]
@idProducto int
as
begin
	update Productos
	set Estado = 0
	where idProducto = @idProducto
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProveedores]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Proveedores-----
CREATE procedure [dbo].[SP_DeleteProveedores]
@idProveedor int
as
begin
	update Proveedores
	set Estado = 0
	where idProveedor = @idProveedor
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteRoles]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Roles-----
create procedure [dbo].[SP_DeleteRoles]
@idRol int
as
begin
	update Roles
	set Estado = 0
	where idRol = @idRol
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUnidades]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Unidades-----
create procedure [dbo].[SP_DeleteUnidades]
@idUnidad int
as
begin
	update Unidades
	set Estado = 0
	where idUnidad = @idUnidad
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Eliminar Usuarios-----
create procedure [dbo].[SP_DeleteUsuarios]
@idUsuario int
as
begin
	update Usuarios
	set Estado = 0
	where idUsuario = @idUsuario
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GananciaDiaria]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GananciaDiaria]
@Fecha Date
as
begin

    select @Fecha AS Fecha, SUM(Ganancia) as Ganancia FROM GananciasDiarias WHERE Fecha = @Fecha

end
GO
/****** Object:  StoredProcedure [dbo].[SP_GuardarVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GuardarVenta]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDetVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertDetVenta]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNCategorias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Registrar Nuva Categoria-----
create procedure [dbo].[SP_InsertNCategorias]
@Categoria varchar(50)
as
begin
	insert into Categorias
	(Categoria,FechaCreacion,Estado)
	values
	(@Categoria, GETDATE(),1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNClientes]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertNClientes]
@Nombre varchar(100),
@Paterno varchar(50),
@Materno varchar(50),
@Sexo varchar(2),
@Direccion varchar(100),
@Telefono varchar(10),
@Correo varchar(100),
@CURP varchar(18),
@RFC varchar(13)
as
begin
	insert into Clientes
	(Nombre,Paterno,Materno,Sexo,Direccion,Telefono,Correo,CURP,RFC,FechaCreacion,Estado)
	values
	(@Nombre,@Paterno,@Materno,@Sexo,@Direccion,@Telefono,@Correo,@CURP,@RFC,GETDATE(),1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNProductos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertNProductos]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNProveedores]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Registrar Nuva Proveedor-----
CREATE procedure [dbo].[SP_InsertNProveedores]
@Proveedor varchar(100),
@NombreContacto varchar(100),
@RFC varchar(13),
@Telefono varchar(10),
@Direccion varchar(100) ,
@Correo varchar(100)
as
begin
	insert into Proveedores
	(Proveedor,NombreContacto,RFC,Telefono,Direccion,Correo,FechaCreacion,Estado)
	values
	(@Proveedor,@NombreContacto,@RFC,@Telefono,@Direccion,@Correo,GETDATE(),1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNRoles]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Registrar Nuva Rol-----
create procedure [dbo].[SP_InsertNRoles]
@Rol varchar(50)
as
begin
	insert into Roles
	(Rol,FechaCreacion,Estado)
	values
	(@Rol, GETDATE(),1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNUnidades]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Registrar Nuva Unidad-----
create procedure [dbo].[SP_InsertNUnidades]
@Unidad varchar(50)
as
begin
	insert into Unidades
	(Unidad,FechaCreacion,Estado)
	values
	(@Unidad, GETDATE(),1)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertNUsuarios]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InTempVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InTempVenta]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_InVenta]
@idUsuario int
as
begin
	insert into Venta
	(idUsuario,Estado)
	values
	(@idUsuario,2)

	select idVenta from Venta where idVenta = @@IDENTITY
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarCategorias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarCategorias]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarCategoriasID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar las Categorias Por ID-----
create procedure [dbo].[SP_ListarCategoriasID]
@idCategoria int
as
begin
	select * from Categorias
	where idCategoria = @idCategoria
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarCategoriasProv]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarCategoriasProv]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarClientes]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----CRUD Clientes-----
-----Listar los Clientes-----
create procedure [dbo].[SP_ListarClientes]
as
begin
	select * from Clientes
	where Estado = 1
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarClientesID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar los Clientes Por ID-----
create procedure [dbo].[SP_ListarClientesID]
@idCliente int
as
begin
	select * from Clientes
	where idCliente = @idCliente
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarDetCompra]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_ListarDetCompra]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarDetVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Listaqdo de venta
create procedure [dbo].[SP_ListarDetVenta]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarMenu]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarMenu]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProductos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarProductos]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProductosCat]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarProductosCat]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProductosCOD]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Listar los Productos Por Codigo-----
create procedure [dbo].[SP_ListarProductosCOD]
@Codigo int
as
begin
	select * from Productos
	where Codigo = @Codigo
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProductosID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarProductosID]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProveedores]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarProveedores]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarProveedoresID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar los Proveedores Por ID-----
CREATE procedure [dbo].[SP_ListarProveedoresID]
@idProveedor int
as
begin
	select * from Proveedores
	where idProveedor = @idProveedor
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarRoles]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----CRUD Roles-----
-----Listar los Roles-----
create procedure [dbo].[SP_ListarRoles]
as
begin
	select * from Roles
	where Estado = 1
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarRolesID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar las Roles Por ID-----
create procedure [dbo].[SP_ListarRolesID]
@idRol int
as
begin
	select * from Roles
	where idRol = @idRol
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarTodaVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_ListarTodaVenta]

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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarUnidades]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarUnidades]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarUnidadesID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar las Unidades Por ID-----
create procedure [dbo].[SP_ListarUnidadesID]
@idUnidad int
as
begin
	select * from Unidades
	where idUnidad = @idUnidad
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarUsuarios]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarUsuariosID]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----Listar los Usuarios Por ID-----
create procedure [dbo].[SP_ListarUsuariosID]
@idUsuario int
as
begin
	select * from Usuarios
	where idUsuario = @idUsuario
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ListarVenta]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCategorias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Actualizar Categoria-----
create procedure [dbo].[SP_UpdateCategorias]
@idCategoria int,
@Categoria varchar(50)
as
begin
	update Categorias
	set Categoria = @Categoria
	where idCategoria = @idCategoria
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateClientes]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_UpdateClientes]
@idCliente int,
@Nombre varchar(100),
@Paterno varchar(50),
@Materno varchar(50),
@Sexo varchar(2),
@Direccion varchar(100),
@Telefono varchar(10),
@Correo varchar(100),
@CURP varchar(18),
@RFC varchar(13)
as
begin
	update Clientes
	set
		Nombre = @Nombre,
		Paterno = @Paterno,
		Materno = @Materno,
		Sexo = @Sexo,
		Direccion = @Direccion,
		Telefono = @Telefono,
		Correo = @Correo,
		CURP = @CURP,
		RFC = @RFC

	where idCliente = @idCliente
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateMenuN]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_UpdateMenuN]
	@idMenuDetalle int
as
begin
	update MenuDetalle
	set
	Permiso = 'No'
	where
	idMenuDetalle = @idMenuDetalle
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateMenuS]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateMenuS]
	@idMenuDetalle int
as
begin
	update MenuDetalle
	set
	Permiso = 'Si'
	where
	idMenuDetalle = @idMenuDetalle
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProductos]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_UpdateProductos]  
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
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProveedores]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Actualizar Proveedor-----
CREATE procedure [dbo].[SP_UpdateProveedores]
@idProveedor int,
@Proveedor varchar(100),
@NombreContacto varchar(100),
@RFC varchar(13),
@Telefono varchar(10),
@Direccion varchar(100) ,
@Correo varchar(100)
as
begin
	update Proveedores
	set
		Proveedor=@Proveedor,
		NombreContacto = @NombreContacto,
		RFC = @RFC,
		Telefono = @Telefono,
		Direccion = @Direccion,
		Correo = @Correo
	where idProveedor = @idProveedor
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateRoles]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Actualizar Rol-----
create procedure [dbo].[SP_UpdateRoles]
@idRol int,
@Rol varchar(50)
as
begin
	update Roles
	set Rol = @Rol
	where idRol = @idRol
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSubTotalVenta]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calcular y actualizar detalle de venta
CREATE PROCEDURE [dbo].[SP_UpdateSubTotalVenta]
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateUnidades]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Actualizar Unidad-----
create procedure [dbo].[SP_UpdateUnidades]
@idUnidad int,
@Unidad varchar(50)
as
begin
	update Unidades
	set Unidad = @Unidad
	where idUnidad = @idUnidad
end
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUsuarios]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----Actualizar Usuario-----
create procedure [dbo].[SP_UpdateUsuarios]
@idUsuario int,
@Nombre varchar(100),
@Paterno varchar(50),
@Materno varchar(50),
@idRol int,
@Sexo varchar(1),
@Direccion varchar(100),
@Telefono varchar(10),
@CURP varchar(18),
@RFC varchar(13),
@Correo varchar(100),
@Contrasena varchar(50)
as
begin
	update Usuarios
	set
		Nombre = @Nombre,
		Paterno = @Paterno,
		Materno = @Materno,
		idRol = @idRol,
		Sexo = @Sexo,
		Direccion = @Direccion,
		Telefono = @Telefono,
		CURP = @CURP,
		RFC = @RFC,
		Correo = @Correo,
		Contrasena = @Contrasena

	where idUsuario = @idUsuario
end
GO
/****** Object:  StoredProcedure [dbo].[SP_VentaDias]    Script Date: 06/06/2024 04:14:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_VentaDias]
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
GO
USE [master]
GO
ALTER DATABASE [Ferreteria] SET  READ_WRITE 
GO
