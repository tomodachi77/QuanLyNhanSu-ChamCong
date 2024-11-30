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