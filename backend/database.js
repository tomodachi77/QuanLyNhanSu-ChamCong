import msyql from 'mysql2/promise'
import { configDotenv } from 'dotenv'
configDotenv()

export async function query(sql, param) {
    const connection = await msyql.createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE
    })
    const [result, ] = await connection.execute(sql, param);

    return result;
}



