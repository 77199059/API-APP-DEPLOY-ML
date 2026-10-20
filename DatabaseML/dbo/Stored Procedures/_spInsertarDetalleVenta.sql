CREATE PROCEDURE [dbo].[_spInsertarDetalleVenta]
    @Id_Venta INT,
    @Id_Producto INT,
    @Cantidad INT,
    @Precio_Unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StockActual INT;

        -- Obtener stock actual del producto
        SELECT @StockActual = Stock 
        FROM Producto 
        WHERE Id_Producto = @Id_Producto;

        -- Validar existencia del producto
        IF @StockActual IS NULL
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('El producto no existe.', 16, 1);
            RETURN;
        END

        -- Validar stock suficiente
        IF @StockActual < @Cantidad
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('Stock insuficiente.', 16, 1);
            RETURN;
        END

        -- Insertar detalle de venta
        -- Insertar detalle de venta con nombre tomado de la tabla Productos
INSERT INTO Detalle_Venta (Id_Venta, Id_Producto, Nombre_Producto, Cantidad, Precio_Unitario)
SELECT 
    @Id_Venta, 
    @Id_Producto, 
    Nombre_Producto,  -- se toma automáticamente de Productos
    @Cantidad, 
    @Precio_Unitario
FROM Producto
WHERE Id_Producto = @Id_Producto;

        -- Actualizar stock
        UPDATE Producto
        SET Stock = Stock - @Cantidad
        WHERE Id_Producto = @Id_Producto;

        -- Actualizar stock en Inventario
        UPDATE Inventario
        SET Stock = Stock - @Cantidad
        WHERE Id_Producto = @Id_Producto;


        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;