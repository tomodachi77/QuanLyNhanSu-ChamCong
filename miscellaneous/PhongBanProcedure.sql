

--Lọc phòng ban có số lượng nhân viên có trạng thái Bảng chấm công là "Có mặt" nhiều nhất
--Lọc phòng ban có số lượng nhân viên lớn hơn số lượng cho trước
DELIMITER //
DROP PROCEDURE IF EXISTS LocPhongBanCoSoLuongNhanVienCoMatNhieuNhat//
CREATE PROCEDURE LocPhongBanCoSoLuongNhanVienCoMatNhieuNhat()
BEGIN
    SELECT 
        PB.MaPhongBan, PB.TenPhongBan, PB.SoLuongNhanVien, COUNT(NV.MaNV) AS SoLuongNhanVienCoMat
    FROM 
        PhongBan PB
    JOIN 
        NhanVien NV ON PB.MaPhongBan = NV.MaPhongBan
    JOIN 
        BangChamCong BCC ON NV.MaNV = BCC.MaNV
    WHERE 
        BCC.TrangThai = 'Có mặt'
    GROUP BY 
        PB.MaPhongBan
    ORDER BY 
        SoLuongNhanVienCoMat DESC;
END//


DROP PROCEDURE IF EXISTS LocPhongBanCoSoLuongNhanVienLonHon//
CREATE PROCEDURE LocPhongBanCoSoLuongNhanVienLonHon(IN minEmployeeCount INT)
BEGIN
    SELECT 
        PB.MaPhongBan, PB.TenPhongBan, COUNT(NV.MaNV) AS EmployeeCount
    FROM 
        PhongBan PB
    LEFT JOIN 
        NhanVien NV ON PB.MaPhongBan = NV.MaPhongBan
    WHERE 
        PB.SoLuongNhanVien > minEmployeeCount
    GROUP BY 
        PB.MaPhongBan
    HAVING 
        EmployeeCount > minEmployeeCount
    ORDER BY 
        EmployeeCount DESC;
END//
DELIMITER ;