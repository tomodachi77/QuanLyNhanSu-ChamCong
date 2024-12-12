import React, { useState, useEffect } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import InputField from '../components/InputField/InputField';
import SelectField from '../components/SelectField/SelectField';
import Button from '../components/Button/button';
import Toastify from 'toastify-js';

function NhanVienInsert() {
  const [newNhanVien, setNewNhanVien] = useState({
    MaNV: '',
    Ho: '',
    TenLot: '',
    Ten: '',
    GioiTinh: '',
    Email: '',
    LuongTheoGio: '',
    MaPhongBan: ''
  });

  const [phongBanOptions, setPhongBanOptions] = useState([]);

  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const currentPage = parseInt(searchParams.get('page'), 10) || 1;


  // Fetch danh sách phòng ban từ backend
  const fetchPhongBans = async () => {
    try {
      const res = await fetch('/api/dsphongban');
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const data = await res.json();

      // Chuyển đổi mảng con thành chuỗi "MaPhongBan - TenPhongBan"
      const phongbans = data.phongbans.map(([MaPhongBan, TenPhongBan]) => `${MaPhongBan} - ${TenPhongBan}`);
      setPhongBanOptions(phongbans);
    } catch (error) {
      console.error('Error fetching phongbans:', error.message);
    }
  };

  useEffect(() => {
    fetchPhongBans();
  }, []);

  // Các hàm cập nhật từng trường riêng biệt
  const handleSetMaNV = (event) => setNewNhanVien({ ...newNhanVien, MaNV: event.target.value });
  const handleSetHo = (event) => setNewNhanVien({ ...newNhanVien, Ho: event.target.value });
  const handleSetTenLot = (event) => setNewNhanVien({ ...newNhanVien, TenLot: event.target.value });
  const handleSetTen = (event) => setNewNhanVien({ ...newNhanVien, Ten: event.target.value });
  const handleSetGioiTinh = (event) => setNewNhanVien({ ...newNhanVien, GioiTinh: event.target.value });
  const handleSetEmail = (event) => setNewNhanVien({ ...newNhanVien, Email: event.target.value });
  const handleSetLuongTheoGio = (event) => setNewNhanVien({ ...newNhanVien, LuongTheoGio: event.target.value });
  const handleSetMaPhongBan = (event) => {
    const selectedOption = event.target.value;
    const MaPhongBan = selectedOption.split(' - ')[0]; // Lấy phần mã trước dấu "-"
    setNewNhanVien({ ...newNhanVien, MaPhongBan });
  };

  const createNhanVien = async (nhanVien) => {
    const errors = [];
  
    // Kiểm tra thiếu trường bắt buộc (trừ trường Tên lót)
    if (!nhanVien.MaNV || !nhanVien.Ho || !nhanVien.Ten || !nhanVien.GioiTinh || !nhanVien.Email || !nhanVien.LuongTheoGio || !nhanVien.MaPhongBan) {
      errors.push('Hãy điền vào tất cả các trường.');
    }
  
    // Kiểm tra định dạng cụ thể
    if (nhanVien.MaNV && !nhanVien.MaNV.match(/^NV[0-9]{4}$/)) {
      errors.push('Mã nhân viên phải có định dạng NVxxxx, với 4 chữ số.');
    }
  
    if (nhanVien.Email && !nhanVien.Email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) {
      errors.push('Email không đúng định dạng.');
    }
  
    if (nhanVien.Ho && nhanVien.Ho.match(/[^a-zA-ZÀ-ỹ ]/)) {
      errors.push('Họ không được chứa số hoặc ký tự đặc biệt.');
    }
  
    if (nhanVien.Ten && nhanVien.Ten.match(/[^a-zA-ZÀ-ỹ ]/)) {
      errors.push('Tên không được chứa số hoặc ký tự đặc biệt.');
    }
  
    if (nhanVien.LuongTheoGio && parseFloat(nhanVien.LuongTheoGio) <= 0) {
      errors.push('Lương theo giờ phải lớn hơn 0.');
    }
  
    // Nếu có lỗi, trả về danh sách lỗi
    if (errors.length > 0) {
      return {
        success: false,
        message: errors.join('\n') // Kết hợp các lỗi thành một chuỗi
      };
    }
  
    // Nếu không có lỗi, gửi yêu cầu tới API để thêm nhân viên
    const res = await fetch('/api/nhanvien/insert', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(nhanVien)
    });
  
    const data = await res.json();
    return {
      success: data.success,
      message: data.message
    };
  };
  

  const handleAddNhanVien = async () => {
    const { success, message } = await createNhanVien(newNhanVien);
  
    if (!success) {
      // Hiển thị tất cả lỗi trong Toastify
      Toastify({
        text: `Thêm nhân viên không thành công:\n${message}`,
        duration: 5000, // Thời gian hiển thị lâu hơn để đọc hết lỗi
        gravity: 'top',
        position: 'center',
        stopOnFocus: true,
        className: 'py-[2px] px-[20px] text-center font-medium font-sans text-lg',
        style: {
          background: 'linear-gradient(to right, #FABB7B, #FF8453)'
        }
      }).showToast();
    } else {
      Toastify({
        text: 'Thêm nhân viên thành công',
        duration: 3000,
        gravity: 'top',
        position: 'center',
        stopOnFocus: true,
        className: 'py-[2px] px-[20px] text-center font-medium font-sans text-lg',
        style: {
          background: 'linear-gradient(to right, #00b09b, #96c93d)'
        }
      }).showToast();
      navigate(`/nhan-vien?page=${currentPage}`);
    }
  };
  

  const clearFields = () => {
    setNewNhanVien({
      MaNV: '',
      Ho: '',
      TenLot: '',
      Ten: '',
      GioiTinh: '',
      Email: '',
      LuongTheoGio: '',
      MaPhongBan: ''
    });
  };

  return (
    <div className='w-full'>
      <div className='py-5 px-8 flex flex-col gap-3 w-1/2 m-auto'>
        <h1 className='text-center text-lg font-bold'>Thêm nhân viên mới</h1>
        <InputField label={'Mã nhân viên'} placeholder={'NVxxxx'} type={'text'} onChangeHandle={handleSetMaNV} />
        <InputField label={'Họ'} placeholder={'Nguyễn'} type={'text'} onChangeHandle={handleSetHo} />
        <InputField label={'Tên lót'} placeholder={'Văn'} type={'text'} onChangeHandle={handleSetTenLot} />
        <InputField label={'Tên'} placeholder={'A'} type={'text'} onChangeHandle={handleSetTen} />
        <SelectField label={'Giới tính'} options={['Nam', 'Nữ', 'Khác']} onchangeHandler={handleSetGioiTinh} />
        <InputField label={'Email'} placeholder={'example@domain.com'} type={'email'} onChangeHandle={handleSetEmail} />
        <InputField label={'Lương theo giờ'} placeholder={'20000'} type={'number'} onChangeHandle={handleSetLuongTheoGio} />
        <SelectField label={'Mã phòng ban'} options={phongBanOptions} onchangeHandler={handleSetMaPhongBan} />
        <div className='w-full flex flex-row justify-center gap-5'>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Quay lại'} path={'/nhan-vien'} />
          </div>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Thêm nhân viên'} onClickFunction={handleAddNhanVien} />
          </div>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Nhập lại'} onClickFunction={clearFields} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default NhanVienInsert;
