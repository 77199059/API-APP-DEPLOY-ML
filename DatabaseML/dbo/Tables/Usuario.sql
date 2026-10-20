CREATE TABLE [dbo].[Usuario] (
    [Id_Usuario]         INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]             NVARCHAR (50)  NULL,
    [Correo_Electronico] NVARCHAR (50)  NULL,
    [Contraseña]         NVARCHAR (200) NULL,
    [Id_Rol]             INT            NULL,
    PRIMARY KEY CLUSTERED ([Id_Usuario] ASC),
    FOREIGN KEY ([Id_Rol]) REFERENCES [dbo].[Roles] ([Id_Rol])
);


GO
CREATE TRIGGER trg_BloquearDeleteUsuario
ON Usuario
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Eliminar registros está deshabilitado', 16, 1);
END
GO
-- Trigger de logins

--  Trigger para INSERT
CREATE TRIGGER dbo.trg_Usuario_Insert
ON dbo.Usuario
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        i.Nombre,
        'INSERT',
        'Usuario',
        CONCAT('Se creó un nuevo usuario con correo: ', i.Correo_Electronico)
    FROM INSERTED i;
END;

GO
-- Trigger para UPDATE
CREATE TRIGGER trg_Usuario_Update
ON Usuario
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        i.Nombre,
        'UPDATE',
        'Usuario',
        CONCAT('Se actualizó información del usuario con ID: ', i.Id_Usuario)
    FROM INSERTED i;
END;

GO
--  Trigger para DELETE
CREATE TRIGGER trg_Usuario_Delete
ON Usuario
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Bitacora (Usuario, Accion, Tabla, Detalle)
    SELECT 
        d.Nombre,
        'DELETE',
        'Usuario',
        CONCAT('Se eliminó el usuario con correo: ', d.Correo_Electronico)
    FROM DELETED d;
END;
