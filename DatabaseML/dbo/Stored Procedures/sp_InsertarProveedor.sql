CREATE PROCEDURE sp_InsertarProveedor
(
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

    -- Validar si el producto existe
    IF NOT EXISTS (
        SELECT 1
        FROM Producto
        WHERE Id_Producto = @Id_Producto
    )
    BEGIN
        RAISERROR('El producto no existe.',16,1);
        RETURN;
    END

    -- Insertar proveedor
    INSERT INTO Proveedor
    (
        Nombre,
        Apellido,
        Email,
        Telefono,
        Razon_Social,
        Direccion,
        Id_Producto
    )
    VALUES
    (
        @Nombre,
        @Apellido,
        @Email,
        @Telefono,
        @Razon_Social,
        @Direccion,
        @Id_Producto
    );

    PRINT 'Proveedor registrado correctamente';
END;
