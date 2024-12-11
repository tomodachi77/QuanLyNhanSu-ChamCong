DELIMITER //
CREATE TRIGGER IF NOT EXISTS checkChiNhanhFormat
BEFORE INSERT on ChiNhanh
FOR EACH ROW
BEGIN 
    IF NEW.MaChiNhanh NOT REGEXP '^CN[0-9]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã chi nhánh phải ở định dạng CNxx, với xx là hai chữ số bất kỳ';
    END IF;

    IF NEW.TenChiNhanh NOT REGEXP '^[[:alnum:][:space:].,\\-]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên chi nhánh không được chứa ký tự đặc biệt';
    END IF;

    IF NEW.DiaChi NOT REGEXP '^[[:alnum:][:space:].,\\-]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Địa chỉ không được chứa ký tự đặc biệt';
    END IF;
END //

CREATE TRIGGER IF NOT EXISTS checkPhongBanFormat
BEFORE INSERT on PhongBan
FOR EACH ROW
BEGIN 
    IF NEW.MaPhongBan NOT REGEXP '^PB[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phòng ban phải ở định dạng PBxxxx, với xxxx là bốn chữ số bất kỳ';
    END IF;

    IF NEW.TenPhongBan NOT REGEXP '^[[:alnum:][:space:].,\\-]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên phòng ban không được chứa ký tự đặc biệt';
    END IF;
END //

CREATE Trigger if NOT EXISTS checkSdtFormat 
BEFORE INSERT ON Sdt_NhanVien
FOR EACH ROW
BEGIN 
    IF NEW.SoDienThoai NOT REGEXP '^0[0-9]{9}' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại phải có chính xác 10 chữ số';
    END IF;
END //

-- Trigger sau khi thêm nhân viên
CREATE TRIGGER update_employee_count_after_insert 
AFTER INSERT ON NhanVien
FOR EACH ROW
BEGIN
    UPDATE PhongBan 
    SET SoLuongNhanVien = SoLuongNhanVien + 1
    WHERE MaPhongBan = NEW.MaPhongBan;
END //

-- Trigger sau khi xóa nhân viên
CREATE TRIGGER update_employee_count_after_delete
AFTER DELETE ON NhanVien
FOR EACH ROW
BEGIN
    UPDATE PhongBan 
    SET SoLuongNhanVien = SoLuongNhanVien - 1
    WHERE MaPhongBan = OLD.MaPhongBan;
END //

CREATE TRIGGER update_total_hours_after_insert
AFTER INSERT ON LanRaVao
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5, 2);
    SET total_hours = TIMESTAMPDIFF(MINUTE, NEW.GioVao, NEW.GioRa) / 60;
    
    UPDATE BangChamCong
    SET TongSoGioLam = COALESCE(TongSoGioLam, 0) + total_hours
    WHERE MaNV = NEW.MaNV AND Ngay = NEW.Ngay;
END //

CREATE TRIGGER update_total_hours_after_delete
AFTER DELETE ON LanRaVao
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5, 2);
    SET total_hours = TIMESTAMPDIFF(MINUTE, OLD.GioVao, OLD.GioRa) / 60;
    
    UPDATE BangChamCong
    SET TongSoGioLam = COALESCE(TongSoGioLam, 0) - total_hours
    WHERE MaNV = OLD.MaNV AND Ngay = OLD.Ngay;
END //

-- DELIMITER ;