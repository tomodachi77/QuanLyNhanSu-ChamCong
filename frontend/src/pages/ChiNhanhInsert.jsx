import React, { useEffect, useState } from 'react'
import InputField from '../components/InputField/InputField'
import SelectField from '../components/SelectField/SelectField';
import Button from '../components/Button/button';

function ChiNhanhInsert() {
    let [MaNV_TenNhanVien, setMaNV_TenNhanVien] = useState([])
    
    const fetchMaNV_TenNhanVien = async () => {
        try {
            const res = await fetch("/api/FullTime-MaNV-TenNhanVien");
            const data = await res.json()
            // console.log(data.MaNV_TenNhanVien)
            setMaNV_TenNhanVien(data.MaNV_TenNhanVien)
        } catch (error) {
            console.error(error);
        }
    }

    useEffect(() => {
        fetchMaNV_TenNhanVien();
    }, [])

    const options = MaNV_TenNhanVien.map((maNV_TenNV) => maNV_TenNV[0].concat(" - ", maNV_TenNV[1]));
    // const options = []
    return (
        <div className='w-full'>
            <div className='py-5 px-8 flex flex-col gap-3 w-1/2 m-auto'>
                <h1 className='text-center text-lg font-bold'>Thêm chi nhánh mới</h1>
                <InputField label={'Mã chi nhánh'} placeholder={'CN__'} type={'text'} />
                <InputField label={'Địa chỉ'} placeholder={'Số nhà, tên đường, tên phường/xã, tên quận/huyện, tên tỉnh/thành phố'} type={'text'} />
                <InputField label={'Tên chi nhánh'} placeholder={'Chi nhánh ABC'} type={'text'} />
                <SelectField options={options} label={'Chọn nhân viên quản lý chi nhánh'}/>
                <div className='w-full flex flex-row justify-center gap-5'>
                    <div className='my-3 w-fit border-blue-300 border rounded-md'>
                        <Button label={'Quay lại'} path={'/chi-nhanh'}/>
                    </div>
                    <div className='my-3 w-fit border-blue-300 border rounded-md'>
                        <Button label={'Thêm chi nhánh'}/>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default ChiNhanhInsert