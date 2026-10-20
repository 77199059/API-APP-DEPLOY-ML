CREATE TABLE [dbo].[Ventas] (
    [Id_Venta]    INT             IDENTITY (1, 1) NOT NULL,
    [Fecha_Venta] DATE            NULL,
    [Total]       DECIMAL (10, 2) NULL,
    [Id_Usuario]  INT             NULL,
    PRIMARY KEY CLUSTERED ([Id_Venta] ASC),
    CONSTRAINT [FK_Ventas_Usuario] FOREIGN KEY ([Id_Usuario]) REFERENCES [dbo].[Usuario] ([Id_Usuario]) ON UPDATE CASCADE
);


GO
CREATE TRIGGER trg_BloquearDeleteVentas
ON Ventas
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END
