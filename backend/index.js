import express from 'express'
import dotenv from 'dotenv'
import { getNhanVien, getPhongBan } from './api.js'
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

app.get('/api/phongban/:MaPB', async function (req, res) {
    const MaPB = req.params.MaPB
    const phongban = await getPhongBan(MaPB)
    res.send({phongban})
})

app.listen(PORT, (req, res) => {
    console.log(`Server start at http://localhost:${PORT}`);
}) 