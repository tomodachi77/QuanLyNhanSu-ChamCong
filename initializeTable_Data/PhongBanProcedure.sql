

DELIMITER //
--Lọc phòng ban có số lượng nhân viên có trạng thái Bảng chấm công là "Có mặt" nhiều nhất
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

--Lọc phòng ban có số lượng nhân viên lớn hơn số lượng cho trước
CREATE PROCEDURE LocPhongBanCoSoLuongNhanVienLonHon(IN minEmployeeCount INT)
BEGIN
    SELECT 
        PB.TenPhongBan, COUNT(NV.MaNV) AS EmployeeCount
    FROM 
        PhongBan PB
    LEFT JOIN 
        NhanVien NV ON PB.MaPhongBan = NV.MaPhongBan
    WHERE 
        PB.SoLuongNhanVien > minEmployeeCount
    GROUP BY 
        PB.TenPhongBan
    HAVING 
        EmployeeCount > minEmployeeCount
    ORDER BY 
        EmployeeCount DESC;
END//

--Tính tổng số giờ làm thêm của từng phòng ban trong một khoảng thời gian
CREATE PROCEDURE TongGioLamThemTheoTungPhongBan(
    IN p_NgayBatDau DATE,
    IN p_NgayKetThuc DATE
)
BEGIN
    SELECT 
        pb.TenPhongBan,
        SUM(TIMESTAMPDIFF(HOUR, lrv.GioVao, lrv.GioRa)) - COUNT(*) * 8 AS TongGioLamThem
    FROM 
        LanRaVao lrv
    INNER JOIN NhanVien n ON lrv.MaNV = n.MaNV
    INNER JOIN PhongBan pb ON n.MaPhongBan = pb.MaPhongBan
    WHERE 
        lrv.Ngay BETWEEN p_NgayBatDau AND p_NgayKetThuc
    GROUP BY pb.TenPhongBan
    HAVING SUM(TIMESTAMPDIFF(HOUR, lrv.GioVao, lrv.GioRa)) > COUNT(*) * 8
    ORDER BY TongGioLamThem DESC;
END //

DELIMITER ;