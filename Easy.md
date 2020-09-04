# SQL Practices
This file includes my solutions to LeetCode SQL questions using MySQL.

## [Q175 Combine Two Tables][Q175]
```sql
SELECT FirstName, LastName, City, State
FROM Person
LEFT JOIN Address
ON Person.PersonId = Address.PersonId
```
[Q175]:
https://leetcode.com/problems/combine-two-tables/
