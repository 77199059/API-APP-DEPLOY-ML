
CREATE PROCEDURE dbo.sp_InsertarCompraConDetalles
    @Id_Proveedor INT,
    @MetodoPago   NVARCHAR(50),
    @Fecha_Compra DATETIME = NULL,
    @Observaciones NVARCHAR(MAX) = NULL,
    @Detalles dbo.DetalleCompraType READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        DECLARE @Total DECIMAL(18,2) = (SELECT ISNULL(SUM(Cantidad * Precio_Unitario),0) FROM @Detalles);

        -- Inserta cabecera (ajusta nombre de tabla/columnas si necesario)
        INSERT INTO dbo.Compras (Fecha_Compra, Id_Proveedor, MetodoPago, Total, Observaciones)
        VALUES (ISNULL(@Fecha_Compra, GETDATE()), @Id_Proveedor, @MetodoPago, @Total, @Observaciones);

        DECLARE @Id_Compra INT = SCOPE_IDENTITY();

        -- Inserta detalles (ajusta nombre de tabla/columnas si necesario)
        INSERT INTO dbo.Detalle_Compras(Id_Compra, Id_Producto, Cantidad, Precio_Unitario, Subtotal)
        SELECT @Id_Compra, Id_Producto, Cantidad, Precio_Unitario, CAST(Cantidad * Precio_Unitario AS DECIMAL(18,2))
        FROM @Detalles;

        COMMIT TRAN;

        -- Devuelve filas combinadas (una fila por detalle con columnas de cabecera repetidas)
        SELECT
            c.Id_Compra,
            c.Fecha_Compra,
            c.Id_Proveedor,
            c.MetodoPago,
            c.Total,
            c.Observaciones,
            d.Id_Detalle_Compra,
            d.Id_Producto,
            d.Cantidad,
            d.Precio_Unitario,
            d.Subtotal
        FROM dbo.Compras c
        INNER JOIN dbo.Detalle_Compras d ON c.Id_Compra = d.Id_Compra
        WHERE c.Id_Compra = @Id_Compra
        ORDER BY d.Id_Detalle_Compra;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRAN;
        THROW;
    END CATCH
END
