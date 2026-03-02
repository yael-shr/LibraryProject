CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Authors (
    AuthorId INT PRIMARY KEY IDENTITY(1,1),
    AuthorName NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Statuses (
    StatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50) NOT NULL
);
GO


CREATE TABLE Books (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,    
    Description NVARCHAR(MAX),       
    AuthorId INT,                    
    CategoryId INT,                  
    StatusId INT,                   
    CreatedAt DATETIME DEFAULT GETDATE(), 
    CONSTRAINT FK_Books_Authors FOREIGN KEY (AuthorId) REFERENCES Authors(AuthorId),
    CONSTRAINT FK_Books_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
    CONSTRAINT FK_Books_Statuses FOREIGN KEY (StatusId) REFERENCES Statuses(StatusId)
);
GO


CREATE PROCEDURE Books_Create
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


CREATE PROCEDURE Books_Update
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


CREATE PROCEDURE Books_GetById
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


CREATE PROCEDURE Books_GetAll_Search
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

 
CREATE PROCEDURE Statuses_GetAll
AS
BEGIN
    SELECT StatusId, StatusName FROM Statuses;
END
GO


INSERT INTO Categories (CategoryName) VALUES ('Fantacy'), ('Children'), ('History');
INSERT INTO Authors (AuthorName) VALUES ('Yeal Shraga'), ('Yona Sapir'), ('Maya Kainan');
INSERT INTO Statuses (StatusName) VALUES ('Availible'), ('Taken'), ('Not Good');
GO

INSERT INTO Books (Title, Description, AuthorId, CategoryId, StatusId)
VALUES 
('Sarah, Heroine of Nili', 'The moving story of Sarah Aaronsohn', 1, 3, 1),
('To the Top of the Mountain', 'A fascinating biography', 1, 3, 1),
('Point Blank', 'A breathtaking suspense thriller', 2, 1, 2),
('Cold Blood', 'Psychological suspense novel', 2, 1, 1),
('Istarak', 'The first book in the Kingdom under Test series', 3, 1, 1),
('Mahalalel', 'The second book in the Kingdom under Test series', 3, 1, 2),
('Yosele the Hero', 'A children''s story about Jewish bravery', 1, 2, 1),
('Maze', 'A plot-filled suspense novel', 2, 1, 3),
('I Am Not Leaving', 'A moving historical story', 1, 3, 1),
('Scar', 'An immersive and emotional drama', 3, 1, 1);
GO