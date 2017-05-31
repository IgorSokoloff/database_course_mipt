use lab_10


select * from customers where (CustomerID like 'R%') and (region is not null) and (Country = 'usa')

DROP INDEX customer_nonclustered on customers

create nonclustered index customer_nonclustered on dbo.customers(CustomerID, region, country)
include (companyname, contactname, contacttitle, address, city, postalcode, phone, fax)
where (region is not null and Country = 'usa')

select * from customers with(index(customer_nonclustered)) where (CustomerID like 'R%') and (region is not null) and (Country = 'usa')




DROP INDEX customer_clustered on customers

create clustered index customer_clustered on dbo.customers(CustomerID, Country)

select * from customers with(index(customer_clustered)) where (CustomerID like 'R%') and (region is not null) and (Country = 'usa')


--select * from orders 

/*
select * from sys.columns inner join sys.objects on sys.columns.object_id = sys.objects.object_id 
where type like 'U'


select *  from sys.objects where type like 'PK



select objext

select * from sys.indexes where name like 'customer_index'

*/
