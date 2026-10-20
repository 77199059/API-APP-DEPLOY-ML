CREATE PROCEDURE sp_EliminarProveedor
(
    @Id_Proveedor INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar si existe
    IF NOT EXISTS (
        SELECT 1
        FROM Proveedor
        WHERE Id_Proveedor = @Id_Proveedor
    )
    BEGIN
        RAISERROR('El proveedor no existe.',16,1);
        RETURN;
    END

    DELETE FROM Proveedor
    WHERE Id_Proveedor = @Id_Proveedor;

    PRINT 'Proveedor eliminado correctamente';
END;
