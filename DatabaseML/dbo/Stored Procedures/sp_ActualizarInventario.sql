CREATE PROCEDURE [dbo].[sp_ActualizarInventario]
    @Id_Inventario INT,
    @Id_Producto INT,
    @Descripcion NVARCHAR(200),
    @Stock INT = NULL,           -- opcional
    @Precio DECIMAL(10,2) = NULL  -- opcional
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el producto existe
    IF EXISTS (SELECT 1 FROM Producto WHERE Id_Producto = @Id_Producto)
    BEGIN
        -- Actualizar Inventario
        UPDATE i
        SET 
            i.Id_Producto = @Id_Producto,
            i.Descripcion = @Descripcion,
            i.Stock = ISNULL(@Stock, p.Stock),
            i.Precio = ISNULL(@Precio, p.Precio),
            i.Nombre_Producto = p.Nombre_Producto
        FROM Inventario i
        INNER JOIN Producto p ON p.Id_Producto = @Id_Producto
        WHERE i.Id_Inventario = @Id_Inventario;

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