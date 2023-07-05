--PROJECT-QUERYING A LARGE DATABASE 
--Problem Statement:
--How to get details about customers by querying a database?

--Tasks To Be Performed:
--1. Download the AdventureWorks database from the following location and
--restore it in your server

--3. Perform the following with help of the above database:--a. Get all the details from the person table including email ID, phone--number and phone number typeselect * from Person.Addressselect * from person.EmailAddressselect * from person.PersonPhoneselect * from person.PhoneNumberType SELECT 
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    pe.EmailAddress,
    pp.PhoneNumber,
    pt.Name AS PhoneNumberType
FROM 
    Person.Person AS p
    LEFT JOIN Person.EmailAddress AS pe ON p.BusinessEntityID = pe.BusinessEntityID
    LEFT JOIN Person.PersonPhone AS pp ON p.BusinessEntityID = pp.BusinessEntityID
    LEFT JOIN Person.PhoneNumberType AS pt ON pp.PhoneNumberTypeID = pt.PhoneNumberTypeID;

--b. Get the details of the sales header order made in May 2011SELECT 
    SalesOrderID,
    OrderDate,
    CustomerID,
    TotalDue
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) = 2011
    AND MONTH(OrderDate) = 5

--c. Get the details of the sales details order made in the month of May 2011SELECT
    sod.SalesOrderID,
    sod.ProductID,
    sod.UnitPrice,
    sod.OrderQty,
    sod.LineTotal
FROM
    Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE
    YEAR(soh.OrderDate) = 2011
    AND MONTH(soh.OrderDate) = 5


--d. Get the total sales made in May 2011SELECT
    SUM(sod.LineTotal) AS TotalSales
FROM
    Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE
    YEAR(soh.OrderDate) = 2011
    AND MONTH(soh.OrderDate) = 5

--e. Get the total sales made in the year 2011 by month order by increasing sales
SELECT
    MONTH(soh.OrderDate) AS Month,
    SUM(sod.LineTotal) AS TotalSales
FROM
    Sales.SalesOrderDetail AS sod
    INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE
    YEAR(soh.OrderDate) = 2011
GROUP BY
    MONTH(soh.OrderDate)
ORDER BY
    TotalSales ASC

--f. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'
 SELECT
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    SUM(sod.LineTotal) AS TotalSales
FROM
    Person.Person AS p
    JOIN Sales.SalesOrderHeader AS soh ON p.BusinessEntityID = soh.CustomerID
    JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE
    p.FirstName = 'Gustavo'
    AND p.LastName = 'Achong'
GROUP BY
    p.BusinessEntityID,
    p.FirstName,
    p.LastName;

 
