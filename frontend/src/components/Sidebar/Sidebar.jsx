import Button from "../Button/button"
import Avatar from "../../assets/avatar"

const Sidebar = () => {
    return (
        <div className="h-screen w-1/6 bg-white flex flex-col justify-between sticky top-0 border-r">
            <div>
                <div className="w-full h-fit flex flex-col items-center py-5 border-b border-slate-300">
                    <Avatar/>
                    <p className="font-semibold text-lg">Chủ sở hữu công ty</p>
                </div>
                <div>
                    <Button label={"Thông tin chi nhánh"} path={'/chi-nhanh'} className="w-full"/>
                    <Button label={"Thông tin phòng ban"} path={'/phong-ban'} className="w-full"/>
                    <Button label={"Thông tin dự án"} path={'/du-an'} className="w-full"/>
                    <Button label={"Thông tin nhân viên"} path={'/nhan-vien'} className="w-full"/>
                </div>
            </div>
            <div className="border-t border-slate-300">
                <Button label={"Thông tin cá nhân"}></Button>
            </div>
        </div>
    )
}

export default Sidebar