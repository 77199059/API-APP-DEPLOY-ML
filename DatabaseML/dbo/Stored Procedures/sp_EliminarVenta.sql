Create PROCEDURE [dbo].[sp_EliminarVenta]
    @Id_Venta INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia de la venta
        IF NOT EXISTS (SELECT 1 FROM Ventas WHERE Id_Venta = @Id_Venta)
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('La venta no existe.', 16, 1);
            RETURN;
        END

        -- Restaurar stock de productos relacionados
        UPDATE P
        SET P.Stock = P.Stock + DV.Cantidad
        FROM Producto P
        INNER JOIN Detalle_Venta DV ON P.Id_Producto = DV.Id_Producto
        WHERE DV.Id_Venta = @Id_Venta;

        -- Eliminar detalles de la venta
        DELETE FROM Detalle_Venta
        WHERE Id_Venta = @Id_Venta;

        -- Eliminar la venta principal
        DELETE FROM Ventas
        WHERE Id_Venta = @Id_Venta;

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
