import React, { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import Button from '../components/Button/button';
import NhanVienTable from '../components/NhanVienTable/NhanVienTable';

function NhanVienInfo() {
  const [nhanVien, setNhanVien] = useState([]);
  const [searchParams] = useSearchParams();
  const initialPage = parseInt(searchParams.get('page'), 10) || 1;
  const [currentPage, setCurrentPage] = useState(initialPage);
  const rowsPerPage = 10;

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

  // Xác định dữ liệu cho trang hiện tại
  const totalPages = Math.ceil(nhanVien.length / rowsPerPage);
  const currentRows = nhanVien.slice(
    (currentPage - 1) * rowsPerPage,
    currentPage * rowsPerPage
  );

  // Hàm thay đổi trang
  const handlePageChange = (page) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  return (
    <div className='flex py-5 flex-col gap-8 items-center px-8'>
      <h1 className='w-full font-bold text-4xl text-center'>
        Thông tin nhân viên
      </h1>
      {/* Truyền dữ liệu xuống component NhanVienTable */}
      <NhanVienTable rowsData={currentRows} setRowsData={setNhanVien} currentPage={currentPage} />
      {/* Phân trang */}
      <div className='flex justify-center gap-4 mt-4'>
        <button
          onClick={() => handlePageChange(currentPage - 1)}
          disabled={currentPage === 1}
          className='px-4 py-2 bg-gray-300 rounded-md hover:bg-gray-400 disabled:bg-gray-200'
        >
          Trang trước
        </button>
        <span>
          Trang {currentPage} / {totalPages}
        </span>
        <button
          onClick={() => handlePageChange(currentPage + 1)}
          disabled={currentPage === totalPages}
          className='px-4 py-2 bg-gray-300 rounded-md hover:bg-gray-400 disabled:bg-gray-200'
        >
          Trang sau
        </button>
      </div>
      <div className='w-fit border-blue-300 hover:border-blue-600 border rounded-md'>
        <Button label={'Thêm nhân viên'} path={'/nhan-vien/insert'} />
      </div>
    </div>
  );
}

export default NhanVienInfo;
