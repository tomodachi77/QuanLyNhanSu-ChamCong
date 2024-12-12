import React, { useState } from 'react'
import Table from '../Table/Table'
import { data } from 'react-router';

function PhongBanTable(props) {
    const editFunctionParam = props.rowsData.map((data) => data[0]);
    const deleteFunctionParam = editFunctionParam;
    
    const deleteFunction = (MaPhongBan) => {
        console.log("delete: ", MaPhongBan)
    }

    const editFunction = (MaPhongBan) => {
        console.log('edited: ', MaPhongBan)
    }

    const headers = ['Mã Phòng Ban', 'Tên Phòng Ban', 'Mã Chi Nhánh', 'Số Lượng Nhân viên', 'MSNV Vận Hành', 'Tên NV vận hành', /*'MSNV Quản Lý', 'Tên NV quản lý',*/ "Tùy chỉnh"]

    return (
        <Table columnHeaders={headers} rowsData={props.rowsData} canEdit={true} canDelete={true} deleteFunction={deleteFunction} editFunction={editFunction} editFunctionParam={editFunctionParam} deleteFunctionParam={deleteFunctionParam}/>
    )
}

export default PhongBanTable