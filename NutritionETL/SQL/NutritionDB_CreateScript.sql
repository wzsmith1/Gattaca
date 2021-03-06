USE [master]
GO
/****** Object:  Database [NutritionDB]    Script Date: 1/9/2015 9:08:20 AM ******/
CREATE DATABASE [NutritionDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NutritionDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\NutritionDB.mdf' , SIZE = 31744KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NutritionDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\NutritionDB_log.ldf' , SIZE = 427392KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NutritionDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NutritionDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NutritionDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NutritionDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NutritionDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NutritionDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NutritionDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [NutritionDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NutritionDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [NutritionDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NutritionDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NutritionDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NutritionDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NutritionDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NutritionDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NutritionDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NutritionDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NutritionDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NutritionDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NutritionDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NutritionDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NutritionDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NutritionDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NutritionDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NutritionDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NutritionDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NutritionDB] SET  MULTI_USER 
GO
ALTER DATABASE [NutritionDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NutritionDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NutritionDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NutritionDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [NutritionDB]
GO
/****** Object:  Table [dbo].[DataSource]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DataSource](
	[DataSourceID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](255) NULL,
	[Authors] [varchar](255) NULL,
	[Journal] [varchar](135) NULL,
	[Year] [int] NULL,
 CONSTRAINT [PK_DataSource] PRIMARY KEY CLUSTERED 
(
	[DataSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Food]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Food](
	[FoodID] [int] IDENTITY(1,1) NOT NULL,
	[FoodGroupID] [int] NOT NULL,
	[Name] [varchar](200) NULL,
	[ShortName] [varchar](60) NULL,
	[Manufacturer] [varchar](65) NULL,
	[HasCompleteProfile] [bit] NULL,
	[RefusePercent] [numeric](3, 2) NULL,
	[RefuseDescription] [varchar](135) NULL,
 CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
(
	[FoodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FoodFootnoteCross]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FoodFootnoteCross](
	[FoodFootnoteCrossID] [int] IDENTITY(1,1) NOT NULL,
	[FoodID] [int] NULL,
	[FootnoteID] [int] NULL,
	[Type] [varchar](50) NULL,
 CONSTRAINT [PK_FoodFootnoteCross] PRIMARY KEY CLUSTERED 
(
	[FoodFootnoteCrossID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FoodGroup]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FoodGroup](
	[FoodGroupID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NULL,
 CONSTRAINT [PK_FoodGroup] PRIMARY KEY CLUSTERED 
(
	[FoodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FoodNutrientCross]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodNutrientCross](
	[FoodNutrientCrossID] [int] IDENTITY(1,1) NOT NULL,
	[FoodID] [int] NULL,
	[NutrientID] [int] NULL,
	[ValuePerHundredGrams] [numeric](10, 3) NULL,
	[IsFortified] [bit] NULL,
 CONSTRAINT [PK_FoodNutrientCross] PRIMARY KEY CLUSTERED 
(
	[FoodNutrientCrossID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodNutrientDataSourceCross]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodNutrientDataSourceCross](
	[FoodNutrientDataSourceCrossID] [int] IDENTITY(1,1) NOT NULL,
	[FoodNutrientCrossID] [int] NULL,
	[DataSourceID] [int] NULL,
 CONSTRAINT [PK_FoodNutrientDataSourceCross] PRIMARY KEY CLUSTERED 
(
	[FoodNutrientDataSourceCrossID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodNutrientFootnoteCross]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodNutrientFootnoteCross](
	[FoodNutrientFootnoteCrossID] [int] IDENTITY(1,1) NOT NULL,
	[FoodNutrientCrossID] [int] NULL,
	[FootnoteID] [int] NULL,
 CONSTRAINT [PK_FoodNutrientFootnoteCross] PRIMARY KEY CLUSTERED 
(
	[FoodNutrientFootnoteCrossID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodWeight]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FoodWeight](
	[FoodWeightID] [int] IDENTITY(1,1) NOT NULL,
	[FoodID] [int] NULL,
	[Sequence] [int] NULL,
	[Value] [numeric](5, 3) NULL,
	[UnitOfMeasure] [varchar](84) NULL,
	[WeightInGrams] [numeric](7, 1) NULL,
 CONSTRAINT [PK_FoodWeight] PRIMARY KEY CLUSTERED 
(
	[FoodWeightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Footnote]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Footnote](
	[FootnoteID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](200) NULL,
 CONSTRAINT [PK_Footnote] PRIMARY KEY CLUSTERED 
(
	[FootnoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Nutrient]    Script Date: 1/9/2015 9:08:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Nutrient](
	[NutrientID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NULL,
	[UnitOfMeasure] [varchar](7) NULL,
	[NumberOfDecimals] [int] NULL,
 CONSTRAINT [PK_Nutrient] PRIMARY KEY CLUSTERED 
(
	[NutrientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Food]  WITH NOCHECK ADD  CONSTRAINT [FK_Food_FoodGroup] FOREIGN KEY([FoodGroupID])
REFERENCES [dbo].[FoodGroup] ([FoodGroupID])
GO
ALTER TABLE [dbo].[Food] CHECK CONSTRAINT [FK_Food_FoodGroup]
GO
ALTER TABLE [dbo].[FoodFootnoteCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodFootnoteCross_Food] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([FoodID])
GO
ALTER TABLE [dbo].[FoodFootnoteCross] CHECK CONSTRAINT [FK_FoodFootnoteCross_Food]
GO
ALTER TABLE [dbo].[FoodFootnoteCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodFootnoteCross_Footnote] FOREIGN KEY([FootnoteID])
REFERENCES [dbo].[Footnote] ([FootnoteID])
GO
ALTER TABLE [dbo].[FoodFootnoteCross] CHECK CONSTRAINT [FK_FoodFootnoteCross_Footnote]
GO
ALTER TABLE [dbo].[FoodNutrientCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientCross_Food] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([FoodID])
GO
ALTER TABLE [dbo].[FoodNutrientCross] CHECK CONSTRAINT [FK_FoodNutrientCross_Food]
GO
ALTER TABLE [dbo].[FoodNutrientCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientCross_Nutrient] FOREIGN KEY([NutrientID])
REFERENCES [dbo].[Nutrient] ([NutrientID])
GO
ALTER TABLE [dbo].[FoodNutrientCross] CHECK CONSTRAINT [FK_FoodNutrientCross_Nutrient]
GO
ALTER TABLE [dbo].[FoodNutrientDataSourceCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientDataSourceCross_DataSource] FOREIGN KEY([DataSourceID])
REFERENCES [dbo].[DataSource] ([DataSourceID])
GO
ALTER TABLE [dbo].[FoodNutrientDataSourceCross] CHECK CONSTRAINT [FK_FoodNutrientDataSourceCross_DataSource]
GO
ALTER TABLE [dbo].[FoodNutrientDataSourceCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientDataSourceCross_FoodNutrientCross] FOREIGN KEY([FoodNutrientCrossID])
REFERENCES [dbo].[FoodNutrientCross] ([FoodNutrientCrossID])
GO
ALTER TABLE [dbo].[FoodNutrientDataSourceCross] CHECK CONSTRAINT [FK_FoodNutrientDataSourceCross_FoodNutrientCross]
GO
ALTER TABLE [dbo].[FoodNutrientFootnoteCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientFootnoteCross_FoodNutrientCross] FOREIGN KEY([FoodNutrientCrossID])
REFERENCES [dbo].[FoodNutrientCross] ([FoodNutrientCrossID])
GO
ALTER TABLE [dbo].[FoodNutrientFootnoteCross] CHECK CONSTRAINT [FK_FoodNutrientFootnoteCross_FoodNutrientCross]
GO
ALTER TABLE [dbo].[FoodNutrientFootnoteCross]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodNutrientFootnoteCross_Footnote] FOREIGN KEY([FootnoteID])
REFERENCES [dbo].[Footnote] ([FootnoteID])
GO
ALTER TABLE [dbo].[FoodNutrientFootnoteCross] CHECK CONSTRAINT [FK_FoodNutrientFootnoteCross_Footnote]
GO
ALTER TABLE [dbo].[FoodWeight]  WITH NOCHECK ADD  CONSTRAINT [FK_FoodWeight_Food] FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([FoodID])
GO
ALTER TABLE [dbo].[FoodWeight] CHECK CONSTRAINT [FK_FoodWeight_Food]
GO
USE [master]
GO
ALTER DATABASE [NutritionDB] SET  READ_WRITE 
GO
