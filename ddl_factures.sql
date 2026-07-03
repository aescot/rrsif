USE [NetissimDB3]
GO

/****** Objeto: Table [dbo].[Factures] Fecha de script: 03/07/2026 21:39:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Factures](
	[FacturaId] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [int] NOT NULL,
	[Periode] [nchar](6) NOT NULL,
	[EmpresaId] [int] NOT NULL,
	[Serie] [smallint] NOT NULL,
	[Abreujat] [nvarchar](4) NOT NULL,
	[FacturatA] [smallint] NOT NULL,
	[DirigidaA] [smallint] NOT NULL,
	[PagadaPer] [smallint] NOT NULL,
	[Automatica] [bit] NOT NULL,
	[FormatFra] [smallint] NOT NULL,
	[TipusIVA] [smallint] NOT NULL,
	[IVA] [decimal](7, 3) NOT NULL,
	[RE] [decimal](7, 3) NOT NULL,
	[Subtotal] [decimal](13, 2) NOT NULL,
	[Descompte] [decimal](13, 2) NOT NULL,
	[TipusDte] [tinyint] NOT NULL,
	[RappelPct] [decimal](7, 3) NULL,
	[RappelIVA] [decimal](7, 3) NULL,
	[RappelIRPF] [decimal](7, 3) NULL,
	[RappelLiquid] [smallint] NULL,
	[Data] [date] NOT NULL,
	[Nom] [nvarchar](100) NOT NULL,
	[Cognoms] [nvarchar](120) NULL,
	[Document] [nvarchar](12) NOT NULL,
	[Carrer] [nvarchar](200) NOT NULL,
	[CodiPostal] [nvarchar](5) NOT NULL,
	[Poblacio] [nvarchar](100) NOT NULL,
	[ProvinciaId] [smallint] NOT NULL,
	[IBAN] [nvarchar](24) NULL,
	[Oficina] [nvarchar](120) NULL,
	[Nota] [nvarchar](120) NULL,
	[Venciment] [nvarchar](100) NULL,
	[Descripcio] [nvarchar](800) NOT NULL,
	[DirigidaDocument] [nvarchar](12) NULL,
	[DirigidaNom] [nvarchar](100) NULL,
	[DirigidaCognoms] [nvarchar](120) NULL,
	[DirigidaCarrer] [nvarchar](200) NULL,
	[DirigidaCodiPostal] [nvarchar](5) NULL,
	[DirigidaPoblacio] [nvarchar](100) NULL,
	[DirigidaProvinciaId] [smallint] NOT NULL,
	[ClientId] [int] NOT NULL,
	[PropietariId] [int] NULL,
	[AdministradorId] [int] NULL,
	[PagadorId] [int] NULL,
	[Estat] [smallint] NOT NULL,
	[User] [nvarchar](30) NULL,
	[FormaPagament] [smallint] NOT NULL,
	[DocPagament] [smallint] NOT NULL,
	[DataVenciment] [date] NOT NULL,
	[Idioma] [nvarchar](2) NOT NULL,
	[Liquidacio] [smallint] NOT NULL,
	[Enviament] [smallint] NOT NULL,
	[DataEnviament] [datetime] NULL,
	[Modified] [datetime] NOT NULL,
	[DebitId] [int] NULL,
	[Exercici]  AS (CONVERT([smallint],substring([Periode],(1),(4)))) PERSISTED,
	[CTotal]  AS (isnull(CONVERT([decimal](13,2),CONVERT([decimal](15,4),[Subtotal]-isnull([Descompte],(0)))*(((1)+CONVERT([decimal](15,4),[IVA]/(100)))+CONVERT([decimal](15,4),[RE]/(100)))),(0))),
	[CRappel]  AS (isnull(CONVERT([decimal](13,2),(CONVERT([decimal](15,4),[Subtotal]-[Descompte])*CONVERT([decimal](15,4),[RappelPct]/(100)))*CONVERT([decimal](15,4),(1)+([RappelIVA]-[RappelIRPF])/(100))),(0))),
	[UnpaidDebitId] [int] NULL,
	[Created] [datetime] NOT NULL,
	[RectificaFacturaId] [int] NULL,
	[Tipo] [tinyint] NOT NULL,
	[ClaveSii] [varchar](2) NULL,
	[MotivoSii] [varchar](2) NULL,
	[FullIdentity]  AS (concat([Abreujat],replicate('0',(6)-len(rtrim([Numero])))+rtrim([Numero]),'/',substring([Periode],(3),(2)),case when [Serie]=(0) then 'N' when [Serie]=(1) then 'M' when [Serie]=(10) then 'R' else '?' end)) PERSISTED NOT NULL,
	[Fullname]  AS ([dbo].[ufnFormatContactName]([Nom],[Cognoms],[Carrer])),
 CONSTRAINT [PK_Factures] PRIMARY KEY CLUSTERED 
(
	[FacturaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Unique_Number] UNIQUE NONCLUSTERED 
(
	[EmpresaId] ASC,
	[Exercici] ASC,
	[Serie] ASC,
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Factures] ADD  CONSTRAINT [DF_Factures_TipusDte]  DEFAULT ((0)) FOR [TipusDte]
GO

ALTER TABLE [dbo].[Factures] ADD  CONSTRAINT [DF_Factures_Created]  DEFAULT (getutcdate()) FOR [Created]
GO

ALTER TABLE [dbo].[Factures] ADD  CONSTRAINT [DF_Factures_Tipo]  DEFAULT ((0)) FOR [Tipo]
GO

ALTER TABLE [dbo].[Factures]  WITH CHECK ADD  CONSTRAINT [FK_Empresa_Factura] FOREIGN KEY([EmpresaId])
REFERENCES [dbo].[Empreses] ([EmpresaId])
GO

ALTER TABLE [dbo].[Factures] CHECK CONSTRAINT [FK_Empresa_Factura]
GO

ALTER TABLE [dbo].[Factures]  WITH CHECK ADD  CONSTRAINT [FK_Factura_RectificaFactura] FOREIGN KEY([RectificaFacturaId])
REFERENCES [dbo].[Factures] ([FacturaId])
GO

ALTER TABLE [dbo].[Factures] CHECK CONSTRAINT [FK_Factura_RectificaFactura]
GO

ALTER TABLE [dbo].[Factures]  WITH NOCHECK ADD  CONSTRAINT [CK_Factura_Periode_Format] CHECK  ((len([Periode])=(6) AND NOT [Periode] like '%[^0-9]%' AND (substring([Periode],(5),(2))>='01' AND substring([Periode],(5),(2))<='12') AND (left([Periode],(4))>='2000' AND left([Periode],(4))<='2999')))
GO

ALTER TABLE [dbo].[Factures] CHECK CONSTRAINT [CK_Factura_Periode_Format]
GO


