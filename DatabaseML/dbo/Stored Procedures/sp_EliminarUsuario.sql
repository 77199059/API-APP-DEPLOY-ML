CREATE PROCEDURE [dbo].[sp_EliminarUsuario]
    @Id_Usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Id_Rol INT;

    -- Obtener el Id_Rol del usuario antes de eliminarlo
    SELECT @Id_Rol = Id_Rol
    FROM Usuario
    WHERE Id_Usuario = @Id_Usuario;

    -- Eliminar el usuario
    DELETE FROM Usuario
    WHERE Id_Usuario = @Id_Usuario;

    -- Eliminar también el rol asociado (si existe)
    DELETE FROM Roles
    WHERE Id_Rol = @Id_Rol;
END
