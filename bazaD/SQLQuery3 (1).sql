--1
Select * 
From (Select * From Customers Where City='LONDON') MIESZKANCY_LONDYNU
Where CompanyName LIKE'[A-C]%'
--2
Select Orders.OrderID, QUANTITY*UNITPRICE WARTOSC
from Orders
INNER join [Order Details]
on Orders.OrderID=[Order Details].OrderID
 INNER JOIN Employees 
ON Orders.EmployeeID=Employees.EmployeeID
INNER JOIN EmployeeTerritories
ON EmployeeTerritories.EmployeeID=Employees.EmployeeID
INNER JOIN Territories
ON EmployeeTerritories.TerritoryID=Territories.TerritoryID
INNER JOIN Region
ON Territories.RegionID=Region.RegionID
Where RegionDescription='EASTERN' AND OrderDate LIKE'%1996%' AND QUANTITY*UNITPRICE>(Select AVG(QUANTITY*UNITPRICE)FROM [Order Details])
--3
Select ProductName FROM Products Where UnitPrice= (Select min(UnitPrice)From Products)
--4
Select productname, CategoryID, UnitPrice
from Products p1
where unitprice in (Select min(unitPrice) From Products p2 where p1.CategoryID=p2.CategoryID)
--5
Select COUNT(*) Ilu, City From Employees Group By City;
Select COUNT(*) Ilu From Employees p1 Where city IN(Select City From Employees p2 where p1.EmployeeID != p2.EmployeeID);
Select City From Employees
--6
Select ProductID From Products
except
select distinct ProductID from [Order Details]
--7
Select CustomerID From Customers
except
Select distinct CustomerID From Orders
--8
Select Customers.CompanyName From Customers INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID Group by Customers.CompanyName Having COUNT(OrderID)=
(Select MAX(ile)From (Select COUNT(CustomerID)ile from Orders Group BY CustomerID)p1)
--9
Select distinct city From Customers
intersect
select distinct city From Employees

Select CompanyName, Orderid 
From Customers left join Orders
on Customers.CustomerID= Orders.CustomerID
where OrderID is null

Select * From Employees
Select * From Customers
Select * From Products
Select * From [Order Details]
--1
Select AVG(UnitPrice) srednia, CategoryName From Products inner join Categories on Products.CategoryID=Categories.CategoryID where CategoryName!='Seafood' Group by CategoryName
--2
Select CategoryID, AVG(QUANTITY*[Order Details].UnitPrice) srednia FROM [Order Details] inner join Products on [Order Details].ProductID=Products.ProductID Group by CategoryID
--3
Select CategoryName From Categories
inner join Products on Categories.CategoryID=Products.CategoryID
inner join [Order Details] on Products.ProductID=[Order Details].ProductID
Where (Select(AVG([Order Details].Quantity*[Order Details].UnitPrice))From [Order Details] Group by CategoryName)>10000
--4
Select Title, max(GETDATE()-HireDate) From Employees Group by Title
--5
Select BirthDate, year(getdate())-year(BirthDate) wiek From Employees
--6
Select LastName From Employees Where LEN(LastName)= (Select max(Len(LastName)) From Employees)
--7 
Select COUNT(*) Ilu, City From Employees Group By City
--8
Select * From Customers Where Fax IS NULL








