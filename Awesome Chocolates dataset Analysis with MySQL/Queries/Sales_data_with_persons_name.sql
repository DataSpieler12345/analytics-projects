select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales s
join people p on p.SPID = s.SPID

