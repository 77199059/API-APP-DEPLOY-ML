CREATE PROCEDURE [dbo].[sp_InsertarCompras]
    @Id_Proveedor INT,
    @Fecha_Compra DATETIME,
    @Total DECIMAL(10,2),
    @Observaciones NVARCHAR(250),
    @Id_Compra INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        INSERT INTO Compras
        (
            Id_Proveedor,
            Fecha_Compra,
            Total,
            Observaciones
        )
        VALUES
        (
            @Id_Proveedor,
            @Fecha_Compra,
            @Total,
            @Observaciones
        );

        -- Obtener ID generado
        SET @Id_Compra = SCOPE_IDENTITY();

    END TRY

    BEGIN CATCH

        DECLARE @ErrMsg NVARCHAR(4000),
                @ErrSeverity INT;

        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY();

        RAISERROR(@ErrMsg, @ErrSeverity, 1);

    END CATCH
END