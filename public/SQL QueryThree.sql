
SELECT full_user_name, SUM(number_elevators ) as NumberofElevator
from dimcustomers 
GROUP by full_user_name
ORDER BY SUM(number_elevators) DESC,  full_user_name
