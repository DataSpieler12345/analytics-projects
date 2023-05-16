select GeoID, sum(Amount), avg(Amount), sum(boxes)
from sales
group by geoID;

select g.Geo, sum(Amount), avg(Amount), sum(boxes)
from sales s
join geo g on s.GeoID = g.GeoID
group by g.Geo;