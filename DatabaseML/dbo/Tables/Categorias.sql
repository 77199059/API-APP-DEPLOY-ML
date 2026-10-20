CREATE TABLE [dbo].[Categorias] (
    [Id_Categoria]     INT            IDENTITY (1, 1) NOT NULL,
    [Nombre_Categoria] NVARCHAR (50)  NULL,
    [Descripcion]      NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id_Categoria] ASC)
);

