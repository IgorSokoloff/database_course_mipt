--в бд kongs corp представление выводит дл¤ каждого продукат цену на сегодны¤щний день 
--если пользоватлеь вносит в жто предтсавние изменеине в ценеи то это изменение должно грамотным образом отобразитс¤ в базе

use lab_1

if (object_id('product_current_price') is not null)
drop view product_current_price

go
create view product_current_price (id,product, price) as
	select PRODUCT.product_id,product.description, PRICE.list_price 
	from PRODUCT inner join price on PRODUCT.product_id = PRICE.product_id
	where PRICE.end_date is null
go


--select * from Product_Current_Price

if (object_id('price_trig') is not null)
drop trigger price_trig


go
create trigger price_trig on dbo.product_current_price 
instead of update 
as
begin 
	update PRICE set PRICE.end_date = getdate() 
	where PRICE.end_date is null

	insert into	PRICE (product_id,list_price,min_price,start_date, end_date)
	select inserted.id, inserted.price, null, getdate(), null
	from inserted 
end
go

--обновл¤ем цены наACE TENNIS RACKET I и ACE TENNIS RACKET II
begin tran 

select PRODUCT.product_id,PRODUCT.description, price.list_price, PRICE.start_date, PRICE.end_date
from PRODUCT inner join PRICE on PRODUCT.product_id = PRICE.product_id
where PRODUCT.description like 'ACE TENNIS RACKET I'or
	  PRODUCT.description like 'ACE TENNIS RACKET II'

update product_current_price set price = 200 where product like 'ACE TENNIS RACKET I'
or	  product like 'ACE TENNIS RACKET II'

select PRODUCT.description, price.list_price, PRICE.start_date, PRICE.end_date
from PRODUCT inner join PRICE on PRODUCT.product_id = PRICE.product_id
where PRODUCT.description like 'ACE TENNIS RACKET I'or
	  PRODUCT.description like 'ACE TENNIS RACKET II'

rollback 


--select getdate()