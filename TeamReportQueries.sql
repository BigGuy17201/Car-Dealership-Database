CREATE TABLE tbl_inspector (
    Inspector_ID INT PRIMARY KEY,
	Inspector_F_Name varchar(50) NOT NULL,
	Inspector_L_Name varchar(50),
	Certification_Number varchar(6) NOT NULL,
	License_Expiration date NOT NULL
);

CREATE TABLE tbl_warranty (
    Warranty_ID INT PRIMARY KEY,
	Warranty_Duration_Years int NOT NULL,
	Coverage_Details varchar(255) NOT NULL,
	Issuer varchar(50) NOT NULL,
	Warranty_Claim varchar(255) NOT NULL
);

CREATE TABLE tbl_sales_person (
    Employee_ID INT PRIMARY KEY,
	Sales_Person_F_Name varchar(50) NOT NULL,
    Sales_Person_L_Name varchar(50),
	Employee_Start_Date date NOT NULL,
	Employee_Salary int NOT NULL
);

CREATE TABLE tbl_mechanic (
	Mechanic_ID INT PRIMARY KEY,
    Mechanic_F_Name varchar(50) NOT NULL,
    Mechanic_L_Name varchar(50),
	Years_Experience INT NOT NULL,
	Contract_Start date NOT NULL,
	Contract_End date NOT NULL,
    Salary int NOT NULL
);

CREATE TABLE tbl_customer (
    Customer_ID INT PRIMARY KEY,
	Customer_F_Name varchar(50) NOT NULL,
    Customer_L_Name varchar(50),
    Phone_Number varchar(12) NOT NULL,
	Email varchar(100) NOT NULL
);

CREATE TABLE tbl_inspection (
    Inspection_ID INT PRIMARY KEY,
	Inspector_ID int NOT NULL,
	Inspection_Result varchar(255),
	Inspection_Date date,
	FOREIGN KEY (Inspector_ID) REFERENCES tbl_inspector(Inspector_ID)
);

CREATE TABLE tbl_car (
	VIN VARCHAR(17) PRIMARY KEY,
	C_Make varchar(50) NOT NULL,
	C_Model varchar(50) NOT NULL,
	Color varchar(50) NOT NULL,
	Model_Year int NOT NULL,
	Base_Price int,
	C_Milage int NOT NULL,
	Inspection_ID int,
	C_Status varchar(50) NOT NULL,
	FOREIGN KEY (Inspection_ID) REFERENCES tbl_inspection(Inspection_ID)
);

CREATE TABLE tbl_part (
    Part_ID INT PRIMARY KEY,
	Serial_Number VARCHAR(25) NOT NULL,
	Wholesale_Price int NOT NULL,
	Manufacturer varchar(50) NOT NULL,
	Part_Name varchar(50) NOT NULL,
	Warranty_ID int,
	FOREIGN KEY (Warranty_ID) REFERENCES tbl_warranty(Warranty_ID)
);

CREATE TABLE tbl_diagnostic (
    Diagnostic_ID INT,
	Explanation_of_Problem VARCHAR(255) NOT NULL,
	Solution VARCHAR(255) NOT NULL,
    Part_ID INT NOT NULL,
    Part_Quantity INT NOT NULL,
    FOREIGN KEY (Part_ID) REFERENCES tbl_part(part_ID)
);

CREATE TABLE tbl_repair (
    Repair_ID INT PRIMARY KEY,
	Mechanic_ID INT NOT NULL,
	Customer_ID INT NOT NULL,
	VIN VARCHAR(17) NOT NULL,
	Appointment_Date date NOT NULL,
    Diagnostic_ID INT NOT NULL,
	FOREIGN KEY (Mechanic_ID) REFERENCES tbl_mechanic(Mechanic_ID),
	FOREIGN KEY (Customer_ID) REFERENCES tbl_customer(Customer_ID),
	FOREIGN KEY (VIN) REFERENCES tbl_car(VIN)
);

CREATE TABLE tbl_rental (
    Rental_ID INT PRIMARY KEY,
	Customer_ID INT NOT NULL,
	Rental_Start_Date Date NOT NULL,
    Rental_End_Date Date NOT NULL,
    VIN VARCHAR(17) NOT NULL,
	Start_Milage INT NOT NULL,
	End_Mileage INT,
	Start_Gas INT NOT NULL,
	End_Gas INT,
    FOREIGN KEY (Customer_ID) REFERENCES tbl_customer(Customer_ID),
	FOREIGN KEY (VIN) REFERENCES tbl_car(VIN)
);

CREATE TABLE tbl_sale (
    Sale_ID INT PRIMARY KEY,
	Customer_ID int NOT NULL,
	Employee_ID int NOT NULL,
	VIN VARCHAR(17),
    Sale_Price int NOT NULL,
	Commission int,
	Sale_Date date NOT NULL,
	Purchase_Type varchar(255) NOT NULL,
	Rental_ID int,
	Repair_ID int,
	Part_ID int,
	FOREIGN KEY (Customer_ID) REFERENCES tbl_customer(Customer_ID),
	FOREIGN KEY (Employee_ID) REFERENCES tbl_sales_person(Employee_ID),
	FOREIGN KEY (Rental_ID) REFERENCES tbl_rental(Rental_ID),
	FOREIGN KEY (Repair_ID) REFERENCES tbl_repair(Repair_ID),
	FOREIGN KEY (Part_ID) REFERENCES tbl_part(Part_ID),
	FOREIGN KEY (VIN) REFERENCES tbl_car(VIN)
);



BULK INSERT tbl_inspector
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_inspector.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_warranty
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_warranty.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_sales_person
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_sales_person.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_mechanic
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_mechanic.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_customer
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_customer.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_inspection
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_inspection.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_car
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_car.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_part
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_part.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_diagnostic
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_diagnostic.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_repair
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_repair.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_rental
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_rental.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)

BULK INSERT tbl_sale
FROM 'C:\Users\natee\Desktop\is410\inserts\insert_sale.txt'
WITH (FIELDTERMINATOR=',', ROWTERMINATOR='/', KEEPNULLS)



CREATE OR ALTER VIEW Parts_and_Warranties AS
SELECT tbl_part.Part_ID,
	tbl_part.Serial_Number,
	tbl_part.Wholesale_Price,
	tbl_part.Manufacturer,
	tbl_part.Part_Name,
	tbl_warranty.Warranty_ID,
	tbl_warranty.Warranty_Duration_Years,
	tbl_warranty.Coverage_Details,
	tbl_warranty.Issuer,
	tbl_warranty.Warranty_Claim
FROM tbl_part INNER JOIN tbl_warranty 
ON tbl_part.Warranty_ID = tbl_warranty.Warranty_ID;


--Show diagnostics with parts that have warranties.
SELECT tbl_diagnostic.DIagnostic_ID, tbl_diagnostic.Explanation_of_Problem, Parts_and_Warranties.Part_ID, Parts_and_Warranties.Part_Name, Parts_and_Warranties.Warranty_ID, Parts_and_Warranties.Coverage_Details
FROM tbl_diagnostic
INNER JOIN Parts_and_Warranties ON tbl_diagnostic.Part_ID = Parts_and_Warranties.Part_ID;


--Show sales of warrantied parts.
Select tbl_sale.Sale_ID, tbl_sale.Sale_Date, tbl_sale.Sale_Price, Parts_and_Warranties.Part_ID, Parts_and_Warranties.Part_Name, Parts_and_Warranties.Warranty_ID
FROM tbl_sale
INNER JOIN Parts_and_Warranties ON tbl_sale.Part_ID = Parts_and_Warranties.Part_ID;


--Show the most commonly used warrantied part.
SELECT TOP 5 Parts_and_Warranties.Part_Name, Parts_and_Warranties.Warranty_ID, COUNT(tbl_diagnostic.Part_ID) AS Usage_Count
FROM tbl_diagnostic
INNER JOIN Parts_and_Warranties ON tbl_diagnostic.Part_ID = Parts_and_Warranties.Part_ID
GROUP BY Parts_and_Warranties.Part_Name, Parts_and_Warranties.Warranty_ID
ORDER BY Usage_Count DESC;


--Show the diagnostics without warrantied parts.
SELECT tbl_diagnostic.Diagnostic_ID, tbl_diagnostic.Explanation_of_Problem
FROM tbl_diagnostic 
LEFT JOIN Parts_And_Warranties ON tbl_diagnostic.Part_ID = Parts_And_Warranties.Part_ID 
WHERE Parts_And_Warranties.Warranty_ID IS NULL;



CREATE OR ALTER PROCEDURE Model_Rental @make varchar(50)
AS
	SELECT COUNT(tbl_rental.Rental_ID) AS Total_Rentals
	FROM tbl_rental
	INNER JOIN tbl_car ON tbl_rental.VIN = tbl_car.VIN
	WHERE tbl_car.C_Make = @make
GO


--How many times have Hondas been rented?
EXEC Model_Rental @make = 'Chevrolet';


--How many times have BMWs been rented?
EXEC Model_Rental @make = 'Volkswagen';


--Show parts without warranties.
SELECT tbl_part.Part_Name, tbl_part.Part_ID, tbl_part.Serial_Number, tbl_warranty.Warranty_ID
FROM tbl_part
LEFT JOIN tbl_warranty ON tbl_part.Warranty_ID = tbl_warranty.Warranty_ID
WHERE tbl_part.Warranty_ID IS NULL;


--Which Customers have no recorded car purchases?
SELECT tbl_customer.Customer_F_Name, tbl_customer.Customer_L_Name, COUNT(tbl_sale.Sale_ID) AS Total_Non_Car_Sales
FROM tbl_customer
LEFT JOIN tbl_sale ON tbl_customer.Customer_ID = tbl_sale.Customer_ID
WHERE tbl_sale.Purchase_Type <> 'Car Sale'
GROUP BY tbl_customer.Customer_F_Name, tbl_customer.Customer_L_Name;


--List all salespeople who have sold used cars.
SELECT DISTINCT tbl_sales_person.Sales_Person_L_Name, tbl_sale.Purchase_Type,tbl_sale.Sale_Date, tbl_car.C_Status
FROM tbl_sales_person
INNER JOIN tbl_sale ON tbl_sales_person.Employee_ID = tbl_sale.Employee_ID
INNER JOIN tbl_car ON tbl_sale.VIN = tbl_car.VIN
WHERE tbl_car.C_Status = 'Used' AND tbl_sale.Purchase_Type = 'Car Sale';


--Give the names of all mechanics that have completed repairs.
SELECT DISTINCT tbl_mechanic.Mechanic_L_Name, tbl_repair.Repair_ID, tbl_repair.Appointment_Date
FROM tbl_mechanic
INNER JOIN tbl_repair ON tbl_mechanic.Mechanic_ID = tbl_repair.Mechanic_ID
