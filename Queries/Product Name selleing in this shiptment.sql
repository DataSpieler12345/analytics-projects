select s.SaleDate, s.amount, pr.Product
from sales s
left join products pr on pr.PID = s.PID;