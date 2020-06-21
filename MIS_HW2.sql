/* Data Dictionary: https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008/ms124438(v%3dsql.100) */
/* 1. How many distinct orders were made? Answer: 31465*/
SELECT COUNT(DISTINCT "SalesOrderID") AS "DistinctOrders"
FROM "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader";

/* 2. What is the $$ total of all orders?  Answer: 109846381.40003*/
SELECT SUM("TotalDue") AS "TotalSales" /*140707579.83*/
FROM "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader";
 
/* 3. What were the top 10 best-selling products, by $$ amount? */
SELECT TOP 10 "Sales"."ProductID", "Product"."Name",SUM("Sales"."LineTotal") AS "TotalSales"
FROM  "GBI_909"."GBI_909::Sales_SalesOrderDetail.Sales_SalesOrderDetail" as "Sales" INNER JOIN  "GBI_909"."GBI_909::Production_Product.Production_Product" as "Product" ON
"Sales"."ProductID"="Product"."ProductID"
GROUP BY "Sales"."ProductID","Product"."Name"
ORDER BY "TotalSales" desc;

/* 4. What were the top 10 best-selling products by number of orders?*/
SELECT TOP 10 "Sales"."ProductID", "Product"."Name",COUNT("Sales"."SalesOrderID") AS "TotalProductOrders"
FROM  "GBI_909"."GBI_909::Sales_SalesOrderDetail.Sales_SalesOrderDetail" as "Sales" INNER JOIN  "GBI_909"."GBI_909::Production_Product.Production_Product" as "Product" ON
"Sales"."ProductID"="Product"."ProductID"
GROUP BY "Sales"."ProductID","Product"."Name"
ORDER BY "TotalProductOrders" desc;

/*5. Who were the top 10 best customers, by $$ amount?*/
SELECT TOP 10 "CustomerID",SUM("TotalDue") AS "TotalCustomerAmount"
FROM  "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader" as "SalesHeader"
GROUP BY "CustomerID"
ORDER BY "TotalCustomerAmount" desc;

/*6. Who were the top 10 customers (by $$ amount) of products with the word "Mountain" in their name? (2 points)*/
SELECT TOP 10 "SalesHeader"."CustomerID",SUM("SalesHeader"."SubTotal") AS "TotalCustomerAmount"
FROM  
"GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader" as "SalesHeader" 
INNER JOIN "GBI_909"."GBI_909::Sales_SalesOrderDetail.Sales_SalesOrderDetail" as "Sales"
ON"Sales"."SalesOrderID" = "SalesHeader"."SalesOrderID"
INNER JOIN  "GBI_909"."GBI_909::Production_Product.Production_Product" as "Product" 
ON "Sales"."ProductID"="Product"."ProductID"
WHERE "Product"."Name" LIKE '%Mountain%'
GROUP BY "SalesHeader"."CustomerID"
ORDER BY "TotalCustomerAmount" desc;

SELECT TOP 10 "SalesHeader"."CustomerID",SUM("Sales"."LineTotal") AS "TotalCustomerAmount"
FROM  
"GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader" as "SalesHeader" 
INNER JOIN "GBI_909"."GBI_909::Sales_SalesOrderDetail.Sales_SalesOrderDetail" as "Sales"
ON"Sales"."SalesOrderID" = "SalesHeader"."SalesOrderID"
INNER JOIN  "GBI_909"."GBI_909::Production_Product.Production_Product" as "Product" 
ON "Sales"."ProductID"="Product"."ProductID"
WHERE "Product"."Name" LIKE '%Mountain%'
GROUP BY "SalesHeader"."CustomerID"
ORDER BY "TotalCustomerAmount" desc;

/*7. What is the average order total?*/
SELECT SUM("TotalDue") /COUNT(DISTINCT"SalesOrderID")
FROM "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader";

/*8. List the products and quantities purchased by the top 10 customers and their dollar value.  (2 points)*/
SELECT "Name",sum("OrderQty") ,sum("LineTotal") AS "TotalDollorValue"
FROM    "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader" as "SalesHeader" 
INNER JOIN "GBI_909"."GBI_909::Sales_SalesOrderDetail.Sales_SalesOrderDetail" as "Sales"
ON"Sales"."SalesOrderID" = "SalesHeader"."SalesOrderID"
INNER JOIN  "GBI_909"."GBI_909::Production_Product.Production_Product" as "Product" 
ON "Sales"."ProductID"="Product"."ProductID"
WHERE ( "CustomerID" IN ( SELECT "CustomerID"
    From(
    SELECT TOP 10 "CustomerID",SUM("TotalDue") AS "TotalCustomerAmount"
    FROM  "GBI_909"."GBI_909::Sales_SalesOrderHeader.Sales_SalesOrderHeader" as "SalesHeader"
    GROUP BY "CustomerID"
    ORDER BY "TotalCustomerAmount" desc)))
GROUP BY "Name"
ORDER BY "TotalDollorValue"