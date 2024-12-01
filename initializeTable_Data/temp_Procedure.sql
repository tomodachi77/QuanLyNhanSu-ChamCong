DELIMITER //

CREATE PROCEDURE IF NOT EXISTS insert_ChiNhanh (MaChiNhanh CHAR(4), TenChiNhanh NVARCHAR(100), DiaChi NVARCHAR(200), MSNV_QuanLy CHAR(6))
BEGIN
    INSERT INTO chinhanh VALUES (MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy);
END //

DELIMITER;