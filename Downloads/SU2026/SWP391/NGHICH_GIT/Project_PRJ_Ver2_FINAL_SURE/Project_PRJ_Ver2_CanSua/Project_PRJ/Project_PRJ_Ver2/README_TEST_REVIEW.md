# Hướng Dẫn Test Tính Năng Review

## Chuẩn Bị
1. **Chạy database**: Đảm bảo SQL Server đang chạy
2. **Tạo database**: Chạy `TTGShop8_Database.sql` để tạo bảng
3. **Thêm dữ liệu mẫu**: Chạy `run_sample_reviews.bat` để thêm review mẫu

## Các Bước Test

### 1. Kiểm Tra Hiển Thị Review
1. Start ứng dụng web
2. Truy cập: `http://localhost:8080/Project_PRJ_Ver2/productdetail?id=33`
3. **Kết quả mong muốn**:
   - Hiển thị 3 review mẫu
   - Rating breakdown với progress bars
   - Average rating: 4.67 sao
   - Total reviews: 3

### 2. Kiểm Tra Logic Review (Đã Đăng Nhập)
1. Đăng nhập với user: `user1` / `user123`
2. Vào trang sản phẩm 33
3. **Kết quả mong muốn**:
   - Hiển thị form đánh giá
   - Message: "Bạn chỉ có thể đánh giá khi đã mua sản phẩm này" (vì chưa có đơn hàng)

### 3. Kiểm Tra Logic Review (Chưa Đăng Nhập)
1. Logout (hoặc dùng trình duyệt ẩn danh)
2. Vào trang sản phẩm 33
3. **Kết quả mong muốn**:
   - Message: "Bạn cần đăng nhập để gửi đánh giá"
   - Không hiển thị form đánh giá

### 4. Test Các Sản Phẩm Khác
- Product 34: 2 reviews
- Product 35: 2 reviews
- Product khác (không có review): "Chưa có đánh giá nào"

## Files Đã Sửa
✅ `ProductDetailServlet.java` - Thêm logic review
✅ `ReviewDAO.java` - Thêm RatingBreakdown và methods
✅ `ReviewService.java` - Thêm methods
✅ `Product.jsp` - Thêm UI review và rating breakdown

## Troubleshooting
- **Lỗi compilation**: Kiểm tra import và method names
- **Không hiển thị review**: Kiểm tra database connection
- **Form không hiện**: Kiểm tra session và login status
- **Rating breakdown lỗi**: Kiểm tra class RatingBreakdown

## Database Tables Required
- `Users` (đã có user1, admin)
- `Products` (đã có sản phẩm 33-35)
- `Reviews` (thêm bằng sample_reviews.sql)
- `Orders` và `OrderDetails` (để test logic đã mua hàng)
