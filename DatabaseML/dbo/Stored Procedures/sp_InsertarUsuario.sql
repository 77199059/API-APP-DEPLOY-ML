CREATE PROCEDURE [dbo].[sp_InsertarUsuario]
    @Nombre NVARCHAR(50),
    @Correo_Electronico NVARCHAR(50),
    @Contraseña NVARCHAR(100),
    @Id_Rol INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar el nuevo usuario en la tabla Usuario
    INSERT INTO Usuario (Nombre, Correo_Electronico, Contraseña, Id_Rol)
    VALUES (@Nombre, @Correo_Electronico, @Contraseña, @Id_Rol);

    -- Devolver el Id del usuario recién insertado
    SELECT SCOPE_IDENTITY() AS Id_Usuario;
END