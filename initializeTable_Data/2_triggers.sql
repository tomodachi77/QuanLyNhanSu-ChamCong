DELIMITER //

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

DELIMITER ;