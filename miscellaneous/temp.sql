-- DELIMITER //
--     CREATE FUNCTION IF NOT EXISTS is_fullTime (MaNV CHAR(6)) 
--     RETURNS BOOLEAN DETERMINISTIC
--     BEGIN
--         IF MaNV IN (SELECT nhanvientoanthoigian.`MaNV` from nhanvientoanthoigian) THEN RETURN TRUE;
--         ELSE RETURN FALSE;
--         END IF;
--     END;
-- DELIMITER;

SELECT `MaNV`, `is_fullTime`(`MaNV`) FROM nhanvien;


-- {"GioBatDau": "08:00:00", "GioKetThuc": "12:00:00"}, {"GioBatDau": "13:00:00", "GioKetThuc": "17:00:00"}
-- {"GioBatDau": @GioBatDau, "GioKetThuc": @GioKetThuc}
-- DROP FUNCTION get_schedule;

--     CREATE FUNCTION IF NOT EXISTS get_schedule (MaNV Char(6), NgayLamViec Date) RETURNS JSON DETERMINISTIC
--     BEGIN
--         IF MaNV IN (SELECT nhanvientoanthoigian.`MaNV` from nhanvientoanthoigian) 
--             THEN RETURN '{"GioBatDau": "08:00:00", "GioKetThuc": "17:00:00"}';
--         ELSE 
--             BEGIN 
--                 set @GioBatDau = (SELECT lichlamviec.`GioBatDau` FROM lichlamviec WHERE lichlamviec.`MaNV`=MaNV AND lichlamviec.`Ngay`=NgayLamViec);
--                 set @GioKetThuc = (SELECT lichlamviec.`GioKetThuc` FROM lichlamviec WHERE lichlamviec.`MaNV`=MaNV AND lichlamviec.`Ngay`=NgayLamViec);
--                 RETURN '{"GioBatDau": @GioBatDau, "GioKetThuc": @GioBatDau}';
--             END;
--         END IF; 
--     END; 
-- DELIMITER;

SELECT * from lichlamviec WHERE `MaNV` = 'NV8232' AND `Ngay`='2024-11-04';

SELECT `MaNV`, get_schedule(nhanvien.`MaNV`, '2024-11-04') from nhanvien
LIMIT 5;

SELECT * FROM nhanvienbanthoigian WHERE `MaNV`='NV8232';

CREATE OR REPLACE VIEW SoLuongNhanVien (`MaPhongBan`, `SoLuongNhanVien`)
AS SELECT `MaPhongBan`, COUNT(`MaNV`) FROM quanlynhansu.nhanvien GROUP BY `MaPhongBan`;

SELECT * FROM soluongnhanvien WHERE soluongnhanvien.`MaPhongBan`='PB0106';

INSERT INTO NhanVien (MaNV, Ho, TenLot, Ten, GioiTinh, Email, LuongTheoGio, MaPhongBan)
VALUES
    ('NV8059', 'Văn', 'Phú', 'Ân', 'Nam', 'vanphuan2@gmail.com', 90000, 'PB0106');

-- CREATE TABLE ChiNhanh (
--     MaChiNhanh CHAR(4) PRIMARY KEY,
--     TenChiNhanh NVARCHAR(100) NOT NULL,
--     DiaChi NVARCHAR(200) NOT NULL,
--     MSNV_QuanLy CHAR(6)
--     -- Sau khi đã import đủ data thì thêm thuộc tính khóa ngoại và cập nhật NV quản lý
-- );
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS insert_ChiNhanh (MaChiNhanh CHAR(4), TenChiNhanh NVARCHAR(100), DiaChi NVARCHAR(200), MSNV_QuanLy CHAR(6))
BEGIN
    INSERT INTO chinhanh VALUES (MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy)
END; //

DELIMITER ;

SELECT * FROM chinhanh;
CALL `insert_ChiNhanh`('CN05', 'Chi Nhánh Bình Thạnh', '123, Đường Phạm Ngũ Lão, Phường 12, Quận Bình Thạnh, Thành phố Hồ Chí Minh', 'NV1271');

DELETE FROM chinhanh WHERE chinhanh.`MaChiNhanh`='CN05';

-- SELECT  FROM chinhanh NATURAL INNER JOIN nhanvientoanthoigian NATURAL INNER JOIN nhanvien;
-- SELECT `MaChiNhanh`, `TenChiNhanh`, `DiaChi`, nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`,' ', nhanvien.`TenLot`,' ', nhanvien.`Ten`) as 'TenQuanLy' from chinhanh JOIN nhanvien ON chinhanh.`MSNV_QuanLy`=nhanvien.`MaNV`;


SELECT `MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as 'TenNhanVien' from nhanvientoanthoigian NATURAL INNER JOIN nhanvien ORDER BY `MaNV`;

-- NV1108	Bùi	Bích	Như	Nam	buibichnhu@gmail.com	1.00	1.00	12	25000.00	PB0403
-- INSERT INTO NhanVien (MaNV, Ho, TenLot, Ten, GioiTinh, Email, HeSoPhatDiTre, HeSoPhatVangKhongPhep, SoNgayNghi, LuongTheoGio, MaPhongBan)
CALL `ThemNhanVien`('NV0234', "Tran", "Anh", "Khoi", "Nam", "trananhkhoitv@gmail.com", 0.5, 0.5, 12, 40000, "PB0302"); 

-- Tham số ban đầu là ngày bắt đầu và ngày kết thúc tính lương + MaNV
-- loop qua từng ngày trong bảng ngày chấm công, tính tổng luongngay theo từng nhân viên

SELECT * from quanlynhansu.bangchamcong LIMIT 20;