# QuanLyNhanSu-ChamCong

# Cài đặt workspace
- Cài MySQL tại đường link sau [MySQL Community Downloads](https://dev.mysql.com/downloads/mysql/) - Chọn phiên bản 8.4.3 LTS, tải về MSI Installer và làm theo video sau [Hướng dẫn cài MySQL](https://youtu.be/a3HJnbYhXUc).
- Vào Environment Variables trên máy, ở system variables, chọn Path, chọn Edit, chọn Browse, rồi chọn đến folder MySQL\MySQL Server 8.4\bin, sau đó nhấn OK.
- Test setup thành công bằng cách bật terminal/command prompt, chạy lệnh `mysql --version`.
  
# Cách chạy
## Clone git repo về máy
- Mở terminal, chạy lệnh `git clone git@github.com:HK241-HCSDL-L11G2/QuanLyNhanSu-ChamCong.git`
## Chạy Backend
- Cd vào folder QuanLyNhanSu-ChamCong, chạy lệnh `npm install` để cài các node_modules
- Ở folder QuanLyNhanSu-ChamCong, tạo 1 file có tên `.env`, copy các dòng ở file `example_env.txt` sang file vừa tạo, thay đổi những chỗ cần thiết (như MYSQL_PASSWORD)
- Chạy `npm run dev` ở terminal trong folder QuanLyNhanSu-ChamCong để khởi động server backend.
## Chạy Frontend
- Lưu ý cần chạy server backend trước khi chạy client frontend.
- Cd vào folder `QuanLyNhanSu-ChamCong/frontend`, chạy `npm install` để cài các node_modules
- Sau khi cài xong, chạy lệnh `npm run dev` ở terminal đang trong folder `QuanLyNhanSu-ChamCong/frontend` để khởi động client frontend.

 
