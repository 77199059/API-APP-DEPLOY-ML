Create PROCEDURE [dbo].[sp_InsertarInventario]
    @Id_Producto INT,
    @Descripcion NVARCHAR(200),
    @Stock INT = NULL,          -- opcional
    @Precio DECIMAL(10,2) = NULL  -- opcional
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el producto existe
    IF EXISTS (SELECT 1 FROM Producto WHERE Id_Producto = @Id_Producto)
    BEGIN
        DECLARE @NombreProducto NVARCHAR(200);

        -- Obtener el nombre del producto desde la tabla Producto
        SELECT @NombreProducto = Nombre_Producto
        FROM Producto
        WHERE Id_Producto = @Id_Producto;

        -- Insertar en Inventario
        INSERT INTO Inventario (Id_Producto, Descripcion, Stock, Precio, Nombre_Producto)
        VALUES (
            @Id_Producto,
            @Descripcion,
            ISNULL(@Stock, (SELECT Stock FROM Producto WHERE Id_Producto = @Id_Producto)),
            ISNULL(@Precio, (SELECT Precio FROM Producto WHERE Id_Producto = @Id_Producto)),
            @NombreProducto
        );

        -- Actualizar Producto si envían stock o precio
        IF @Stock IS NOT NULL OR @Precio IS NOT NULL
        BEGIN
            UPDATE Producto
            SET 
                Stock = ISNULL(@Stock, Stock),
                Precio = ISNULL(@Precio, Precio)
            WHERE Id_Producto = @Id_Producto;
        END
    END
    ELSE
    BEGIN
        RAISERROR('El producto especificado no existe.', 16, 1);
    END
END;