import React from 'react'
import TableHeader from './TableHeader'
import TableRow from './TableRow'

function Table(props) {
    // console.log("Table: ", props.columnHeaders)
    return (
        // relative flex flex-col w-full h-full overflow-scroll text-gray-700 bg-white shadow-md rounded-xl bg-clip-border
        <div className="relative w-fit h-fit overflow-scroll flex flex-col rounded-xl bg-clip-border border-stone-200">
            <table className='border-collapse'>
                <TableHeader columnHeaders={props.columnHeaders}/>
                <TableRow rowsData={props.rowsData}/>
            </table>
        </div>
    )
}

export default Table