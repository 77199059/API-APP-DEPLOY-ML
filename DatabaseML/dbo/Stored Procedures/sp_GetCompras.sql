
CREATE PROCEDURE dbo.sp_GetCompras
AS
BEGIN
    SET NOCOUNT ON;

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
    ORDER BY c.Id_Compra, d.Id_Detalle_Compra;
END
