import { useState, useEffect } from 'react'; // Import state và effect
import './App.css';
import { Route, Routes } from 'react-router-dom'
import Sidebar from './components/Sidebar/Sidebar';
import ChiNhanhInfo from './pages/chinhanhInfo';
import DuAnInfo from './pages/DuAnInfo';
import NhanVienInfo from './pages/NhanVienInfo';
import PhongBanInfo from './pages/PhongBanInfo';
import ChiNhanhInsert from './pages/ChiNhanhInsert';
import NhanVienInsert from './pages/NhanVienInsert';
import NhanVienEdit from './pages/NhanVienEdit';
import TinhLuong from './pages/tinhLuong';


// function App() {
//   // Tạo state để lưu trữ danh sách nhân viên
//   const [employees, setEmployees] = useState([]); // Khởi tạo state với mảng rỗng
//   const [loading, setLoading] = useState(true);  // State để hiển thị trạng thái loading

//   // Hàm gọi API lấy danh sách nhân viên
//   const fetchNhanVien = async () => {
//     try {
//       const res = await fetch("/api/nhanvien"); // Gọi API
//       const data = await res.json();           // Chuyển đổi kết quả API thành JSON
//       setEmployees(data.nhanvien);            // Cập nhật state với dữ liệu nhân viên
//       setLoading(false);                      // Kết thúc trạng thái loading
//     } catch (err) {
//       console.error("Lỗi khi gọi API:", err); // Xử lý lỗi (nếu có)
//       setLoading(false);                      // Kết thúc trạng thái loading ngay cả khi lỗi
//     }
//   };

//   // Sử dụng useEffect để gọi hàm fetchNhanVien khi component được mount
//   useEffect(() => {
//     fetchNhanVien();
//   }, []); // [] để chỉ chạy một lần khi component được mount

//   // Hiển thị Loading khi dữ liệu đang được tải
//   if (loading) {
//     return <div>Loading...</div>;
//   }

//   // Render danh sách nhân viên
//   return (
//     <div>
//       {employees.length > 0 ? (
//         employees.map((nhanvien, index) => (
//           <div key={index}>
//             <p>Họ: {nhanvien.Ho}</p>
//             <p>Tên: {nhanvien.Ten}</p>
//             {/* Bạn có thể thêm các thông tin khác tại đây */}
//           </div>
//         ))
//       ) : (
//         <div>Không có nhân viên nào!</div>
//       )}
//     </div>
//   );
// }

function App() {
  return (
    <div className='flex flex-row'>
      <Sidebar/>
      <div className='w-full'>
        <Routes>
          <Route path='/' element={<ChiNhanhInfo/>}/>
          <Route path='/chi-nhanh' element={<ChiNhanhInfo/>}/>
          <Route path='/phong-ban' element={<PhongBanInfo/>}/>
          <Route path='/du-an' element={<DuAnInfo/>}/>
          <Route path='/nhan-vien' element={<NhanVienInfo/>}/>

          <Route path='/chi-nhanh/insert' element={<ChiNhanhInsert/>}/>
          <Route path='/nhan-vien/insert' element={<NhanVienInsert/>}/>
          <Route path="/nhan-vien/edit/:MaNV" element={<NhanVienEdit />} />

          <Route path='tinh-luong' element={<TinhLuong/>}/>
        </Routes>
      </div>
    </div>
  )
}

export default App;
