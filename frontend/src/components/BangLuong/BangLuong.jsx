import React from 'react'
import Table from '../Table/Table'
function BangLuong({Data}) {
    const Headers = ["MSNV", "Tên nhân viên", "Tổng số giờ làm việc", "Lương tạm tính", "Lương thực tế"]
    return (
        <Table columnHeaders={Headers} rowsData={Data} />
    )
}

export default BangLuong