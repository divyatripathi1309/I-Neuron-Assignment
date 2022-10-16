show databases ;

create database FSDA ;

use FSDA ;
create table test (student_id int, last_name varchar (20) , first_name varchar(20));

SElect * from test ; 

select * from sales1

Delimiter $$
Create function add_to_col(a int )
returns INT
DETERMINISTIC 
BEGIN
   DECLARE b int ;
   set b = a + 10 ;
   return b ;
end $$
 
 select * from sales1
 Select max(sales) from sales1 ;
 
 select add_to_col(15)
 
 select * from sales1
 
 select quantity , add_to_col (quantity) from sales1
 
 Delimiter $$
 Create function final_profit(profit int , discount int ) 
 returns INT
 DETERMINISTIC 
BEGIN
DECLARE final_profit int ;
set final_profit = profit ;
return final_profit ;
end $$
 
 select profit , discount , final_profit( profit , discount ) from sales1
 
 Delimiter $$
 Create function final_profit_real(profit decimal(20,6) , discount decimal(20,6) ,sales decimal(20,6)  ) 
 returns INT
 DETERMINISTIC 
BEGIN
DECLARE final_profit int ;
set final_profit = profit - sales * discount ;
return final_profit ;
end $$


select profit , discount , sales , final_profit_real( profit , discount , sales  ) from sales1

Delimiter $$
 Create function final_profit_real(profit decimal(20,6) , discount decimal(20,6) ,sales decimal(20,6)  ) 
 returns int 
 DETERMINISTIC 
BEGIN
DECLARE final_profit int ;
set final_profit = profit - sales * discount ;
return final_profit ;
end $$


Delimiter $$
Create function int_to_str(a int )
returns Varchar(30)
DETERMINISTIC 
BEGIN
   DECLARE b varchar(30) ;
   set b = a + 10 ;
   return b ;
end $$

select int_to_str(45)

select * from Sales1

select quantity , int_to_str(quantity) from sales1

select max(sales) , min(sales) from sales1 


1  - 100 - super affordable product 
100-300 - affordable 
300 - 600 - moderate price 
600 + - expensive 


DELIMITER &&
create function mark_sales2(sales int ) 
returns varchar(30)
DETERMINISTIC
begin 
declare flag_sales varchar(30); 
if sales  <= 100  then 
	set flag_sales = "super affordable product" ;
elseif sales > 100 and sales < 300 then 
	set flag_sales = "affordable" ;
elseif sales >300 and sales < 600 then 
	set flag_sales = "moderate price" ;
else 
	set flag_sales = "expensive" ;
end if ;
return flag_sales;
end &&
 
 Select mark_sales2(100)
 
 Select sales , mark_sales2(sales) from sales1;
 
 
 create table loop_table (val int)
 
 Delimiter $$
 create procedure insert_data ()
 Begin 
 set @var = 10 ;
 generate_data : loop  
 set @var = @var + 1 ;
 if @var = 100 then 
     leave generate_data ;
end if ;
end loop generate_data ;
End $$
