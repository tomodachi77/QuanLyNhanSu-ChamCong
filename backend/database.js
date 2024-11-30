import msyql from 'mysql2/promise'
import dotenv from 'dotenv'
dotenv.config()

let MaNV = 'NV1108';
const sql = `SELECT * FROM \`nhanvien\` WHERE \`MaNV\` = '${MaNV}'`
msyql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
})
.then((conn) => conn.query(sql))
.then(([rows, fields]) => console.log(`${rows[0].Ho} ${rows[0].TenLot} ${rows[0].Ten}`));
// connection.query(sql, (err, rows, fields))
// .then()

// try {
//     const sql = `SELECT * FROM \`nhanvien\` WHERE \`MaNV\` = '${MaNV}'`
  
//     const [rows, fields] = await connection.query({
//       sql
//     });
  
//     console.log(rows);
//     console.log(fields);
//   } catch (err) {
//     console.log(err);
//   }

// printNhanVien('NV1108')

