CREATE PROCEDURE [dbo].[sp_InsertarProducto]
    @Nombre_Producto VARCHAR(100),
    @Descripcion VARCHAR(300),
    @Id_Categoria INT
AS
BEGIN
    INSERT INTO Producto (Nombre_Producto, Descripcion, Id_Categoria)
    VALUES (@Nombre_Producto, @Descripcion, @Id_Categoria);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END