Select * from Orders
--1
Select DATEDIFF(day, OrderDate, ShippedDate), OrderID From Orders Order by 1 Desc

Select OrderID From Orders
where DATEDIFF(day, OrderDate, ShippedDate)=
(Select max(DATEDIFF(day, OrderDate, ShippedDate)) From Orders)

Select OrderID From Orders
where DATEDIFF(day, OrderDate, ShippedDate)>=ALL
(Select DATEDIFF(day, OrderDate, ShippedDate) From Orders)

--2
Select orderID, orderdate, customerid from orders where CustomerID='vinet'

Select  customerid, orderID, orderdate,
(select top 1 OrderDate from orders where orderid>o.orderid and customerid=o.CustomerID)nastepne,
datediff(day, OrderDate,(select top 1 OrderDate from orders where orderid>o.orderid and customerid=o.CustomerID) )
from orders o where datediff(day, OrderDate,(select top 1 OrderDate from orders where orderid>o.orderid and customerid=o.CustomerID))>62

--3
Select orders.EmployeeID, count(OrderID)
from orders group by orders.EmployeeID
having count(OrderID)>=all(
Select Count(OrderID)
 From Orders  inner join Employees on orders.EmployeeID=Employees.EmployeeID
 where country=[ShipCountry] 
 Group by orders.EmployeeID )

 --4 
 select LOWER(SUBSTRING(FirstName,1,1))+ LOWER(SUBSTRING(LastName, 1,8))+'@wsiz.edu.pl' from Employees
 --6
 Select CustomerID, Count(OrderID) ile From Orders Group by CustomerID Order by ile Desc

 Select City, companyName From Customers Where CompanyName=(
 Select CompanyName From Customers INNER Join Orders ON Customers.CustomerID = Orders.CustomerID 
 Group by CompanyName
 Having Count(Orders.OrderID) >=ALL (Select count(OrderID)ile From Orders Group by CustomerID))
 --5 
 Select OrderDate From Orders Group By DateName(WEEKDAY, OrderDate)
 --8

 Select LastName From Employees where LEN(LastName)=(Select max(LEN(LastName)) From Employees)






