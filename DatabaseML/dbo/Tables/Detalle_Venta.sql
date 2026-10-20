CREATE TABLE [dbo].[Detalle_Venta] (
    [Id_Detalle_Venta] INT             IDENTITY (1, 1) NOT NULL,
    [Cantidad]         INT             NULL,
    [Id_Producto]      INT             NULL,
    [Id_Venta]         INT             NULL,
    [Precio_Unitario]  DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id_Detalle_Venta] ASC),
    FOREIGN KEY ([Id_Producto]) REFERENCES [dbo].[Producto] ([Id_Producto]),
    FOREIGN KEY ([Id_Venta]) REFERENCES [dbo].[Ventas] ([Id_Venta])
);


GO
CREATE TRIGGER trg_BloquearDeleteDetalleVenta
ON Detalle_Venta
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END