--Tính tổng số giờ làm thêm của từng phòng ban trong một khoảng thời gian

DELIMITER //

CREATE PROCEDURE TongGioLamThemTheoPhongBan(
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