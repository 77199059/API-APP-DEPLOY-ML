CREATE TABLE [dbo].[Compras] (
    [Id_Compra]     INT             IDENTITY (1, 1) NOT NULL,
    [Fecha_Compra]  DATE            NULL,
    [Id_Proveedor]  INT             NULL,
    [MetodoPago]    NVARCHAR (50)   NULL,
    [Total]         DECIMAL (10, 2) NULL,
    [Observaciones] NVARCHAR (300)  NULL,
    PRIMARY KEY CLUSTERED ([Id_Compra] ASC),
    FOREIGN KEY ([Id_Proveedor]) REFERENCES [dbo].[Proveedor] ([Id_Proveedor])
);


GO

CREATE TRIGGER [dbo].[trg_BloquearDeleteCompras]
ON [dbo].[Compras]
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END
