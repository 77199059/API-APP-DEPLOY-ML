CREATE PROCEDURE sp_ActualizarUsuario
    @Id_Usuario INT,
    @Nombre NVARCHAR(100),
    @Correo_Electronico NVARCHAR(100),
    @Contraseña NVARCHAR(MAX) = NULL,
    @Id_Rol INT
AS
BEGIN
    UPDATE Usuario
    SET Nombre = @Nombre,
        Correo_Electronico = @Correo_Electronico,
        Contraseña = ISNULL(@Contraseña, Contraseña), -- no cambia si es null
        Id_Rol = @Id_Rol
    WHERE Id_Usuario = @Id_Usuario
END