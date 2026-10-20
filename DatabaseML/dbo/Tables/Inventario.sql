CREATE TABLE [dbo].[Inventario] (
    [Id_Inventario]     INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]       VARCHAR (50)    NULL,
    [Precio]            DECIMAL (10, 2) NULL,
    [Stock]             INT             NULL,
    [Id_Producto]       INT             NULL,
    [Id_Detalle_Compra] INT             NULL,
    [Nombre_Producto]   NVARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([Id_Inventario] ASC),
    FOREIGN KEY ([Id_Detalle_Compra]) REFERENCES [dbo].[Detalle_Compras] ([Id_Detalle_Compra]),
    FOREIGN KEY ([Id_Producto]) REFERENCES [dbo].[Producto] ([Id_Producto])
);


GO
CREATE TRIGGER trg_BloquearDeleteInventario
ON Inventario
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END