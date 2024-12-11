import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import InputField from '../components/InputField/InputField';
import SelectField from '../components/SelectField/SelectField';
import Button from '../components/Button/button';
import Toastify from 'toastify-js';

function NhanVienEdit() {
  const { MaNV } = useParams(); // Lấy Mã nhân viên từ URL
  const navigate = useNavigate();
  const location = useLocation(); // Lấy thông tin state từ điều hướng
  const currentPage = location.state?.currentPage || 1; // Lấy currentPage, mặc định là 1 nếu không có

  // State lưu thông tin nhân viên
  const [nhanVien, setNhanVien] = useState({
    Ho: '',
    TenLot: '',
    Ten: '',
    GioiTinh: '',
    Email: '',
    HeSoPhatDiTre: '',
    HeSoPhatVangKhongPhep: '',
    SoNgayNghi: '',
    LuongTheoGio: '',
    MaPhongBan: '',
  });

  const [phongBanOptions, setPhongBanOptions] = useState([]); // Lưu danh sách phòng ban

  // Fetch thông tin nhân viên
  const fetchNhanVien = async () => {
    try {
      const res = await fetch(`/api/nhanvien/${MaNV}`); // API lấy thông tin nhân viên
      const data = await res.json();

      if (data.success) {
        const nhanVienData = data.nhanvien; // Giả sử API trả về object nhân viên
        setNhanVien({
          Ho: nhanVienData[1],
          TenLot: nhanVienData[2],
          Ten: nhanVienData[3],
          GioiTinh: nhanVienData[4],
          Email: nhanVienData[5],
          HeSoPhatDiTre: nhanVienData[6],
          HeSoPhatVangKhongPhep: nhanVienData[7],
          SoNgayNghi: nhanVienData[8],
          LuongTheoGio: nhanVienData[9],
          MaPhongBan: nhanVienData[10],
        });
      } else {
        console.error(data.message);
        alert('Không tìm thấy nhân viên!');
        navigate('/nhan-vien');
      }
    } catch (error) {
      console.error('Error fetching nhân viên:', error.message);
      alert('Có lỗi xảy ra khi lấy thông tin nhân viên!');
    }
  };

  // Fetch danh sách phòng ban
  const fetchPhongBans = async () => {
    try {
      const res = await fetch('/api/phongban'); // API lấy danh sách phòng ban
      const data = await res.json();
      const phongbans = data.phongbans.map(
        ([MaPhongBan, TenPhongBan]) => `${MaPhongBan} - ${TenPhongBan}`
      );
      setPhongBanOptions(phongbans);
    } catch (error) {
      console.error('Error fetching phongbans:', error.message);
    }
  };

  // Fetch dữ liệu khi component được render
  useEffect(() => {
    fetchNhanVien();
    fetchPhongBans();
  }, []);

  const validateNhanVien = (nhanVien) => {
    const errors = [];

    // Kiểm tra thiếu trường bắt buộc (trừ trường Tên lót)
    if (!nhanVien.Ho || !nhanVien.Ten || !nhanVien.GioiTinh || !nhanVien.Email || !nhanVien.LuongTheoGio || !nhanVien.MaPhongBan || !nhanVien.HeSoPhatDiTre || !nhanVien.HeSoPhatVangKhongPhep || !nhanVien.SoNgayNghi) {
      errors.push('Hãy điền vào tất cả các trường.');
    }

    // Kiểm tra định dạng cụ thể
    if (nhanVien.Ho && nhanVien.Ho.match(/[^a-zA-ZÀ-ỹ ]/)) {
      errors.push('Họ không được chứa số hoặc ký tự đặc biệt.');
    }

    if (nhanVien.TenLot && nhanVien.TenLot.match(/[^a-zA-ZÀ-ỹ ]/)) {
      errors.push('Tên lót không được chứa số hoặc ký tự đặc biệt.');
    }

    if (nhanVien.Ten && nhanVien.Ten.match(/[^a-zA-ZÀ-ỹ ]/)) {
      errors.push('Tên không được chứa số hoặc ký tự đặc biệt.');
    }

    if (nhanVien.Email && !nhanVien.Email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) {
      errors.push('Email không đúng định dạng.');
    }

    if (nhanVien.LuongTheoGio && parseFloat(nhanVien.LuongTheoGio) <= 0) {
      errors.push('Lương theo giờ phải lớn hơn 0.');
    }

    if (nhanVien.HeSoPhatDiTre && parseFloat(nhanVien.HeSoPhatDiTre) < 0) {
      errors.push('Hệ số phạt đi trễ phải lớn hơn hoặc bằng 0.');
    }

    if (nhanVien.HeSoPhatVangKhongPhep && parseFloat(nhanVien.HeSoPhatVangKhongPhep) < 0) {
      errors.push('Hệ số phạt vắng không phép phải lớn hơn hoặc bằng 0.');
    }

    if (nhanVien.SoNgayNghi && parseInt(nhanVien.SoNgayNghi, 10) < 0) {
      errors.push('Số ngày nghỉ phải lớn hơn hoặc bằng 0.');
    }

    return errors;
  };

  // Hàm xử lý cập nhật nhân viên
  const handleUpdateNhanVien = async () => {
    const errors = validateNhanVien(nhanVien);
    if (errors.length > 0) {
      Toastify({
        text: `Cập nhật thất bại:\n${errors.join('\n')}`,
        duration: 5000,
        gravity: 'top',
        position: 'center',
        stopOnFocus: true,
        className: 'py-[2px] px-[20px] text-center font-medium font-sans text-lg',
        style: {
          background: 'linear-gradient(to right, #FABB7B, #FF8453)'
        }
      }).showToast();
      return;
    }

    const updatedNhanVien = {
      MaNV, // Mã nhân viên từ URL (không thay đổi)
      ...nhanVien,
      HeSoPhatDiTre: parseFloat(nhanVien.HeSoPhatDiTre),
      HeSoPhatVangKhongPhep: parseFloat(nhanVien.HeSoPhatVangKhongPhep),
      SoNgayNghi: parseInt(nhanVien.SoNgayNghi, 10),
      LuongTheoGio: parseFloat(nhanVien.LuongTheoGio),
    };

    try {
      const res = await fetch(`/api/nhanvien/update/${MaNV}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updatedNhanVien),
      });
      const data = await res.json();

      if (data.success) {
        Toastify({
          text: 'Cập nhật thành công',
          duration: 3000,
          gravity: 'top',
          position: 'center',
          stopOnFocus: true,
          className: 'py-[2px] px-[20px] text-center font-medium font-sans text-lg',
          style: {
            background: 'linear-gradient(to right, #00b09b, #96c93d)'
          }
        }).showToast();
        navigate(`/nhan-vien?page=${currentPage}`); // Quay lại trang đúng
      } else {
        Toastify({
          text: `Cập nhật thất bại: ${data.message}`,
          duration: 5000,
          gravity: 'top',
          position: 'center',
          stopOnFocus: true,
          className: 'py-[2px] px-[20px] text-center font-medium font-sans text-lg',
          style: {
            background: 'linear-gradient(to right, #FABB7B, #FF8453)'
          }
        }).showToast();
      }
    } catch (error) {
      console.error('Error updating nhân viên:', error.message);
    }
  };

  return (
    <div className='w-full'>
      <div className='py-5 px-8 flex flex-col gap-3 w-1/2 m-auto'>
        <h1 className='text-center text-lg font-bold'>Chỉnh sửa thông tin nhân viên {MaNV}</h1>
        <InputField
          label={'Họ'}
          value={nhanVien.Ho}
          placeholder={nhanVien.Ho} // Placeholder hiển thị dữ liệu cũ
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, Ho: e.target.value })
          }
        />
        <InputField
          label={'Tên lót'}
          value={nhanVien.TenLot}
          placeholder={nhanVien.TenLot}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, TenLot: e.target.value })
          }
        />
        <InputField
          label={'Tên'}
          value={nhanVien.Ten}
          placeholder={nhanVien.Ten}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, Ten: e.target.value })
          }
        />
        <SelectField
          label={'Giới tính'}
          value={nhanVien.GioiTinh}
          options={['Nam', 'Nữ', 'Khác']}
          placeholder={nhanVien.GioiTinh}
          onchangeHandler={(e) =>
            setNhanVien({ ...nhanVien, GioiTinh: e.target.value })
          }
        />
        <InputField
          label={'Email'}
          value={nhanVien.Email}
          placeholder={nhanVien.Email}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, Email: e.target.value })
          }
        />
        <InputField
          label={'Hệ số phạt đi trễ'}
          value={nhanVien.HeSoPhatDiTre}
          placeholder={nhanVien.HeSoPhatDiTre}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, HeSoPhatDiTre: e.target.value })
          }
        />
        <InputField
          label={'Hệ số phạt vắng không phép'}
          value={nhanVien.HeSoPhatVangKhongPhep}
          placeholder={nhanVien.HeSoPhatVangKhongPhep}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, HeSoPhatVangKhongPhep: e.target.value })
          }
        />
        <InputField
          label={'Số ngày nghỉ'}
          value={nhanVien.SoNgayNghi}
          placeholder={nhanVien.SoNgayNghi}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, SoNgayNghi: e.target.value })
          }
        />
        <InputField
          label={'Lương theo giờ'}
          value={nhanVien.LuongTheoGio}
          placeholder={nhanVien.LuongTheoGio}
          onChangeHandle={(e) =>
            setNhanVien({ ...nhanVien, LuongTheoGio: e.target.value })
          }
        />
        <SelectField
          label={'Mã phòng ban'}
          value={nhanVien.MaPhongBan}
          options={phongBanOptions}
          placeholder={nhanVien.MaPhongBan}
          onchangeHandler={(e) => {
            const MaPhongBan = e.target.value.split(' - ')[0];
            setNhanVien({ ...nhanVien, MaPhongBan });
          }}
        />
        <div className='w-full flex justify-center gap-4'>
          <Button label={'Quay lại'} path={'/nhan-vien'} />
          <Button label={'Cập nhật'} onClickFunction={handleUpdateNhanVien} />
        </div>
      </div>
    </div>
  );
}

export default NhanVienEdit;
