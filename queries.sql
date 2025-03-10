-- a) Tính tổng lượng phát thải của một công ty (bao gồm công ty con) theo ngày
-- Sử dụng CTE đệ quy để lấy cây công ty từ một tenant cụ thể, ví dụ tenant có company_id = :given_company_id
WITH RECURSIVE company_tree AS (
    SELECT company_id 
    FROM companies 
    WHERE company_id = :given_company_id
    UNION ALL
    SELECT c.company_id
    FROM companies c
    INNER JOIN company_tree ct ON c.parent_company_id = ct.company_id
)

SELECT a.activity_date, SUM(a.activity_value * ef.emission_factor_value) AS total_emissions
FROM activities a
JOIN departments d ON a.department_id = d.department_id
JOIN company_tree ct ON d.company_id = ct.company_id
JOIN emission_factors ef ON a.activity_type = ef.activity_type
WHERE a.activity_date = '2025-03-01'
GROUP BY a.activity_date;

-- b) Xác định loại hoạt động tạo ra lượng phát thải cao nhất cho mỗi công ty
SELECT company_id, activity_type, total_emissions
FROM (
    SELECT 
        c.company_id,
        a.activity_type,
        SUM(a.activity_value * ef.emission_factor_value) AS total_emissions,
        ROW_NUMBER() OVER (
            PARTITION BY c.company_id 
            ORDER BY SUM(a.activity_value * ef.emission_factor_value) DESC
        ) AS rn
    FROM companies c
    JOIN departments d ON c.company_id = d.company_id
    JOIN activities a ON d.department_id = a.department_id
    JOIN emission_factors ef ON a.activity_type = ef.activity_type
    GROUP BY c.company_id, a.activity_type
) sub
WHERE rn = 1;

-- c) Truy vấn mở rộng: Tính tổng lượng phát thải của các công ty (bao gồm công ty con) theo ngày cho từng tenant
WITH RECURSIVE company_tree AS (
    -- Lấy tất cả các công ty gốc (tenant) và gán chính nó làm root
    SELECT 
        company_id, 
        company_name, 
        parent_company_id,
        company_id AS root_company_id
    FROM companies
    WHERE parent_company_id IS NULL

    UNION ALL

    -- Lấy các công ty con và truyền theo root_company_id của cha
    SELECT 
        c.company_id, 
        c.company_name, 
        c.parent_company_id,
        ct.root_company_id
    FROM companies c
    INNER JOIN company_tree ct ON c.parent_company_id = ct.company_id
)
SELECT 
    ct.root_company_id,
    t.company_name AS tenant_company_name,
    a.activity_date,
    SUM(a.activity_value * ef.emission_factor_value) AS total_emissions
FROM company_tree ct
JOIN departments d ON ct.company_id = d.company_id
JOIN activities a ON d.department_id = a.department_id
JOIN emission_factors ef ON a.activity_type = ef.activity_type
JOIN companies t ON ct.root_company_id = t.company_id
GROUP BY ct.root_company_id, t.company_name, a.activity_date
ORDER BY ct.root_company_id, a.activity_date;

