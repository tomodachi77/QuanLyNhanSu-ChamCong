import React from 'react'

function SelectField({ isDisable = false, options, placeholder, label, onchangeHandler }) {
    if (!isDisable) {
        return (
            <div>
                <div className='text-sm'>{label}</div>
                <select name='input' disabled={false} className='py-2 px-4 w-full outline-none bg-white text-black border-2 border-blue-200 rounded-md focus:border-blue-500' onChange={onchangeHandler}>
                    <option value="" className='bg-white text-black'>{placeholder}</option>
                    {options.map((option, index) => <option value={option} key={index} className='bg-white text-black'>{option}</option>)}
                </select>
            </div>
        )
    } else {
        return (
            <div>
                <div className='text-sm'>{label}</div>
                <select name='input' disabled={true} className='py-2 px-4 w-full outline-none bg-gray-200 text-gray-600 border-2 border-blue-200 rounded-md focus:border-blue-500' onChange={onchangeHandler}>
                    <option value="">{placeholder}</option>
                    {options.map((option, index) => <option value={option} key={index}>{option}</option>)}
                </select>
            </div>
        )
    }
}

export default SelectField