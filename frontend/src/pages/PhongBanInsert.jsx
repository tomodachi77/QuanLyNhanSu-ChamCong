import React, { useState, useEffect } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import InputField from '../components/InputField/InputField';
import SelectField from '../components/SelectField/SelectField';
import Button from '../components/Button/button';
import Toastify from 'toastify-js';

function PhongBanInsert() {
  const [newPhongBan, setNewPhongBan] = useState({
    MaPhongBan: '',
    TenPhongBan: '',
    MaChiNhanh: '',
    SoLuongNhanVien: '',
    MSNV_VanHanh: ''
  });

  const [chiNhanhOptions, setChiNhanhOptions] = useState([]);

  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const currentPage = parseInt(searchParams.get('page'), 10) || 1;

  // Fetch danh sách chi nhánh từ backend
  const fetchChiNhanhs = async () => {
    try {
      const res = await fetch('/api/chinhanh');
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const data = await res.json();

      // Chuyển đổi dữ liệu thành mảng chuỗi "MaChiNhanh - TenChiNhanh"
      const chinhanhs = data.chinhanh.map(([MaChiNhanh, TenChiNhanh]) => `${MaChiNhanh} - ${TenChiNhanh}`);
      setChiNhanhOptions(chinhanhs);
    } catch (error) {
      console.error('Error fetching chinhanhs:', error.message);
    }
  };

  useEffect(() => {
    fetchChiNhanhs();
  }, []);

  // Các hàm cập nhật từng trường riêng biệt
  const handleSetMaPhongBan = (event) => setNewPhongBan({ ...newPhongBan, MaPhongBan: event.target.value });
  const handleSetTenPhongBan = (event) => setNewPhongBan({ ...newPhongBan, TenPhongBan: event.target.value });
  const handleSetMaChiNhanh = (event) => {
    const selectedOption = event.target.value;
    const MaChiNhanh = selectedOption.split(' - ')[0]; // Lấy phần mã trước dấu "-"
    setNewPhongBan({ ...newPhongBan, MaChiNhanh });
  };
  const handleSetSoLuongNhanVien = (event) => setNewPhongBan({ ...newPhongBan, SoLuongNhanVien: event.target.value });
 

  const createPhongBan = async (phongBan) => {
    const errors = [];

    // Kiểm tra thiếu trường bắt buộc
    if (!phongBan.MaPhongBan || !phongBan.TenPhongBan || !phongBan.MaChiNhanh || !phongBan.MSNV_VanHanh) {
      errors.push('Hãy điền vào tất cả các trường bắt buộc.');
    }

    // Kiểm tra định dạng cụ thể
    if (phongBan.MaPhongBan && !phongBan.MaPhongBan.match(/^PB[0-9]{4}$/)) {
      errors.push('Mã phòng ban phải có định dạng PBxxxx, với 4 chữ số.');
    }

    if (phongBan.SoLuongNhanVien && parseInt(phongBan.SoLuongNhanVien, 10) < 0) {
      errors.push('Số lượng nhân viên phải lớn hơn hoặc bằng 0.');
    }

    // Nếu có lỗi, trả về danh sách lỗi
    if (errors.length > 0) {
      return {
        success: false,
        message: errors.join('\n')
      };
    }

    // Gửi yêu cầu tới API để thêm phòng ban
    const res = await fetch('/api/phongban/insert', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(phongBan)
    });

    const data = await res.json();
    return {
      success: data.success,
      message: data.message
    };
  };

  const handleAddPhongBan = async () => {
    const { success, message } = await createPhongBan(newPhongBan);

    if (!success) {
      Toastify({
        text: `Thêm phòng ban không thành công:\n${message}`,
        duration: 5000,
        gravity: 'top',
        position: 'center',
        stopOnFocus: true,
        style: {
          background: 'linear-gradient(to right, #FABB7B, #FF8453)'
        }
      }).showToast();
    } else {
      Toastify({
        text: 'Thêm phòng ban thành công',
        duration: 3000,
        gravity: 'top',
        position: 'center',
        stopOnFocus: true,
        style: {
          background: 'linear-gradient(to right, #00b09b, #96c93d)'
        }
      }).showToast();
      navigate(`/phong-ban?page=${currentPage}`);
    }
  };

  const clearFields = () => {
    const inputs = document.getElementsByName('input');
    inputs.forEach(input => {
        input.value = "";
    });
}

  return (
    <div className='w-full'>
      <div className='py-5 px-8 flex flex-col gap-3 w-1/2 m-auto'>
        <h1 className='text-center text-lg font-bold'>Thêm phòng ban mới</h1>
        <InputField label={'Mã phòng ban'} placeholder={'PBxxxx'} type={'text'} onChangeHandle={handleSetMaPhongBan} />
        <InputField label={'Tên phòng ban'} placeholder={'Phòng Kế Toán'} type={'text'} onChangeHandle={handleSetTenPhongBan} />
        <SelectField label={'Mã chi nhánh'} options={chiNhanhOptions} onchangeHandler={handleSetMaChiNhanh} />
        <InputField label={'Số lượng nhân viên'} placeholder={'0'} type={'number'} onChangeHandle={handleSetSoLuongNhanVien} />
        <SelectField options={options} label={'Chọn nhân viên vận hành phòng ban'} onchangeHandler={handleSetMaNVVH}/>
        <div className='w-full flex flex-row justify-center gap-5'>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Quay lại'} path={'/phong-ban'} />
          </div>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Thêm phòng ban'} onClickFunction={handleAddPhongBan} />
          </div>
          <div className='my-3 w-fit border-blue-300 border rounded-md'>
            <Button label={'Nhập lại'} onClickFunction={clearFields} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default PhongBanInsert;
