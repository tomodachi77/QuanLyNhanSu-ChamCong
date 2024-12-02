import React from 'react'
import Table from '../Table/Table'

function ChiNhanhTable(props) {
    const headers = ['Mã Chi Nhánh', 'Tên Chi Nhánh', 'Địa chỉ', 'MSNV Quản lý', "Tên NV quản lý", ""]

    return (
        <Table columnHeaders={headers} rowsData={props.rowsData} canEdit={true} canDelete={true}/>
    )
}

export default ChiNhanhTable