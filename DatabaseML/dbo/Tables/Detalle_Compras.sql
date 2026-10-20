CREATE TABLE [dbo].[Detalle_Compras] (
    [Id_Detalle_Compra] INT             IDENTITY (1, 1) NOT NULL,
    [Id_Compra]         INT             NULL,
    [Id_Producto]       INT             NULL,
    [Cantidad]          INT             NULL,
    [Precio_Unitario]   DECIMAL (10, 2) NULL,
    [Subtotal]          DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id_Detalle_Compra] ASC),
    FOREIGN KEY ([Id_Compra]) REFERENCES [dbo].[Compras] ([Id_Compra]),
    FOREIGN KEY ([Id_Producto]) REFERENCES [dbo].[Producto] ([Id_Producto])
);


GO

CREATE TRIGGER [dbo].[trg_BloquearDeleteDetalleCompra]
ON [dbo].[Detalle_Compras]
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END
