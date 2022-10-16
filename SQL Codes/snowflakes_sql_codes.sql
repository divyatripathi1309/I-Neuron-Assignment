--CREATE DATABASE AJ_NEW_DATABASE;



USE DATABASE demodatabase;

CREATE OR REPLACE  TABLE  CONSUMER_COMPLAINTS 
   (	
      "DATE_RECEIVED" STRING ,
      "PRODUCT_NAME" VARCHAR2(50) , 
	  "SUB_PRODUCT" VARCHAR2(40) , 
	  "ISSUE" VARCHAR2(100), 
      "SUB_ISSUE" VARCHAR2(100),
      "CONSUMER_COMPLAINT_NARRATIVE" VARCHAR2(100),
      "Company Public_Response" STRING,
      "Company" VARCHAR(30),
      "State_Name" CHAR(4),
      "Zip_Code" INTEGER,
      "Tags" VARCHAR(10),
      "Consumer_Consent_Provided" CHAR(6),
       "Submitted_via" STRING,
      "Date_Sent_to_Company" STRING,
     "Company_Response_to_Consumer" VARCHAR(2),
     "Timely_Response" CHAR(4),
     "CONSUMER_DISPUTED" CHAR(4),
     "COMPLAINT_ID" NUMBER(12,0) NOT NULL PRIMARY KEY
);


Select * from INEURON_CONSUMER_COMPLAINTS 


CREATE OR REPLACE  TABLE INEURON_CONSUMER_COMPLAINTS 
   (	
      DATE_RECEIVED STRING ,
      PRODUCT_NAME VARCHAR2(100) , 
	  SUB_PRODUCT VARCHAR2(100) , 
	  ISSUE VARCHAR2(100), 
      SUB_ISSUE VARCHAR2(100),
      CONSUMER_COMPLAINT_NARRATIVE VARCHAR2(100),
      Company_Public_Response STRING,
      Company VARCHAR(100),
      State_Name CHAR(100),
      Zip_Code INTEGER,
      Tags VARCHAR(100),
      Consumer_Consent_Provided CHAR(100),
       Submitted_via STRING,
      Date_Sent_to_Company STRING,
     Company_Response_to_Consumer VARCHAR(100),
     Timely_Response CHAR(100),
     CONSUMER_DISPUTED CHAR(100),
     COMPLAINT_ID NUMBER(12,0) NOT NULL PRIMARY KEY
);

Select * from INEURON_CONSUMER_COMPLAINTS ;



Show columns in INEURON_CONSUMER_COMPLAINTS ;

create or replace file format csv_format
type = csv 
record_delimiter = '\n'
field_delimiter = ','
skip_header = 1
null_if = ('NULL','null')
empty_field_as_null = true;


SElect * from INEURON_CONSUMER_COMPLAINTS ;
SELECT * FROM "DEMODATABASE"."PUBLIC"."CONSUMER_COMPLAINTS";

select * from "DEMODATABASE"."CLONE_SCHEMA"."DEMO_INFO_TABLE";

USE DATABASE"AJ_NEW_DATABASE" ;

CREATE OR REPLACE TABLE OWNER
(
   OwnerID INTEGER NOT NULL PRIMARY KEY ,
   Name VARCHAR2(20),
   Surname STRING,
   StreetAddress VARCHAR2(50),
   City STRING,
   State CHAR(4),
   StateFull STRING,
   ZipCode INTEGER
);


select * from OWNER

CREATE OR REPLACE TABLE PETS
(
    PetID VARCHAR(10) NOT NULL PRIMARY KEY,
    Name VARCHAR(20),
    Kind STRING,
    Gender CHAR(7),
    Age INTEGER,
    OwnerID INTEGER NOT NULL REFERENCES OWNER 
);

select * from PETS


SELECT * FROM OWNER; -- 89 ROWS
SELECT * FROM PETS;-- 100 ROWS

--SUBQUERY
SELECT * FROM OWNER WHERE OWNERID IN (SELECT DISTINCT OWNERID FROM PETS);

SELECT NAME,SURNAME FROM OWNER WHERE OWNERID NOT IN (SELECT DISTINCT OWNERID FROM PETS WHERE KIND = 'Dog');

-- UNION ALL
SELECT OWNERID,NAME FROM OWNER
UNION ALL
SELECT OWNERID,NAME FROM PETS;

--EXCEPT CLAUSE
SELECT OWNERID,NAME FROM OWNER
EXCEPT
SELECT OWNERID,NAME FROM PETS;

--INTERSECT
SELECT OWNERID,NAME FROM OWNER
INTERSECT
SELECT OWNERID,NAME FROM PETS;

SELECT COUNT(DISTINCT OwnerID) from OWNER;
SELECT COUNT(DISTINCT PetID) from PETS;

-- NEED THE NAME OF OWNER & THEIR DOGS NAME ALONG WITH THEIR AGE  ---- INNER JOIN
SELECT O.Name AS OWNER_NAME,p.NAME AS PET_NAME,p.age AS PET_AGE
FROM OWNER o
INNER JOIN PETS p ON o.OwnerID = p.OwnerID;

--NEED THE NAME OF ALL THE OWNERS IRRESPECTIVE WETHER OR NOT THEY ARE HAVING PETS 
SELECT O.Name AS OWNER_NAME,p.NAME AS PET_NAME,p.age AS PET_AGE
FROM OWNER o
LEFT OUTER JOIN PETS p ON o.OwnerID = p.OwnerID;
--- COUNT OF PETS EACH OWNER HAS
SELECT O.Name AS OWNER_NAME,COUNT(DISTINCT p.PETID)
FROM OWNER o
INNER JOIN PETS p ON o.OwnerID = p.OwnerID
GROUP BY 1
ORDER BY 2 DESC;

---RIGHT JOIN
SELECT O.Name AS OWNER_NAME,p.NAME AS PET_NAME,p.age AS PET_AGE
FROM OWNER o
RIGHT JOIN PETS p ON o.OwnerID = p.OwnerID;

--FULL OUTER JOIN
SELECT O.*,P.*
FROM OWNER O
FULL OUTER JOIN PETS p ON o.OwnerID = p.OwnerID;

-- INFO OF ALL THE PETS HOLD BY THEIR OWNER
SELECT DISTINCT KIND FROM PETS;
SELECT KIND,COUNT(*) FROM PETS
GROUP BY 1;

--- CROSS JOIN 
SELECT O.*,P.*
FROM OWNER O
CROSS JOIN PETS p ;

------------------------
CREATE OR REPLACE TABLE EMPLOYEE
(
   EMPID INTEGER NOT NULL PRIMARY KEY,
   EMP_NAME VARCHAR2(20),
   JOB_ROLE STRING,
   SALARY NUMBER(10,2)
);

INSERT INTO EMPLOYEE
VALUES('101','ANAND JHA','Analyst',50000);

INSERT INTO EMPLOYEE
VALUES(102,'ALex', 'Data Enginner',60000);

INSERT INTO EMPLOYEE
VALUES(103,'Ravi', 'Data Scientist',48000);

INSERT INTO EMPLOYEE
VALUES(104,'Peter', 'Analyst',98000);

INSERT INTO EMPLOYEE
VALUES(105,'Pulkit', 'Data Scientist',72000);

INSERT INTO EMPLOYEE
VALUES(106,'Robert','Analyst',100000);

INSERT INTO EMPLOYEE
VALUES(107,'Rishabh','Data Engineer',67000);

INSERT INTO EMPLOYEE
VALUES(108,'Subhash','Manager',148000);

INSERT INTO EMPLOYEE
VALUES(109,'Michaeal','Manager',213000);

INSERT INTO EMPLOYEE
VALUES(110,'Dhruv','Data Scientist',89000);

INSERT INTO EMPLOYEE
VALUES(111,'Amit Sharma','Analyst',72000);

DELETE FROM EMPLOYEE WHERE EMPID = 110;

SELECT * FROM EMPLOYEE;

update employee set job_role='Data Engineer'
where empid=102;

update employee set salary= 50000
where empid=104;

SELECT @temp_var = EMP_NAME WHERE EMPID = 104;

DECLARE 
   profit number(38,2);
   revenue number(38,2);
   cost number(38,2);

BEGIN 
  
  profit := revenue - cost;
  
  return profit;
  
set my_variable=10;
set my_variable='example';
  
  
  
 
-------------------------------------------------------------WINDOW FUNCTIONS------------------------------------------------------------

-- SYNTAX : window_function_name(<exprsn>) OVER (<partition_by_clause> <order_clause>)

--- display total salary based on job profile
SELECT JOB_ROLE,SUM(SALARY) FROM EMPLOYEE 
GROUP BY JOB_ROLE;

-- display total salary along with all the records ()every row value 
SELECT * , SUM(SALARY) OVER() AS TOT_SALARY
FROM EMPLOYEE;

-- display the total salary per job category for all the rows 
SELECT *,MAX(SALARY) OVER(PARTITION BY JOB_ROLE) AS MAX_JOB_SAL
FROM EMPLOYEE;

select *,max(salary) over(partition by JOB_ROLE) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE) as TOT_SAL
from Employee;



--ARRANGING ROWS WITHIN EACH PARTITION BASED ON SALARY IN DESC ORDDER
select *,max(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as TOT_SAL
from Employee;

-- ROW_NUMBER() It assigns a unique sequential number to each row of the table ...
SELECT * FROM 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS PART_ROW_NUM 
FROM EMPLOYEE 
)
WHERE PART_ROW_NUM <=2;



USE DATABASE "AJ_NEW_DATABASE" ;

CREATE TABLE  "CONSUMER_COMPLAINTS" 
   (	
      "DATE_RECEIVED" STRING ,
      "PRODUCT NAME" VARCHAR2(50) , 
	  "SUB_PRODUCT" VARCHAR2(40) , 
	  "ISSUE" VARCHAR2(100), 
      "SUB_ISSUE" VARCHAR2(100),
      "CONSUMER COMPLAINT NARRATIVE" VARCHAR2(100),
      "Company Public Response" STRING,
      "Company" VARCHAR(30),
      "State Name" CHAR(4),
      "Zip Code" INTEGER,
      "Tags" VARCHAR(10),
      "Consumer Consent Provided" CHAR(6),
       "Submitted via" STRING,
      "Date Sent to Company" STRING,
     "Company Response to Consumer" VARCHAR(2),
     "Timely Response" CHAR(4),
     "CONSUMER DISPUTED" CHAR(4),
     "COMPLAINT_ID" NUMBER(12,0) NOT NULL PRIMARY KEY
);
SELECT* FROM CONSU_COMPLAINTS 





