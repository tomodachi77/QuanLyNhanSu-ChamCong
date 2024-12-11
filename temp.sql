SELECT * FROM nhanvien;

-- DELIMITER \\

-- CREATE PROCEDURE doiterate(p1 INT) 
-- BEGIN
--     label1: LOOP
--         SET p1 = p1 + 1;
--         IF p1 < 10 THEN
--             ITERATE label1;
--         END IF;
--         LEAVE label1;
--     END LOOP label1;
--     set @x = p1;
-- END \\

-- DELIMITER ;

-- -- DECLARE @x INT;
-- CALL doiterate(3);
-- SELECT @x;

-- DROP Procedure quanlynhansu.doiterate;

set @salary = (SELECT `TongSoGioLam`*`LuongTheoGio` AS 'LuongNgay' FROM bangchamcong NATURAL INNER JOIN nhanvien WHERE `MaNV`='NV1108' AND `Ngay`='2024-11-27');
SELECT @salary;

-- SELECT `MaNV`, `Ngay`, `TongSoGioLam`, `LuongTheoGio`, `TongSoGioLam`*`LuongTheoGio` AS 'LuongNgay' FROM bangchamcong NATURAL INNER JOIN nhanvien
-- WHERE `MaNV`='NV1108' AND `Ngay`='2024-11-27';

-- SELECT `TongSoGioLam`*`LuongTheoGio` AS 'LuongNgay' FROM bangchamcong NATURAL INNER JOIN nhanvien
-- WHERE `MaNV`='NV1108' AND `Ngay`='2024-11-27';

-- DELIMITER //
-- CREATE FUNCTION tinhLuong (MaNV CHAR(6), ngayBatDau DATE, ngayKetThuc DATE) RETURNS INT
-- BEGIN
--     IF MaNV is NULL OR NOT EXISTS (
--         select 1 FROM nhanvien WHERE nhanvien.`MaNV` = `MaNV`
--     ) THEN
--         RETURN -1;
--     END IF;

--     DECLARE luong INT DEFAULT 0;
--     DECLARE current_workingDate DATE;
--     DECLARE current_luong INT;

--     DECLARE WorkDay_CURSOR CURSOR FOR
--         SELECT 'Ngay', 'LuongNgay' FROM nhanvien NATURAL INNER JOIN bangchamcong WHERE nhanvien.`MaNV`=`MaNV`;

--     OPEN WorkDay_CURSOR;

--     read_loop: LOOP
--         FETCH WorkDay_CURSOR INTO current_workingDate, current_luong;

--         IF current_workingDate IS NULL THEN
--             LEAVE read_loop;
--         END IF;

--         IF current_workingDate BETWEEN ngayBatDau AND ngayKetThuc THEN
--             SET luong = luong + current_luong;
--         END IF;
--     END LOOP;

--     CLOSE WorkDay_CURSOR;

--     return luong;
-- END //

-- DELIMITER ;

DELIMITER //
DROP FUNCTION IF EXISTS `tinhLuong` //
CREATE FUNCTION tinhLuong (MaNV CHAR(6), ngayBatDau DATE, ngayKetThuc DATE) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE luong INT DEFAULT 0;
    DECLARE current_workingDate DATE;
    DECLARE current_luong INT;
    DECLARE done INT DEFAULT 0;

    -- Declare a cursor to iterate through workdays and daily salaries
    DECLARE WorkDay_CURSOR CURSOR FOR
        SELECT `Ngay`, `TongSoGioLam`*`LuongTheoGio`
        FROM bangchamcong NATURAL INNER JOIN nhanvien
        WHERE nhanvien.MaNV = MaNV;

    -- Declare a handler for the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Input validation: Check if MaNV exists
    IF MaNV IS NULL OR NOT EXISTS (
        SELECT 1 
        FROM nhanvien 
        WHERE nhanvien.MaNV = MaNV
    ) THEN
        RETURN -1; -- Invalid employee ID
    END IF;

    -- Open the cursor
    OPEN WorkDay_CURSOR;

    -- Loop through the cursor
    read_loop: LOOP
        FETCH WorkDay_CURSOR INTO current_workingDate, current_luong;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Check if the working date is within the specified range
        IF (current_luong is NOT NULL) AND (current_workingDate BETWEEN ngayBatDau AND ngayKetThuc) THEN
            SET luong = luong + current_luong;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE WorkDay_CURSOR;

    RETURN luong;
END //

DELIMITER ;

SELECT `tinhLuong`(
    'NV1108',
    '2024-11-01',
    '2024-11-30'
);

SELECT Manv, sum(`TongSoGioLam`*`LuongTheoGio`)
        FROM bangchamcong NATURAL INNER JOIN nhanvien
        WHERE nhanvien.MaNV = 'NV1108' AND `Ngay` BETWEEN '2024-11-01' AND '2024-11-30' AND bangchamcong.`TongSoGioLam` is not null
        GROUP BY `MaNV`;

-- danh sánh nhân viên có tăng ca trong 1 quãng thời gian.

DELIMITER //
DROP Function if EXISTS KiemTraTangCa//
CREATE Function KiemTraTangCa (MaNV CHAR(6), NgayBatDau Date, NgayKetThuc Date, GioTangCaToiThieu TIME) RETURNS BOOLEAN DETERMINISTIC
BEGIN 
    DECLARE total_hours TIME DEFAULT 0;
    DECLARE current_gioTangCa TIME;
    DECLARE current_ngay DATE;
    DECLARE done INT DEFAULT 0;
    -- DECLARE 
    DECLARE nhungLanRaVao CURSOR FOR 
        SELECT TIMEDIFF(lanravao.`GioRa`, lanravao.`GioVao`), lanravao.`Ngay`
        FROM lanravao 
        WHERE `GioVao` > '17:00:00' AND lanravao.`MaNV` = `MaNV`;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    IF MaNV is NULL OR NOT EXISTS (SELECT 1 FROM nhanvientoanthoigian WHERE nhanvientoanthoigian.`MaNV` = `MaNV`) THEN 
        RETURN -1; -- MaNV rỗng hoặc MaNV không phải là NV toàn thời gian;
    END IF; 

    IF NgayBatDau IS NULL OR NgayKetThuc IS NULL OR (NgayKetThuc < NgayBatDau) THEN 
        RETURN -2; -- NgayBatDau hoặc NgayKetThuc rỗng hoặc phạm vi ngày không hợp lệ
    END IF;

    IF GioTangCaToiThieu IS NULL THEN
        RETURN -3; -- GioTangCaToiThieu rỗng
    END IF;

    OPEN nhungLanRaVao;

    read_loop: LOOP
        FETCH nhungLanRaVao into current_gioTangCa, current_ngay;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF current_ngay BETWEEN NgayBatDau AND NgayKetThuc THEN
            SET total_hours = ADDTIME(total_hours, current_gioTangCa);
        END IF;
    END LOOP;

    CLOSE nhungLanRaVao;

    return (total_hours >= GioTangCaToiThieu);
END //

DELIMITER ;

SELECT `KiemTraTangCa`(NULL, NULL, NULL, NULL);


SELECT * FROM nhanvientoanthoigian;
select `MaNV`, SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(`GioRa`, `GioVao`)))) from lanravao 
WHERE `GioVao` > '17:00:00' AND `MaNV`='NV6036' AND `Ngay` BETWEEN '2024-10-01' AND '2024-11-30' 
GROUP BY `MaNV`;

SELECT *, TIMEDIFF(`GioRa`, `GioVao`) FROM lanravao 
WHERE `GioVao` > '17:00:00' AND `MaNV`='NV6036' AND `Ngay` BETWEEN '2024-10-01' AND '2024-10-31';

-- KiemTraTangCa (MaNV CHAR(6), NgayBatDau Date, NgayKetThuc Date, GioTangCaToiThieu TIME)
SELECT `KiemTraTangCa`('NV6036', '2024-10-01', '2024-11-30', '08:00:00');