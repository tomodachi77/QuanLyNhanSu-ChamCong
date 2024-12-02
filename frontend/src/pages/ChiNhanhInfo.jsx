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
      const res = await fetch("/api/chinhanh");
      const data = await res.json();
      // console.log(data);
      setChiNhanh(data.chinhanh)
    } catch (error) {
      console.log(error);
    }
  }

  useEffect(() => {
    fetchChiNhanh();
  }, []);

  return (
    <div className='flex py-5 flex-col gap-8 items-center'>
        <h1 className='w-full font-bold text-4xl text-center'>
          Thông tin chi nhánh
        </h1>
        <ChiNhanhTable rowsData={ChiNhanh}/>
        <div className='w-fit'>
          <Button label={"Thêm chi nhánh"}/>
        </div>
    </div>
  )
}

export default ChiNhanhInfo