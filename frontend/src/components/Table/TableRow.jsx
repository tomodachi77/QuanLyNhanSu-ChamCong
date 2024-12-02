import React from 'react'
import { MdEdit } from "react-icons/md";
import { MdDelete } from "react-icons/md";

function TableRow(props) {
    const tableRows = [];
    props.rowsData.forEach((rowData, index) => {
        let row = rowData.map((data, index) => <td className='max-w-[400px] text-wrap px-3 py-1 border' key={index}>{data}</td>);
        if (props.canEdit && props.canDelete) {
            row.push(<td className='max-w-[400px] text-wrap px-3 py-1 border' key={rowData.length}>
                <div className='flex flex-row gap-2'>
                    <MdEdit/>
                    <MdDelete/>
                </div>
            </td>)
        }
        tableRows.push(<tr key={index}>{row}</tr>)
    });
    
    return (
        <tbody>
            {tableRows}
        </tbody>
    )
}

export default TableRow