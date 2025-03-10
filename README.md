# Carbon Accounting System

## Giới thiệu
Hệ thống quản lý carbon accounting hỗ trợ đa tenant, trong đó mỗi tenant là một công ty cấp cao và có thể có các công ty con, phòng ban, và các hoạt động phát thải. Mỗi hoạt động được gắn với một hệ số phát thải tương ứng.
## HƯỚNG TIẾP CẬN VÀ GIẢI QUYẾT BÀI TOÁN

**1. Phân tích yêu cầu:**

- **Hiểu bài toán:**  
  Hệ thống cần hỗ trợ nhiều tenant, với mỗi tenant là một công ty cấp cao (Level 0) có thể có các công ty con (subsidiaries). Mỗi công ty có các phòng ban, và các phòng ban thực hiện các hoạt động (activities) với thông tin gồm loại, tên, giá trị và ngày thực hiện. Hệ thống cũng cần quản lý bảng hệ số phát thải (emission_factors) để tính lượng CO2e từ các hoạt động đó.

- **Các yêu cầu chính:**
  - Thiết kế schema cho các bảng: companies, departments, activities, emission_factors.
  - Tính tổng lượng phát thải của một công ty (bao gồm các công ty con) theo ngày.
  - Xác định loại hoạt động tạo ra lượng phát thải cao nhất cho mỗi công ty.

**2. Thiết kế cơ sở dữ liệu:**

- **Bảng companies:**  
  Lưu trữ thông tin công ty và thiết lập mối quan hệ phân cấp thông qua trường `parent_company_id`. Điều này giúp dễ dàng xây dựng cấu trúc cây của các công ty con thuộc mỗi tenant.

- **Bảng departments:**  
  Liên kết phòng ban với công ty, cho phép quản lý các bộ phận bên trong mỗi công ty.

- **Bảng activities:**  
  Ghi nhận các hoạt động được thực hiện bởi các phòng ban, lưu trữ thông tin về loại, tên, giá trị và ngày thực hiện. Việc lưu trữ ngày thực hiện giúp hỗ trợ các báo cáo thời gian.

- **Bảng emission_factors:**  
  Lưu trữ hệ số phát thải cho từng loại hoạt động. Việc tách riêng bảng này giúp dễ dàng cập nhật và bảo trì hệ số mà không làm ảnh hưởng đến dữ liệu của các hoạt động.

**3. Giải pháp truy vấn và các quyết định quan trọng:**

- **Sử dụng CTE đệ quy:**  
  Để tính tổng lượng phát thải cho một công ty bao gồm các công ty con, tôi đã sử dụng CTE đệ quy nhằm truy xuất toàn bộ cây hệ thống công ty từ một tenant gốc. Điều này giúp giải quyết vấn đề số cấp độ không xác định của cây công ty.

- **Tính toán phát thải:**  
  Mỗi hoạt động được tính lượng phát thải thông qua công thức:  
  `activity_value * emission_factor_value`  
  Các kết quả sau đó được tổng hợp theo ngày và theo tenant (trong trường hợp mở rộng tính tổng cho tất cả các công ty).

- **Xác định loại hoạt động có lượng phát thải cao nhất:**  
  Sử dụng hàm cửa sổ (ROW_NUMBER) kết hợp với GROUP BY giúp xác định được activity_type với tổng phát thải cao nhất cho mỗi công ty.

- **Những lưu ý khi thiết kế:**  
  - **Khả năng mở rộng:** Thiết kế các bảng riêng biệt cho phép dễ dàng mở rộng và bảo trì khi hệ thống phát triển.
  - **Hiệu năng:** Sử dụng CTE đệ quy là một giải pháp mạnh mẽ cho các cấu trúc phân cấp, tuy nhiên cần chú ý khi số lượng công ty tăng lớn.
  - **Độ chính xác của dữ liệu:** Việc tách riêng bảng emission_factors đảm bảo rằng hệ số phát thải có thể được cập nhật độc lập mà không ảnh hưởng đến dữ liệu hoạt động.

**4. Kết luận:**

Qua việc phân tích yêu cầu và áp dụng các kỹ thuật SQL tiên tiến như CTE đệ quy và hàm cửa sổ, tôi đã xây dựng được một thiết kế cơ sở dữ liệu hiệu quả cho hệ thống carbon accounting đa tenant. Giải pháp này không chỉ đáp ứng các yêu cầu cơ bản của bài toán mà còn đảm bảo khả năng mở rộng và tính bảo trì cao, hỗ trợ việc phân tích dữ liệu theo nhiều chiều khác nhau (theo ngày, theo loại hoạt động, theo tenant).

## Cấu trúc Repository
carbon-accounting-system/
├── README.md
├── schema.sql
├── queries.sql
└── sample_data.sql

## Hướng dẫn chạy
1. Tạo database và thực hiện các câu lệnh trong file **schema.sql**.
2. Chạy file **sample_data.sql** để chèn dữ liệu mẫu.
3. Chạy các truy vấn trong file **queries.sql** để kiểm tra kết quả.

## Nhấn vào đây để đi tới thiết kế cơ sở dữ liệu của hệ thống (https://dbdiagram.io/d/67ceb96575d75cc8447cdaf0)

