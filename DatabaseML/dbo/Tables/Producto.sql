CREATE TABLE [dbo].[Producto] (
    [Id_Producto]     INT             IDENTITY (1, 1) NOT NULL,
    [Nombre_Producto] NVARCHAR (50)   NOT NULL,
    [Descripcion]     NVARCHAR (300)  NOT NULL,
    [Id_Categoria]    INT             NULL,
    [Precio]          DECIMAL (10, 2) NULL,
    [Stock]           INT             NULL,
    [Id_Proveedor]    INT             NULL,
    PRIMARY KEY CLUSTERED ([Id_Producto] ASC),
    FOREIGN KEY ([Id_Categoria]) REFERENCES [dbo].[Categorias] ([Id_Categoria])
);


GO
CREATE TRIGGER trg_Insert_Productos
ON Producto
AFTER INSERT
AS
BEGIN
    DECLARE @Usuario NVARCHAR(50) = SYSTEM_USER;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        @Usuario,
        'INSERT',
        'Productos',
        CONCAT('Se insertó producto ID=', i.Id_Producto, ', Nombre=', i.Nombre_Producto)
    FROM INSERTED i;
END;

GO
-- 2.2 UPDATE en Productos
CREATE TRIGGER trg_Update_Producto
ON Producto
AFTER UPDATE
AS
BEGIN
    DECLARE @Usuario NVARCHAR(50) = SYSTEM_USER;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        @Usuario,
        'UPDATE',
        'Producto',
        CONCAT('Se modificó producto ID=', i.Id_Producto, '. Cambios: Nombre=', i.Nombre_Producto)
    FROM INSERTED i;
END;

GO
CREATE TRIGGER trg_Delete_Producto
ON Producto
AFTER DELETE
AS
BEGIN
    DECLARE @Usuario NVARCHAR(50) = SYSTEM_USER;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        @Usuario,
        'DELETE',
        'Producto',
        CONCAT('Se eliminó producto ID=', d.Id_Producto, ', Nombre=', d.Nombre_Producto)
    FROM DELETED d;
END;

GO
CREATE TRIGGER trg_BloquearDelete
ON Producto
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END
