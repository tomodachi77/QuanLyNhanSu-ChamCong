// import Button from "./components/Button/button"
import './App.css'
import Temp from './components/Temp/temp';

async function App() {
  const fetchNhanVien = async () => {
    const res = await fetch("/api/nhanvien");
    const data = await res.json()
    // console.log(data.nhanvien)
    return data.nhanvien
  }

  let employees = fetchNhanVien().then(() => {
    console.log(employees)
  }).then(() => {
    return (
      <div>
        Hello
      </div>
    )
  })
  
  
  // const showNhanVien = () => {
    
  // }

  // return (
  //   <button onClick={showNhanVien} className="w-fit h-fit px-3 py-1 bg-blue-500">
  //     Hello
  //   </button>
  // );
}

export default App
