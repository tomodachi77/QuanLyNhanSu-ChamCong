import React from 'react'

function InputField({ label, placeholder, isDisable=false, type, onChangeHandle }) {

    if (!isDisable) {
        return (
            <div>
                <div className='text-sm'>{label}</div>
                <div>
                    <input name='input' type={type} placeholder={placeholder} onChange={onChangeHandle} disabled={false} className='py-2 px-4 w-full outline-none border-2 border-blue-200 rounded-md focus:border-blue-500'/>
                </div>
            </div>
        )
    }
    else return (
        <div>
            <div className='text-sm text-gray-400'>{label}</div>
            <div>
                <input name='input' type={type} placeholder={placeholder} onChange={onChangeHandle} disabled={true} className='py-2 px-4 w-full outline-none border-2 bg-gray-200 border-blue-200 rounded-md text-gray-600 focus:border-blue-500'/>
            </div>
        </div>
    )
}

export default InputField