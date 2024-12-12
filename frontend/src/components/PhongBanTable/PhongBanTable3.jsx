import Table from '../Table/Table';

function PhongBanTable3({ rowsData }) {
    const headers = ['Mã Phòng Ban', 'Tên Phòng Ban', 'Số Lượng Nhân viên', 'Tổng số ngày có mặt'];

    return (
        <Table 
            columnHeaders={headers} 
            rowsData={rowsData} 
            canEdit={false} 
            canDelete={false} 
        />
    );
}

export default PhongBanTable3;
