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

DELIMITER ;