# (MaNV, Ho, TenLot, Ten, GioiTinh, Email, LuongTheoGio, MaPhongBan)

# CREATE TABLE NhanVien (
#     MaNV CHAR(6) PRIMARY KEY, -> 'NV0000'
#     Ho NVARCHAR(10) NOT NULL,
#     TenLot NVARCHAR(10),
#     Ten NVARCHAR(10) NOT NULL,
#     GioiTinh ENUM('Nam', 'Nữ', 'Khác') NOT NULL, -> ('Nam', 'Nữ', 'Khác')
#     Email VARCHAR(100) NOT NULL UNIQUE,
#     HeSoPhatDiTre DECIMAL(5, 2) DEFAULT 1,
#     HeSoPhatVangKhongPhep DECIMAL(5, 2) DEFAULT 1,
#     SoNgayNghi INT DEFAULT 12,
#     LuongTheoGio DECIMAL(10, 2) NOT NULL,
#     MaPhongBan CHAR(6), -> ('PB0101', 'PB0102', 'PB0103', 'PB0104', 'PB0105', 'PB0106', 'PB0201', 'PB0202', 'PB0203', 'PB0204', 'PB0205', 'PB0206', 'PB0301', 'PB0302', 'PB0303', 'PB0304', 'PB0305', 'PB0306', 'PB0401', 'PB0402', 'PB0403', 'PB0404', 'PB0405', 'PB0406')
#     FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhongBan) 
# );
import re
import random

def no_accent_vietnamese(s):
    s = re.sub(r'[àáạảãâầấậẩẫăằắặẳẵ]', 'a', s)
    s = re.sub(r'[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]', 'A', s)
    s = re.sub(r'[èéẹẻẽêềếệểễ]', 'e', s)
    s = re.sub(r'[ÈÉẸẺẼÊỀẾỆỂỄ]', 'E', s)
    s = re.sub(r'[òóọỏõôồốộổỗơờớợởỡ]', 'o', s)
    s = re.sub(r'[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]', 'O', s)
    s = re.sub(r'[ìíịỉĩ]', 'i', s)
    s = re.sub(r'[ÌÍỊỈĨ]', 'I', s)
    s = re.sub(r'[ùúụủũưừứựửữ]', 'u', s)
    s = re.sub(r'[ƯỪỨỰỬỮÙÚỤỦŨ]', 'U', s)
    s = re.sub(r'[ỳýỵỷỹ]', 'y', s)
    s = re.sub(r'[ỲÝỴỶỸ]', 'Y', s)
    s = re.sub(r'[Đ]', 'D', s)
    s = re.sub(r'[đ]', 'd', s)
    s = s.replace(' ', '')
    s = s.lower()
    return s

def process_name(name: str) -> list:
    return name.split(' ')
    
names = ('Văn Phú Ân','Kim Hải Sơn','Thi Dũng Trí','Tô Đức Duy','Lục Thuận Thành','Sái Thế An','Nguyễn Việt Khôi','Đoàn Hữu Trung','Phạm Anh Tài','Trần Bảo Hoàng','Nguyễn Trúc Quân','Huỳnh Ái Khanh','Lý Thanh Xuân','Nguyễn Hương Ly','Lê Diễm Châu','Triệu Quỳnh Hà','Lạc Nhật Hạ','Hoàng Kiều Dung','Mạch Tâm Đoan','Dương Tuyết Mai','Chung Yên Nhi','Hàn Khánh Quỳnh','Nguyễn Phương Diễm','Bành Triều Nguyệt','Văn Tâm Trang','Võ Diễm Châu','Huỳnh San San','Mai Nhật Hạ','Võ Kim Xuân','Lâm Hương Liên','An Khải Tuấn','Đỗ Tường Nguyên','Nguyễn Quang Vũ','Chử Chấn Hùng','Phạm Thanh Trung','Dương Trọng Dũng','Huỳnh Trường Nhân','Lục Quốc Hoàng','Lê Bảo Sơn','Cao Tường Lâm','Quang Huyền Ngọc','Bùi Bích Như','Nguyễn Cẩm Nhi','Nguyễn Thúy Anh','Dương Phương Loan','Vũ Ngọc Uyên','Nguyễn Uyên Nhi','Hoàng Vân Ngọc','Huỳnh Thảo Vân','Thân Diễm Thảo','Nguyễn Thái Yên','Châu Phương Chi','Nguyễn Tú Quỳnh','Ngô Tuyết Oanh','Nguyễn Thúy Hiền','Trần Hồng Trúc','Đặng Thu Phương','Phan Diệp Vy','Vũ Hoài Phương','Mai Nhã Khanh','Phan Thế Dũng','Bùi Hải Thụy','Mã Hưng Đạo','Thạch Nhật Minh','Hoàng Bảo Định','Đàm Bảo Châu','Nguyễn Minh Huy','Đỗ Ngọc Đại','Hoàng Triệu Thái','Doãn Phúc diền','Mai Ánh Trang','Lương Diệu Ái','Đỗ Nhã Thanh','Trần Lan Vy','Thi Hạnh Vi','La Thi Cầm','Đỗ Hoài An','Ngô Diệu Hồng','Phạm Ngọc Đào','Hồ Băng Băng','Liễu Xuân An','Tôn Quốc Anh','Nghiêm Sỹ Phú','Huỳnh Thanh Phi','Dữu Minh Quý','Lục Thanh Tuấn','Phan Nam Hưng','Thạch Anh Đức','Quyền Hoài Bắc','Võ Tất Bình','Lê Hồng Quế','Nguyễn Minh Duyên','Triệu Phương Quế','Phan Thu Huyền','Nguyễn Thanh Hoa','Bạch Phương Thủy','Võ Uyên Trâm','Ngô Thụy Khanh','Phan Dạ Hương','Thi Thúy Ngân','Bùi Trí Dũng','Mai Duy Hùng','Lê Tiến Hiệp','Thái Vĩnh Hưng','Phạm Phú Ân','Sái Hữu Chiến','Phạm Quang Triệu','Phan Đình Diệu','La Sơn Quyền','Mạc Vũ Anh','Dữu Hồng Đức','Doãn Phước Thiện','Ân Như Khang','Lê Bá Kỳ','Nguyễn Việt Hải','Phùng Tuấn Thành','Thân Hùng Ngọc','Dữu Minh Nhân','Ngô Thanh Vinh','Úc Thanh Quang','Vương Minh Triết','Ngư Khánh Huy','Lý Đức Giang','La Khải Ca','Uất Hùng Cường','Tôn Đăng An','Lê Anh Vũ','Phan Viễn Đông','Úc Tuấn Châu','Ngô Huy Phong','An Hoài An','Nguyễn Thảo Nguyên','Châu Ngọc Hoa','Bùi Thụy Trâm','Phan Huệ Thương','Trương Ngọc Mai','Thi Thúy Hiền','Nguyễn Hiền Thục','Đỗ Kiều Thu','Vĩnh Quế Phương','Hàn Bích Huệ','Võ Ái Hồng','Trầm Minh Loan','Huỳnh Ánh Hồng','Nguyễn Phương Anh','Đào Phi Nhung','Nguyễn Gia Khanh','Phạm Ngọc Vân','Huỳnh Triều Nguyệt','Cao Bích Quân','Đặng Hiệp Hào','Trần Phước Nhân','Thi Thanh Quang','Triệu Nguyên Phong','Vũ Trung Kiên','Tiêu Hữu Canh','Giang Thuận Toàn','Huỳnh Chế Phương','Nguyễn Tuấn Long','Nguyễn Thanh Vinh','Trầm Công Phụng','Hà Việt Thái','Chung Công Vinh','Nguyễn Anh Tuấn','Thái Đức Quyền','Hoàng Thiện Ngôn','Phạm Khắc Minh','Lục Quang Hưng','Lý Viễn Phương','Võ Quang Thạch')

ids = (8058, 9750, 2034, 2790, 1452, 9714, 9858, 7733, 9240, 3993, 7947, 6256, 7528, 9606, 8120, 1967, 3587, 4867, 5474, 7994, 4906, 4739, 5194, 2825, 8481, 8049, 9229, 8929, 5031, 5170, 4620, 2977, 8703, 6713, 2368, 3678, 6452, 5192, 3577, 6411, 9574, 1108, 6510, 1371, 9225, 9983, 9007, 5494, 5604, 3205, 7597, 1252, 4602, 5594, 3981, 1271, 3984, 6562, 9964, 2689, 4052, 8112, 8232, 6475, 9648, 2494, 4526, 9375, 9119, 9022, 6789, 1282, 5235, 9548, 6406, 7803, 2231, 2551, 5858, 2582, 8680, 8937, 5324, 4036, 6043, 1492, 9676, 3709, 6419, 8084, 3265, 6786, 5849, 3308, 8278, 2124, 3171, 3058, 3857, 5775, 7197, 3140, 4225, 2137, 9115, 1778, 1816, 2357, 7466, 8971, 7040, 2553, 3027, 3614, 8815, 9199, 8594, 7288, 4257, 1540, 5718, 7171, 6643, 1404, 9979, 3214, 3728, 3692, 7743, 8938, 2099, 7938, 5896, 3184, 8348, 7788, 2994, 3795, 8801, 6164, 5859, 4112, 4590, 8291, 3325, 4355, 9273, 6036, 8519, 6160, 5136, 3290, 3300, 2569, 7327, 9405, 5918, 2959, 9885, 7556, 2105, 9741, 8795, 4286, 3189, 9433, 1472, 1234, 3287, 8207)

sexes = ('Nam', 'Nữ', 'Khác')

emails = ('vanphuan@gmail.com','kimhaison@gmail.com','thidungtri@gmail.com','toducduy@gmail.com','lucthuanthanh@gmail.com','saithean@gmail.com','nguyenvietkhoi@gmail.com','doanhuutrung@gmail.com','phamanhtai@gmail.com','tranbaohoang@gmail.com','nguyentrucquan@gmail.com','huynhaikhanh@gmail.com','lythanhxuan@gmail.com','nguyenhuongly@gmail.com','lediemchau@gmail.com','trieuquynhha@gmail.com','lacnhatha@gmail.com','hoangkieudung@gmail.com','machtamdoan@gmail.com','duongtuyetmai@gmail.com','chungyennhi@gmail.com','hankhanhquynh@gmail.com','nguyenphuongdiem@gmail.com','banhtrieunguyet@gmail.com','vantamtrang@gmail.com','vodiemchau@gmail.com','huynhsansan@gmail.com','mainhatha@gmail.com','vokimxuan@gmail.com','lamhuonglien@gmail.com','ankhaituan@gmail.com','dotuongnguyen@gmail.com','nguyenquangvu@gmail.com','chuchanhung@gmail.com','phamthanhtrung@gmail.com','duongtrongdung@gmail.com','huynhtruongnhan@gmail.com','lucquochoang@gmail.com','lebaoson@gmail.com','caotuonglam@gmail.com','quanghuyenngoc@gmail.com','buibichnhu@gmail.com','nguyencamnhi@gmail.com','nguyenthuyanh@gmail.com','duongphuongloan@gmail.com','vungocuyen@gmail.com','nguyenuyennhi@gmail.com','hoangvanngoc@gmail.com','huynhthaovan@gmail.com','thandiemthao@gmail.com','nguyenthaiyen@gmail.com','chauphuongchi@gmail.com','nguyentuquynh@gmail.com','ngotuyetoanh@gmail.com','nguyenthuyhien@gmail.com','tranhongtruc@gmail.com','dangthuphuong@gmail.com','phandiepvy@gmail.com','vuhoaiphuong@gmail.com','mainhakhanh@gmail.com','phanthedung@gmail.com','buihaithuy@gmail.com','mahungdao@gmail.com','thachnhatminh@gmail.com','hoangbaodinh@gmail.com','dambaochau@gmail.com','nguyenminhhuy@gmail.com','dongocdai@gmail.com','hoangtrieuthai@gmail.com','doanphucdien@gmail.com','maianhtrang@gmail.com','luongdieuai@gmail.com','donhathanh@gmail.com','tranlanvy@gmail.com','thihanhvi@gmail.com','lathicam@gmail.com','dohoaian@gmail.com','ngodieuhong@gmail.com','phamngocdao@gmail.com','hobangbang@gmail.com','lieuxuanan@gmail.com','tonquocanh@gmail.com','nghiemsyphu@gmail.com','huynhthanhphi@gmail.com','duuminhquy@gmail.com','lucthanhtuan@gmail.com','phannamhung@gmail.com','thachanhduc@gmail.com','quyenhoaibac@gmail.com','votatbinh@gmail.com','lehongque@gmail.com','nguyenminhduyen@gmail.com','trieuphuongque@gmail.com','phanthuhuyen@gmail.com','nguyenthanhhoa@gmail.com','bachphuongthuy@gmail.com','vouyentram@gmail.com','ngothuykhanh@gmail.com','phandahuong@gmail.com','thithuyngan@gmail.com','buitridung@gmail.com','maiduyhung@gmail.com','letienhiep@gmail.com','thaivinhhung@gmail.com','phamphuan@gmail.com','saihuuchien@gmail.com','phamquangtrieu@gmail.com','phandinhdieu@gmail.com','lasonquyen@gmail.com','macvuanh@gmail.com','duuhongduc@gmail.com','doanphuocthien@gmail.com','annhukhang@gmail.com','lebaky@gmail.com','nguyenviethai@gmail.com','phungtuanthanh@gmail.com','thanhungngoc@gmail.com','duuminhnhan@gmail.com','ngothanhvinh@gmail.com','ucthanhquang@gmail.com','vuongminhtriet@gmail.com','ngukhanhhuy@gmail.com','lyducgiang@gmail.com','lakhaica@gmail.com','uathungcuong@gmail.com','tondangan@gmail.com','leanhvu@gmail.com','phanviendong@gmail.com','uctuanchau@gmail.com','ngohuyphong@gmail.com','anhoaian@gmail.com','nguyenthaonguyen@gmail.com','chaungochoa@gmail.com','buithuytram@gmail.com','phanhuethuong@gmail.com','truongngocmai@gmail.com','thithuyhien@gmail.com','nguyenhienthuc@gmail.com','dokieuthu@gmail.com','vinhquephuong@gmail.com','hanbichhue@gmail.com','voaihong@gmail.com','tramminhloan@gmail.com','huynhanhhong@gmail.com','nguyenphuonganh@gmail.com','daophinhung@gmail.com','nguyengiakhanh@gmail.com','phamngocvan@gmail.com','huynhtrieunguyet@gmail.com','caobichquan@gmail.com','danghiephao@gmail.com','tranphuocnhan@gmail.com','thithanhquang@gmail.com','trieunguyenphong@gmail.com','vutrungkien@gmail.com','tieuhuucanh@gmail.com','giangthuantoan@gmail.com','huynhchephuong@gmail.com','nguyentuanlong@gmail.com','nguyenthanhvinh@gmail.com','tramcongphung@gmail.com','havietthai@gmail.com','chungcongvinh@gmail.com','nguyenanhtuan@gmail.com','thaiducquyen@gmail.com','hoangthienngon@gmail.com','phamkhacminh@gmail.com','lucquanghung@gmail.com','lyvienphuong@gmail.com','voquangthach@gmail.com')

depts = ('PB0101', 'PB0102', 'PB0103', 'PB0104', 'PB0105', 'PB0106', 'PB0201', 'PB0202', 'PB0203', 'PB0204', 'PB0205', 'PB0206', 'PB0301', 'PB0302', 'PB0303', 'PB0304', 'PB0305', 'PB0306', 'PB0401', 'PB0402', 'PB0403', 'PB0404', 'PB0405', 'PB0406')

hourlySalaries = (25000, 30000, 35000, 40000, 50000, 60000, 70000, 80000, 90000, 100000)

# print("INSERT INTO NhanVien (MaNV, Ho, TenLot, Ten, GioiTinh, Email, LuongTheoGio, MaPhongBan) VALUES\n")

for MSNV, name, email in zip(ids, names, emails):
    processed_name = process_name(name)
    ho = processed_name[0]
    tenlot = processed_name[1]
    ten = processed_name[2]
    sex = random.choice(sexes)
    hourlySalary = random.choice(hourlySalaries)
    dept = random.choice(depts)
    print(f'(\'NV{MSNV}\', \'{ho}\', \'{tenlot}\', \'{ten}\', \'{sex}\', \'{email}\', {hourlySalary}, \'{dept}\'),')
    
    
# print(len(ids))
