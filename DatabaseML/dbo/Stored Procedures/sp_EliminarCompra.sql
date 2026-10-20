
CREATE PROCEDURE [dbo].[sp_EliminarCompra]
    @Id_Compra INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia de la compra
        IF NOT EXISTS (
            SELECT 1 
            FROM Compras 
            WHERE Id_Compra = @Id_Compra
        )
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR('La compra no existe.', 16, 1);
            RETURN;
        END

        -- Restar stock de productos relacionados
        UPDATE P
        SET P.Stock = P.Stock - DC.Cantidad
        FROM Producto P
        INNER JOIN Detalle_Compra DC 
            ON P.Id_Producto = DC.Id_Producto
        WHERE DC.Id_Compra = @Id_Compra;

        -- Restar stock en inventario
        UPDATE I
        SET I.Stock = I.Stock - DC.Cantidad
        FROM Inventario I
        INNER JOIN Detalle_Compra DC 
            ON I.Id_Producto = DC.Id_Producto
        WHERE DC.Id_Compra = @Id_Compra;

        -- Eliminar detalles de compra
        DELETE FROM Detalle_Compra
        WHERE Id_Compra = @Id_Compra;

        -- Eliminar compra principal
        DELETE FROM Compras
        WHERE Id_Compra = @Id_Compra;

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
