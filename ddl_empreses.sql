USE [NetissimDB3]
GO

/****** Objeto: Table [dbo].[Empreses] Fecha de script: 03/07/2026 21:37:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Empreses](
	[EmpresaId] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](120) NOT NULL,
	[Document] [nvarchar](12) NOT NULL,
	[DocumentTipus] [smallint] NOT NULL,
	[Abreujat] [nvarchar](4) NOT NULL,
	[Carrer] [nvarchar](200) NOT NULL,
	[CodiPostal] [nvarchar](5) NOT NULL,
	[Poblacio] [nvarchar](100) NOT NULL,
	[ProvinciaId] [smallint] NOT NULL,
	[Fix] [nvarchar](15) NOT NULL,
	[Telef] [nvarchar](15) NULL,
	[Email] [nvarchar](120) NOT NULL,
	[PaginaWeb] [nvarchar](512) NULL,
	[Color] [int] NOT NULL,
	[Logotip] [varbinary](max) NULL,
	[Signatura] [varbinary](max) NULL,
	[Notes] [nvarchar](400) NULL,
	[Model] [nvarchar](4) NULL,
	[PreuHoraLL] [decimal](9, 4) NOT NULL,
	[PreuHoraLS] [decimal](9, 4) NOT NULL,
	[PreuHoraLF] [decimal](9, 4) NOT NULL,
	[PreuHoraSL] [decimal](9, 4) NOT NULL,
	[PreuHoraSS] [decimal](9, 4) NOT NULL,
	[PreuHoraSF] [decimal](9, 4) NOT NULL,
	[PreuHoraAB] [decimal](9, 4) NOT NULL,
	[PreuHoraPP] [decimal](9, 4) NOT NULL,
	[PreuHoraNeteja] [decimal](9, 4) NOT NULL,
	[PreuHoraExtraNeteja] [decimal](9, 4) NOT NULL,
	[PreuHoraCristaler] [decimal](9, 4) NOT NULL,
	[PreuHoraExtraCristaler] [decimal](9, 4) NOT NULL,
	[PreuHoraAbrillantador] [decimal](9, 4) NOT NULL,
	[PreuHoraExtraAbrillantador] [decimal](9, 4) NOT NULL,
	[FacturacioPeriodicitat] [smallint] NOT NULL,
	[FacturacioSetmana] [smallint] NOT NULL,
	[IBAN] [nvarchar](24) NULL,
	[Increment] [decimal](7, 3) NOT NULL,
	[ActualitzacioPeriodicitat] [smallint] NOT NULL,
	[ActualitzacioCarencia] [smallint] NOT NULL,
	[ActualizarEn] [nvarchar](26) NOT NULL,
	[TipusIVA] [smallint] NOT NULL,
	[OfertaValidesa] [smallint] NOT NULL,
	[OfertaId] [int] NULL,
	[DataAlta] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[User] [nvarchar](30) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
 CONSTRAINT [PK_Empreses] PRIMARY KEY CLUSTERED 
(
	[EmpresaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UIX_Abreujat] UNIQUE NONCLUSTERED 
(
	[Abreujat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Empreses]  WITH CHECK ADD  CONSTRAINT [FK_OfertaEmpresa] FOREIGN KEY([OfertaId])
REFERENCES [dbo].[Ofertes] ([OfertaId])
GO

ALTER TABLE [dbo].[Empreses] CHECK CONSTRAINT [FK_OfertaEmpresa]
GO


