import React, { useEffect, useState } from 'react';
import Button from '../components/Button/button';
import NhanVienTable from '../components/NhanVienTable/NhanVienTable';

function NhanVienInfo() {
  const [nhanVien, setNhanVien] = useState([]);

  // Fetch dữ liệu chỉ một lần tại đây
  const fetchNhanVien = async () => {
    try {
      const res = await fetch('/api/nhanvien');
      const data = await res.json();
      setNhanVien(data.nhanvien);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    fetchNhanVien();
  }, []);

  return (
    <div className='flex py-5 flex-col gap-8 items-center px-8'>
      <h1 className='w-full font-bold text-4xl text-center'>
        Thông tin nhân viên
      </h1>
      {/* Truyền dữ liệu xuống component NhanVienTable */}
      <NhanVienTable rowsData={nhanVien} setRowsData={setNhanVien} />
      <div className='w-fit border-blue-300 hover:border-blue-600 border rounded-md'>
        <Button label={'Thêm nhân viên'} path={'/nhan-vien/insert'} />
      </div>
    </div>
  );
}

export default NhanVienInfo;
