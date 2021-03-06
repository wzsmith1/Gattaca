USE [master]
GO
/****** Object:  Database [Staging_Nutrition]    Script Date: 1/9/2015 9:09:07 AM ******/
CREATE DATABASE [Staging_Nutrition]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Staging_Nutrition', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Nutrition.mdf' , SIZE = 88064KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Staging_Nutrition_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Nutrition_log.ldf' , SIZE = 5184KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Staging_Nutrition] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Staging_Nutrition].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Staging_Nutrition] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET ARITHABORT OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Staging_Nutrition] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Staging_Nutrition] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Staging_Nutrition] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Staging_Nutrition] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Staging_Nutrition] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Staging_Nutrition] SET  MULTI_USER 
GO
ALTER DATABASE [Staging_Nutrition] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Staging_Nutrition] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Staging_Nutrition] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Staging_Nutrition] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Staging_Nutrition]
GO
/****** Object:  Table [dbo].[DATA_SRC]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DATA_SRC](
	[DataSrc_ID] [varchar](6) NULL,
	[Authors] [varchar](255) NULL,
	[Title] [varchar](255) NULL,
	[Year] [varchar](4) NULL,
	[Journal] [varchar](135) NULL,
	[Vol_City] [varchar](16) NULL,
	[Issue_State] [varchar](5) NULL,
	[Start_Page] [varchar](5) NULL,
	[End_Page] [varchar](5) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DATSRCLN]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DATSRCLN](
	[NDB_No] [varchar](5) NULL,
	[Nutr_No] [varchar](3) NULL,
	[DataSrc_ID] [varchar](6) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DERIV_CD]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DERIV_CD](
	[Deriv_Cd] [varchar](4) NULL,
	[Deriv_Desc] [varchar](120) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FD_GROUP]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FD_GROUP](
	[FdGrp_Cd] [varchar](4) NULL,
	[FdGrp_Desc] [varchar](60) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FOOD_DES]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FOOD_DES](
	[NDB_No] [varchar](5) NULL,
	[FdGrp_Cd] [varchar](4) NULL,
	[Long_Desc] [varchar](200) NULL,
	[Shrt_Desc] [varchar](60) NULL,
	[ComName] [varchar](100) NULL,
	[ManufacName] [varchar](65) NULL,
	[Survey] [varchar](1) NULL,
	[Ref_desc] [varchar](135) NULL,
	[Refuse] [int] NULL,
	[SciName] [varchar](65) NULL,
	[N_Factor] [numeric](4, 2) NULL,
	[Pro_Factor] [numeric](4, 2) NULL,
	[Fat_Factor] [numeric](4, 2) NULL,
	[CHO_Factor] [numeric](4, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FOOTNOTE]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FOOTNOTE](
	[NDB_No] [varchar](5) NULL,
	[Footnt_No] [varchar](4) NULL,
	[Footnt_Typ] [varchar](1) NULL,
	[Nutr_No] [varchar](3) NULL,
	[Footnt_Txt] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LANGDESC]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LANGDESC](
	[Factor_Code] [varchar](5) NULL,
	[Description] [varchar](140) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LANGUAL]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LANGUAL](
	[NDB_No] [varchar](5) NULL,
	[Factor_Code] [varchar](5) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NUT_DATA]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NUT_DATA](
	[NDB_No] [varchar](5) NULL,
	[Nutr_No] [varchar](3) NULL,
	[Nutr_Val] [numeric](10, 3) NULL,
	[Num_Data_Pts] [int] NULL,
	[Std_Error] [numeric](8, 3) NULL,
	[Src_Cd] [varchar](2) NULL,
	[Deriv_Cd] [varchar](4) NULL,
	[Ref_NDB_No] [varchar](5) NULL,
	[Add_Nutr_Mark] [varchar](1) NULL,
	[Num_Studies] [int] NULL,
	[Min] [numeric](10, 3) NULL,
	[Max] [numeric](10, 3) NULL,
	[DF] [int] NULL,
	[Low_EB] [numeric](10, 3) NULL,
	[Up_EB] [numeric](10, 3) NULL,
	[Stat_cmt] [varchar](10) NULL,
	[AddMod_Date] [varchar](10) NULL,
	[CC] [varchar](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NUTR_DEF]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NUTR_DEF](
	[Nutr_No] [varchar](3) NULL,
	[Units] [varchar](7) NULL,
	[Tagname] [varchar](20) NULL,
	[NutrDesc] [varchar](60) NULL,
	[Num_Dec] [varchar](1) NULL,
	[SR_Order] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SRC_CD]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SRC_CD](
	[Src_Cd] [varchar](2) NULL,
	[SrcCd_Desc] [varchar](60) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WEIGHT]    Script Date: 1/9/2015 9:09:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WEIGHT](
	[NDB_No] [varchar](5) NULL,
	[Seq] [varchar](2) NULL,
	[Amount] [numeric](5, 3) NULL,
	[Msre_Desc] [varchar](84) NULL,
	[Gm_Wgt] [numeric](7, 1) NULL,
	[Num_Data_Pts] [int] NULL,
	[Std_Dev] [numeric](7, 3) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [Staging_Nutrition] SET  READ_WRITE 
GO
