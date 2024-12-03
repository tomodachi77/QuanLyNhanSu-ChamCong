import React, { useState } from 'react'
import Table from '../Table/Table'
import { data } from 'react-router';

function ChiNhanhTable(props) {
    const editFunctionParam = props.rowsData.map((data) => data[0]);
    const deleteFunctionParam = editFunctionParam;
    
    const deleteFunction = (MaChiNhanh) => {
        console.log("delete: ", MaChiNhanh)
    }

    const editFunction = (MaChiNhanh) => {
        console.log('edited: ', MaChiNhanh)
    }

    const headers = ['Mã Chi Nhánh', 'Tên Chi Nhánh', 'Địa chỉ', 'MSNV Quản lý', "Tên NV quản lý", "Tùy chỉnh"]

    return (
        <Table columnHeaders={headers} rowsData={props.rowsData} canEdit={true} canDelete={true} deleteFunction={deleteFunction} editFunction={editFunction} editFunctionParam={editFunctionParam} deleteFunctionParam={deleteFunctionParam}/>
    )
}

export default ChiNhanhTable