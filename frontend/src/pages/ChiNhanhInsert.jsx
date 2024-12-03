import React, { useEffect, useState } from 'react'
import InputField from '../components/InputField/InputField'
import SelectField from '../components/SelectField/SelectField';
import Button from '../components/Button/button';
import Toastify from 'toastify-js'

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

    const [newChiNhanh, setNewChiNhanh] = useState({
        MaChiNhanh: "",
        DiaChi: "",
        TenChiNhanh: "",
        MSNV_QuanLy: ""
    })

    const handleSetCN = (event) => {
        setNewChiNhanh({...newChiNhanh, MaChiNhanh: event.target.value});
        // console.log(MaChiNhanh)
    }

    const handleSetDiaChi = (event) => {
        setNewChiNhanh({...newChiNhanh, DiaChi: event.target.value});
        // console.log(DiaChi)
    }
    
    const handleSetTenChiNhanh = (event) => {
        setNewChiNhanh({...newChiNhanh, TenChiNhanh: event.target.value});
        // console.log(TenChiNhanh)
    }

    const handleSetMaNVQL = (event) => {
        const newValue = event.target.value;
        if (newValue !== '')
            setNewChiNhanh({...newChiNhanh, MSNV_QuanLy: newValue.substr(0, 6)});
        // console.log(MSNV_QuanLy)
    }

    // createProduct: async (newProduct) => {
	// 	if (!newProduct.name || !newProduct.image || !newProduct.price) {
	// 		return { success: false, message: "Please fill in all fields." };
	// 	}
	// 	const res = await fetch("/api/products", {
	// 		method: "POST",
	// 		headers: {
	// 			"Content-Type": "application/json",
	// 		},
	// 		body: JSON.stringify(newProduct),
	// 	});
	// 	const data = await res.json();
	// 	set((state) => ({ products: [...state.products, data.data] }));
	// 	return { success: true, message: "Product created successfully" };
	// },

    const createChiNhanh = async (newChiNhanh) => {
        if (!newChiNhanh.MaChiNhanh || !newChiNhanh.DiaChi || !newChiNhanh.TenChiNhanh || !newChiNhanh.MSNV_QuanLy) {
            return {
                success: false,
                message: "Hãy điền vào tất cả các fields"
            };
        }

        const res = await fetch("/api/chinhanh/insert", {
            method: 'POST',
            headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(newChiNhanh),
        });

        const data = await res.json();
        return {
            success: data.success,
            message: data.message
        };
    }

    const handleAddChiNhanh = async () => {
        const {success, message} = await createChiNhanh(newChiNhanh);
        if (!success) {
            // console.log("fail", message);
            Toastify({
                text: `Thêm chi nhánh không thành công. Lý do: ${message}`,
                duration: 3000,
                gravity: "top",
                position: 'center',
                stopOnFocus: true,
                className: "py-[2px] px-[20px] text-center font-medium font-sans text-lg",
                style: {
                    background: "linear-gradient(to right, #FABB7B, #FF8453)",
                }
            }).showToast()
        } else {
            Toastify({
                text: "Thêm chi nhánh thành công",
                duration: 3000,
                gravity: "top",
                position: 'center',
                stopOnFocus: true,
                className: "py-[2px] px-[20px] text-center font-medium font-sans text-lg",
                style: {
                    background: "linear-gradient(to right, #00b09b, #96c93d)",
                }
            }).showToast();
        }
        
    }

    // FOR DEBUG PURPOSE
    const clicked = () => {
        console.log(newChiNhanh)
    }

    const clearFields = () => {
        const inputs = document.getElementsByName('input');
        inputs.forEach(input => {
            input.value = "";
        });
    }

    // const options = []
    return (
        <div className='w-full'>
            <div className='py-5 px-8 flex flex-col gap-3 w-1/2 m-auto'>
                <h1 className='text-center text-lg font-bold'>Thêm chi nhánh mới</h1>
                <InputField label={'Mã chi nhánh'} placeholder={'CN__'} type={'text'} onChangeHandle={handleSetCN}/>
                <InputField label={'Địa chỉ'} placeholder={'Số nhà, tên đường, tên phường/xã, tên quận/huyện, tên tỉnh/thành phố'} type={'text'} onChangeHandle={handleSetDiaChi} />
                <InputField label={'Tên chi nhánh'} placeholder={'Chi nhánh ABC'} type={'text'} onChangeHandle={handleSetTenChiNhanh} />
                <SelectField options={options} label={'Chọn nhân viên quản lý chi nhánh'} onchangeHandler={handleSetMaNVQL}/>
                <div className='w-full flex flex-row justify-center gap-5'>
                    <div className='my-3 w-fit border-blue-300 border rounded-md'>
                        <Button label={'Quay lại'} path={'/chi-nhanh'}/>
                    </div>
                    <div className='my-3 w-fit border-blue-300 border rounded-md'>
                        <Button label={'Thêm chi nhánh'} onClickFunction={handleAddChiNhanh}/>
                    </div>
                    <div className='my-3 w-fit border-blue-300 border rounded-md'>
                        <Button label={'Nhập lại'} onClickFunction={clearFields}/>
                    </div>
                    <div className='my-3 w-fit border-blue-300 border rounded-md hidden'>
                        <Button label={'Check Value'} onClickFunction={clicked}/>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default ChiNhanhInsert