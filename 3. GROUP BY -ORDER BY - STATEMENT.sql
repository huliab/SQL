
SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;
SELECT gender, AVG(age) , MAX(age), MIN(age) , COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC;

SELECT occupation ,salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation,salary;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age,gender;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5,4;  # colomn position but not recommended











