CREATE PROCEDURE sp_EliminarProducto
    @Id_Producto INT
AS
BEGIN
    DELETE FROM Producto
    WHERE Id_Producto = @Id_Producto;
END
