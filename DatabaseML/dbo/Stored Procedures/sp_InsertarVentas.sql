CREATE PROCEDURE [dbo].[sp_InsertarVentas]
    @Id_Usuario INT,
    @Fecha_Venta DATETIME,
    @Total DECIMAL(10,2),
    @Id_Venta INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar venta y tomar automáticamente el nombre del usuario
        INSERT INTO Ventas (Id_Usuario, Nombre, Fecha_Venta, Total)
        SELECT 
            @Id_Usuario,
            Nombre,        -- se toma automáticamente de Usuarios
            @Fecha_Venta,
            @Total
        FROM Usuario
        WHERE Id_Usuario = @Id_Usuario;

        -- Obtener Id_Venta recién insertado
        SET @Id_Venta = SCOPE_IDENTITY();

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