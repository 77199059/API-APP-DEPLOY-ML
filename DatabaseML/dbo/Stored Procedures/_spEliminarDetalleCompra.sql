
CREATE PROCEDURE [dbo].[_spEliminarDetalleCompra]
    @Id_Detalle_Compra INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Id_Producto INT;
        DECLARE @Cantidad INT;

        -- Validar que el detalle exista y obtener datos
        SELECT
            @Id_Producto = Id_Producto,
            @Cantidad = Cantidad
        FROM Detalle_Compra
        WHERE Id_Detalle_Compra = @Id_Detalle_Compra;

        IF @Id_Producto IS NULL
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('El detalle de compra no existe.', 16, 1);
            RETURN;
        END

        -- Eliminar detalle de compra
        DELETE FROM Detalle_Compra
        WHERE Id_Detalle_Compra = @Id_Detalle_Compra;

        -- Restar stock del producto
        UPDATE Producto
        SET Stock = Stock - @Cantidad
        WHERE Id_Producto = @Id_Producto;

        -- Restar stock en inventario
        UPDATE Inventario
        SET Stock = Stock - @Cantidad
        WHERE Id_Producto = @Id_Producto;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000),
                @ErrSeverity INT;

        SELECT
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY();

        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;
