select * from sales;

select SaleDate, Amount,
	   case    when amount < 1000 then 'Under 1k'
			   when amount < 5000 then 'Under 5k'
                when amount < 1000 then 'Under 10k'
			else '10k or more'
	   end as 'Amount category'
from sales;
		