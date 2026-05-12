CREATE DATABASE TTGShop8;
GO
USE TTGShop8;
GO

/* =======================
   USERS
   ======================= */
CREATE TABLE Users (
    userId INT IDENTITY PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fullName NVARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER',      -- ADMIN / USER
    status VARCHAR(20) DEFAULT 'ACTIVE',  -- ACTIVE / BLOCK
    createdAt DATETIME DEFAULT GETDATE()
);

/* =======================
   CATEGORY
   ======================= */
CREATE TABLE Categories (
    categoryId INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

/* =======================
   BRAND
   ======================= */
CREATE TABLE Brands (
    brandId INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);

/* =======================
   PRODUCTS
   ======================= */
CREATE TABLE Products (
    productId INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(15,2) NOT NULL,
    stock INT NOT NULL,
    soldCount INT DEFAULT 0,
    categoryId INT,
    brandId INT,
    createdAt DATETIME DEFAULT GETDATE(),
    images NVARCHAR(255),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (categoryId) REFERENCES Categories(categoryId),
    FOREIGN KEY (brandId) REFERENCES Brands(brandId)
);


/* =======================
   PRODUCT IMAGES
   ======================= */
   --chua anh phu
CREATE TABLE ProductImages (
    imageId INT IDENTITY PRIMARY KEY,
    productId INT NOT NULL,
    imageUrl VARCHAR(255),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);

/* =======================
   CART
   ======================= */
CREATE TABLE CartItems (
    cartItemId INT IDENTITY PRIMARY KEY,
    userId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);

/* =======================
   ORDERS
   ======================= */
CREATE TABLE Orders (
    orderId INT IDENTITY PRIMARY KEY,
    userId INT NOT NULL,
    totalAmount DECIMAL(10,2),
    paymentMethod VARCHAR(50),
    status VARCHAR(20) DEFAULT 'PENDING',
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

/* =======================
   ORDER DETAILS
   ======================= */
CREATE TABLE OrderDetails (
    orderDetailId INT IDENTITY PRIMARY KEY,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    unitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES Orders(orderId),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);

CREATE TABLE Reviews (
    reviewId INT IDENTITY PRIMARY KEY,
    userId INT,
    productId INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),--đánh giá
    comment NVARCHAR(1000),
    reviewAt DATETIME DEFAULT GETDATE(), --ngày review
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);


/* =======================
   SAMPLE DATA
   ======================= */
INSERT INTO Users (username, password, email, fullName, role)
VALUES
('admin', 'admin123', 'admin@shop.com', N'Quản Trị Viên', 'ADMIN'),
('user1', 'user123', 'user1@shop.com', N'Nguyễn Van A', 'USER');

INSERT INTO Categories (name)
VALUES (N'PC'), (N'Laptop');------1,2


INSERT INTO Brands (name)
VALUES
-- PC brands
('OMEN'),--1 -        -1 2 3
('MSI'),--2           4 5 6
('Gigabyte'),--3      7 8 9
('Corsair'),--4       10 11 12
('Lenovo Legion'),--5     13 14 15
-- Laptop brands
('Dell'),---6        16 17 18
('HP'),--7           19 20 21
('ASUS'),--8         22 23 24
('Acer'),--9         25 26 27
('Apple');--10       28 29 30

select *
from Users



/* =======================
   PRODUCTS 
   ======================= */
INSERT INTO Products
(name, description, price, stock, soldCount, categoryId, brandId, images)
VALUES
 
                                           --1 :PC      --('OMEN'),--1 -        -1 2 3
                                           --2: Laptop   --('MSI'),--2           4 5 6
                                                         --('Gigabyte'),--3      7 8 9
                                                         -- ('Corsair'),--4       10 11 12
                                                         -- ('Lenovo Legion'),--5     13 14 15
                                                          -- Laptop brands
                                                          --  ('Dell'),---6        16 17 18
                                                           -- ('HP'),--7           19 20 21
                                                           -- (   'ASUS'),--8         22 23 24
                                                           -- ('Acer'),--9         25 26 27
                                                          --('Apple');--10         --28 29 30
                                           
-- 1
(N'OMEN MAX 45L GT23-0000t',
 N'Cấu hình Ryzen 7, RAM 32GB, SSD 1TB, RTX 5070. Đáp ứng mượt gaming AAA, stream và đồ họa nặng.',
 55000000, 8, 3, 1, 1, 'images/products/product_01.jpg'),

-- 2
(N'OMEN MAX 45L GT23-0100m',
 N'Ryzen 9 hiệu năng cao, RAM 32GB, SSD 1TB, RTX 5070. Phù hợp game thủ và nhà sáng tạo nội dung.',
 59000000, 6, 2, 1, 1, 'images/products/product_02.jpg'),

-- 3
(N'OMEN MAX 45L GT23-0797m',
 N'Ryzen 7, RAM 32GB, SSD 1TB, RTX 5070. Chiến tốt game 4K và công việc đồ họa.',
 55000000, 7, 4, 1, 1, 'images/products/product_03.jpg'),

-- 4
(N'MSI GOLD 074 i5-12400F RTX 3050',
 N'Intel i5-12400F, RAM 16GB, SSD 500GB, RTX 3050. Phù hợp game eSports và AAA mức trung cao.',
 19499000, 12, 7, 1, 2, 'images/products/product_04.jpg'),

-- 5
(N'MSI GOLD 075 PRO i5-12400F RTX 5060',
 N'Intel i5-12400F, RAM 16GB, SSD 500GB, RTX 5060. Gaming mượt, render ổn định.',
 27999000, 9, 3, 1, 2, 'images/products/product_05.jpg'),

-- 6
(N'MSI HI-END Ryzen 7 9800X3D RTX 5080',
 N'Ryzen 7 9800X3D, RAM 64GB, SSD 2TB, RTX 5080. Đỉnh cao gaming và workstation.',
 93899000, 4, 1, 1, 2, 'images/products/product_06.jpg'),

-- 7
(N'Gigabyte ENTRY i5-12400F RTX 3060',
 N'i5-12400F, RAM 32GB, SSD 512GB, RTX 3060. Phù hợp game thủ phổ thông.',
 20199000, 10, 6, 1, 3, 'images/products/product_07.jpg'),

-- 8
(N'Gigabyte GOLD PRO i5-13400F RTX 5060',
 N'i5-13400F, RAM 16GB DDR5, SSD 500GB, RTX 5060. Gaming mạnh, tiết kiệm điện.',
 20890000, 11, 5, 1, 3, 'images/products/product_08.jpg'),

-- 9
(N'Gigabyte AORUS MASTER Ultra 9 RTX 5090',
 N'Intel Ultra 9, RAM 32GB, SSD 2TB, RTX 5090. Cấu hình quái vật cho AI, render, game 8K.',
 154449000, 2, 0, 1, 3, 'images/products/product_09.jpg'),

-- 10
(N'Corsair Cooling Prime i7-14700KF RTX 4060Ti',
 N'i7-14700KF, RAM 32GB, SSD 1TB, RTX 4060Ti, tản nước custom. Hiệu năng cao, mát mẻ.',
 44990000, 5, 2, 1, 4, 'images/products/product_10.jpg'),

-- 11
(N'PC Gaming i7-6700 GTX 750Ti',
 N'Cấu hình i7-6700, RAM 16GB, SSD 128GB, GTX 750Ti. Đáp ứng tốt PUBG, LOL, CF, FIFA, Đế Chế.',
 9245000, 15, 8, 1, 4, 'images/products/product_11.jpg'),

-- 12
(N'PC Gaming i9-14900K RTX 5070',
 N'i9-14900K, RAM 64GB DDR5, RTX 5070. Phù hợp streamer, render, game 4K.',
 69900000, 4, 1, 1, 5, 'images/products/product_12.jpg'),

-- 13
(N'PC Gaming NC02 i5-14600KF RTX 3060',
 N'i5-14600KF, RAM 32GB, SSD 1TB, RTX 3060. Gaming và làm việc ổn định.',
 30508000, 7, 4, 1, 5, 'images/products/product_13.jpg'),

-- 14
(N'PC Gaming i7-14700K RTX 4070 Super',
 N'i7-14700K, RAM 64GB, RTX 4070 Super. Chơi game nặng, dựng phim mượt.',
 84990000, 3, 1, 1, 5, 'images/products/product_14.jpg'),

-- 15
(N'Dell XPS 15 9570',
 N'i7-8750H, RAM 16GB, SSD 512GB, GTX 1050Ti. Laptop đồ họa, thiết kế cao cấp.',
 10200000, 9, 6, 2, 6, 'images/products/product_15.jpg'),

-- 16
(N'Dell XPS 15 9510',
 N'i7-11800H, RAM 16GB, SSD 512GB, RTX 3050. Phù hợp lập trình, đồ họa và gaming.',
 17190000, 8, 4, 2, 6, 'images/products/product_16.jpg'),

-- 17
(N'Dell Precision 7760',
 N'i7-11850H, RAM 32GB, SSD 512GB, RTX A3000. Máy trạm chuyên CAD, AI.',
 22990000, 5, 2, 2, 6, 'images/products/product_17.jpg'),

-- 18
(N'Dell XPS 13 Ultra 7 (2025)',
 N'Ultra 7, RAM 16GB, SSD 512GB, Intel Arc. Laptop mỏng nhẹ cao cấp.',
 33990000, 6, 2, 2, 6, 'images/products/product_18.jpg'),

-- 19
(N'HP OmniBook 5 Flip',
 N'Core 7 150U, RAM 16GB, SSD 512GB. Laptop xoay gập linh hoạt.',
 18790000, 7, 3, 2, 7, 'images/products/product_19.jpg'),

-- 20
(N'HP OMEN 16 RTX 5060',
 N'Ultra 7, RAM 16GB, SSD 512GB, RTX 5060. Laptop gaming hiệu năng cao.',
 38990000, 6, 2, 2, 7, 'images/products/product_20.jpg'),

-- 21
(N'HP OmniBook X Flip',
 N'Ryzen AI 7, RAM 32GB, SSD 1TB, màn hình cảm ứng. Phù hợp làm việc sáng tạo.',
 34990000, 5, 1, 2, 7, 'images/products/product_21.jpg'),

-- 22
(N'ASUS TUF FX506',
 N'i5/i7 Gen 11, RAM 16GB, SSD 512GB, RTX 3050. Laptop gaming bền bỉ.',
 13990000, 10, 6, 2, 8, 'images/products/product_22.jpg'),

-- 23
(N'ASUS ExpertBook B3405',
 N'Ultra 5, RAM 16GB, SSD 512GB. Laptop doanh nghiệp gọn nhẹ.',
 21690000, 7, 2, 2, 8, 'images/products/product_23.jpg'),

-- 24
(N'ASUS Zenbook 14 Snapdragon X',
 N'Snapdragon X, RAM 16GB, SSD 512GB. Pin trâu, nhẹ, AI PC.',
 26990000, 6, 2, 2, 8, 'images/products/product_24.jpg'),

-- 25
(N'Acer Nitro 5',
 N'Ryzen 5, RAM 16GB, SSD 512GB, GTX 1650. Laptop gaming phổ thông.',
 12490000, 11, 5, 2, 9, 'images/products/product_25.jpg'),

-- 26
(N'Acer Aspire Lite 15',
 N'i7-13620H, RAM 16GB, SSD 512GB. Laptop học tập và văn phòng.',
 16990000, 9, 3, 2, 9, 'images/products/product_26.jpg'),

-- 27
(N'Acer Swift Go 14 AI',
 N'Ultra 7, RAM 16GB, SSD 512GB, màn 2.8K. Laptop AI mỏng nhẹ.',
 24290000, 7, 2, 2, 9, 'images/products/product_27.jpg'),

-- 28
(N'MacBook Pro 16 M1 Pro',
 N'Apple M1 Pro, RAM 16GB, màn XDR 120Hz. Laptop chuyên nghiệp.',
 26390000, 6, 2, 2, 10, 'images/products/product_28.jpg'),

-- 29
(N'MacBook Air 15 M4 (2025)',
 N'Chip M4, RAM 16GB, SSD 512GB. Laptop mỏng nhẹ, pin lâu.',
 60200000, 5, 1, 2, 10, 'images/products/product_29.jpg'),

-- 30
(N'MacBook Pro 16 Touchbar 2019',
 N'Intel i9, RAM 16GB, SSD 512GB. Laptop Apple mạnh mẽ cho đồ họa.',
 13990000, 8, 4, 2, 10, 'images/products/product_30.jpg');



 /* =======================
   PRODUCT IMAGES (ảnh phụ)
   ======================= */
INSERT INTO ProductImages (productId, imageUrl)
VALUES
-- Product 1
(1,'images/products/product_01_detail1.jpg'),
(1,'images/products/product_01_detail2.jpg'),

-- Product 2
(2,'images/products/product_02_detail1.jpg'),
(2,'images/products/product_02_detail2.jpg'),

-- Product 3
(3,'images/products/product_03_detail1.jpg'),
(3,'images/products/product_03_detail2.jpg'),

-- Product 4
(4,'images/products/product_04_detail1.jpg'),
(4,'images/products/product_04_detail2.jpg'),

-- Product 5
(5,'images/products/product_05_detail1.jpg'),
(5,'images/products/product_05_detail2.jpg'),

-- Product 6
(6,'images/products/product_06_detail1.jpg'),
(6,'images/products/product_06_detail2.jpg'),

-- Product 7
(7,'images/products/product_07_detail1.jpg'),
(7,'images/products/product_07_detail2.jpg'),

-- Product 8
(8,'images/products/product_08_detail1.jpg'),
(8,'images/products/product_08_detail2.jpg'),

-- Product 9
(9,'images/products/product_09_detail1.jpg'),
(9,'images/products/product_09_detail2.jpg'),

-- Product 10
(10,'images/products/product_10_detail1.jpg'),
(10,'images/products/product_10_detail2.jpg'),

-- Product 11
(11,'images/products/product_11_detail1.jpg'),
(11,'images/products/product_11_detail2.jpg'),

-- Product 12
(12,'images/products/product_12_detail1.jpg'),
(12,'images/products/product_12_detail2.jpg'),

-- Product 13
(13,'images/products/product_13_detail1.jpg'),
(13,'images/products/product_13_detail2.jpg'),

-- Product 14
(14,'images/products/product_14_detail1.jpg'),
(14,'images/products/product_14_detail2.jpg'),

-- Product 15
(15,'images/products/product_15_detail1.jpg'),
(15,'images/products/product_15_detail2.jpg'),

-- Product 16
(16,'images/products/product_16_detail1.jpg'),
(16,'images/products/product_16_detail2.jpg'),

-- Product 17
(17,'images/products/product_17_detail1.jpg'),
(17,'images/products/product_17_detail2.jpg'),

-- Product 18
(18,'images/products/product_18_detail1.jpg'),
(18,'images/products/product_18_detail2.jpg'),

-- Product 19
(19,'images/products/product_19_detail1.jpg'),
(19,'images/products/product_19_detail2.jpg'),

-- Product 20
(20,'images/products/product_20_detail1.jpg'),
(20,'images/products/product_20_detail2.jpg'),

-- Product 21
(21,'images/products/product_21_detail1.jpg'),
(21,'images/products/product_21_detail2.jpg'),

-- Product 22
(22,'images/products/product_22_detail1.jpg'),
(22,'images/products/product_22_detail2.jpg'),

-- Product 23
(23,'images/products/product_23_detail1.jpg'),
(23,'images/products/product_23_detail2.jpg'),

-- Product 24
(24,'images/products/product_24_detail1.jpg'),
(24,'images/products/product_24_detail2.jpg'),

-- Product 25
(25,'images/products/product_25_detail1.jpg'),
(25,'images/products/product_25_detail2.jpg'),

-- Product 26
(26,'images/products/product_26_detail1.jpg'),
(26,'images/products/product_26_detail2.jpg'),

-- Product 27
(27,'images/products/product_27_detail1.jpg'),
(27,'images/products/product_27_detail2.jpg'),

-- Product 28
(28,'images/products/product_28_detail1.jpg'),
(28,'images/products/product_28_detail2.jpg'),

-- Product 29
(29,'images/products/product_29_detail1.jpg'),
(29,'images/products/product_29_detail2.jpg'),

-- Product 30
(30,'images/products/product_30_detail1.jpg'),
(30,'images/products/product_30_detail2.jpg');


/* =======================
   EXTRA CATEGORIES & PRODUCTS (optional)
   ======================= */
-- Thêm category mới (sau khi đã có 1: PC, 2: Laptop)
INSERT INTO Categories (name, status) VALUES
    (N'Linh Kiện Máy Tính', 'ACTIVE'),   -- 3
    (N'Gaming Gear', 'ACTIVE'),          -- 4
    (N'Màn Hình Máy Tính', 'ACTIVE'),    -- 5
    (N'Thiết Bị Lưu Trữ', 'ACTIVE'),     -- 6
    (N'Bàn Phím, Chuột', 'ACTIVE');      -- 7

INSERT INTO Products
(name, description, price, stock, soldCount, categoryId, brandId, images)
VALUES
-- 31
(N'CPU Intel Core i5-14400F',
 N'CPU thế hệ mới cho game và đồ hoạ tầm trung.',
 4990000, 20, 5, 3, 3, 'images/products/product_31.jpg'),

-- 32
(N'RAM DDR5 16GB 5600MHz',
 N'RAM DDR5 bus cao, tối ưu cho PC gaming.',
 1690000, 30, 8, 3, 4, 'images/products/product_32.jpg'),

-- 33
(N'Tai nghe Gaming 7.1 RGB',
 N'Tai nghe giả lập âm thanh vòm 7.1, micro chống ồn.',
 1290000, 25, 10, 4, 8, 'images/products/product_33.jpg'),

-- 34
(N'Ghế Gaming lưng cao',
 N'Ghế gaming êm ái, ngả 180 độ, kê chân.',
 3590000, 10, 3, 4, 9, 'images/products/product_34.jpg'),

-- 35
(N'Màn hình 24\" 165Hz IPS',
 N'Màn hình gaming 24 inch, tần số quét 165Hz, tấm nền IPS.',
 3990000, 15, 4, 5, 2, 'images/products/product_35.jpg'),

-- 36
(N'Màn hình cong 32\" 2K 144Hz',
 N'Màn hình cong 2K, tần số quét 144Hz cho trải nghiệm game mượt mà.',
 7990000, 8, 2, 5, 3, 'images/products/product_36.jpg'),

-- 37
(N'SSD NVMe 1TB Gen4',
 N'Ổ cứng SSD NVMe PCIe Gen4 tốc độ cao.',
 2590000, 40, 12, 6, 4, 'images/products/product_37.jpg'),

-- 38
(N'HDD 2TB 3.5\"',
 N'Ổ cứng HDD 2TB cho lưu trữ dữ liệu dung lượng lớn.',
 1590000, 35, 7, 6, 3, 'images/products/product_38.jpg'),

-- 39
(N'Bàn phím cơ RGB Blue Switch',
 N'Fullsize, switch Blue, LED RGB nhiều hiệu ứng.',
 1290000, 25, 9, 7, 8, 'images/products/product_39.jpg'),

-- 40
(N'Chuột gaming 16000DPI',
 N'Chuột gaming cảm biến quang học 16000DPI, 6 nút lập trình.',
 890000, 30, 11, 7, 9, 'images/products/product_40.jpg');

INSERT INTO ProductImages (productId, imageUrl) VALUES
(31, 'images/products/product_31_detail1.jpg'),
(31, 'images/products/product_31_detail2.jpg'),
(32, 'images/products/product_32_detail1.jpg'),
(32, 'images/products/product_32_detail2.jpg'),
(33, 'images/products/product_33_detail1.jpg'),
(33, 'images/products/product_33_detail2.jpg'),
(34, 'images/products/product_34_detail1.jpg'),
(34, 'images/products/product_34_detail2.jpg'),
(35, 'images/products/product_35_detail1.jpg'),
(35, 'images/products/product_35_detail2.jpg'),
(36, 'images/products/product_36_detail1.jpg'),
(36, 'images/products/product_36_detail2.jpg'),
(37, 'images/products/product_37_detail1.jpg'),
(37, 'images/products/product_37_detail2.jpg'),
(38, 'images/products/product_38_detail1.jpg'),
(38, 'images/products/product_38_detail2.jpg'),
(39, 'images/products/product_39_detail1.jpg'),
(39, 'images/products/product_39_detail2.jpg'),
(40, 'images/products/product_40_detail1.jpg'),
(40, 'images/products/product_40_detail2.jpg');


/* =======================
   USEFUL QUERIES (reference)
   ======================= */
-- 1. Lấy tất cả sản phẩm
-- SELECT * FROM Products

-- 2. Lấy chi tiết 1 sản phẩm
-- SELECT * FROM Products WHERE productId = ?;

-- 3. Lọc theo danh mục (PC / Laptop)
-- SELECT * FROM Products WHERE categoryId = ?;

-- 4. Lọc theo hãng
-- SELECT * FROM Products WHERE brandId = ?;

-- 5. Lọc theo giá
-- SELECT * FROM Products WHERE price BETWEEN ? AND ?;

-- 6. Tìm kiếm theo tên
-- SELECT * FROM Products WHERE name LIKE N'%' + ? + '%';

-- 7. Sắp xếp giá tăng dần
-- SELECT * FROM Products ORDER BY price ASC;

-- 8. Sắp xếp bán chạy
-- SELECT * FROM Products ORDER BY soldCount DESC;

-- 9. Lấy ảnh phụ của sản phẩm
-- SELECT imageUrl FROM ProductImages WHERE productId = ?;

-- 10. Lấy đánh giá sản phẩm
-- SELECT r.rating, r.comment, u.username
-- FROM Reviews r JOIN Users u ON r.userId = u.userId WHERE r.productId = ?;


/* =======================
   ROLLBACK: Xóa sản phẩm 31-40 (chạy khi cần)
   ======================= */
/*
DELETE FROM ProductImages WHERE productId BETWEEN 31 AND 40;
DELETE FROM Reviews WHERE productId BETWEEN 31 AND 40;
DELETE FROM CartItems WHERE productId BETWEEN 31 AND 40;
DELETE FROM OrderDetails WHERE productId BETWEEN 31 AND 40;
DELETE FROM Products WHERE productId > 30;
*/

select *
from Orders 
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 2500000, 'BANK', 'COMPLETED', '2026-01-05 10:30:00'),
(2, 1800000, 'COD', 'COMPLETED', '2026-01-12 14:20:00'),
(1, 3200000, 'BANK', 'COMPLETED', '2026-01-18 09:15:00'),
(2, 2100000, 'COD', 'PENDING', '2026-01-25 16:45:00'),
(1, 2900000, 'BANK', 'COMPLETED', '2026-01-28 11:30:00');
 
-- Tháng 2: Thấp (Tết)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 3500000, 'BANK', 'COMPLETED', '2026-02-03 13:20:00'),
(1, 2800000, 'COD', 'COMPLETED', '2026-02-10 10:45:00'),
(2, 4200000, 'BANK', 'COMPLETED', '2026-02-15 15:30:00'),
(1, 3100000, 'COD', 'COMPLETED', '2026-02-20 12:15:00'),
(2, 3800000, 'BANK', 'PENDING', '2026-02-25 17:20:00');
 
-- Tháng 3: Trung bình (hậu Tết)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 4500000, 'BANK', 'COMPLETED', '2026-03-02 14:10:00'),
(2, 5200000, 'COD', 'COMPLETED', '2026-03-08 09:40:00'),
(1, 4800000, 'BANK', 'COMPLETED', '2026-03-14 16:25:00'),
(2, 5500000, 'COD', 'COMPLETED', '2026-03-19 11:50:00'),
(1, 6200000, 'BANK', 'COMPLETED', '2026-03-25 13:35:00');
 
-- Tháng 4: Trung bình (đầu mùa hè)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 6800000, 'BANK', 'COMPLETED', '2026-04-03 15:45:00'),
(1, 7200000, 'COD', 'COMPLETED', '2026-04-09 12:20:00'),
(2, 6500000, 'BANK', 'COMPLETED', '2026-04-15 10:15:00'),
(1, 7800000, 'COD', 'COMPLETED', '2026-04-20 14:40:00'),
(2, 8200000, 'BANK', 'COMPLETED', '2026-04-26 09:25:00');
 
-- Tháng 5: Cao (mùa du lịch)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 8500000, 'BANK', 'COMPLETED', '2026-05-04 16:30:00'),
(2, 9200000, 'COD', 'COMPLETED', '2026-05-10 13:15:00'),
(1, 8800000, 'BANK', 'COMPLETED', '2026-05-16 11:45:00'),
(2, 9500000, 'COD', 'COMPLETED', '2026-05-22 15:20:00'),
(1, 10200000, 'BANK', 'COMPLETED', '2026-05-28 10:50:00');
 
-- Tháng 6: Cao (mùa hè)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 10800000, 'BANK', 'COMPLETED', '2026-06-05 14:20:00'),
(1, 11200000, 'COD', 'COMPLETED', '2026-06-11 09:55:00'),
(2, 11800000, 'BANK', 'COMPLETED', '2026-06-17 16:10:00'),
(1, 12500000, 'COD', 'COMPLETED', '2026-06-23 13:40:00'),
(2, 13200000, 'BANK', 'PENDING', '2026-06-29 17:25:00');
 
-- Tháng 7: Rất cao (mùa sale)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 13500000, 'BANK', 'COMPLETED', '2026-07-02 15:10:00'),
(2, 14200000, 'COD', 'COMPLETED', '2026-07-08 12:45:00'),
(1, 14800000, 'BANK', 'COMPLETED', '2026-07-14 10:30:00'),
(2, 15500000, 'COD', 'COMPLETED', '2026-07-20 14:15:00'),
(1, 16200000, 'BANK', 'COMPLETED', '2026-07-26 09:50:00');
 
-- Tháng 8: Rất cao (đầu năm học)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 16800000, 'BANK', 'COMPLETED', '2026-08-03 16:25:00'),
(1, 17200000, 'COD', 'COMPLETED', '2026-08-09 13:00:00'),
(2, 17800000, 'BANK', 'COMPLETED', '2026-08-15 11:35:00'),
(1, 18500000, 'COD', 'COMPLETED', '2026-08-21 15:20:00'),
(2, 19200000, 'BANK', 'COMPLETED', '2026-08-27 10:45:00');
 
-- Tháng 9: Cao (hạ nhiệt)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 15800000, 'BANK', 'COMPLETED', '2026-09-04 14:50:00'),
(2, 16500000, 'COD', 'COMPLETED', '2026-09-10 12:25:00'),
(1, 15200000, 'BANK', 'COMPLETED', '2026-09-16 09:10:00'),
(2, 14800000, 'COD', 'COMPLETED', '2026-09-22 16:40:00'),
(1, 14200000, 'BANK', 'PENDING', '2026-09-28 13:15:00');
 
-- Tháng 10: Cao (mùa lễ)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 13800000, 'BANK', 'COMPLETED', '2026-10-05 15:30:00'),
(1, 14500000, 'COD', 'COMPLETED', '2026-10-11 11:05:00'),
(2, 15200000, 'BANK', 'COMPLETED', '2026-10-17 14:45:00'),
(1, 15800000, 'COD', 'COMPLETED', '2026-10-23 10:20:00'),
(2, 16500000, 'BANK', 'COMPLETED', '2026-10-29 16:55:00');
 
-- Tháng 11: Rất cao (Black Friday)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 17500000, 'BANK', 'COMPLETED', '2026-11-04 13:40:00'),
(2, 18200000, 'COD', 'COMPLETED', '2026-11-10 09:15:00'),
(1, 18800000, 'BANK', 'COMPLETED', '2026-11-16 15:25:00'),
(2, 19500000, 'COD', 'COMPLETED', '2026-11-22 12:50:00'),
(1, 20200000, 'BANK', 'COMPLETED', '2026-11-28 17:10:00');
 
-- Tháng 12: Cao nhất (Giáng sinh)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 21000000, 'BANK', 'COMPLETED', '2026-12-03 14:20:00'),
(1, 21800000, 'COD', 'COMPLETED', '2026-12-09 10:55:00'),
(2, 22500000, 'BANK', 'COMPLETED', '2026-12-15 16:30:00'),
(1, 23200000, 'COD', 'COMPLETED', '2026-12-21 13:15:00'),
(2, 24000000, 'BANK', 'PENDING', '2026-12-28 17:45:00');
 
-- Thêm một số orders CANCEL để đa dạng
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 3200000, 'COD', 'CANCEL', '2026-03-15 14:20:00'),
(2, 4500000, 'BANK', 'CANCEL', '2026-05-20 10:15:00'),
(1, 5800000, 'COD', 'CANCEL', '2026-07-25 16:45:00'),
(2, 7200000, 'BANK', 'CANCEL', '2026-09-30 11:30:00'),
(1, 8500000, 'COD', 'CANCEL', '2026-11-15 14:50:00');

select *
from Products


select *
from Users

-- Kiem tra ton kho
select stock from Products

SELECT od.*, p.productId, p.name as productName, p.description as productDesc, 
p.price as productPrice, p.stock as productStock, p.images as productImage 
FROM OrderDetails od 
LEFT JOIN Products p ON od.productId = p.productId 
WHERE od.orderId = 67 
ORDER BY od.orderDetailId

select * from Orders where userId = 3

select * from Orders where 