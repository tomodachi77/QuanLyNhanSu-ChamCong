import { Link } from "react-router-dom";

const Button = ({ label, onClickFunction, icon_left, icon_right, path }) => {
    if (path)
        return (
            <button onClick={onClickFunction} className="bg-white hover:bg-slate-100 text-black h-8 w-full px-2 rounded-md">
                <div className="flex flex-row gap-x-1.5">
                    <span>{icon_left}</span>
                    <Link className="items-start font-semibold" to={path}>{label}</Link>
                    <span>{icon_right}</span>
                </div>
            </button>
        );
    else
        return (
            <button onClick={onClickFunction} className="bg-white hover:bg-slate-100 text-black h-8 w-full px-2 rounded-md">
                <div className="flex flex-row gap-x-1.5">
                    <span>{icon_left}</span>
                    <span className="items-start font-semibold" >{label}</span>
                    <span>{icon_right}</span>
                </div>
            </button>
        );
        
};

export default Button;