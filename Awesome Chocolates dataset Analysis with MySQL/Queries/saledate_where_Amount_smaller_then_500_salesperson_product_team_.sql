select s.SaleDate, s.Amount, pr.product 
from sales s
left join products pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.product, p.team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.product, p.team
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount <500;