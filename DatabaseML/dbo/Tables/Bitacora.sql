CREATE TABLE [dbo].[Bitacora] (
    [Id_Log]  INT            IDENTITY (1, 1) NOT NULL,
    [Usuario] NVARCHAR (50)  NULL,
    [Accion]  NVARCHAR (50)  NULL,
    [Tabla]   NVARCHAR (50)  NULL,
    [Fecha]   DATETIME       DEFAULT (getdate()) NULL,
    [Detalle] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id_Log] ASC)
);

