-- Dữ liệu cho bảng companies
INSERT INTO companies (company_id, company_name, parent_company_id, created_at, updated_at) VALUES
(1, 'Công ty TNHH Sản Xuất ABC', NULL, '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(2, 'Công ty TNHH Sản Xuất ABC - Chi nhánh Hà Nội', 1, '2025-01-02 00:00:00', '2025-01-02 00:00:00'),
(3, 'Công ty TNHH Sản Xuất ABC - Chi nhánh TP.HCM', 1, '2025-01-03 00:00:00', '2025-01-03 00:00:00'),
(4, 'Công ty Cổ phần Đầu Tư XYZ', NULL, '2025-01-04 00:00:00', '2025-01-04 00:00:00'),
(5, 'Công ty Cổ phần Đầu Tư XYZ - Chi nhánh Đà Nẵng', 4, '2025-01-05 00:00:00', '2025-01-05 00:00:00');

-- Dữ liệu cho bảng departments
INSERT INTO departments (department_id, company_id, department_name, created_at, updated_at) VALUES
(1, 1, 'Phòng Kế toán', '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(2, 1, 'Phòng Kinh doanh', '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(3, 2, 'Phòng Sản xuất', '2025-01-02 00:00:00', '2025-01-02 00:00:00'),
(4, 3, 'Phòng R&D', '2025-01-03 00:00:00', '2025-01-03 00:00:00'),
(5, 4, 'Phòng Nhân sự', '2025-01-04 00:00:00', '2025-01-04 00:00:00'),
(6, 5, 'Phòng Marketing', '2025-01-05 00:00:00', '2025-01-05 00:00:00');

-- Dữ liệu cho bảng activities
INSERT INTO activities (activity_id, department_id, activity_type, activity_name, activity_value, activity_date, created_at, updated_at) VALUES
(1, 1, 'electricity', 'Tiêu thụ điện văn phòng', 1000, '2025-03-01 08:30:00', '2025-03-01 08:30:00', '2025-03-01 08:30:00'),
(2, 2, 'diesel', 'Tiêu thụ nhiên liệu xe', 500, '2025-03-01 09:00:00', '2025-03-01 09:00:00', '2025-03-01 09:00:00'),
(3, 3, 'electricity', 'Tiêu thụ điện xưởng sản xuất', 2000, '2025-03-01 10:00:00', '2025-03-01 10:00:00', '2025-03-01 10:00:00'),
(4, 4, 'diesel', 'Tiêu thụ nhiên liệu máy móc R&D', 300, '2025-03-01 11:00:00', '2025-03-01 11:00:00', '2025-03-01 11:00:00'),
(5, 5, 'electricity', 'Tiêu thụ điện trụ sở', 800, '2025-03-01 12:00:00', '2025-03-01 12:00:00', '2025-03-01 12:00:00'),
(6, 6, 'diesel', 'Tiêu thụ nhiên liệu Marketing', 600, '2025-03-01 13:00:00', '2025-03-01 13:00:00', '2025-03-01 13:00:00');

-- Dữ liệu cho bảng emission_factors
INSERT INTO emission_factors (activity_type, emission_factor_value, created_at, updated_at) VALUES
('điện', 0.5, '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
('dầu diesel', 2.68, '2025-01-01 00:00:00', '2025-01-01 00:00:00');
