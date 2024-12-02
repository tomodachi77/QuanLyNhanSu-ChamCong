import React from 'react'
import TableHeader from './TableHeader'
import TableRow from './TableRow'

function Table(props) {
    // console.log("Table: ", props.columnHeaders)
    return (
        <table className='border-collapse'>
            <TableHeader columnHeaders={props.columnHeaders}/>
            <TableRow rowsData={props.rowsData}/>
        </table>
    )
}

export default Table