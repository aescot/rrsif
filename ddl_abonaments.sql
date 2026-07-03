USE [NetissimDB3]
GO

/****** Objeto: Table [dbo].[Abonaments] Fecha de script: 03/07/2026 21:39:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Abonaments](
	[Numero] [int] NOT NULL,
	[EmpresaId] [int] NOT NULL,
	[Serie] [smallint] NULL,
	[Abreujat] [nvarchar](4) NULL,
	[Data] [date] NOT NULL,
	[Detall] [nvarchar](250) NOT NULL,
	[Import] [decimal](13, 2) NOT NULL,
	[IVA] [decimal](7, 3) NOT NULL,
	[RappelPct] [decimal](7, 3) NULL,
	[RappelIVA] [decimal](7, 3) NULL,
	[RappelIRPF] [decimal](7, 3) NULL,
	[FacturaId] [int] NOT NULL,
	[Tipus] [smallint] NOT NULL,
	[Estat] [smallint] NOT NULL,
	[ClientId] [int] NULL,
	[PropietariId] [int] NULL,
	[AdministradorId] [int] NULL,
	[AbonatData] [datetime] NULL,
	[AbonatNota] [nvarchar](100) NULL,
	[Enviament] [smallint] NOT NULL,
	[DataEnviament] [datetime] NULL,
	[Modified] [datetime] NOT NULL,
	[User] [nvarchar](30) NULL,
	[DebitId] [int] NULL,
	[FullIdentity]  AS (concat([Abreujat],replicate('0',(6)-len(rtrim([Numero])))+rtrim([Numero]),'/A')),
	[CTotal]  AS (isnull(CONVERT([decimal](13,2),CONVERT([decimal](13,2),[Import])*((1)+CONVERT([decimal](13,2),[IVA]/(100)))),(0))),
	[CRappel]  AS (isnull(CONVERT([decimal](13,2),(CONVERT([decimal](15,4),[Import])*CONVERT([decimal](15,4),[RappelPct]/(100)))*CONVERT([decimal](15,4),(1)+([RappelIVA]-[RappelIRPF])/(100))),(0))),
	[UnpaidDebitId] [int] NULL,
 CONSTRAINT [PK_Abonaments] PRIMARY KEY CLUSTERED 
(
	[Numero] ASC,
	[EmpresaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Abonaments]  WITH CHECK ADD  CONSTRAINT [FK_DebitAbonament] FOREIGN KEY([DebitId])
REFERENCES [dbo].[Debits] ([Id])
GO

ALTER TABLE [dbo].[Abonaments] CHECK CONSTRAINT [FK_DebitAbonament]
GO

ALTER TABLE [dbo].[Abonaments]  WITH CHECK ADD  CONSTRAINT [FK_FacturaAbonament] FOREIGN KEY([FacturaId])
REFERENCES [dbo].[Factures] ([FacturaId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Abonaments] CHECK CONSTRAINT [FK_FacturaAbonament]
GO


