import React from 'react'
import { MdEdit } from "react-icons/md";

function EditRow({ editFunction }) {
  return (
    <div onClick={editFunction} className='hover:cursor-pointer'>
        <MdEdit/>
    </div>
  )
}

export default EditRow