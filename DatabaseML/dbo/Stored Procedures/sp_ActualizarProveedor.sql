CREATE PROCEDURE sp_ActualizarProveedor
(
    @Id_Proveedor INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(50),
    @Telefono NVARCHAR(50),
    @Razon_Social NVARCHAR(50),
    @Direccion NVARCHAR(50),
    @Id_Producto INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar si existe el proveedor
    IF NOT EXISTS (
        SELECT 1
        FROM Proveedor
        WHERE Id_Proveedor = @Id_Proveedor
    )
    BEGIN
        RAISERROR('El proveedor no existe.',16,1);
        RETURN;
    END

    -- Validar si existe el producto
    IF NOT EXISTS (
        SELECT 1
        FROM Producto
        WHERE Id_Producto = @Id_Producto
    )
    BEGIN
        RAISERROR('El producto no existe.',16,1);
        RETURN;
    END

    UPDATE Proveedor
    SET
        Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email,
        Telefono = @Telefono,
        Razon_Social = @Razon_Social,
        Direccion = @Direccion,
        Id_Producto = @Id_Producto
    WHERE Id_Proveedor = @Id_Proveedor;

    PRINT 'Proveedor actualizado correctamente';
END;
