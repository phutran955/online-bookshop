USE [master]
GO
DROP DATABASE IF EXISTS [bookDB]
GO

CREATE DATABASE [bookDB]
GO

USE [bookDB]
GO

-- Categories Table
CREATE TABLE [dbo].[tblCategories] (
    [CategoryID] INT IDENTITY(1,1) PRIMARY KEY,
    [CategoryName] NVARCHAR(50) NOT NULL
)
GO

-- Suppliers Table
CREATE TABLE [dbo].[tblSuppliers] (
    [SupplierID] INT IDENTITY(1,1) PRIMARY KEY,
    [CompanyName] NVARCHAR(40) NOT NULL,
    [ContactName] NVARCHAR(50) NULL,
    [Country] NVARCHAR(50) NULL,
    [Phone] NVARCHAR(24) NULL,
    [HomePage] NVARCHAR(MAX) NULL
)
GO

-- Products Table
CREATE TABLE [dbo].[tblProducts] (
    [ProductID] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductName] NVARCHAR(100) NOT NULL,
    [Author] NVARCHAR(100) NULL,
    [SupplierID] INT NULL,
    [CategoryID] INT NULL,
    [UnitPrice] MONEY NULL,
    [UnitsInStock] SMALLINT NULL,
    [QuantitySold] INT NULL,
    [Image] NVARCHAR(MAX) NULL,
    [Description] NVARCHAR(MAX) NULL,
    [ReleaseDate] DATE NULL,
    [Discount] FLOAT NULL,
    [Status] BIT NOT NULL,

    CONSTRAINT FK_Products_Supplier FOREIGN KEY ([SupplierID])
        REFERENCES [dbo].[tblSuppliers] ([SupplierID])
        ON DELETE SET NULL ON UPDATE CASCADE,

    CONSTRAINT FK_Products_Category FOREIGN KEY ([CategoryID])
        REFERENCES [dbo].[tblCategories] ([CategoryID])
)
GO


-- Users Table
CREATE TABLE [dbo].[tblUsers] (
    [UserID] INT IDENTITY(1,1),
    [UserName] NVARCHAR(50) NOT NULL PRIMARY KEY,
    [FullName] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(50) NOT NULL,
    [RoleID] NVARCHAR(50) NULL,
    [Email] NVARCHAR(50) NULL,
    [BirthDay] DATE NOT NULL,
    [Address] NVARCHAR(200) NULL,
    [Phone] NVARCHAR(11) NOT NULL,
    [Status] BIT NOT NULL
)
GO



-- Insert Sample Data

-- Categories
INSERT INTO [dbo].[tblCategories] ([CategoryName]) VALUES 
(N'Fantasy'),
(N'Horror'),
(N'Science Fiction')
GO

-- Products
INSERT INTO [dbo].[tblProducts] (
    [ProductName], [Description], [UnitPrice], [CategoryID], [Status], [Image]
) VALUES 
(N'Fire and Blood', N'Detailed history of House Targaryen...', 211000, 1, 1, N'https://i.postimg.cc/PrNLh4VZ/548x840.jpg'),
(N'86', N'Set in a world with fake drones...', 145000, 3, 1, N'https://i.postimg.cc/wv07Dpsc/OIP-2.jpg'),
(N'Harry Potter', N'Dark past of Lord Voldemort explored...', 311760, 1, 1, N'https://i.postimg.cc/pVqQRNyH/half-blood-prince-2022-pottermore-cover.jpg'),
(N'Another: Episode S/0', N'Mei Misaki meets a ghost...', 100000, 2, 1, N'https://i.postimg.cc/ncs12HGL/another-s0-76f7ba55511f477692f4c3a2a1da7f4a-master.jpg')
GO

-- Users
INSERT INTO [dbo].[tblUsers] (
    [UserName], [FullName], [Password], [RoleID], [Email], [BirthDay], [Address], [Phone], [Status]
) VALUES
(N'admin', N'Administrator', N'1', N'AD', NULL, '1990-01-01', NULL, '0123456789', 1),
(N'ce175533', N'Mai Thanh Quan', N'ct', N'MB', NULL, '1999-05-15', NULL, '0987654321', 1);
GO
