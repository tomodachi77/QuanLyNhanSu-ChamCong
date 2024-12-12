import React, { useEffect, useState } from 'react';
import Button from '../components/Button/button';
import PhongBanTable from '../components/PhongBanTable/PhongBanTable';
import PhongBanTable2 from '../components/PhongBanTable/PhongBanTable2'; 
import PhongBanTable3 from '../components/PhongBanTable/PhongBanTable3';

function PhongBanInfo() {
  const [phongBan, setPhongBan] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const rowsPerPage = 10; // Số dòng hiển thị mỗi trang

  // Thêm state cho chức năng lọc
  const [filterEnabled, setFilterEnabled] = useState(false);
  const [filterValue, setFilterValue] = useState(0);

  // State cho chức năng lọc phòng ban có mặt nhiều nhất
  const [showMaxPresence, setShowMaxPresence] = useState(false);

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

  // Fetch dữ liệu lọc từ server
  const fetchFilteredPhongBan = async () => {
    try {
      const res = await fetch(`/api/phongban-co-nhanvien-lon-hon?min=${filterValue}`);
      const data = await res.json();
      if (data.success) {
        setPhongBan(data.filteredPhongBan);
      } else {
        console.error("Không có dữ liệu sau khi lọc.");
      }
    } catch (error) {
      console.error("Lỗi khi lọc dữ liệu:", error);
    }
  };

  // Fetch dữ liệu phòng ban có mặt nhiều nhất
  const fetchMaxPresencePhongBan = async () => {
    try {
      const res = await fetch("/api/phongban-nhanvien-comatnhieunhat");
      const data = await res.json();
      if (data.success) {
        setPhongBan(data.maxPresencePhongBan);
      } else {
        console.error("Không có dữ liệu phòng ban có mặt nhiều nhất.");
      }
    } catch (error) {
      console.error("Lỗi khi fetch dữ liệu phòng ban có mặt nhiều nhất:", error);
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

  // Hàm bật/tắt lọc
  const handleFilter = () => {
    if (filterEnabled) {
      // Nếu lọc đang bật, tắt lọc và load lại toàn bộ dữ liệu
      fetchPhongBan();
    } else {
      // Nếu lọc đang tắt, bật lọc và lấy dữ liệu lọc
      fetchFilteredPhongBan();
    }
    setFilterEnabled(!filterEnabled);
  };

  // Hàm bật/tắt hiển thị phòng ban có mặt nhiều nhất
  const handleMaxPresence = () => {
    if (!showMaxPresence) {
      fetchMaxPresencePhongBan();
    } else {
      fetchPhongBan();
    }
    setShowMaxPresence(!showMaxPresence);
    setFilterEnabled(false); // Reset trạng thái lọc
  };

  return (
    <div className='flex py-5 flex-col gap-8 items-center px-8'>
      <h1 className='w-full font-bold text-4xl text-center'>
        Thông tin phòng ban
      </h1>
      <div className="flex gap-4 items-center">
        {/* Input để nhập số lượng nhân viên */}
        <input
          type="number"
          placeholder="Nhập số lượng nhân viên tối thiểu"
          value={filterValue}
          onChange={(e) => setFilterValue(e.target.value)}
          className="border rounded-md px-3 py-2 w-20"
        />
        {/* Nút để bật/tắt lọc */}
        <button
          onClick={handleFilter}
          className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600"
        >
          {filterEnabled ? "Tắt lọc" : "Lọc phòng ban"}
        </button>

        {/* Nút để bật/tắt hiển thị phòng ban có mặt nhiều nhất */}
        <button
          onClick={handleMaxPresence}
          className="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 ml-20"
        >
          {showMaxPresence ? "Tắt hiển thị" : "Phòng ban NV có mặt nhiều nhất"}
        </button>
      </div>

      {/* Chọn bảng hiển thị dựa trên trạng thái */}
      {showMaxPresence ? (
        <PhongBanTable3 rowsData={currentRows} />
      ) : filterEnabled ? (
        <PhongBanTable2 rowsData={currentRows} />
      ) : (
        <PhongBanTable rowsData={currentRows} />
      )}

      {/* Truyền dữ liệu đã phân trang xuống component PhongBanTable
      <PhongBanTable rowsData={currentRows} /> */}

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
