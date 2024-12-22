USE quanlynhansu;
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE, -- Format: long.tran2510
    password VARCHAR(255) NOT NULL,        -- Hashed password
    fullname VARCHAR(255) NOT NULL,        -- Full name: Trần Thành Long
    email VARCHAR(255) NOT NULL            -- Email: long.tran2510@gmail.com
);

INSERT INTO admins (username, password, fullname, email) VALUES 
('long.tran2510', '123456', 'Trần Thành Long', 'long.tran2510@hcmut.edu.vn'); 

SELECT * FROM admins;
