CREATE TABLE [dbo].[Proveedor] (
    [Id_Proveedor] INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]       NVARCHAR (50) NULL,
    [Apellido]     NVARCHAR (50) NULL,
    [Email]        NVARCHAR (50) NULL,
    [Telefono]     NVARCHAR (50) NULL,
    [Razon_Social] NVARCHAR (50) NULL,
    [Direccion]    NVARCHAR (50) NULL,
    [Id_Producto]  INT           NULL,
    PRIMARY KEY CLUSTERED ([Id_Proveedor] ASC)
);

