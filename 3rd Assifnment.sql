--Assignment 3
--Control Flow SQL for >> Empty Northwind Mart 
DELETE FROM CustomerDimension;
DELETE FROM TimeDimension;
DELETE FROM EmployeeDimension;
DELETE FROM ShipperDimension;
DELETE FROM ProductDimension;
DELETE FROM SaleFact;





--Control Flow SQL "Load NorthwindMart ProductDimension" >> Datasource SQL
SELECT 
	Prod.ProductName, 
	Prod.ProductID, 
	Supp.CompanyName AS SupplierName, 
	Cat.CategoryName,
	Prod.UnitPrice AS ListUnitPrice 
FROM Products AS Prod
JOIN Suppliers AS Supp ON Prod.SupplierID= Supp.SupplierID
JOIN Categories AS Cat ON Prod.CategoryID = Cat.CategoryID



--Control Flow SQL "Load NorthwindMart EmployeeDimension" >> Datasource SQL
SELECT 
      EmployeeID,
      FirstName,
      LastName,
      HireDate
FROM Employees


--Control Flow SQL "Load NorthwindMart CustomerDimension" >> Datasource Script Component
public override void Input0_ProcessInputRow(Input0Buffer Row)
    {
        if (Row.Region_IsNull)
        {
            Row.OutputRegion = "Other";
        }
        else
        {
            Row.OutputRegion = Row.Region;
        }
    }
}




--Control Flow SQL "Load NorthwindMart TimeDimension" >> Datasource SQL
SELECT
    ShippedDate AS [TheDate (shipped date)],
    DATEPART(WEEKDAY, ShippedDate) AS [DayOfWeek (number)],
    DATENAME(WEEKDAY, ShippedDate) AS [DayOfWeekName],
    DATEPART(MONTH, ShippedDate) AS [Month (number)],
    DATENAME(MONTH, ShippedDate) AS [MonthName],
    DATEPART(YEAR, ShippedDate) AS [Year (number)],
    DATEPART(QUARTER, ShippedDate) AS [Quarter (number)],
    DATEPART(DAYOFYEAR, ShippedDate) AS [DayOfYear (number)],
    CASE WHEN DATEPART(WEEKDAY, ShippedDate) IN (1,7) THEN 'Y' ELSE 'N' END AS [Weekday (character, 'Y' or 'N')],
    DATEPART(WEEK, ShippedDate) AS [WeekOfYear (number)]
FROM
    Orders
Where ShippedDate IS NOT NULL






--Control Flow SQL "Load NorthwindMart SalesFact" >> Datasource SQL
SELECT
    
   CuDim.CustomerKey AS CustomerKey,
    
   EmDim.EmployeeKey AS EmployeeKey,
    
   PrDim.ProductKey AS ProductKey,
    
   ShDim.ShipperKey AS ShipperKey,
    
   Ord.OrderDate AS OrderDate,
   
   Ord.ShippedDate AS ShippedDate,

   Ord.RequiredDate AS RequiredDate,

   TiDim.TimeKey AS TimeKey,
    
   OrdDet.Quantity AS LineItemQuantity,
    
   OrdDet.Discount AS LineItemDiscount,
    
   Ord.Freight AS LineItemFreight,
    
   (OrdDet.UnitPrice * OrdDet.Quantity * (1 - OrdDet.Discount)) AS     LineItemTotal

FROM
 Northwind.dbo.Orders As Ord
    
INNER JOIN Northwind.dbo.[Order Details] AS OrdDet ON     OrdDet.OrderID = Ord.OrderID
    
INNER JOIN emallo1.dbo.CustomerDimension AS CuDim ON     CuDIm.CustomerID = Ord.CustomerID
    
INNER JOIN emallo1.dbo.EmployeeDimension AS EmDim ON     EmDim.EmployeeID = Ord.EmployeeID 
    
INNER JOIN emallo1.dbo.ProductDimension AS PrDim ON    PrDim.ProductID = OrdDet.ProductID
    
INNER JOIN emallo1.dbo.ShipperDimension AS ShDim ON    ShDim.ShipperID = Ord.ShipVia
	
INNER JOIN emallo1.dbo.TimeDimension AS TiDim ON TiDim.   [TheDate (shipped date)] = Ord.ShippedDate;