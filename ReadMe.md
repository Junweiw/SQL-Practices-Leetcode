# SQL Practices
This file includes my solutions to LeetCode SQL questions using MySQL.

[**Q175 Combine Two Tables**][Q175]
```sql
SELECT FirstName, LastName, City, State
FROM Person
LEFT JOIN Address
ON Person.PersonId = Address.PersonId
```
[Q175]:
https://leetcode.com/problems/combine-two-tables/

[**Q176 Second Highest Salary**][Q176]
```sql
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)
```
[Q176]:
https://leetcode.com/problems/second-highest-salary/

[**Q181 Employees Earning More Than Their Managers**][Q181]
```sql
SELECT Name AS Employee   
FROM
    (SELECT T1.Name, T1.Salary AS Employee_Salary,T2.Salary AS Manager_Salary 
     FROM Employee T1 LEFT JOIN Employee T2
    ON T1.ManagerId = T2.Id) T3
WHERE Employee_Salary > Manager_Salary
```
[Q181]:
https://leetcode.com/problems/employees-earning-more-than-their-managers/

[**Q182 Duplicate Emails**][Q182]
```sql
SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(Id)>1
```
[Q182]:
https://leetcode.com/problems/duplicate-emails/

[**Q183 Customers Who Never Order**][Q183]
```sql
SELECT Name AS Customers
FROM Customers
LEFT JOIN
    (SELECT CustomerId, COUNT(Id) AS Order_Count
    FROM Orders
    GROUP BY CustomerId) T1
ON Customers.Id = T1.CustomerId
WHERE T1.Order_Count IS NULL
```
[Q183]:
https://leetcode.com/problems/customers-who-never-order/

[**Q196 Delete Duplicate Emails**][Q196]
```sql
DELETE 
FROM Person
WHERE Id NOT IN(SELECT Min_id
FROM
(SELECT MIN(Id) AS Min_id,Email
FROM Person
GROUP BY Email) T1)
```
[Q196]:
https://leetcode.com/problems/delete-duplicate-emails/

[**Q197 Rising Temperature**][Q197]
```sql
SELECT T1.Id
FROM Weather AS T1, Weather AS T2
WHERE DATEDIFF(T1.RecordDate, T2.RecordDate) = 1 
AND T1.Temperature > T2.Temperature
```
[Q197]:
https://leetcode.com/problems/rising-temperature/

[**Q511 Game Play Analysis I**][Q511]
```sql
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
```
[Q511]:
https://leetcode.com/problems/game-play-analysis-i/

[**Q512 Game Play Analysis II**][Q512]
```sql
SELECT player_id, device_id
FROM
    (SELECT player_id, device_id, MIN(event_date) OVER (PARTITION BY        player_id) AS earliest, event_date
    FROM Activity) T1
WHERE event_date = earliest
```
[Q512]:
https://leetcode.com/problems/game-play-analysis-ii/

[**Q577 Employee Bonus**][Q577]
```sql
SELECT name, bonus
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId
WHERE bonus < 1000 OR bonus is NULL
```
[Q577]:
https://leetcode.com/problems/employee-bonus/

[**Q584 Find Customer Referee**][Q584]
```sql
SELECT name
FROM customer
WHERE referee_id !=2 OR referee_id IS NULL
```
[Q584]:
https://leetcode.com/problems/find-customer-referee/

[**Q586 Customer Placing the Largest Number of Orders**][Q586]
```sql
SELECT customer_number
FROM
    (SELECT COUNT(order_number) AS order_count, customer_number
    FROM orders
    GROUP BY customer_number) T1
WHERE order_count = (SELECT MAX(order_count) 
                     FROM 
                     (SELECT 
                      COUNT(order_number) AS order_count
                      FROM orders
                      GROUP BY customer_number) T2)
```
[Q586]:
https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/

[**Q595 Big Countries**][Q595]
```sql
SELECT name, population, area
FROM World
WHERE area > 3000000 OR population > 25000000
```
[Q595]:
https://leetcode.com/problems/big-countries/

[**Q596 Classes More Than 5 Students**][Q596]
```sql
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5
```
[Q596]:
https://leetcode.com/problems/classes-more-than-5-students/

[**Q597 Friend Requests I: Overall Acceptance Rate**][Q597]
```sql
SELECT ROUND(COALESCE(T2_1.requester_count/T1_1.sender_count,0),2) AS accept_rate
FROM
    (SELECT COUNT(T1.sender_id) AS sender_count
     FROM
     (SELECT sender_id
      FROM friend_request
      GROUP BY sender_id, sender_id + send_to_id) T1) T1_1,
    
    (SELECT COUNT(T2.requester_id) AS requester_count
     FROM
     (SELECT requester_id
     FROM request_accepted
     GROUP BY requester_id, requester_id + accepter_id) T2) T2_1
```
[Q597]:
https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

[**Q603 Friend Requests I: Overall Acceptance Rate**][Q603]
```sql
SELECT current.seat_id
FROM cinema AS current
LEFT JOIN cinema AS last
ON current.seat_id = last.seat_id-1
LEFT JOIN cinema AS next
ON current.seat_id = next.seat_id+1
WHERE current.free = 1 AND COALESCE(current.free,0) + COALESCE(last.free,0) + COALESCE(next.free,0) >= 2
ORDER BY current.seat_id
```
[Q603]:
https://leetcode.com/problems/consecutive-available-seats/

[**Q607 Sales Person**][Q607]
```sql
SELECT name
FROM salesperson
WHERE salesperson.sales_id 
    NOT IN (SELECT DISTINCT sales_id 
            FROM orders
            LEFT JOIN company
            ON orders.com_id = company.com_id
            WHERE company.name = ""RED"")
```
[Q607]:
https://leetcode.com/problems/sales-person/

[**Q610 Triangle Judgement**][Q610]
```sql
SELECT x, y, z,
    CASE 
        WHEN x+y > z AND x+z > y AND y+z > x THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM triangle
```
[Q610]:
https://leetcode.com/problems/triangle-judgement/

[**Q613 Shortest Distance in a Line**][Q613]
```sql
SELECT MIN(distance) AS shortest
FROM
    (SELECT LEAD(x,1) OVER() - x AS distance
    FROM point
    ORDER BY x) T1
```
[Q613]:
https://leetcode.com/problems/shortest-distance-in-a-line/

[**Q619 Biggest Single Number**][Q619]
```sql
SELECT MAX(num) AS num
FROM
    (SELECT num
     FROM my_numbers
     GROUP BY num
     HAVING COUNT(num)=1) T1
```
[Q619]:
https://leetcode.com/problems/biggest-single-number/

[**Q620 Not Boring Movies**][Q620]
```sql
SELECT *
FROM cinema
WHERE id%2=1 AND description != 'boring'
ORDER BY rating DESC
```
[Q620]:
https://leetcode.com/problems/not-boring-movies/

[**Q627 Not Boring Movies**][Q627]
```sql
UPDATE salary
SET sex = CASE sex
            WHEN 'm' THEN 'f'
            ELSE 'm'
          END
```
[Q627]:
https://leetcode.com/problems/swap-salary/

[**Q1050 Actors and Directors Who Cooperated At Least Three Times**][Q1050]
```sql
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3
```
[Q1050]:
https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/

[**Q1068 Product Sales Analysis I**][Q1068]
```sql
SELECT Product.product_name, Sales.year, Sales.price
FROM Sales
LEFT JOIN Product
ON Sales.product_id = Product.product_id
```
[Q1068]:
https://leetcode.com/problems/product-sales-analysis-i/

[**Q1069 Product Sales Analysis II**][Q1069]
```sql
SELECT product_id, SUM(quantity) AS total_quantity
FROM Sales
GROUP BY Sales.product_id
```
[Q1069]:
https://leetcode.com/problems/product-sales-analysis-ii/

[**Q1075 Project Employees I**][Q1075]
```sql
SELECT project_id, ROUND(AVG(experience_years),2) AS average_years
FROM Project
LEFT JOIN Employee
ON Project.employee_id = Employee.employee_id
GROUP BY project_id
```
[Q1075]:
https://leetcode.com/problems/project-employees-i/

[**Q1076 Project Employees II**][Q1076]
```sql
SELECT project_id
FROM project
GROUP BY project_id
HAVING COUNT(employee_id) = (SELECT COUNT(employee_id)
                             FROM project
                             GROUP BY project_id
                             ORDER BY COUNT(employee_id) DESC
                             LIMIT 1)
```
[Q1076]:
https://leetcode.com/problems/project-employees-ii/

[**Q1082 Sales Analysis I**][Q1082]
```sql
SELECT seller_id
FROM Sales
GROUP BY seller_id
HAVING SUM(price) = 
    (SELECT SUM(price)
    FROM Sales
    GROUP BY seller_id
    ORDER BY SUM(price) DESC
    LIMIT 1)
```
[Q1082]:
https://leetcode.com/problems/sales-analysis-i/

[**Q1083 Sales Analysis II**][Q1083]
```sql
SELECT DISTINCT buyer_id
FROM Sales
LEFT JOIN Product
ON Sales.product_id = Product.product_id
WHERE buyer_id NOT IN ( SELECT buyer_id
                        FROM Sales
                        LEFT JOIN Product
                        ON Sales.product_id = Product.product_id
                        WHERE product_name ='iPhone')
AND product_name = 'S8'
```
[Q1083]:
https://leetcode.com/problems/sales-analysis-ii/

[**Q1084 Sales Analysis III**][Q1084]
```sql
SELECT product_id, product_name
FROM Product
WHERE product_id NOT IN ( SELECT DISTINCT product_id
                        FROM Sales
                        WHERE sale_date > DATE('2019-03-31')
                        OR sale_date < DATE('2019-01-01'))
```
[Q1084]:
https://leetcode.com/problems/sales-analysis-iii/

[**Q1113 Reported Posts**][Q1113]
```sql
SELECT extra AS report_reason, COUNT(DISTINCT post_id) AS report_count
FROM Actions
WHERE action = 'report' AND action_date = DATE('2019-07-04')
GROUP BY extra
HAVING COUNT(DISTINCT post_id) > 0
```
[Q1113]:
https://leetcode.com/problems/reported-posts/

[**Q1141 User Activity for the Past 30 Days I**][Q1141]
```sql
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_ADD('2019-07-27', INTERVAL -29 DAY) AND DATE('2019-07-27')
GROUP BY activity_date
```
[Q1141]:
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/

[**Q1142 User Activity for the Past 30 Days II**][Q1142]
```sql
SELECT ROUND(COALESCE(COUNT(DISTINCT session_id)/COUNT(DISTINCT user_id),0),2) AS average_sessions_per_user
FROM Activity
WHERE activity_date
    BETWEEN DATE_ADD('2019-07-27', INTERVAL -29 DAY) AND DATE('2019-07-27')
```
[Q1142]:
https://leetcode.com/problems/user-activity-for-the-past-30-days-ii/

[**Q1148 Article Views I**][Q1148]
```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_i
```
[Q1148]:
https://leetcode.com/problems/article-views-i/

[**Q1173 Immediate Food Delivery I**][Q1173]
```sql
SELECT ROUND(COALESCE(T1.immediate/T2.Tot*100,0),2) AS immediate_percentage
FROM
    (SELECT COUNT(delivery_id) AS Immediate
     FROM Delivery
     WHERE Delivery.order_date = Delivery.customer_pref_delivery_date) T1,
     (SELECT COUNT(delivery_id) AS Tot
      FROM Delivery) T2
```
[Q1173]:
https://leetcode.com/problems/immediate-food-delivery-i/

[**Q1179 Reformat Department Table**][Q1179]
```sql
SELECT id, 
SUM(Jan) AS Jan_Revenue, SUM(Feb) AS Feb_Revenue, SUM(Mar) AS Mar_Revenue,
SUM(Apr) AS Apr_Revenue, SUM(May) AS May_Revenue, SUM(Jun) AS Jun_Revenue,
SUM(Jul) AS Jul_Revenue, SUM(Aug) AS Aug_Revenue, SUM(Sep) AS Sep_Revenue, 
SUM(Oct) AS Oct_Revenue, SUM(Nov) AS Nov_Revenue, SUM(DecE) AS Dec_Revenue
FROM   (SELECT id,
       (CASE month WHEN 'Jan' THEN revenue END) AS Jan,
       (CASE month WHEN 'Feb' THEN revenue END) AS Feb,
       (CASE month WHEN 'Mar' THEN revenue END) AS Mar,
       (CASE month WHEN 'Apr' THEN revenue END) AS Apr,
       (CASE month WHEN 'May' THEN revenue END) AS May,
       (CASE month WHEN 'Jun' THEN revenue END) AS Jun, 
       (CASE month WHEN 'Jul' THEN revenue END) AS Jul,
       (CASE month WHEN 'Aug' THEN revenue END) AS Aug,
       (CASE month WHEN 'Sep' THEN revenue END) AS Sep,
       (CASE month WHEN 'Oct' THEN revenue END) AS Oct,
       (CASE month WHEN 'Nov' THEN revenue END) AS Nov,
       (CASE month WHEN 'Dec' THEN revenue END) AS DecE
        FROM Department) T1
GROUP BY id
```
[Q1179]:
https://leetcode.com/problems/reformat-department-table/

[**Q1211 Queries Quality and Percentage**][Q1211]
```sql
SELECT query_name, ROUND(SUM(quality)/COUNT(query_name),2) AS quality, ROUND(SUM(poor_query)/COUNT(query_name) * 100,2) AS poor_query_percentage
FROM
    (SELECT query_name, 
     CASE WHEN rating < 3 THEN 1 ELSE 0 END AS poor_query, 
     rating/position AS quality
     FROM Queries) T1
GROUP BY query_name
```
[Q1211]:
https://leetcode.com/problems/queries-quality-and-percentage/

[**Q1241 Number of Comments per Post**][Q1241]
```sql
SELECT post_id, COUNT(DISTINCT sub_id)-1 AS number_of_comments
FROM
    (SELECT IFNULL(parent_id, sub_id) AS post_id , sub_id, parent_id
    FROM Submissions) T1
WHERE post_id IN (
    SELECT DISTINCT sub_id AS post_id
    FROM Submissions
    WHERE parent_id IS NULL
    GROUP BY sub_id)
GROUP BY post_id
```
[Q1241]:
https://leetcode.com/problems/number-of-comments-per-post/

[**Q1251 Average Selling Price**][Q1251]
```sql
SELECT product_id, ROUND(SUM(sales)/SUM(units),2) AS average_price
FROM
     (SELECT UnitsSold.product_id, purchase_date, units,units*price AS sales
     FROM UnitsSold
     LEFT JOIN Prices
     ON UnitsSold.product_id = Prices.product_id
     WHERE purchase_date BETWEEN start_date AND end_date) T1
GROUP BY product_id
```
[Q1251]:
https://leetcode.com/problems/average-selling-price/



