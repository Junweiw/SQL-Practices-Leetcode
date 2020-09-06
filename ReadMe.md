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

[**Q1280 Students and Examinations**][Q1280]
```sql
SELECT T1.student_id, T1.student_name, T1.subject_name, COALESCE(T2.exam_counts,0) AS attended_exams
FROM
(SELECT *
 FROM Students, Subjects) T1
LEFT JOIN
(SELECT student_id, subject_name, COUNT(*) AS exam_counts
 FROM Examinations
 GROUP BY student_id, subject_name) T2
ON T1.Student_id = T2.Student_id AND T1.subject_name = T2.subject_name
ORDER BY T1.student_id, T1.subject_name, COALESCE(T2.exam_counts,0) DESC
```
[Q1280]:
https://leetcode.com/problems/students-and-examinations/

[**Q1294 Weather Type in Each Country**][Q1294]
```sql
SELECT Countries.country_name,
    CASE WHEN AVG(Weather.weather_state) <= 15 THEN "Cold"
         WHEN AVG(Weather.weather_state) >= 25 THEN "Hot"
         ELSE "Warm" 
    END AS weather_type
FROM Weather
LEFT JOIN Countries
ON Weather.country_id = Countries.country_id
WHERE Weather.day BETWEEN DATE("2019-11-01") AND DATE("2019-11-30")
GROUP BY Countries.country_name
```
[Q1294]:
https://leetcode.com/problems/weather-type-in-each-country/

[**Q1303 Find the Team Size**][Q1303]
```sql
SELECT employee_id, team_size
FROM Employee
LEFT JOIN (SELECT team_id, COUNT(Employee_id) AS team_size
           FROM Employee GROUP BY team_id) T1
ON Employee.team_id = T1.team_id
```
[Q1303]:
https://leetcode.com/problems/find-the-team-size/

[**Q1322 Ads Performance**][Q1322]
```sql
SELECT ad_id, ROUND(COALESCE(Clicks/(Views+Clicks)*100,0), 2) AS ctr
FROM
    (SELECT ad_id, SUM(CASE action WHEN ""Clicked"" THEN 1 ELSE 0 END) AS Clicks, 
                   SUM(CASE action WHEN ""Viewed"" THEN 1 ELSE 0 END) AS ""Views""
     FROM Ads
     GROUP BY ad_id) T1
ORDER BY ctr DESC, ad_id
```
[Q1322]:
https://leetcode.com/problems/ads-performance/

[**Q1327 List the Products Ordered in a Period**][Q1327]
```sql
SELECT product_name, unit
FROM (SELECT product_id, SUM(unit) AS unit
      FROM Orders
      WHERE order_date BETWEEN DATE(""2020-02-01"") AND DATE(""2020-02-29"")
      GROUP BY product_id) T1
LEFT JOIN Products
ON T1.product_id = Products.product_id
WHERE unit >= 100
```
[Q1327]:
https://leetcode.com/problems/list-the-products-ordered-in-a-period/

[**Q1350 Students With Invalid Departments**][Q1350]
```sql
SELECT Students.id, Students.name
FROM Students
LEFT JOIN Departments
ON Students.department_id = Departments.id
WHERE Departments.name IS NULL
```
[Q1350]:
https://leetcode.com/problems/students-with-invalid-departments/

[**Q1378 Replace Employee ID With The Unique Identifier**][Q1378]
```sql
SELECT unique_id, name
FROM Employees
LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id
```
[Q1378]:
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/

[**Q1407 Top Travellers**][Q1407]
```sql
SELECT name, COALESCE(tot_distance,0) AS travelled_distance
FROM Users
LEFT JOIN (SELECT user_id, SUM(distance) AS tot_distance
           FROM Rides
           GROUP BY user_id) T1
ON Users.id = T1.user_id
ORDER BY COALESCE(tot_distance,0) DESC, name
```
[Q1407]:
https://leetcode.com/problems/top-travellers/

[**Q1435 Create a Session Bar Chart**][Q1435]
```sql
SELECT T1.bin, COALESCE(T2.total,0) AS total
FROM
    (SELECT '[0-5>' AS bin
     UNION ALL 
     SELECT '[5-10>' AS bin
     UNION ALL 
     SELECT '[10-15>' AS bin
     UNION ALL 
     SELECT '15 or more' AS bin)T1
    LEFT JOIN
    (SELECT COUNT(session_id) AS total,
      CASE WHEN duration/60 >= 0 AND duration/60 < 5 THEN ""[0-5>""
            WHEN duration/60 >= 5 AND duration/60 < 10 THEN ""[5-10>""
            WHEN duration/60 >= 10 AND duration/60 < 15 THEN ""[10-15>""
            ELSE ""15 or more""
      END AS bin
     FROM Sessions
     GROUP BY bin)T2
     ON T1.bin = T2.bin
```
[Q1435]:
https://leetcode.com/problems/create-a-session-bar-chart/

[**Q1484 Group Sold Products By The Date**][Q1484]
```sql
SELECT sell_date, 
       COUNT(DISTINCT product) AS num_sold,
       GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date
```
[Q1484]:
https://leetcode.com/problems/group-sold-products-by-the-date/

[**Q1495 Friendly Movies Streamed Last Month**][Q1485]
```sql
SELECT DISTINCT title AS TITLE
FROM TVProgram
LEFT JOIN Content
ON TVProgram.content_id = Content.content_id
WHERE program_date BETWEEN DATE('2020-06-01') AND DATE('2020-06-30')
    AND Kids_content = 'Y' AND content_type = 'Movies'
```
[Q1495]:
https://leetcode.com/problems/friendly-movies-streamed-last-month/
