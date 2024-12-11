import React, { useEffect, useState } from 'react'
import SelectField from '../components/SelectField/SelectField'
import InputField from '../components/InputField/InputField'
import Button from '../components/Button/button'
import BangLuong from '../components/BangLuong/BangLuong'

function numberWithSpaces(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}

function TinhLuong() {

    const [chiNhanhOptions, setChiNhanhOptions] = useState([]);
    const [phongBanOptions, setPhongBanOptions] = useState([]);

    const fetch_ChiNhanhOptions = async() => {
        try {
            const res = await fetch("/api/chinhanh-tenChiNhanh")
            const data = await res.json();
            // console.log(data.MaChiNhanh_TenChiNhanh);
            setChiNhanhOptions(data.MaChiNhanh_TenChiNhanh);
        } catch (error) {
            console.log(error);
        }
    }
    
    useEffect(() => {
        fetch_ChiNhanhOptions();
    }, [])
    

    const [beginDate, setBeginDate] = useState("")
    const [endDate, setEndDate] = useState("")
    const [maChiNhanh, setMaChiNhanh] = useState("");
    const [maPhongBan, setMaPhongBan] = useState("");
    const [empType, setEmpType] = useState(0);

    const fetch_PhongBanOptions = async(maChiNhanh) => {
        try {
            let res = null
            if (maChiNhanh !== '') {
                res = await fetch(`/api/phongBan-TenPhongBan/${maChiNhanh}`)
            } else {
                res = await fetch(`/api/phongBan-TenPhongBan/all`)
            }

            const data = await res.json();
            // console.log(data.MaPhongBan_TenPhongBan);
            setPhongBanOptions(data.MaPhongBan_TenPhongBan);
        } catch (error) {
            console.log(error)
        }
    }

    useEffect(() => {
        fetch_PhongBanOptions(maChiNhanh);
    }, [maChiNhanh])

    const handleBeginDate = (event) => {
        setBeginDate(event.target.value);
    }

    const handleEndDate = (event) => {
        setEndDate(event.target.value);
    }

    const handleMaChiNhanh = (event) => {
        const newValue = event.target.value;
        setMaChiNhanh(newValue.substr(0, 4));
    }

    const handleMaPhongBan = (event) => {
        const newValue = event.target.value;
        setMaPhongBan(newValue.substr(0, 6));
    }

    const handleEmpType = (event) => {
        const raw_type = event.target.value;
        if (raw_type === "") setEmpType(0);
        else if (raw_type === "Nhân viên toàn thời gian") setEmpType(1);
        else setEmpType(-1);
    }

    const checkValue = () => {
        console.log("BEGIN_DATE: ", beginDate)
        console.log("END DATE: ", endDate)
        // console.log(chiNhanhOptions)
        console.log("MA CN: ", maChiNhanh)
        console.log("Ma PhongBan: ", maPhongBan)
        console.log("EmpType: ", empType)
        console.log("bangLuongData: ", bangLuongData)
    }

    const [bangLuongData, setBangLuongData] = useState([]);
    
    const fetchBangLuong = async (maPhongBan, empType, beginDate, endDate) => {
        try {
            // http://localhost:3000/api/bang-luong?MaChiNhanh=&EmpType=1&BeginDate=2024-10-01&EndDate=2024-10-31
            const res = await fetch(`api/bang-luong?MaPhongBan=${maPhongBan}&EmpType=${empType}&BeginDate=${beginDate}&EndDate=${endDate}`);
            // console.log(`api/bang-luong?MaPhongBan=${maPhongBan}&EmpType=${empType}&BeginDate=${beginDate}&EndDate=${endDate}`);
            const data = await res.json();
            console.log(data.BangLuong)
            data.BangLuong.forEach(item => {
                item[3] = numberWithSpaces(item[3])
                item[4] = numberWithSpaces(Math.round(item[4]))
            });
            setBangLuongData(data.BangLuong);
        } catch (error) {
            console.log(error);
        }
    }

    const [curPage, setCurPage] = useState(1);
    const [maxPage, setMaxPage] = useState(1);

    useEffect(() => {
        fetchBangLuong(maPhongBan, empType, beginDate, endDate);
    }, [maPhongBan, empType, beginDate, endDate])

    useEffect(() => {
        setMaxPage(Math.ceil(bangLuongData.length / 10));
        if (maxPage == 0) setCurPage(0);
        else setCurPage(1);
    }, [bangLuongData, maxPage])
    
    const handlePreviousPage = () => {
        if (curPage <= 1) return;
        setCurPage(curPage - 1);
    }

    const handleNextPage = () => {
        if (curPage == maxPage) return;
        setCurPage(curPage + 1);
    }

    const [curData, setCurData] = useState([]);

    useEffect(() => {
        setCurData(bangLuongData.slice(curPage * 10 - 10, curPage * 10));
    }, [bangLuongData, curPage])

    return (
        <div className='flex py-5 flex-col gap-8 items-center px-8'>
            <h1 className='w-full font-bold text-4xl text-center'>
                Tính lương cho nhân viên
            </h1>

            <div className='flex flex-col w-full gap-3'>
                <div className='flex flex-row gap-5'>
                    <SelectField label={"Chi nhánh"} placeholder={"Tất cả"} options={chiNhanhOptions} onchangeHandler={handleMaChiNhanh}/>
                    <SelectField label={"Phòng ban"} placeholder={"Tất cả"} options={phongBanOptions} onchangeHandler={handleMaPhongBan} />
                    <SelectField label={"Loại nhân viên"} placeholder={"Tất cả"} options={["Nhân viên toàn thời gian", "Nhân viên bán thời gian"]} onchangeHandler={handleEmpType}/>
                </div>

                <div className='flex flex-row gap-5'>
                    <InputField label={"Ngày bắt đầu tính lương"} type={'date'} onChangeHandle={handleBeginDate}/>
                    <InputField label={"Ngày kết thúc"} type={'date'} onChangeHandle={handleEndDate}/>
                </div>
            </div>

            <div>
                <BangLuong Data={curData}/>
            </div>
            
            <div className='flex flex-row items-center gap-5' >
                <div className='w-fit border border-blue-400 rounded-md'><Button label={"Trang trước"} onClickFunction={handlePreviousPage}/></div>
                Trang {curPage} / {maxPage}
                <div className='w-fit border border-blue-400 rounded-md'><Button label={"Trang sau"} onClickFunction={handleNextPage}/></div>
            </div>
            <div className='border rounded-md border-blue-400'>
                <Button label={"Check Value"} onClickFunction={checkValue}/>
            </div>
        </div>
    )
}

export default TinhLuong