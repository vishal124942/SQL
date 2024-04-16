CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;
CREATE TABLE worker(
   WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   FIRST_NAME CHAR(25),
   LAST_NAME CHAR(25),
   SALARY INT(15),
   JOINING_DATE DATETIME,
   DEPARTMENT CHAR(25)
   );
   INSERT INTO worker 
   (WORKER_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT) VALUES
    (001,'Monika','Arora',100000,'14-02-20 09.00.00','HR'),
    (002,'Niharika','Verma',80000,'14-06-11 09.00.00','Admin'),
    (003,'Vishal','Singhal',300000,'14-02-20 09.00.00','HR'),
    (004,'Ambitabh','Singh',500000,'14-02-20 09.00.00','Admin'),
    (005,'Vivek','Bhati',500000,'14-06-11 09.00.00','Admin'),
    (006,'Vipul','Diwan',200000,'14-06-11 09.00.00','Account'),
    (007,'Satish','Kumar',75000,'14-01-20 09.00.00','Account'),
    (008,'Geetika','Chauhan',90000,'14-04-11 09.00.00','Admin');
    
    CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
         REFERENCES worker(WORKER_ID)
         ON DELETE CASCADE
   );
   INSERT INTO Bonus
   (WORKER_REF_ID,BONUS_AMOUNT,BONUS_DATE) VALUES
     (001,5000,'16-02-20'),
	 (002,3000,'16-06-11'),
	 (003,4000,'16-02-20'),
     (004,4500,'16-02-20'),
	 (005,3500,'16-06-11');
    
  CREATE TABLE Title (
    Worker_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
       REFERENCES worker(WORKER_ID)
        ON DELETE CASCADE
);
 
 INSERT INTO Title
    (WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM) VALUES
    (001,'Manager','2016-02-20 00:00:00'),
    (002,'Executive','2016-06-11 00:00:00'),
    (008,'Executive','2016-06-11 00:00:00'),
    (005,'Manager','2016-06-11 00:00:00'),
    (004,'Asst. Manager','2016-06-11 00:00:00'),
    (007,'Executive','2016-06-11 00:00:00'),
    (006,'Lead','2016-06-11 00:00:00'),
    (003,'Lead','2016-06-11 00:00:00');

SELECT FIRST_NAME AS WORKER_NAME FROM Worker ;
SELECT UPPER(FIRST_NAME) FROM worker ;
SELECT DISTINCT department from worker;
SELECT department From worker group by department;
SELECT UPPER(SUBSTRING(FIRST_NAME,1,3)) as first_name from worker;
SELECT DISTINCT LENGTH(department) FROM worker;
SELECT REPLACE(first_name,'a','A') from worker ;
SELECT CONCAT(first_name,' ',last_name) from worker;
SELECT * FROM worker ORDER BY first_name;
SELECT * from worker where first_name not in('Vipul', 'Satish');
SELECT * from worker where department like 'Admin%';
SELECT * from worker where first_name like '%a%';
Select * from worker where first_name like '%a';
select * from worker where first_name like '%h' and length(first_name)=6;
select * from worker where salary between 100000 and 500000;
SELECT *FROM worker WHERE DATE_FORMAT(joining_date, '%Y-%m') = '2014-02';
SELECT Count(*) from worker  where department='Admin';
SELECT concat(first_name,' ',last_name) as full_name from worker where salary between 50000 and 100000;
select department,count(*) AS department_count from worker group by department Order by department_count desc; 
-- for odd number of rows --
select * from worker where MOD(worker_id,2)!=0;
-- for even number of rows --
select * from worker where MOD(worker_id,2)=0;
-- clone a table --
create table worker_clone like worker;
insert into worker_clone select * from worker;
select * from worker_clone;
-- intersected data  between cloned and actual table
select worker.* from worker inner join worker_clone using(worker_id);
-- sql query to show record from one table that another table does not have -- 
 select * from worker left join worker_clone using(worker_id) where worker_clone.worker_id is null;
select current_timestamp;
-- sql query to get data of top 5 in descending order of salary --;
select * from worker order by salary desc limit 5;
-- to get salary of 5th top only
select * from worker order by salary desc limit 4,1;
-- without limit keyword
select * from worker w1
where 4=(
select count(distinct(w2.salary))
from worker w2
where w2.salary>=w1.salary
);
-- query to get list of employees with same salary --;
select * from worker w1,worker w2 where w1.salary = w2.salary and w1.worker_id!=w2.worker_id;
-- query to show one row twice from a table
select * from worker
union all
select * from worker order by worker_id;
-- to get first 50% records
select * from worker where worker_id<=(select count(worker_id)/2 from worker);
select department,count(department) as depCount from worker group by department having depCount<=4;
-- sql query to show the last record from the table
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 1;
-- query to get the name of employees having the highest salary in each department 
SELECT department,salary,concat(first_name, ' ', last_name) AS employee_name
FROM worker w1
WHERE salary = (
  SELECT MAX(salary)
  FROM worker w2
  WHERE w1.department = w2.department
  GROUP BY w2.department
);
-- query to fetch three max salaries from the table
select distinct salary from worker w1
where 3>= (select count(distinct salary) from worker w2 where w1.salary<=w2.salary) order by w1.salary desc;
-- query to fetch three min salaries from the table
select distinct salary from worker w1
where 3>=(select count(distinct salary) from worker w2 where w1.salary>=w2.salary) order by w1.salary;