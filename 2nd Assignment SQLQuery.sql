USE emallo1

CREATE TABLE CustomerDimension(
	CustomerKey INT IDENTITY(1,1) NOT NULL,
	CompanyName NVARCHAR(50) NOT NULL,
	CustomerID NCHAR(5) NOT NULL,
	ContactName NVARCHAR(30),
	ContactTitle NVARCHAR(30),
	Address NVARCHAR(60),
	City NVARCHAR(15),
	Region NVARCHAR(15),
	PostalCode NVARCHAR(10),
	Country NVARCHAR(15),
	Phone NVARCHAR(24),
	Fax NVARCHAR(24)
)
--Adding contraints
ALTER TABLE CustomerDimension
    ADD CONSTRAINT PK_CustomerDimensionCustomerKey PRIMARY KEY NONCLUSTERED (CustomerKey)

--EmployeeDimension
CREATE TABLE EmployeeDimension(
	EmployeeKey INT IDENTITY(1,1) NOT NULL,
	EmployeeName NVARCHAR(31) NOT NULL,
	EmployeeID INT NOT NULL,
	HireDate DATETIME
)
--Adding contraints
ALTER TABLE EmployeeDimension
    ADD CONSTRAINT PK_EmployeeDimensionEmployeeKey PRIMARY KEY NONCLUSTERED (EmployeeKey)



--ProductionDimension
CREATE TABLE ProductDimension(
	ProductKey INT IDENTITY(1,1) NOT NULL,
	ProductName NVARCHAR(40) NOT NULL,
	ProductID INT NOT NULL,
	SupplierName INT,
	CategoryName NVARCHAR(15) NOT NULL,
	ListUnitPrice MONEY ,
)
--Adding contraints
ALTER TABLE ProductDimension
    ADD CONSTRAINT PK_ProductDimensionProductKey PRIMARY KEY NONCLUSTERED (ProductKey)





--ShipperDimension
CREATE TABLE ShipperDimension(
	ShipperKey INT IDENTITY(1,1) NOT NULL,
	CompanyName NVARCHAR(50) NOT NULL,
	ShipperID INT NOT NULL
)
--Adding contraints
ALTER TABLE ShipperDimension
    ADD CONSTRAINT PK_ShipperDimensionShipperKey PRIMARY KEY NONCLUSTERED (ShipperKey)




--TimeDimension
CREATE TABLE TimeDimension(
	TimeKey INT IDENTITY(1,1) NOT NULL,
	"TheDate (shipped date)" DATE NOT NULL,
	"DayOfWeek (number)" INT NOT NULL,
	DayOfWeekName NCHAR(12) NOT NULL,
	"Month (number)" INT NOT NULL,
	MonthName NCHAR(12) NOT NULL,
	"Year (number)" INT NOT NULL,
	"Quarter (number)" INT NOT NULL,
	"DayOfYear (number)" INT NOT NULL,
	"Weekday (character, ‘Y’ or ‘N’)" BIT NOT NULL,
	"WeekOfYear (number)" INT NOT NULL
)
--Adding contraints
ALTER TABLE TimeDimension
    ADD CONSTRAINT PK_TimeDimensionTimeKey PRIMARY KEY NONCLUSTERED (TimeKey)





	

--SaleFact
CREATE TABLE SaleFact(
	CustomerKey INT NOT NULL,
	EmployeeKey INT NOT NULL,
	ProductKey INT NOT NULL,
	ShipperKey INT NOT NULL,
	TimeKey INT NOT NULL,
	OrderID SMALLINT NOT NULL,
	OrderDate DATETIME,
	RequiredDate DATETIME,
	ShippedDate DATETIME,
	Freight MONEY,
	LineItemQuantity INT NOT NULL,
	LineItemDiscount INT NOT NULL,
	LineItemFreight MONEY NOT NULL,
	LineItemTotal MONEY NOT NULL
	)
-- Defining non-clustered indexes on foreign key columns in the fact table
CREATE INDEX IX_SaleFact_CustomerKey ON SaleFact (CustomerKey);
CREATE INDEX IX_SaleFact_EmployeeKey ON SaleFact (EmployeeKey);
CREATE INDEX IX_SaleFact_ProductKey ON SaleFact (ProductKey);
CREATE INDEX IX_SaleFact_ShipperKey ON SaleFact (ShipperKey);
CREATE INDEX IX_SaleFact_TimeKey ON SaleFact (TimeKey);


--Adding contraints
ALTER TABLE SaleFact
	ADD CONSTRAINT PK_SaleFactCustomerKey PRIMARY KEY NONCLUSTERED (CustomerKey, EmployeeKey, ProductKey, ShipperKey, TimeKey),
		CONSTRAINT FK_SaleFactCustomerKey FOREIGN KEY (CustomerKey) REFERENCES CustomerDimension(CustomerKey),
    	CONSTRAINT FK_SaleFactEmployeeKey FOREIGN KEY (EmployeeKey) REFERENCES EmployeeDimension(EmployeeKey),
        CONSTRAINT FK_SaleFactProductKey FOREIGN KEY (ProductKey) REFERENCES ProductDimension(ProductKey),
        CONSTRAINT FK_SaleFactShipperKey FOREIGN KEY (ShipperKey) REFERENCES ShipperDimension(ShipperKey),
        CONSTRAINT FK_SaleFactTimeKey FOREIGN KEY (TimeKey) REFERENCES TimeDimension(TimeKey)

