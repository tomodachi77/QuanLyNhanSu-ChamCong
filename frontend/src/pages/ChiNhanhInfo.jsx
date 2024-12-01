import React, { useEffect, useState } from 'react'
import Button from '../components/Button/button'

// let temp = "Khoi"

function ChiNhanhInfo() {
  const [name, setName] = useState('Khoi');
  // let count = 0;
  const changeName = () => {
    if (name === 'Khoi') 
      setName('Kiet');
    else
      setName('Khoi');
    // count += 1;
  }

  return (
    <div className='flex py-5 flex-col'>
        <h1 className='w-full font-bold text-4xl text-center'>
          Thông tin chi nhánh
        </h1>
        <p>{name}</p>
        <Button label={'Click me!'} onClickFunction={changeName}/>
    </div>
  )
}

export default ChiNhanhInfo