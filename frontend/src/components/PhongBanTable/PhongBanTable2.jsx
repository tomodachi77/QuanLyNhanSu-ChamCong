import Table from '../Table/Table';

function PhongBanTable2({ rowsData }) {
    const headers = ['Mã Phòng Ban', 'Tên Phòng Ban', 'Số Lượng Nhân viên'];

    return (
        <Table 
            columnHeaders={headers} 
            rowsData={rowsData} 
            canEdit={false} 
            canDelete={false} 
        />
    );
}

export default PhongBanTable2;
