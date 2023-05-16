select GeoID, sum(Amount), avg(Amount), sum(boxes)
from sales
group by geoID