import React from 'react'
import Table from '../Table/Table'

function ChiNhanhTable(props) {
    const headers = ['Mã Chi Nhánh', 'Tên Chi Nhánh', 'Địa chỉ', 'MSNV Quản lý']

    return (
        <div>
            <Table columnHeaders={headers} rowsData={props.rowsData}/>
        </div>
    )
}

export default ChiNhanhTable