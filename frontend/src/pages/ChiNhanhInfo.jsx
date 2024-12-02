import React, { useEffect, useState } from 'react'
import Button from '../components/Button/button'
import ChiNhanhTable from '../components/ChiNhanhTable/ChiNhanhTable';

// let temp = "Khoi"

// MaChiNhanh: "CN01", TenChiNhanh: "Chi nhánh Cần Thơ", DiaChi: "321 Đường Cần Thơ, Cần Thơ", … }
// DiaChi: "321 Đường Cần Thơ, Cần Thơ"
// MSNV_QuanLy: "NV3058"
// MaChiNhanh: "CN01"
// TenChiNhanh: "Chi nhánh Cần Thơ"

function ChiNhanhInfo() {
  const [ChiNhanh, setChiNhanh] = useState([])
  
  const fetchChiNhanh = async () => {
    try {
      const res = await fetch("/api/chinhanh-tenQuanLy");
      const data = await res.json();
      console.log(data)
      // console.log(data);
      setChiNhanh(data.chinhanh_tenQuanLy)
    } catch (error) {
      console.log(error);
    }
  }

  useEffect(() => {
    fetchChiNhanh();
  }, []);

  return (
    <div className='flex py-5 flex-col gap-8 items-center px-8'>
        <h1 className='w-full font-bold text-4xl text-center'>
          Thông tin chi nhánh
        </h1>
        <ChiNhanhTable rowsData={ChiNhanh}/>
        <div className='w-fit border-blue-300 border rounded-md'>
          <Button label={"Thêm chi nhánh"} path={"/chi-nhanh/insert"}/>
        </div>
    </div>
  )
}

export default ChiNhanhInfo