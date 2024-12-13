DELIMITER //

-- Trigger sau khi thêm nhân viên
drop TRIGGER update_employee_count_after_insert;
CREATE TRIGGER update_employee_count_after_insert 
AFTER INSERT ON NhanVien
FOR EACH ROW
BEGIN
    UPDATE soluongnhanvien 
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
DROP TRIGGER IF EXISTS update_employee_count_after_update;
CREATE TRIGGER update_employee_count_after_update
AFTER UPDATE ON NhanVien
FOR EACH ROW
BEGIN
    -- Nếu phòng ban của nhân viên thay đổi, cập nhật số lượng nhân viên ở phòng ban cũ và mới
    IF OLD.MaPhongBan != NEW.MaPhongBan THEN
        -- Giảm số lượng nhân viên ở phòng ban cũ
        UPDATE PhongBan
        SET SoLuongNhanVien = SoLuongNhanVien - 1
        WHERE MaPhongBan = OLD.MaPhongBan;
        
        -- Tăng số lượng nhân viên ở phòng ban mới
        UPDATE PhongBan
        SET SoLuongNhanVien = SoLuongNhanVien + 1
        WHERE MaPhongBan = NEW.MaPhongBan;
    END IF;
END//

DELIMITER ;