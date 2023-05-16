select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales s
left join people p on p.SPID = s.SPID