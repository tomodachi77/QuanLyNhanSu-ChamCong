DELIMITER //
DROP Procedure IF EXISTS insert_ChiNhanh//

CREATE PROCEDURE IF NOT EXISTS insert_ChiNhanh (MaChiNhanh CHAR(4), TenChiNhanh NVARCHAR(100), DiaChi NVARCHAR(200), MSNV_QuanLy CHAR(6))
BEGIN
    INSERT INTO chinhanh VALUES (MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy);
END //

DROP PROCEDURE IF EXISTS ThemNhanVien //
CREATE PROCEDURE ThemNhanVien(
    IN p_MaNV CHAR(6),
    IN p_Ho NVARCHAR(10),
    IN p_TenLot NVARCHAR(10),
    IN p_Ten NVARCHAR(10),
    IN p_GioiTinh ENUM('Nam', 'Nữ', 'Khác'),
    IN p_Email VARCHAR(100),
    IN p_LuongTheoGio DECIMAL(10, 2),
    IN p_MaPhongBan CHAR(6)
)
BEGIN

    -- Kiểm tra dữ liệu hợp lệ
    IF p_MaNV NOT REGEXP '^NV[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số đằng sau';
    END IF;
    IF p_Ho REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Họ không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_TenLot IS NOT NULL AND p_TenLot REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên lót không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Ten REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email không đúng định dạng.';
    END IF;
    -- Kiểm tra sự tồn tại của MaPhongBan trong bảng PhongBan
    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPhongBan = p_MaPhongBan) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã phòng ban không tồn tại.';
    END IF;
    IF p_LuongTheoGio <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lương theo giờ phải lớn hơn 0.';
    END IF;

    -- Thêm nhân viên
    INSERT INTO NhanVien (MaNV, Ho, TenLot, Ten, GioiTinh, Email, LuongTheoGio, MaPhongBan)
    VALUES (p_MaNV, p_Ho, p_TenLot, p_Ten, p_GioiTinh, p_Email, p_LuongTheoGio, p_MaPhongBan);
END //

-- Thủ tục sửa nhân viên
DROP PROCEDURE IF EXISTS SuaNhanVien //
CREATE PROCEDURE SuaNhanVien(
    IN p_MaNV CHAR(6),
    IN p_Ho NVARCHAR(10),
    IN p_TenLot NVARCHAR(10),
    IN p_Ten NVARCHAR(10),
    IN p_GioiTinh ENUM('Nam', 'Nữ', 'Khác'),
    IN p_Email VARCHAR(100),
    IN p_HeSoPhatDiTre DECIMAL(5, 2),
    IN p_HeSoPhatVangKhongPhep DECIMAL(5, 2),
    IN p_SoNgayNghi INT,
    IN p_LuongTheoGio DECIMAL(10, 2),
    IN p_MaPhongBan CHAR(6)
)
BEGIN
    -- Kiểm tra dữ liệu hợp lệ
    IF p_MaNV NOT REGEXP '^NV[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số đằng sau';
    END IF;
    -- Kiểm tra sự tồn tại của nhân viên trong bảng NhanVien
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = p_MaNV) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhân viên với mã này không tồn tại.';
    END IF;
    IF p_Ho REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Họ không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_TenLot IS NOT NULL AND p_TenLot REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên lót không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Ten REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email không đúng định dạng.';
    END IF;
    -- Kiểm tra sự tồn tại của MaPhongBan trong bảng PhongBan
    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPhongBan = p_MaPhongBan) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã phòng ban không tồn tại.';
    END IF;
    IF p_LuongTheoGio <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lương theo giờ phải lớn hơn 0.';
    END IF;
    IF p_HeSoPhatDiTre < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hệ số phạt đi trễ phải lớn hơn hoặc bằng 0.';
    END IF;
    IF p_HeSoPhatVangKhongPhep < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hệ số phạt vắng không phép phải lớn hơn hoặc bằng 0.';
    END IF;
    IF p_SoNgayNghi < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số ngày nghỉ phải lớn hơn hoặc bằng 0.';
    END IF;

    -- Sửa thông tin nhân viên
    UPDATE NhanVien
    SET Ho = p_Ho,
        TenLot = p_TenLot,
        Ten = p_Ten,
        GioiTinh = p_GioiTinh,
        Email = p_Email,
        HeSoPhatDiTre = p_HeSoPhatDiTre,
        HeSoPhatVangKhongPhep = p_HeSoPhatVangKhongPhep,
        SoNgayNghi = p_SoNgayNghi,
        LuongTheoGio = p_LuongTheoGio,
        MaPhongBan = p_MaPhongBan
    WHERE MaNV = p_MaNV;
END //

-- Thủ tục xóa nhân viên
DROP PROCEDURE IF EXISTS XoaNhanVien //
CREATE PROCEDURE XoaNhanVien(
    IN p_MaNV CHAR(6)
)
BEGIN
    -- Xóa dữ liệu liên quan từ các bảng con trước
    DELETE FROM LanRaVao WHERE MaNV = p_MaNV;
    DELETE FROM BangChamCong WHERE MaNV = p_MaNV;
    DELETE FROM LichLamViec WHERE MaNV = p_MaNV;
    DELETE FROM NhanVienThamGiaDuAn WHERE MaNhanVien = p_MaNV;
    DELETE FROM NguoiPhuThuoc WHERE MaNV = p_MaNV;
    DELETE FROM Sdt_NhanVien WHERE MaNV = p_MaNV;
    DELETE FROM BangLuong WHERE MaNV = p_MaNV;

    -- Xóa nhân viên từ bảng cụ thể
    DELETE FROM NhanVienBanThoiGian WHERE MaNV = p_MaNV;
    DELETE FROM NhanVienToanThoiGian WHERE MaNV = p_MaNV;

    -- Cuối cùng, xóa nhân viên từ bảng chính
    DELETE FROM NhanVien WHERE MaNV = p_MaNV;
END //

DROP PROCEDURE if EXISTS `View_BangLuong` //
create Procedure View_BangLuong (MaPhongBan CHAR(6), EmpType INT, BeginDate DATE, EndDate DATE) 
BEGIN
    DECLARE ThueSuat DECIMAL(5, 2);
    DECLARE BaoHiemXH DECIMAL(5, 2);
    
    SET ThueSuat = (SELECT bangthietlapluong.`ThueSuat` from bangthietlapluong WHERE `NgayApDung` <= EndDate ORDER BY `NgayApDung` DESC LIMIT 1);
    SET BaoHiemXH = (SELECT bangthietlapluong.`BaoHiemXH` from bangthietlapluong WHERE `NgayApDung` <= EndDate ORDER BY `NgayApDung` DESC LIMIT 1);
    
    IF EmpType = 0 THEN
        IF MaPhongBan = 'all' THEN 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien;
        ELSE 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien WHERE nhanvien.`MaPhongBan`=MaPhongBan;
        END IF;
    ELSEIF EmpType = 1 THEN
        IF MaPhongBan = 'all' THEN 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien NATURAL INNER JOIN nhanvientoanthoigian;
        ELSE 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien NATURAL INNER JOIN nhanvientoanthoigian WHERE nhanvien.`MaPhongBan`=MaPhongBan;
        END IF;
    ELSEIF EmpType = -1 THEN
        IF MaPhongBan = 'all' THEN 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien NATURAL INNER JOIN nhanvienbanthoigian;
        ELSE 
            SELECT nhanvien.`MaNV`, CONCAT(nhanvien.`Ho`, ' ', nhanvien.`TenLot`, ' ', nhanvien.`Ten`) as TenNhanVien, tonggiolamviec(nhanvien.`MaNV`, BeginDate, EndDate) as TongGioLamViec, tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) as LuongTamTinh, ((tinhluong(nhanvien.`MaNV`, BeginDate, EndDate) - tinhluong(nhanvien.`MaNV`, BeginDate, EndDate)*(BaoHiemXH))*(1 - ThueSuat)) as LuongThucTe FROM nhanvien NATURAL INNER JOIN nhanvienbanthoigian WHERE nhanvien.`MaPhongBan`=MaPhongBan;
        END IF;
    END IF;
END //

DELIMITER;
