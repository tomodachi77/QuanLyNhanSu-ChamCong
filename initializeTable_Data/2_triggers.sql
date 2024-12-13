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

    IF (NEW.MSNV_QuanLy IS NOT NULL) AND (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MSNV_QuanLy)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên quản lý không tồn tại';
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

    IF NOT EXISTS (SELECT 1 FROM chinhanh where chinhanh.`MaChiNhanh`=NEW.MaChiNhanh) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã chi nhánh không tồn tại';
    END IF;

    IF (NEW.MSNV_VanHanh IS NOT NULL) AND (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MSNV_VanHanh)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên vận hành không tồn tại';
    END IF;
END //

CREATE Trigger if NOT EXISTS checkSdtFormat 
BEFORE INSERT ON Sdt_NhanVien
FOR EACH ROW
BEGIN 
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;

    IF NEW.SoDienThoai NOT REGEXP '^0[0-9]{9}' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu bằng số 0 và có chính xác 10 chữ số';
    END IF;

    IF EXISTS (SELECT 1 from nhanvien NATURAL INNER JOIN Sdt_NhanVien WHERE `MaNV`=NEW.MaNV AND `SoDienThoai`=NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhân viên vừa nhập đã có số điện thoại trên';
    END IF;
END //

CREATE TRIGGER IF NOT EXISTS checkNhanVienFormat
BEFORE INSERT ON nhanvien
FOR EACH ROW
BEGIN
    IF NEW.MaNV NOT REGEXP '^NV[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số đằng sau';
    END IF;

    IF NEW.Ho NOT REGEXP '^[[:alnum:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Họ chỉ gồm một từ và không được chứa ký tự đặc biệt';
    END IF;

    IF NEW.TenLot NOT REGEXP '^[[:alnum:][:space:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên lót không được chứa ký tự đặc biệt';
    END IF;

    IF NEW.Ten NOT REGEXP '^[[:alnum:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên chỉ gồm một từ và không được chứa ký tự đặc biệt';
    END IF;

    IF NEW.Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Email không đúng định dạng.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPhongBan = NEW.MaPhongBan) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã phòng ban không tồn tại.';
    END IF;

    IF NEW.LuongTheoGio <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lương theo giờ phải lớn hơn 0.';
    END IF;

    IF NEW.HeSoPhatDiTre < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hệ số phạt đi trễ phải lớn hơn hoặc bằng 0.';
    END IF;

    IF NEW.HeSoPhatVangKhongPhep < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hệ số phạt vắng không phép phải lớn hơn hoặc bằng 0.';
    END IF;

    IF NEW.SoNgayNghi < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số ngày nghỉ phải lớn hơn hoặc bằng 0.';
    END IF;

    IF EXISTS (SELECT 1 FROM nhanvien WHERE nhanvien.MaNV = NEW.MaNV) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã nhân viên đã tồn tại';
    END IF;

    IF EXISTS (SELECT 1 FROM nhanvien WHERE nhanvien.Email = NEW.Email) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email nhân viên đã tồn tại';
    END IF;
END//

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

CREATE TRIGGER checkDuAnFormat 
BEFORE INSERT ON DuAn
FOR EACH ROW
BEGIN
    IF NEW.MaDuAn NOT REGEXP '^DA[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã dự án phải có định dạng DAxxxx, với 4 chữ số đằng sau';
    END IF;

    IF EXISTS (SELECT 1 from duan WHERE duan.MaDuAn=NEW.MaDuAn) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã dự án đã tồn tại';
    END IF;

    IF NEW.TenDuAn NOT REGEXP '^[[:alnum:][:space:].,\\-]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên dự án không được chứa ký tự đặc biệt';
    END IF;

    IF NEW.MoTa NOT REGEXP '^[[:alnum:][:space:][:punct:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mô tả không được chứa ký tự đặc biệt';
    END IF;

    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaQuanLy)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên quản lý dự án không tồn tại';
    END IF;

    IF (NOT EXISTS (SELECT 1 from phongban WHERE phongban.`MaPhongBan`=NEW.MaPhongBan)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phòng ban không tồn tại';
    END IF;
END //

-- CREATE TABLE NhanVienThamGiaDuAn (
--     MaNhanVien CHAR(6),
--     MaDuAn CHAR(6),
--     PRIMARY KEY (MaNhanVien, MaDuAn),
--     Foreign Key (MaNhanVien) REFERENCES NhanVien(MaNV),
--     Foreign Key (MaDuAn) REFERENCES DuAn(MaDuAn)
-- );

DELIMITER //
CREATE TRIGGER checkNhanVienThamGiaDuAnFormat 
BEFORE INSERT ON NhanVienThamGiaDuAn
FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNhanVien)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;

    IF (NOT EXISTS (SELECT 1 from DuAn WHERE DuAn.`MaDuAn`=NEW.MaDuAn)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số dự án không tồn tại';
    END IF;

    IF EXISTS (SELECT 1 FROM NhanVienThamGiaDuAn WHERE NhanVienThamGiaDuAn.`MaNhanVien`=NEW.`MaNhanVien` AND NhanVienThamGiaDuAn.`MaDuAn`=NEW.`MaDuAn`) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhân viên vừa nhập đã tham gia dự án trên';
    END IF;
END //

CREATE TRIGGER IF NOT EXISTS checkNguoiPhuThuocFormat
BEFORE INSERT on NguoiPhuThuoc
FOR EACH ROW
BEGIN
    IF NEW.Ten NOT REGEXP '^[[:alnum:][:space:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên người phụ thuộc không được chứa những ký tự đặc biệt';
    END IF;

    IF NEW.MoiQuanHe NOT REGEXP '^[[:alnum:][:space:]]*$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên mối quan hệ không được chứa những ký tự đặc biệt';
    END IF;

    IF NEW.SoDienThoai NOT REGEXP '^0[0-9]{9}' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu bằng số 0 và có chính xác 10 chữ số';
    END IF;

    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;
END//

CREATE TRIGGER checkBangChamCongFormat 
BEFORE INSERT ON BangChamCong
FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;
END //

CREATE TRIGGER checkLanRaVaoFormat 
BEFORE INSERT ON LanRaVao
FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;
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
END //

CREATE TRIGGER checkLichLamViecFormat 
BEFORE INSERT ON LichLamViec
FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;
END //

CREATE TRIGGER checkBangLuongFormat 
BEFORE INSERT ON BangLuong
FOR EACH ROW
BEGIN
    IF (NOT EXISTS (SELECT 1 from nhanvien WHERE nhanvien.`MaNV`=NEW.MaNV)) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã số nhân viên không tồn tại';
    END IF;
END //

-- DELIMITER ;