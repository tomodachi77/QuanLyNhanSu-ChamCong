import { ReadQuery, WriteQuery } from "./database.js";

export const getNhanVien = async () => {
    const rows = await ReadQuery('Select * from nhanvien limit 5');
    return rows;
}

export const getPhongBan = async (MaPB) => {
    const rows = await ReadQuery(`SELECT * FROM phongban WHERE MaPhongBan='${MaPB}'`)
    return rows;
}

export const getChiNhanh = async () => {
    const rows = await ReadQuery('Select * from chinhanh');
    return rows;
}

export const getChiNhanh_Manager = async () => {
    const rows = await ReadQuery(`SELECT \`MaChiNhanh\`, \`TenChiNhanh\`, \`DiaChi\`, nhanvien.\`MaNV\`, CONCAT(nhanvien.\`Ho\`,' ', nhanvien.\`TenLot\`,' ', nhanvien.\`Ten\`) as 'TenQuanLy' from chinhanh JOIN nhanvien ON chinhanh.\`MSNV_QuanLy\`=nhanvien.\`MaNV\`;`)
    return rows;
}

export const insertChiNhanh = async (MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy) => {
    const [result, message] = await WriteQuery(`CALL \`insert_ChiNhanh\`('${MaChiNhanh}', '${TenChiNhanh}', '${DiaChi}', '${MSNV_QuanLy}')`);
    // console.log("result", result)
    return [result, message];
}

