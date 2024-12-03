import React from 'react'
import { MdDelete } from "react-icons/md";

function DeleteRow({deleteFunction}) {
  return (
    <div onClick={deleteFunction} className='hover:cursor-pointer'>
      <MdDelete/>
    </div>
  )
}

export default DeleteRow