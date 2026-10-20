CREATE PROCEDURE sp_ActualizarProducto
    @Id_Producto INT,
    @Nombre_Producto NVARCHAR(100),
    @Descripcion NVARCHAR(200),
    @Id_Categoria INT
AS
BEGIN
    UPDATE Producto
    SET Nombre_Producto = @Nombre_Producto,
        Descripcion = @Descripcion,
        Id_Categoria = @Id_Categoria
    WHERE Id_Producto = @Id_Producto;
END
