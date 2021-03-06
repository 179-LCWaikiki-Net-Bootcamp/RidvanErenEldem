USE [master]
GO
/****** Object:  Database [DbOnlineShop]    Script Date: 5.05.2022 22:07:32 ******/
CREATE DATABASE [DbOnlineShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DbOnlineShop', FILENAME = N'/var/opt/mssql/data/DbOnlineShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DbOnlineShop_log', FILENAME = N'/var/opt/mssql/data/DbOnlineShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DbOnlineShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DbOnlineShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DbOnlineShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DbOnlineShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DbOnlineShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DbOnlineShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DbOnlineShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [DbOnlineShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DbOnlineShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DbOnlineShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DbOnlineShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DbOnlineShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DbOnlineShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DbOnlineShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DbOnlineShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DbOnlineShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DbOnlineShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DbOnlineShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DbOnlineShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DbOnlineShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DbOnlineShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DbOnlineShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DbOnlineShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DbOnlineShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DbOnlineShop] SET RECOVERY FULL 
GO
ALTER DATABASE [DbOnlineShop] SET  MULTI_USER 
GO
ALTER DATABASE [DbOnlineShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DbOnlineShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DbOnlineShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DbOnlineShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DbOnlineShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DbOnlineShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DbOnlineShop] SET QUERY_STORE = OFF
GO
USE [DbOnlineShop]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Msisdn] [nchar](10) NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_MSISDN] UNIQUE NONCLUSTERED 
(
	[Msisdn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[PricePerUnit] [decimal](18, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[Description] [varchar](max) NULL,
	[Barcode] [char](12) NOT NULL,
	[CategoryId] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Date] [date] NULL,
	[OrderStatus] [varchar](30) NULL,
	[ZipCode] [int] NOT NULL,
	[Address] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Order_View]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Order_View]
AS
SELECT        dbo.Client.Id AS [Client Id], dbo.Client.Name AS [Client Name], dbo.Client.Surname AS [Client Surname], dbo.[Order].Id AS [Order Id], dbo.[Order].Date AS [Ordered Date], dbo.[Order].OrderStatus AS [Order Status], 
                         dbo.[Order].ZipCode AS [Zip Code], dbo.[Order].Address, dbo.Product.Id AS [Product Id], dbo.Product.Name AS [Product Name], dbo.Product.PricePerUnit AS Price
FROM            dbo.Client INNER JOIN
                         dbo.[Order] ON dbo.Client.Id = dbo.[Order].ClientId INNER JOIN
                         dbo.Product ON dbo.[Order].ProductId = dbo.Product.Id
GO
/****** Object:  Table [dbo].[Category]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Client] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Client]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  Trigger [dbo].[lowerStock]    Script Date: 5.05.2022 22:07:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[lowerStock] on [dbo].[Order]
AFTER INSERT AS
BEGIN
	UPDATE Product SET Product.Stock = Product.Stock - 1 FROM Product INNER JOIN [Order] on Product.Id = [Order].ProductId WHERE ProductId = Product.Id
END
GO
ALTER TABLE [dbo].[Order] ENABLE TRIGGER [lowerStock]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[25] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Client"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 220
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 215
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 2
               Left = 506
               Bottom = 213
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 1650
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Order_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Order_View'
GO
USE [master]
GO
ALTER DATABASE [DbOnlineShop] SET  READ_WRITE 
GO
