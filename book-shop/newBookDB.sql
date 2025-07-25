USE [master]
GO
DROP DATABASE IF EXISTS [bookDBN]
GO

CREATE DATABASE [bookDBN]
GO

USE [bookDBN]
GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetails](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[UnitPrice] [money] NULL,
	[Discount] [float] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[TotalMoney] [money] NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducts](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Author] [nvarchar](100) NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[QuantitySold] [int] NULL,
	[Image] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ReleaseDate] [date] NULL,
	[Discount] [float] NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSuppliers]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSuppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Phone] [nvarchar](24) NULL,
	[HomePage] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[RoleID] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[BirthDay] [date] NOT NULL,
	[Address] [nvarchar](200) NULL,
	[Phone] [nvarchar](11) NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wallets]    Script Date: 7/22/2025 1:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallets](
	[WalletID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Balance] [decimal](10, 2) NULL,
 CONSTRAINT [PK_Wallets] PRIMARY KEY CLUSTERED 
(
	[WalletID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCategories] ON 

INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Fantasy')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Horror')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (3, N'Science Fiction')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (4, N'Manga - Comic')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (5, N'Mystery')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (6, N'Romance')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (7, N'Thriller')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (8, N'Historical Fiction')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (9, N'Adventure')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (10, N'Poetry')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (11, N'Drama')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (12, N'Business & Economics')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (13, N'Philosophy')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (14, N'Politics')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (15, N'Health & Wellness')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (16, N'Travel')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (17, N'Language Learning')
INSERT [dbo].[tblCategories] ([CategoryID], [CategoryName]) VALUES (18, N'Children’s Books')
SET IDENTITY_INSERT [dbo].[tblCategories] OFF
GO
INSERT [dbo].[tblOrderDetails] ([OrderID], [ProductID], [Quantity], [UnitPrice], [Discount]) VALUES (1, 15, 1, 150000.0000, 30)
GO
SET IDENTITY_INSERT [dbo].[tblOrders] ON 

INSERT [dbo].[tblOrders] ([OrderID], [Date], [UserName], [TotalMoney], [Status]) VALUES (1, CAST(N'2025-07-22' AS Date), N'se192676', 105000.0000, 1)
SET IDENTITY_INSERT [dbo].[tblOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[tblProducts] ON 

INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (1, N'Khóa Chặt Cửa Nào Suzume', N' Shinkai Makoto', 4, 9, 145000.0000, 10, NULL, N'https://i.postimg.cc/Y9mm8HG3/suzu.jpg', N'vv...', CAST(N'2023-09-01' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (2, N'86 - 1', N'Asato Asato', 4, 3, 145000.0000, 30, NULL, N'https://i.postimg.cc/1zY253M7/86vol01.jpg', N'vv...', CAST(N'2023-01-15' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (3, N'86 - 2', N'Asato Asato', 1, 3, 145000.0000, 25, NULL, N'https://i.postimg.cc/6qLN3N87/86vol02.jpg', N'vv...', CAST(N'2023-05-10' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (4, N'86 - 3', N'Asato Asato', 1, 3, 145000.0000, 15, NULL, N'https://i.postimg.cc/0jLJ8DJ5/86vol3.jpg', N'vv...', CAST(N'2023-06-10' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (5, N'86 - 4', N'Asato Asato', 1, 3, 145000.0000, 10, NULL, N'https://i.postimg.cc/JhtVJz7J/86vol04.jpg', N'vv...', CAST(N'2024-08-10' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (6, N'86 - 5', N'Asato Asato', 1, 3, 145000.0000, 10, NULL, N'https://i.postimg.cc/XYWtJhWF/86vol05.jpg', N'vv...', CAST(N'2024-08-10' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (7, N'Another', N'Yukito Ayatsuji', 1, 2, 140000.0000, 16, NULL, N'https://i.postimg.cc/3R9j2YLM/another12.jpg', N'vv...', CAST(N'2015-06-01' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (8, N'Another S/0', N'Yukito Ayatsuji', 1, 2, 100000.0000, 10, NULL, N'https://i.postimg.cc/fyJq8k7P/another.jpg', N'vv...', CAST(N'2018-09-01' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (9, N'Another 2001', N'Yukito Ayatsuji', 1, 2, 210000.0000, 18, NULL, N'https://i.postimg.cc/Dww1q1x7/another2001.jpg', N'vv...', CAST(N'2023-06-01' AS Date), 50, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (10, N'Soul Eater - 1', N'Atsushi Ohkubo', 5, 4, 95000.0000, 12, NULL, N'https://i.postimg.cc/65qjNrNN/soul01.jpg', N'vv...', CAST(N'2024-06-01' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (11, N'Soul Eater - 2', N'Atsushi Ohkubo', 5, 4, 95000.0000, 18, NULL, N'https://i.postimg.cc/mkL97WsF/soul02.jpg', N'vv...', CAST(N'2024-08-03' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (12, N'Nòng Nọc Đã Lớn', N' Giuliano Ferri', 1, 18, 46000.0000, 18, NULL, N'https://i.postimg.cc/kg5fn2Rh/nongnoc.jpg', N'Giới thiệu sách: Nòng Nọc Đã Lớn kể về sự tiến hóa từ nòng nọc thành ếch, dành cho các bé từ 4 đến 8 tuổi. Chẳng là ngày nọ, nòng nọc chào đời, có cái đuôi dài nhọn bơi tung tăng khắp nơi. Bơi thi này. Đi chơi này. Đi trốn này. Khám phá khắp ao nước này', CAST(N'2017-02-01' AS Date), 70, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (13, N'Soul Eater - 17', N'Atsushi Ohkubo', 1, 4, 95000.0000, 10, NULL, N'https://i.postimg.cc/C58KZvZf/soul017.jpg', N'vv...', CAST(N'2025-03-01' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (14, N'Death Note - 1 - 13', N'Tsugumi Ohba', 4, 4, 635000.0000, 30, NULL, N'https://i.postimg.cc/kMWRXHDt/deathnote.jpg', N'Giới thiệu sách: Trọn bộ 13 tập manga DEATH NOTE đã có tại IPM. 

Giữa đời thực của chúng ta, giả như có một dị vật “từ trên trời” rơi xuống, lại có quyền năng gần như vô hạn chi phối số mạng con người.

Dị vật ấy không thua gì một công cụ phán xử và người sử dụng chẳng mấy khác quan tòa.

Vậy, cách sử dụng ra sao sẽ là điều quyết định.

Vì lợi ích cá nhân? Hay để thay đổi thế giới?

Vị trí “kẻ ích kỉ ngộ nhận” và “quan tòa chính nghĩa” chỉ cách nhau một ranh giới mong manh - sự tỉnh táo trong cách nghĩ “công lý-lý tưởng, liệu có thể chỉ do một cá nhân định đoạt”.', CAST(N'2019-10-07' AS Date), 10, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (15, N'Harry Potter and The Philosopher''s Stone', N'J.K Rowling', 1, 2, 150000.0000, 44, 1, N'https://i.postimg.cc/7P5gyT9D/Harry-potter-v-h-n-ph-th-y.jpg', N'vv...', CAST(N'1997-06-26' AS Date), 30, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (16, N'Rich Dad Poor Dad', N'Robert T. Kiyosaki', 1, 12, 120000.0000, 45, NULL, N'https://i.postimg.cc/qBXXwCkG/Rich-Dad-Poor-Dad.jpg', N'vv...', CAST(N'2000-04-01' AS Date), 15, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (17, N'Cô bé bán diêm', N'Hans Christian Andersen', 1, 18, 20000.0000, 45, NULL, N'https://i.postimg.cc/ht9SQg8h/Plate-facing-page-406-of-Fairy-tales-and-stories-Andersen-Tegner.jpg', N'', CAST(N'1845-12-10' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (18, N'Think and Grow Rich', N'Napoleon Hill and Rosa Lee Beeland', 1, 12, 150000.0000, 45, NULL, N'https://i.postimg.cc/N0FBJTq2/Think-and-grow-rich-original-cover.jpg', N'', CAST(N'1937-06-09' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (19, N'Harry Potter and Chamber of Secrets', N'J.K Rowling', 1, 1, 130000.0000, 65, NULL, N'https://i.postimg.cc/vTDrD45R/Harry-potter-2-1.jpg', N'vv...', CAST(N'1998-07-02' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (20, N'Harry Potter and The Prisoner of Azkaban', N'J.K Rowling', 1, 1, 165000.0000, 30, NULL, N'https://i.postimg.cc/L6LSwNZP/Harry-Potter-Va-Ten-Tu-Nhan-Nguc-Azkaban.jpg', N'vv...', CAST(N'1999-07-08' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (21, N'Harry Potter and The Goblet of Fire', N'J.K Rowling', 1, 1, 170000.0000, 40, NULL, N'https://i.postimg.cc/J0yrs8nY/9781408855683.jpg', N'vv...', CAST(N'1999-07-08' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (22, N'Harry Potter and the Half-Blood Prince', N'J.K Rowling', 1, 1, 170000.0000, 45, NULL, N'https://i.postimg.cc/fR5Y7754/Harry-Potter-Va-Hoang-Tu-Lai-708x1024.jpg', N'vv...', CAST(N'2005-07-16' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (23, N'Harry Potter and the Order of the Phoenix', N'J.K Rowling', 1, 1, 170000.0000, 50, NULL, N'https://i.postimg.cc/9QzQSGCH/Harry-Potter-and-the-Order-of-the-Phoenix.jpg', N'vv...', CAST(N'2003-06-21' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (24, N'Harry Potter and the Deathly Hallows', N'J.K Rowling', 1, 1, 210000.0000, 48, NULL, N'https://i.postimg.cc/7PmDkfBH/Harry-Potter-and-the-Deathly-Hallows.jpg', N'vv...', CAST(N'2007-07-21' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (25, N'Phù Thủy Xứ Oz', N' L.Frank Baum', 4, 18, 198000.0000, 5, NULL, N'https://i.postimg.cc/tJfk2xjM/xuoz.jpg', N'Giới thiệu sách: Phù Thủy Xứ Oz & Trên Những Nẻo Đường Xứ Oz (Phiên bản có minh họa màu+nhiều minh họa đen trắng) Mở đầu với cái nắng với cái gió, với môi trường xám xịt khô khan… Chỉ bằng một cơn lốc…', CAST(N'2019-07-23' AS Date), 60, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (26, N'Harry Potter and the Cursed Child', N'Jack Thorne', 1, 1, 160000.0000, 30, NULL, N'https://i.postimg.cc/636WrRHP/Cursed-Child-new-poster.jpg', N'vv...', CAST(N'2016-07-30' AS Date), 0, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (27, N'Alice Ở Xứ Sở Diệu Kỳ ', N'LEWIS CARROLL', 4, 18, 150000.0000, 5, NULL, N'https://i.postimg.cc/yYXLCks2/allice.jpg', N'Giới thiệu sách: Alice Ở Xứ Sở Diệu Kỳ Và Thế Giới Trong Gương Alice đang nằm gối đầu lên lòng chị trong vườn nhà. Đúng lúc cô thấy buồn tẻ và thiu thiu ngủ, thì một chú thỏ trắng chạy qua, vừa chạy vừa rút đồng hồ xem và cằn nhằn muộn giờ.', CAST(N'2019-06-20' AS Date), 50, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (28, N'Song of the South', N'Đoàn Giỏi', 6, 9, 225000.0000, 100, NULL, N'https://i.postimg.cc/ncdDC4kC/Dat-Rung-Phuong-Nam.jpg', N'vv...', CAST(N'2010-06-23' AS Date), 20, 1)
INSERT [dbo].[tblProducts] ([ProductID], [ProductName], [Author], [SupplierID], [CategoryID], [UnitPrice], [UnitsInStock], [QuantitySold], [Image], [Description], [ReleaseDate], [Discount], [Status]) VALUES (29, N'The Godfather', N'Mario Puzo', 1, 13, 225000.0000, 35, NULL, N'https://i.postimg.cc/XJV2nKLQ/Godfather-Novel-Cover.jpg', N'', CAST(N'1969-06-12' AS Date), 0, 1)
SET IDENTITY_INSERT [dbo].[tblProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[tblSuppliers] ON 

INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (1, N'Global Books Ltd.', N'Anna Smith', N'USA', N'+1-555-1234', N'https://globalbooks.com')
INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (2, N'Southeast Asia Publishing', N'Nguyen Van A', N'Vietnam', N'+84-24-88888888', N'https://seapub.vn')
INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (3, N'EuroRead GmbH', N'Franz Müller', N'Germany', N'+49-89-123456', N'https://euroread.de')
INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (4, N'IPM', N'Sato Haruki', N'Vie', N'+81-3-45678901', N'https://ipm.vn')
INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (5, N'NXB Trẻ', N'Linda Brown', N'Viet', N'+61-2-98765432', N'https://nxbtre.vn')
INSERT [dbo].[tblSuppliers] ([SupplierID], [CompanyName], [ContactName], [Country], [Phone], [HomePage]) VALUES (6, N'Kim Đồng', N'Đoàn Nguyễn Thanh Hòa', N'Vietnam', N'(+84) 1900571595', N'https://nxbkimdong.com.vn/')
SET IDENTITY_INSERT [dbo].[tblSuppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([UserID], [UserName], [FullName], [Password], [RoleID], [Email], [BirthDay], [Address], [Phone], [Status]) VALUES (1, N'admin', N'Administrator', N'1', N'AD', N'needaname005@gmail.com', CAST(N'1990-01-01' AS Date), N'TPHCM', N'0123456789', 1)
INSERT [dbo].[tblUsers] ([UserID], [UserName], [FullName], [Password], [RoleID], [Email], [BirthDay], [Address], [Phone], [Status]) VALUES (2, N'ce175533', N'Mai Thanh Quan', N'2', N'MB', N'needaname005@gmail.com', CAST(N'1999-05-15' AS Date), N'TPHCM', N'0987654321', 1)
INSERT [dbo].[tblUsers] ([UserID], [UserName], [FullName], [Password], [RoleID], [Email], [BirthDay], [Address], [Phone], [Status]) VALUES (3, N'se192676', N'hung', N'3', N'MB', N'quochungle2005@gmail.com', CAST(N'2025-07-02' AS Date), N'', N'', 1)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
GO
SET IDENTITY_INSERT [dbo].[Wallets] ON 

INSERT [dbo].[Wallets] ([WalletID], [UserName], [Balance]) VALUES (1, N'admin', CAST(2000000.00 AS Decimal(10, 2)))
INSERT [dbo].[Wallets] ([WalletID], [UserName], [Balance]) VALUES (2, N'se192676', CAST(95000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Wallets] OFF
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail] FOREIGN KEY([OrderID])
REFERENCES [dbo].[tblOrders] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_OrderDetail]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProductDetail] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProducts] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_ProductDetail]
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserName])
REFERENCES [dbo].[tblUsers] ([UserName])
GO
ALTER TABLE [dbo].[tblOrders] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[tblProducts]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[tblCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[tblProducts] CHECK CONSTRAINT [FK_Products_Category]
GO
ALTER TABLE [dbo].[tblProducts]  WITH CHECK ADD  CONSTRAINT [FK_Products_Supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[tblSuppliers] ([SupplierID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblProducts] CHECK CONSTRAINT [FK_Products_Supplier]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_Users] FOREIGN KEY([UserName])
REFERENCES [dbo].[tblUsers] ([UserName])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_Users]
GO
