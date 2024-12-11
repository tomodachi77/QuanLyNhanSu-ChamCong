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
        WHERE MaNV = calculateTotalHours.MaNV
    ) THEN
        RETURN -1; -- Invalid employee ID
    END IF;

    -- Validate the date range
    IF ngayBatDau IS NULL OR ngayKetThuc IS NULL OR ngayBatDau > ngayKetThuc THEN
        RETURN -2; -- Invalid date range
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

DROP FUNCTION if EXISTS tonggiolamviec //
Create Function tonggiolamviec (MaNV CHAR(6), ngayBatDau DATE, ngayKetThuc DATE) RETURNS DECIMAL(5, 2) DETERMINISTIC
BEGIN
    DECLARE total_time DECIMAL(5, 2);
    SET total_time = (SELECT SUM(bangchamcong.`TongSoGioLam`)
    from bangchamcong 
    WHERE bangchamcong.`MaNV`=MaNV AND 
    bangchamcong.`TongSoGioLam` IS NOT NULL AND
    bangchamcong.`Ngay` BETWEEN ngayBatDau AND ngayKetThuc
    GROUP BY bangchamcong.`MaNV`);
    return total_time;
END //

DELIMITER ;

-- TEST
-- SELECT `tinhLuong`(
--     'NV1108',
--     '2024-11-01',
--     '2024-11-30'
-- );

-- SELECT Manv, sum(`TongSoGioLam`*`LuongTheoGio`)
--         FROM bangchamcong NATURAL INNER JOIN nhanvien
--         WHERE nhanvien.MaNV = 'NV1108' AND `Ngay` BETWEEN '2024-11-01' AND '2024-11-30' AND bangchamcong.`TongSoGioLam` is not null
--         GROUP BY `MaNV`;

-- select `MaNV`, SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(`GioRa`, `GioVao`)))) from lanravao 
-- WHERE `GioVao` > '17:00:00' AND `MaNV`='NV6036' AND `Ngay` BETWEEN '2024-10-01' AND '2024-11-30' 
-- GROUP BY `MaNV`;

-- SELECT `KiemTraTangCa`('NV6036', '2024-10-01', '2024-11-30', '08:00:00');
