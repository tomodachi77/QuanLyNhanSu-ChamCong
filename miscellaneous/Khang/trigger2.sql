--Trigger để cập nhật tổng số giờ làm việc của nhân viên trong bảng BangChamCong khi có thay đổi trong bảng LanRaVao
DELIMITER //

CREATE TRIGGER update_total_hours_after_insert
AFTER INSERT ON LanRaVao
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5, 2);
    SET total_hours = TIMESTAMPDIFF(MINUTE, NEW.GioVao, NEW.GioRa) /60;
    
    UPDATE BangChamCong
    SET TongSoGioLam = COALESCE(TongSoGioLam, 0) + total_hours
    WHERE MaNV = NEW.MaNV AND Ngay = NEW.Ngay;
END;

CREATE TRIGGER update_total_hours_after_delete
AFTER DELETE ON LanRaVao
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5, 2);
    SET total_hours = TIMESTAMPDIFF(MINUTE, OLD.GioVao, OLD.GioRa) / 60;
    
    UPDATE BangChamCong
    SET TongSoGioLam = COALESCE(TongSoGioLam, 0) - total_hours
    WHERE MaNV = OLD.MaNV AND Ngay = OLD.Ngay;
END;
CREATE TRIGGER update_total_hours_after_update
AFTER UPDATE ON LanRaVao
FOR EACH ROW
BEGIN
    DECLARE total_hours DECIMAL(5, 2);
    DECLARE previous_hours DECIMAL(5, 2);
    SET previous_hours = TIMESTAMPDIFF(MINUTE, OLD.GioVao, OLD.GioRa) / 60;
    

    SET total_hours = TIMESTAMPDIFF(MINUTE, NEW.GioVao, NEW.GioRa) / 60;
    
   
    UPDATE BangChamCong
    SET TongSoGioLam = COALESCE(TongSoGioLam, 0) + total_hours - previous_hours
    WHERE MaNV = NEW.MaNV AND Ngay = NEW.Ngay;
END;

DELIMITER ;
