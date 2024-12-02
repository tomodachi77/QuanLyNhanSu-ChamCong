DROP DATABASE IF EXISTS quanlynhansu;
CREATE DATABASE IF NOT EXISTS quanlynhansu;

USE quanlynhansu;

-- Tạo bảng Chi nhánh
CREATE TABLE ChiNhanh (
    MaChiNhanh CHAR(4) PRIMARY KEY,
    TenChiNhanh NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    MSNV_QuanLy CHAR(6)
    -- Sau khi đã import đủ data thì thêm thuộc tính khóa ngoại và cập nhật NV quản lý
);

-- Tạo bảng Phòng ban
CREATE TABLE PhongBan (
    MaPhongBan CHAR(6) PRIMARY KEY,
    TenPhongBan NVARCHAR(100) NOT NULL,
    MaChiNhanh CHAR(4) NOT NULL,
    SoLuongNhanVien INT DEFAULT 0,
    MSNV_VanHanh CHAR(6),
    FOREIGN KEY (MaChiNhanh) REFERENCES ChiNhanh(MaChiNhanh)
    -- Sau khi đã import đủ data thì thêm thuộc tính khóa ngoại và cập nhật NV quản lý
);

-- Tạo bảng Nhân viên
CREATE TABLE NhanVien (
    MaNV CHAR(6) PRIMARY KEY,
    Ho NVARCHAR(10) NOT NULL,
    TenLot NVARCHAR(10),
    Ten NVARCHAR(10) NOT NULL,
    GioiTinh ENUM('Nam', 'Nữ', 'Khác') NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    HeSoPhatDiTre DECIMAL(5, 2) DEFAULT 1,
    HeSoPhatVangKhongPhep DECIMAL(5, 2) DEFAULT 1,
    SoNgayNghi INT DEFAULT 12,
    LuongTheoGio DECIMAL(10, 2) NOT NULL,
    MaPhongBan CHAR(6),
    FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhongBan)
);

CREATE TABLE Sdt_NhanVien (
    MaNV CHAR(6),
    SoDienThoai VARCHAR(10),
    PRIMARY KEY (MaNV, SoDienThoai)
)

-- Tạo bảng Nhân viên toàn thời gian
CREATE TABLE NhanVienToanThoiGian (
    MaNV CHAR(6) PRIMARY KEY,
    GioBatDau TIME,
    GioKetThuc TIME,
    LuongTangCa DECIMAL(10, 2),
    MaNVQuanLy CHAR(6) DEFAULT NULL,
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    Foreign Key (MaNVQuanLy) REFERENCES NhanVienToanThoiGian(MaNV)
);

-- Tạo bảng Nhân viên bán thời gian
CREATE TABLE NhanVienBanThoiGian (
    MaNV CHAR(6) PRIMARY KEY,
    MaNV_GiamSat CHAR(6),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    Foreign Key (MaNV_GiamSat) REFERENCES NhanVienToanThoiGian(MaNV)
);

-- Tạo bảng Dự án
CREATE TABLE DuAn (
    MaDuAn CHAR(6) PRIMARY KEY,
    TenDuAn NVARCHAR(100) NOT NULL,
    MoTa TEXT,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE,
    Deadline DATE NOT NULL,
    MaPhongBan CHAR(6),
    MaQuanLy CHAR(6),
    FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhongBan),
    FOREIGN KEY (MaQuanLy) REFERENCES NhanVienToanThoiGian(MaNV)
);

CREATE TABLE NhanVienThamGiaDuAn (
    MaNhanVien CHAR(6),
    MaDuAn CHAR(6),
    PRIMARY KEY (MaNhanVien, MaDuAn),
    Foreign Key (MaNhanVien) REFERENCES NhanVien(MaNV),
    Foreign Key (MaDuAn) REFERENCES DuAn(MaDuAn)
);

-- Tạo bảng Người phụ thuộc
CREATE TABLE NguoiPhuThuoc (
    Ten NVARCHAR(50),
    GioiTinh ENUM('Nam', 'Nữ', 'Khác') NOT NULL,
    SoDienThoai VARCHAR(10) NOT NULL,
    MoiQuanHe NVARCHAR(50) NOT NULL,
    MaNV CHAR(6),
    PRIMARY KEY (Ten, MaNV),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- Tạo bảng Bảng chấm công v.1
-- CREATE TABLE BangChamCong (
--     MaNV INT,
--     Ngay DATE,
--     ThoiGianRa TIME,
--     ThoiGianVao TIME,
--     TrangThai ENUM('Có mặt', 'Vắng có phép', 'Vắng không phép'),
--     TongSoGioLam DECIMAL(5, 2),
--     TongSoGioTangCa DECIMAL(5, 2),
--     TienPhat DECIMAL(10, 2),
--     LuongTamTinh DECIMAL(10, 2),
--     PRIMARY KEY (MaNV, Ngay),
--     FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
-- );

-- Tạo bảng Bảng chấm công v.2
CREATE TABLE BangChamCong (
    MaNV CHAR(6),
    Ngay DATE,
    TrangThai ENUM('Có mặt', 'Vắng có phép', 'Vắng không phép'),
    TongSoGioLam DECIMAL(5, 2) DEFAULT NULL,
    PRIMARY KEY (MaNV, Ngay),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE LanRaVao (
    MaNV CHAR(6),
    Ngay DATE,
    GioVao TIME,
    GioRa TIME,
    PRIMARY KEY (MaNV, Ngay, GioVao, GioRa),
    FOREIGN KEY (MaNV, Ngay) REFERENCES BangChamCong(MaNV, Ngay)
);

-- Tạo bảng Lịch làm việc (dành cho nhân viên bán thời gian)
CREATE TABLE LichLamViec (
    MaNV CHAR(6),
    Ngay DATE,
    GioBatDau TIME,
    GioKetThuc TIME,
    PRIMARY KEY (MaNV, Ngay, GioBatDau, GioKetThuc),
    FOREIGN KEY (MaNV) REFERENCES NhanVienBanThoiGian(MaNV)
);

-- Tạo bảng Bảng thiết lập lương
CREATE TABLE BangThietLapLuong (
    NgayApDung DATE PRIMARY KEY,
    ThueSuat DECIMAL(5, 2),
    BaoHiemXH DECIMAL(5, 2)
);

-- Tạo bảng Bảng lương
CREATE TABLE BangLuong (
    MaNV CHAR(6),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    NgayApDung DATE,
    PRIMARY KEY (MaNV, NgayBatDau, NgayKetThuc),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (NgayApDung) REFERENCES BangThietLapLuong(NgayApDung)
);
