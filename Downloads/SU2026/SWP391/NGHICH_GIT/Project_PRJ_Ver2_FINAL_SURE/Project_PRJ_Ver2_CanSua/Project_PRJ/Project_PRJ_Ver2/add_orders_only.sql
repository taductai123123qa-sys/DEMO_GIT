-- Script CHỈ THÊM orders fake cho dashboard
-- Sử dụng userId có sẵn: 1 (admin) và 2 (user1)

-- Tháng 1: Thấp (mùa đầu năm)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 2500000, 'BANK', 'COMPLETED', '2024-01-05 10:30:00'),
(2, 1800000, 'COD', 'COMPLETED', '2024-01-12 14:20:00'),
(1, 3200000, 'BANK', 'COMPLETED', '2024-01-18 09:15:00'),
(2, 2100000, 'COD', 'PENDING', '2024-01-25 16:45:00'),
(1, 2900000, 'BANK', 'COMPLETED', '2024-01-28 11:30:00');

-- Tháng 2: Thấp (Tết)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 3500000, 'BANK', 'COMPLETED', '2024-02-03 13:20:00'),
(1, 2800000, 'COD', 'COMPLETED', '2024-02-10 10:45:00'),
(2, 4200000, 'BANK', 'COMPLETED', '2024-02-15 15:30:00'),
(1, 3100000, 'COD', 'COMPLETED', '2024-02-20 12:15:00'),
(2, 3800000, 'BANK', 'PENDING', '2024-02-25 17:20:00');

-- Tháng 3: Trung bình (hậu Tết)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 4500000, 'BANK', 'COMPLETED', '2024-03-02 14:10:00'),
(2, 5200000, 'COD', 'COMPLETED', '2024-03-08 09:40:00'),
(1, 4800000, 'BANK', 'COMPLETED', '2024-03-14 16:25:00'),
(2, 5500000, 'COD', 'COMPLETED', '2024-03-19 11:50:00'),
(1, 6200000, 'BANK', 'COMPLETED', '2024-03-25 13:35:00');

-- Tháng 4: Trung bình (đầu mùa hè)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 6800000, 'BANK', 'COMPLETED', '2024-04-03 15:45:00'),
(1, 7200000, 'COD', 'COMPLETED', '2024-04-09 12:20:00'),
(2, 6500000, 'BANK', 'COMPLETED', '2024-04-15 10:15:00'),
(1, 7800000, 'COD', 'COMPLETED', '2024-04-20 14:40:00'),
(2, 8200000, 'BANK', 'COMPLETED', '2024-04-26 09:25:00');

-- Tháng 5: Cao (mùa du lịch)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 8500000, 'BANK', 'COMPLETED', '2024-05-04 16:30:00'),
(2, 9200000, 'COD', 'COMPLETED', '2024-05-10 13:15:00'),
(1, 8800000, 'BANK', 'COMPLETED', '2024-05-16 11:45:00'),
(2, 9500000, 'COD', 'COMPLETED', '2024-05-22 15:20:00'),
(1, 10200000, 'BANK', 'COMPLETED', '2024-05-28 10:50:00');

-- Tháng 6: Cao (mùa hè)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 10800000, 'BANK', 'COMPLETED', '2024-06-05 14:20:00'),
(1, 11200000, 'COD', 'COMPLETED', '2024-06-11 09:55:00'),
(2, 11800000, 'BANK', 'COMPLETED', '2024-06-17 16:10:00'),
(1, 12500000, 'COD', 'COMPLETED', '2024-06-23 13:40:00'),
(2, 13200000, 'BANK', 'PENDING', '2024-06-29 17:25:00');

-- Tháng 7: Rất cao (mùa sale)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 13500000, 'BANK', 'COMPLETED', '2024-07-02 15:10:00'),
(2, 14200000, 'COD', 'COMPLETED', '2024-07-08 12:45:00'),
(1, 14800000, 'BANK', 'COMPLETED', '2024-07-14 10:30:00'),
(2, 15500000, 'COD', 'COMPLETED', '2024-07-20 14:15:00'),
(1, 16200000, 'BANK', 'COMPLETED', '2024-07-26 09:50:00');

-- Tháng 8: Rất cao (đầu năm học)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 16800000, 'BANK', 'COMPLETED', '2024-08-03 16:25:00'),
(1, 17200000, 'COD', 'COMPLETED', '2024-08-09 13:00:00'),
(2, 17800000, 'BANK', 'COMPLETED', '2024-08-15 11:35:00'),
(1, 18500000, 'COD', 'COMPLETED', '2024-08-21 15:20:00'),
(2, 19200000, 'BANK', 'COMPLETED', '2024-08-27 10:45:00');

-- Tháng 9: Cao (hạ nhiệt)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 15800000, 'BANK', 'COMPLETED', '2024-09-04 14:50:00'),
(2, 16500000, 'COD', 'COMPLETED', '2024-09-10 12:25:00'),
(1, 15200000, 'BANK', 'COMPLETED', '2024-09-16 09:10:00'),
(2, 14800000, 'COD', 'COMPLETED', '2024-09-22 16:40:00'),
(1, 14200000, 'BANK', 'PENDING', '2024-09-28 13:15:00');

-- Tháng 10: Cao (mùa lễ)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 13800000, 'BANK', 'COMPLETED', '2024-10-05 15:30:00'),
(1, 14500000, 'COD', 'COMPLETED', '2024-10-11 11:05:00'),
(2, 15200000, 'BANK', 'COMPLETED', '2024-10-17 14:45:00'),
(1, 15800000, 'COD', 'COMPLETED', '2024-10-23 10:20:00'),
(2, 16500000, 'BANK', 'COMPLETED', '2024-10-29 16:55:00');

-- Tháng 11: Rất cao (Black Friday)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 17500000, 'BANK', 'COMPLETED', '2024-11-04 13:40:00'),
(2, 18200000, 'COD', 'COMPLETED', '2024-11-10 09:15:00'),
(1, 18800000, 'BANK', 'COMPLETED', '2024-11-16 15:25:00'),
(2, 19500000, 'COD', 'COMPLETED', '2024-11-22 12:50:00'),
(1, 20200000, 'BANK', 'COMPLETED', '2024-11-28 17:10:00');

-- Tháng 12: Cao nhất (Giáng sinh)
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(2, 21000000, 'BANK', 'COMPLETED', '2024-12-03 14:20:00'),
(1, 21800000, 'COD', 'COMPLETED', '2024-12-09 10:55:00'),
(2, 22500000, 'BANK', 'COMPLETED', '2024-12-15 16:30:00'),
(1, 23200000, 'COD', 'COMPLETED', '2024-12-21 13:15:00'),
(2, 24000000, 'BANK', 'PENDING', '2024-12-28 17:45:00');

-- Thêm một số orders CANCEL để đa dạng
INSERT INTO Orders (userId, totalAmount, paymentMethod, status, createdAt) VALUES
(1, 3200000, 'COD', 'CANCEL', '2024-03-15 14:20:00'),
(2, 4500000, 'BANK', 'CANCEL', '2024-05-20 10:15:00'),
(1, 5800000, 'COD', 'CANCEL', '2024-07-25 16:45:00'),
(2, 7200000, 'BANK', 'CANCEL', '2024-09-30 11:30:00'),
(1, 8500000, 'COD', 'CANCEL', '2024-11-15 14:50:00');

PRINT '========================================';
PRINT '    DA THEM ORDERS FAKE THANH CONG!';
PRINT '========================================';
PRINT '';
PRINT '📊 Thong ke:';
PRINT '  - 60 orders cho 12 thang nam 2024';
PRINT '  - Doanh thu tang tu 12.5M -> 112.5M/thang';
PRINT '  - Status: 55 COMPLETED (92%), 5 PENDING (8%), 5 CANCEL (8%)';
PRINT '  - Su dung userId co san: 1=admin, 2=user1';
PRINT '';
PRINT '🎉 Dashboard se rat dep voi data nay!';
PRINT '';
PRINT '🚀 Hay restart web application va test!';
