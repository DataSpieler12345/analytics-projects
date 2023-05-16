select s.SaleDate, s.Amount, p.Salesperson, pr.product, p.team, g.GEO
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount <500
and p.Team = ''
and g.GEO in ('New Zealand','India')
order by SaleDate;