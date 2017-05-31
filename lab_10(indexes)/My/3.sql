use lab_10
--select min (Orders.OrderDate),max(Orders.OrderDate)  from orders

set dateformat ymd

DROP INDEX Customer_nonclustered ON Customers
DROP INDEX Orders_nonclustered ON Orders

DROP INDEX Customer_clustered ON Customers
DROP INDEX Orders_clustered ON Orders

CREATE CLUSTERED INDEX Customer_clustered ON Customers (CustomerID)
CREATE CLUSTERED INDEX Orders_clustered ON Orders (CustomerID)

CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers (city)
include (ContactName, CompanyName, country)
where city = 'San Francisco'

CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders (orderdate)
where OrderDate >= '1997-01-01' AND OrderDate <='1997-12-31' 

select ContactName, CompanyName, city,country, OrderDate from Orders 
inner join Customers on orders.CustomerID = customers.CustomerID
where (OrderDate BETWEEN '1997-01-01' AND '1997-12-31') and
city = 'San Francisco'
