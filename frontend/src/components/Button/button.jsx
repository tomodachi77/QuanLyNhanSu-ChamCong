const Button = ({ label, onClick, icon_left, icon_right }) => {
    return (
        <button onClick={onClick} className="bg-blue-400 hover:bg-blue-500 text-black h-8 w-fit px-2 rounded-md">
            <div className="flex flex-row gap-x-1.5">
                <span>{icon_left}</span>
                <span>{label}</span>
                <span>{icon_right}</span>
            </div>
        </button>
    );
    
};

export default Button;