select GeoID, sum(Amount), avg(Amount), sum(boxes)
from sales
group by geoID;

select g.Geo, sum(Amount), avg(Amount), sum(boxes)
from sales s
join geo g on s.GeoID = g.GeoID
group by g.Geo;

select pr.Category, p.team, sum(boxes), sum(Amount)
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where p.team <> ''
group by pr.Category, p.team
order by pr.Category, p.team;