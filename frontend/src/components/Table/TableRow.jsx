import React from 'react'

function TableRow(props) {
    const tableRows = [];
    props.rowsData.forEach((rowData, index) => {
        let row = rowData.map((data, index) => <td className='max-w-[400px] text-wrap border px-3' key={index}>{data}</td>);
        tableRows.push(<tr key={index}>{row}</tr>)
    });
    
    return (
        <tbody>
            {tableRows}
        </tbody>
    )
}

export default TableRow