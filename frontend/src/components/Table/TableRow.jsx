import React from 'react'
import EditRow from './EditRow';
import DeleteRow from './DeleteRow';

function TableRow(props) {
    const editParams = props.editFunctionParam;
    const deleteParams = props.deleteFunctionParam;
    // console.log("editParams:", editParams);
    // console.log("deleteParams:", deleteParams);
    
    const tableRows = [];
    props.rowsData.forEach((rowData, index) => {
        let row = rowData.map((data, index) => <td className='max-w-[400px] text-wrap px-3 py-1 border' key={index}>{data}</td>);
        // if (props.canEdit && props.canDelete) {
        //     row.push(<td className='max-w-[400px] text-wrap px-3 py-1 border' key={rowData.length}>
        //         <div className='flex flex-row gap-2'>
        //             <MdEdit/>
        //             <MdDelete/>
        //         </div>
        //     </td>)
        // }
        if (props.canEdit && props.canDelete) {
            row.push(<td className='max-w-[400px] text-wrap px-3 py-1 border' key={rowData.length}>
                <div className='flex flex-row gap-2 justify-around'>
                    <EditRow editFunction={() => props.editFunction(editParams[index])}/>
                    <DeleteRow deleteFunction={() => props.deleteFunction(deleteParams[index])}/>
                </div>
                </td>)
        } else if (props.canEdit && !props.canDelete) {
            row.push(<td className='max-w-[400px] text-wrap px-3 py-1 border' key={rowData.length}>
                <div className='flex flex-row gap-2 justify-around'>
                    <EditRow editFunction={() => props.editFunction(editParams[index])}/>
                </div>
                </td>)
        } else if (!props.canEdit && props.canDelete) {
            row.push(<td className='max-w-[400px] text-wrap px-3 py-1 border' key={rowData.length}>
                <div className='flex flex-row gap-2 justify-around'>
                    <DeleteRow deleteFunction={() => props.deleteFunction(deleteParams[index])}/>
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