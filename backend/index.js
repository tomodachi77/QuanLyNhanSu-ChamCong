import express from 'express'
import dotenv from 'dotenv'
import { getChiNhanh, getChiNhanh_Manager, getMaNV_TenNhanVien, getNhanVien, getPhongBan, insertChiNhanh } from './api.js'
import bodyParser from 'body-parser'

dotenv.config()

const app = express()
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
const PORT = process.env.BE_PORT || 3000

app.get('/', (req, res) => {
    res.send('Hello world')
})

app.get('/api/nhanvien', async function (req, res) {
    const nhanvien = await getNhanVien();
    res.send({nhanvien})
})

app.get('/api/chinhanh', async function (req, res) {
    const chinhanh = await getChiNhanh();
    res.send({chinhanh})
})

app.get('/api/chinhanh-tenQuanLy', async function (req, res) {
    const chinhanh_tenQuanLy = await getChiNhanh_Manager();
    res.send({chinhanh_tenQuanLy})
})

app.get('/api/phongban/:MaPB', async function (req, res) {
    const MaPB = req.params.MaPB
    const phongban = await getPhongBan(MaPB)
    res.send({phongban})
})

app.post('/api/chinhanh/insert', async function (req, res) {
    const {MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy} = req.body;
    const [result, message] = await insertChiNhanh(MaChiNhanh, TenChiNhanh, DiaChi, MSNV_QuanLy)
    if (result === 400) 
        return res.status(400).json({
            success: false,
            message: message
        })
    
    return res.status(200).json({
        success: true,
        message: 'Thanh cong'
    })
    
})

app.get('/api/FullTime-MaNV-TenNhanVien', async function (req, res) {
    const MaNV_TenNhanVien = await getMaNV_TenNhanVien();
    res.send({MaNV_TenNhanVien})
}) 

app.listen(PORT, (req, res) => {
    console.log(`Server start at http://localhost:${PORT}`);
}) 