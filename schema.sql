-- Bảng companies: Lưu trữ thông tin công ty và cấu trúc cây của các công ty.
CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name NVARCHAR(255) NOT NULL,
    parent_company_id INT,
    CONSTRAINT fk_parent_company FOREIGN KEY (parent_company_id) REFERENCES companies(company_id)
);

-- Bảng departments: Lưu trữ thông tin phòng ban của từng công ty.
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    company_id INT NOT NULL,
    department_name NVARCHAR(255) NOT NULL,
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- Bảng activities: Lưu trữ các hoạt động của phòng ban.
CREATE TABLE activities (
    activity_id INT PRIMARY KEY,
    department_id INT NOT NULL,
    activity_type NVARCHAR(50) NOT NULL,
    activity_name NVARCHAR(255) NOT NULL,
    activity_value DECIMAL(10,2) NOT NULL,
    activity_date DATETIME NOT NULL,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Bảng emission_factors: Lưu trữ hệ số phát thải cho mỗi loại hoạt động.
CREATE TABLE emission_factors (
    activity_type NVARCHAR(50) PRIMARY KEY,
    emission_factor_value DECIMAL(10,2) NOT NULL
);
