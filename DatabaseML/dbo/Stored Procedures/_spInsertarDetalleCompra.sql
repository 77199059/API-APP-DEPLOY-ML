CREATE PROCEDURE [dbo].[_spInsertarDetalleCompra]
    @Id_Compra INT,
    @Id_Producto INT,
    @Cantidad INT,
    @Precio_Unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        -- Validar existencia del producto
        IF NOT EXISTS (
            SELECT 1
            FROM Producto
            WHERE Id_Producto = @Id_Producto
        )
        BEGIN
            RAISERROR('El producto no existe.', 16, 1);
            RETURN;
        END

        -- Insertar detalle de compra
        INSERT INTO Detalle_Compras
        (
            Id_Compra,
            Id_Producto,
            Cantidad,
            Precio_Unitario,
            Subtotal
        )
        VALUES
        (
            @Id_Compra,
            @Id_Producto,
            @Cantidad,
            @Precio_Unitario,
            (@Cantidad * @Precio_Unitario)
        );

        -- Actualizar stock en Producto
        UPDATE Producto
        SET Stock = Stock + @Cantidad
        WHERE Id_Producto = @Id_Producto;

        -- Actualizar stock en Inventario
        UPDATE Inventario
        SET Stock = Stock + @Cantidad
        WHERE Id_Producto = @Id_Producto;

    END TRY

    BEGIN CATCH

        DECLARE @ErrMsg NVARCHAR(4000),
                @ErrSeverity INT;

        SELECT
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY();

        RAISERROR(@ErrMsg, @ErrSeverity, 1);

    END CATCH
END;