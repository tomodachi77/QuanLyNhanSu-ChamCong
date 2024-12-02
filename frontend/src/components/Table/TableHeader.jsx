import React from 'react'

function TableHeader(props) {
    // console.log("Table headers: ", props.columnHeaders)
    const TableHeaderData = props.columnHeaders.map((header, index) => <td className='px-3 py-1 text-left font-bold border-stone-300 border-solid border max-w-[300px]' key={index}>{header}</td>)
    // console.log('TableHeaderData', TableHeaderData)
    return (
        <thead className='bg-stone-200'>
            <tr>
                {TableHeaderData}
            </tr>
        </thead>
    )
}

export default TableHeader