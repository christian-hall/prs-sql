DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;

CREATE TABLE User (
	ID					int				primary key auto_increment,
    UserName			varchar(20)		not null,
    Password			varchar(10)		not null,
    FirstName			varchar(20)		not null,
    LastName			varchar(20)		not null,
    PhoneNumber			varchar(12)		not null,
    Email				varchar(75)		not null,
    IsReviewer			tinyint			not null,
    IsAdmin				tinyint			not null,
    
    CONSTRAINT uname UNIQUE (UserName)
);

CREATE TABLE Vendor (
	ID					int				primary key auto_increment,
    Code				varchar(10)		not null,
    Name				varchar(255)	not null,
    Address				varchar(255)	not null,
    City				varchar(255)	not null,
    State				varchar(2)		not null,
    Zip					varchar(5)		not null,
    PhoneNumber			varchar(12)		not null,
    Email				varchar(100)	not null,
    
    CONSTRAINT vcode UNIQUE (Code)
);

CREATE TABLE Request (
	ID					int				primary key auto_increment,
    UserID				int				not null,
	Description			varchar(100)	not null,
    Justification		varchar(255)	not null,
    DateNeeded			date			not null,
    DeliveryMode		varchar(25)		not null,
    Status				varchar(20)		not null,
    Total				decimal(10,2)	not null,
    SubmittedDate		datetime		not null,
    ReasonForRejection	varchar(100),
    
    FOREIGN KEY (UserID) REFERENCES user(ID)
);

CREATE TABLE Product (
	ID					int				primary key auto_increment,
    VendorID			int				not null,
    PartNumber			varchar(50)		not null,
    Name				varchar(150)	not null,
    Price				decimal(10,2)	not null,
    Unit				varchar(255),
	PhotoPath			varchar(255),
    CONSTRAINT vendor_part UNIQUE (VendorID, PartNumber),
    FOREIGN KEY (VendorID) REFERENCES Vendor(ID)
);

CREATE TABLE LineItem (
	ID					int				primary key auto_increment,
    RequestID			int				not null,
    ProductID			int				not null,
    Quantity			int				not null,
	CONSTRAINT req_pdt UNIQUE (RequestID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES product(ID),
    FOREIGN KEY (RequestID) REFERENCES request(ID)
    
   
);

-- Insert needed data

INSERT INTO User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) VALUES
	(1, 'chall326', 'June8th', 'Christian', 'Hall', '502-232-5434', 'christian.hall@co.com', 0, 1),
    (2, 'ahall922', 'Agi1001', 'Allison', 'Hall', '502-232-5435', 'allison.hall@co.com', 1, 0),
    (3, 'ccary925', 'BCNov11', 'Colton', 'Cary', '859-858-2872', 'colton.cary@co.com', 0, 0);
    
INSERT INTO Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email) VALUES
	(1, 'BSTBY-42', 'Best Buy', '650 Eastgate South Dr', 'Cincinnati', 'OH', '45245', '513-753-7062', 'shop-42@bestybuy.com'),
    (2, 'AMAZN-01', 'Amazon.com', 'PO Box 81226', 'Seattle', 'WA', '98198', '888-280-3321', 'customer@amazon.com'),
    (3, 'STPLS-16', 'Staples', '3808 Paxton Ave', 'Cincinnati', 'OH', '45209', '513-321-5777', 'connect16@staples.com'),
    (4, 'OFMAX-05', 'Office Max', '4540 Eastgate Blvd', 'Cincinnati', 'OH', '45245', '513-752-2406', 'client05@officemax.com');

INSERT INTO Product (ID, VendorID, PartNumber, Name, Price) VALUES
	(1, 1, 'INS-HFHB-1599', 'Hands-Free Headset - Black', 21.99),
    (2, 1, 'INS-6SCS-4699', '6-Sheet Crosscut Shredder', 34.99),
    (3, 1, 'EPS-PVPS-2299', 'Perfection V600 Photo Scanner', 219.99),
    (4, 2, 'APPL-MBP16', 'MacBook Pro 16" 16 GB RAM, 512 GB SSD', 2286.99), 
    (5, 2, 'AMZB-HBEOC', 'High-Back Executive Swivel Office Chair', 111.99),
    (6, 2, 'TAOT-LEDDL', 'LED Desk Lamp with USB Charging', 32.99),
    (7, 3, '24377016', 'Retractable Gel Pen, 5-Pack, Black', 5.19),
    (8, 3, '00825885', 'Translucent Snap Cases, Assorted', 2.79),
    (9, 3, '00413815', 'Classification Folders, 5/pack', 16.65),
    (10, 4, 'LYS-DNFW', 'Lysol Disenfecting Wipes, 35', 5.99),
    (11, 4, 'DKN-KCUP', 'Dunkin Donuts K-Cip, 24, Orig.', 15.99), 
    (12, 4, 'AVA-HD12', 'HDMI Cable, 12-foot', 18.99);