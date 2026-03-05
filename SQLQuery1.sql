
USE [libraryDB]
GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO [public] AS [dbo]
GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO [public] AS [dbo]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Authors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Authors](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Books]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Books]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[AuthorId] [int] NULL,
	[CategoryId] [int] NULL,
	[StatusId] [int] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Statuses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Statuses](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Books__CreatedAt__3D5E1FD2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Books] ADD  DEFAULT (getdate()) FOR [CreatedAt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Authors]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Authors] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([AuthorId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Authors]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Authors]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Categories]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Statuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([StatusId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Books_Statuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[Books]'))
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Statuses]
GO
/****** Object:  StoredProcedure [dbo].[Authors_GetAll]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Authors_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Authors_GetAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[Authors_GetAll]
AS
BEGIN
    SELECT AuthorId, AuthorName FROM Authors;
END

GO
/****** Object:  StoredProcedure [dbo].[Books_Create]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Books_Create]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Books_Create] AS' 
END
GO


ALTER PROCEDURE [dbo].[Books_Create]
    @Title NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @AuthorId INT,
    @CategoryId INT,
    @StatusId INT
AS
BEGIN
    INSERT INTO Books (Title, Description, AuthorId, CategoryId, StatusId, CreatedAt)
    VALUES (@Title, @Description, @AuthorId, @CategoryId, @StatusId, GETDATE());
END

GO
/****** Object:  StoredProcedure [dbo].[Books_GetAll_Search]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Books_GetAll_Search]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Books_GetAll_Search] AS' 
END
GO


ALTER PROCEDURE [dbo].[Books_GetAll_Search]
    @SearchText NVARCHAR(100) = NULL
AS
BEGIN
    SELECT B.Id, B.Title, B.Description, A.AuthorName, C.CategoryName, S.StatusName
    FROM Books B
    LEFT JOIN Authors A ON B.AuthorId = A.AuthorId
    LEFT JOIN Categories C ON B.CategoryId = C.CategoryId
    LEFT JOIN Statuses S ON B.StatusId = S.StatusId
    WHERE (@SearchText IS NULL 
           OR B.Title LIKE '%' + @SearchText + '%'
           OR B.Description LIKE '%' + @SearchText + '%'
           OR A.AuthorName LIKE '%' + @SearchText + '%');
END

GO
/****** Object:  StoredProcedure [dbo].[Books_GetById]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Books_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Books_GetById] AS' 
END
GO


ALTER PROCEDURE [dbo].[Books_GetById]
    @Id INT
AS
BEGIN
    SELECT B.Id, B.Title, B.Description, B.CreatedAt,
           A.AuthorName, C.CategoryName, S.StatusName,
           B.AuthorId, B.CategoryId, B.StatusId
    FROM Books B
    LEFT JOIN Authors A ON B.AuthorId = A.AuthorId
    LEFT JOIN Categories C ON B.CategoryId = C.CategoryId
    LEFT JOIN Statuses S ON B.StatusId = S.StatusId
    WHERE B.Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[Books_Update]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Books_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Books_Update] AS' 
END
GO


ALTER PROCEDURE [dbo].[Books_Update]
    @Id INT,
    @Title NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @AuthorId INT,
    @CategoryId INT,
    @StatusId INT
AS
BEGIN
    UPDATE Books
    SET Title = @Title,
        Description = @Description,
        AuthorId = @AuthorId,
        CategoryId = @CategoryId,
        StatusId = @StatusId
    WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[Categories_GetAll]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Categories_GetAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[Categories_GetAll]
AS
BEGIN
    SELECT CategoryId, CategoryName FROM Categories;
END

GO
/****** Object:  StoredProcedure [dbo].[Statuses_GetAll]    Script Date: 05/03/2026 21:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Statuses_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Statuses_GetAll] AS' 
END
GO

 
ALTER PROCEDURE [dbo].[Statuses_GetAll]
AS
BEGIN
    SELECT StatusId, StatusName FROM Statuses;
END

GO
USE [master]
GO
ALTER DATABASE [libraryDB] SET  READ_WRITE 
GO
