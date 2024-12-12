import React, { useEffect, useState } from 'react'
import Button from '../components/Button/button'
import PhongBanTable from '../components/PhongBanTable/PhongBanTable';

function PhongBanInfo() {
  const [PhongBan, setPhongBan] = useState([])
  
  const fetchPhongBan = async () => {
    try {
      const res = await fetch("/api/phongban");
      const data = await res.json();
      console.log(data);
      setPhongBan(data.phongbaninfo)
    } catch (error) {
      console.log(error);
    }
  }

  useEffect(() => {
    fetchPhongBan();
  }, []);

  return (
    <div className='flex py-5 flex-col gap-8 items-center px-8'>
        <h1 className='w-full font-bold text-4xl text-center'>
          Thông tin phòng ban
        </h1>
        <PhongBanTable rowsData={PhongBan} />
        <div className='w-fit border-blue-300 hover:border-blue-600 border rounded-md'>
          <Button label={"Thêm phòng ban"} path={"/phong-ban/insert"}/>
        </div>
    </div>
  )
}

export default PhongBanInfo