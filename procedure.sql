DELIMITER //

-- Thủ tục thêm nhân viên
CREATE PROCEDURE ThemNhanVien(
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số sau.';
    END IF;
    IF p_Ho REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Họ không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_TenLot REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên lót không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Ten REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email không đúng định dạng.';
    END IF;
    IF p_MaPhongBan NOT REGEXP '^PB[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã phòng ban phải có định dạng PBxxxx, với 4 chữ số sau.';
    END IF;
    IF p_LuongTheoGio <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lương theo giờ phải lớn hơn 0.';
    END IF;
    
    -- Thêm nhân viên
    INSERT INTO NhanVien (MaNV, Ho, TenLot, Ten, GioiTinh, Email, HeSoPhatDiTre, HeSoPhatVangKhongPhep, SoNgayNghi, LuongTheoGio, MaPhongBan)
    VALUES (p_MaNV, p_Ho, p_TenLot, p_Ten, p_GioiTinh, p_Email, p_HeSoPhatDiTre, p_HeSoPhatVangKhongPhep, p_SoNgayNghi, p_LuongTheoGio, p_MaPhongBan);
END //

-- Thủ tục sửa thông tin nhân viên
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số sau.';
    END IF;
    IF p_Ho REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Họ không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_TenLot REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên lót không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Ten REGEXP '[^a-zA-ZÀ-ỹ ]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên không được chứa số hoặc ký tự đặc biệt.';
    END IF;
    IF p_Email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email không đúng định dạng.';
    END IF;
    IF p_MaPhongBan NOT REGEXP '^PB[0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã phòng ban phải có định dạng PBxxxx, với 4 chữ số sau.';
    END IF;
    IF p_LuongTheoGio <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lương theo giờ phải lớn hơn 0.';
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
CREATE PROCEDURE XoaNhanVien(
    IN p_MaNV CHAR(6)
)
BEGIN
    -- Xóa nhân viên
    DELETE FROM NhanVien
    WHERE MaNV = p_MaNV;
END //

DELIMITER ;
