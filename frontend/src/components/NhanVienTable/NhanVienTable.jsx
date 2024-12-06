import React from 'react';
import Table from '../Table/Table';
import { useNavigate } from 'react-router-dom';


function NhanVienTable({ rowsData, setRowsData }) {
  // Định nghĩa các cột cho bảng nhân viên
  const headers = [
    'Mã Nhân Viên', 
    'Họ', 
    'Tên Lót', 
    'Tên', 
    'Giới Tính', 
    'Email',
    'Hệ Số Phạt Đi Trễ',
    'Hệ Số Phạt Vắng Không Phép',
    'Số Ngày Nghỉ', 
    'Lương Theo Giờ', 
    'Mã Phòng Ban', 
    'Tùy chỉnh'
  ];

  // Tạo các tham số cho hàm sửa và xóa
  console.log('rowsData in NhanVienTable:', rowsData);
  const editFunctionParam = rowsData.map((data) => {
    if (Array.isArray(data)) {
      return data[0]; // Lấy giá trị tại index 0
    }
    console.error('Hàng dữ liệu không phải mảng:', data);
    return undefined; // Trả về undefined nếu không phải mảng
  });
  

  const deleteFunctionParam = rowsData.map((data) => data[0]); // Lấy MãNV từ index 0


  // Định nghĩa hàm xóa nhân viên
  const deleteFunction = async (MaNV) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa nhân viên này không?')) {
      // Xóa tạm thời hàng khỏi giao diện trước
      setRowsData((prevRows) => prevRows.filter((row) => row[0] !== MaNV));
  
      try {
        const res = await fetch(`/api/nhanvien/delete/${MaNV}`, {
          method: 'DELETE',
        });
        const data = await res.json();
        
        if (data.success) {
          alert('Xóa nhân viên thành công');
        } else {
          alert('Xóa nhân viên không thành công: ' + data.message);
          // Khôi phục lại hàng nếu xóa không thành công
          setRowsData((prevRows) => [...prevRows, rowsData.find((row) => row[0] === MaNV)]);
        }
      } catch (error) {
        console.error('Error deleting employee:', error);
        // Khôi phục lại hàng nếu có lỗi xảy ra
        setRowsData((prevRows) => [...prevRows, rowsData.find((row) => row[0] === MaNV)]);
      }
    }
  };
  

  // Định nghĩa hàm sửa nhân viên
  /*const editFunction = (MaNV) => {
    console.log('edit: ', MaNV);
    // Điều hướng đến trang chỉnh sửa nhân viên (hoặc thêm logic chỉnh sửa tại đây)
  };*/
  const navigate = useNavigate();

  const editFunction = (MaNV) => {
    console.log('MaNV received in editFunction:', MaNV); // Log giá trị MaNV
    if (MaNV) {
      navigate(`/nhan-vien/edit/${MaNV}`);
    } else {
      console.error('Mã nhân viên không hợp lệ');
    }
  };



  return (
    <Table
      columnHeaders={headers}
      rowsData={rowsData}
      canEdit={true}
      canDelete={true}
      deleteFunction={deleteFunction}
      editFunction={editFunction}
      editFunctionParam={editFunctionParam}
      deleteFunctionParam={deleteFunctionParam}
    />
  );
}

export default NhanVienTable;
