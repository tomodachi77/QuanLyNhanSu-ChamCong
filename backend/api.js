import { query } from "./database.js";

export const getNhanVien = async () => {
    const rows = await query('Select * from nhanvien limit 5');
    return rows;
}

export const getPhongBan = async (MaPB) => {
    const rows = await query(`SELECT * FROM phongban WHERE MaPhongBan='${MaPB}'`)
    return rows;
}


