import React, { useEffect, useState } from 'react';
import Button from '../components/Button/button';
import PhongBanTable from '../components/PhongBanTable/PhongBanTable';

function PhongBanInfo() {
  const [phongBan, setPhongBan] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const rowsPerPage = 10; // Số dòng hiển thị mỗi trang

  // Fetch dữ liệu từ server
  const fetchPhongBan = async () => {
    try {
      const res = await fetch("/api/phongban");
      const data = await res.json();
      console.log(data);
      setPhongBan(data.phongbaninfo);
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    fetchPhongBan();
  }, []);

  // Xác định dữ liệu cho trang hiện tại
  const totalPages = Math.ceil(phongBan.length / rowsPerPage);
  const currentRows = phongBan.slice(
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
        Thông tin phòng ban
      </h1>

      {/* Truyền dữ liệu đã phân trang xuống component PhongBanTable */}
      <PhongBanTable rowsData={currentRows} />

      {/* Điều hướng phân trang */}
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
        <Button label={"Thêm phòng ban"} path={"/phong-ban/insert"} />
      </div>
    </div>
  );
}

export default PhongBanInfo;
