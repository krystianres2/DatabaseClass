Select * From Orders
Select OrderID From Orders Where DATEDIFF(dd,OrderDate,ShippedDate)=(Select MAX(DATEDIFF(dd,OrderDate,ShippedDate))From Orders)
--5
Select OrderDate ,COUNT(*) From Orders Group By OrderDate having Count(OrderDate)>=All(Select Count(OrderDate) From Orders Group By OrderDate)
--6
Select distinct CompanyName, Address From Customers inner join Orders on Customers.CustomerID=Orders.CustomerID 
Where Orders.CustomerID= (Select Orders.CustomerID From Orders Group By Orders.CustomerID having COUNT(Orders.CustomerID)>=All(Select Count(CustomerID) From Orders Group By CustomerID) )

Select Orders.CustomerID, Count(Orders.CustomerID) From Orders 
inner join Customers on Orders.CustomerID=Customers.CustomerID Group By Orders.CustomerID having COUNT(Orders.CustomerID)>=All(Select Count(CustomerID) From Orders Group By CustomerID);

Select * From Customers
--3
Select orders.EmployeeID, count(OrderID)
from orders group by orders.EmployeeID
having count(OrderID)>=all(
Select Count(OrderID)
 From Orders  inner join Employees on orders.EmployeeID=Employees.EmployeeID
 where country=[ShipCountry] 
 Group by orders.EmployeeID )
 --4
 Select * From Products
 Select ProductName From Products Where UnitPrice=(Select min(UnitPrice) From Products Group By CategoryID) Group By CategoryID
 Select ProductName, CategoryID, UnitPrice From Products p1 Where UnitPrice=(Select min(UnitPrice)From Products p2 where p1.CategoryID=p2.CategoryID)
 --5
 Select * From Employees
 Select Count(EmployeeID), City From Employees Group By City
 Select COUNT(*) Ilu From Employees p1 Where city IN(Select City From Employees p2 where p1.EmployeeID != p2.EmployeeID);
 --8
 Select CustomerID ,Count(CustomerID) From Orders Group By CustomerID;
 Select Customers.CompanyName From Customers INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID Group by Customers.CompanyName Having COUNT(OrderID)=
(Select MAX(ile)From (Select COUNT(CustomerID)ile from Orders Group BY CustomerID)p1);
