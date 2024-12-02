import msyql from 'mysql2/promise'
import { configDotenv } from 'dotenv'
configDotenv()

const connection_info = {
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    rowsAsArray: true,
}

export async function ReadQuery(sql, param) {
    let result = '';
    let success = true
    try {
        const connection = await msyql.createConnection(connection_info)
        result = await connection.execute(sql, param);
    } catch (error) {
        console.log(error.message)
        success = false;
        // console.log(success)
    }
    return result[0];
}

export async function WriteQuery(sql, param) {
    let result = '';
    let success = true
    let message = ""
    try {
        const connection = await msyql.createConnection(connection_info)
        result = await connection.execute(sql, param);
    } catch (error) {
        message = error.message
        success = false;
        // console.log(success)
    }
    if (success)
        return [200, ""];
    else 
        return [400, message];
}





