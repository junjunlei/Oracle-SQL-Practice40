--表countries(国家)
create table countries (COUNTRY_ID CHAR(2) NOT NULL,COUNTRY_NAME VARCHAR2(40),REGION_ID NUMBER);
insert into countries values('CA','Canada',2);
insert into countries values('DE','Germany',1);
insert into countries values('UK','United Kingdom',1);
insert into countries values('US','United States of America',2);


--表departments(部门)
create table departments(DEPARTMENT_ID NUMBER(4) NOT NULL, DEPARTMENT_NAME VARCHAR2(30) NOT NULL,MANAGER_ID NUMBER(6),LOCATION_ID NUMBER(4));
insert into departments values(10,'Administartion',200,1700);
insert into departments values(20,'Marketing',201,1800);
insert into departments values(50,'Shipping',124,1500);
insert into departments values(60,'IT',103,1400);
insert into departments values(80,'Sales',149,2500);
insert into departments values(90,'Executive',100,1700);
insert into departments values(110,'Accounting',205,1700);
insert into departments values(190,'Contracting',null,1700);

--表employees(员工)
create table employees
(EMPLOYEE_ID NUMBER(6) NOT NULL,
FIRST_NAME VARCHAR2(20),
LAST_NAME VARCHAR2(25) NOT NULL,
EMAIL VARCHAR2(25) NOT NULL,
PHONE_NUMBER VARCHAR(20),
HIRE_DATE DATE NOT NULL,
JOB_ID VARCHAR2(10) NOT NULL,
SALARY NUMBER(8,2),
COMMISSION_PCT NUMBER(2,2),
MANAGER_ID NUMBER(6),
DEPARTMENT_ID NUMBER(4));

insert into employees values(100,'Steven','King','SKING','515.123.4567',to_date('1987-06-17','YYYY-MM-DD'),'AD_PRES',24000,NULL,NULL,90);
insert into employees values(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',to_date('1989-09-21','YYYY-MM-DD'),'AD_VP',17000,NULL,100,90);
insert into employees values(102,'Lex','De Haan','LDEHAAN','515.123.4569',to_date('1993-01-13','YYYY-MM-DD'),'AD_VP',17000,NULL,100,90);
insert into employees values(103,'Alexander','Hunold','AHUNOLD','590.423.4567',to_date('1990-01-03','YYYY-MM-DD'),'IT_PROG',9000,NULL,102,60);
insert into employees values(104,'Bruce','Ernst','BERNST','590.423.4568',to_date('1991-05-21','YYYY-MM-DD'),'IT_PROG',6000,NULL,103,60);
insert into employees values(107,'Diana','Lorentz','DLORENTZ','590.423.5567',to_date('1999-02-07','YYYY-MM-DD'),'IT_PROG',4200,NULL,103,60);
insert into employees values(124,'Kevin','Mourgos','KMOURGOS','650.123.5234',to_date('1999-11-16','YYYY-MM-DD'),'ST_MAN',5800,NULL,100,50);
insert into employees values(141,'Trenna','Rajs','TRAJS','650.121.8009',to_date('1995-10-17','YYYY-MM-DD'),'ST_CLERK',3500,NULL,124,50);
insert into employees values(142,'Curtis','Davies','CDAVIES','650.121.2994',to_date('1997-01-29','YYYY-MM-DD'),'ST_CLERK',3100,NULL,124,50);
insert into employees values(143,'Randall','Matos','RMATOS','650.121.2874',to_date('1998-05-15','YYYY-MM-DD'),'ST_CLERK',2600,NULL,124,50);
insert into employees values(144,'Peter','Vargas','PVARGAS','650.121.2004',to_date('1998-07-09','YYYY-MM-DD'),'ST_CLERK',2500,NULL,124,50);
insert into employees values(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',to_date('2000-06-29','YYYY-MM-DD'),'SA_MAN',10500,.2,100,80);
insert into employees values(174,'Ellen','Abel','EABEL','011.44.1644.429267',to_date('1996-05-11','YYYY-MM-DD'),'SA_REP',11000,.3,149,80);
insert into employees values(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',to_date('1998-05-24','YYYY-MM-DD'),'SA_REP',8600,.2,149,80);
insert into employees values(178,'Kimberely','Grant','KGRANT','011.44.1644.429263',to_date('1999-05-24','YYYY-MM-DD'),'SA_REP',7000,.15,149,NULL);
insert into employees values(200,'Jennifer','Whalen','JWHALEN','515.123.4444',to_date('1987-09-17','YYYY-MM-DD'),'AD_ASST',4400,NULL,101,10);
insert into employees values(201,'Michael','Hartstein','MHARTSTE','515.123.5555',to_date('1996-02-17','YYYY-MM-DD'),'MK_MAN',13000,NULL,100,20);
insert into employees values(202,'Pat','Fay','PFAY','603.123.6666',to_date('1997-08-17','YYYY-MM-DD'),'MK_REP',6000,NULL,201,20);
insert into employees values(205,'Shelley','Higgins','SHIGGINS','515.123.8080',to_date('1994-06-07','YYYY-MM-DD'),'AC_MGR',12000,NULL,101,110);
insert into employees values(206,'William','Gietz','WGIETZ','515.123.8181',to_date('1994-06-07','YYYY-MM-DD'),'AC_ACCOUNT',8300,NULL,205,110);


--表 jobs(工作)
create table jobs(JOB_ID VARCHAR2(10) NOT NULL,JOB_TITLE VARCHAR2(35) NOT NULL,MIN_SALARY NUMBER(6),MAX_SALARY NUMBER(6));
insert into jobs values('AD_PRES','President',20000,40000);
insert into jobs values('AD_VP','Administration Vice President',15000,30000);
insert into jobs values('AD_ASST','Administration Assistant',3000,6000);
insert into jobs values('AC_MGR','Accounting Manager',8200,16000);
insert into jobs values('AC_ACCOUNT','Public Accountant',4200,9000);
insert into jobs values('SA_MAN','Sales Manager',10000,20000);
insert into jobs values('SA_REP','Sales Representative',6000,12000);
insert into jobs values('ST_MAN','Stock Manager',5500,8500);
insert into jobs values('ST_CLERK','Stock Clerk',2000,5000);
insert into jobs values('IT_PROG','Programmer',4000,10000);
insert into jobs values('MK_MAN','Marketing Manager',9000,15000);
insert into jobs values('MK_REP','Marketing Representative',4000,9000);

--表 job_grades(工作等级)
create table job_grades(GRADE_LEVEL VARCHAR2(3),LOWEST_SAL NUMBER,HIGHEST_SAL NUMBER);
insert into job_grades values('A',1000,2999);
insert into job_grades values('B',3000,5999);
insert into job_grades values('C',6000,9999);
insert into job_grades values('D',10000,14999);
insert into job_grades values('E',15000,24999);
insert into job_grades values('F',25000,40000);

--表 job_history(工作历史)
create table job_history(EMPLOYEE_ID NUMBER(6) NOT NULL,START_DATE DATE NOT NULL,END_DATE DATE NOT NULL,JOB_ID VARCHAR2(10) NOT NULL,DEPARTMENT_ID NUMBER(4));
insert into job_history values(102,to_date('1993-06-13','YYYY-MM-DD'),to_date('1998-07-24','YYYY-MM-DD'),'IT_PROG',60);
insert into job_history values(101,to_date('1989-09-21','YYYY-MM-DD'),to_date('1993-10-27','YYYY-MM-DD'),'AC_ACCOUNT',110);
insert into job_history values(101,to_date('1993-10-28','YYYY-MM-DD'),to_date('1997-05-15','YYYY-MM-DD'),'AC_MGR',110);
insert into job_history values(201,to_date('1996-02-17','YYYY-MM-DD'),to_date('1999-12-19','YYYY-MM-DD'),'MK_REP',20);
insert into job_history values(114,to_date('1998-05-24','YYYY-MM-DD'),to_date('1999-12-31','YYYY-MM-DD'),'ST_CLERK',50);
insert into job_history values(122,to_date('1999-01-01','YYYY-MM-DD'),to_date('1999-12-31','YYYY-MM-DD'),'ST_CLERK',50);
insert into job_history values(200,to_date('1987-09-18','YYYY-MM-DD'),to_date('1993-06-17','YYYY-MM-DD'),'AS_ASST',90);
insert into job_history values(176,to_date('1998-05-24','YYYY-MM-DD'),to_date('1998-12-31','YYYY-MM-DD'),'SA_REP',80);
insert into job_history values(176,to_date('1999-06-01','YYYY-MM-DD'),to_date('1999-12-31','YYYY-MM-DD'),'SA_MAN',80);
insert into job_history values(200,to_date('1994-07-01','YYYY-MM-DD'),to_date('1998-12-31','YYYY-MM-DD'),'AC_ACCOUNT',90);

--表 locations(位置)
create table locations(LOCATION_ID NUMBER(4) NOT NULL,STREER_ADDRESS VARCHAR2(40),POSTAL_CODE VARCHAR2(12),CITY VARCHAR2(30) NOT NULL,STATE_PROVINCE VARCHAR2(25),COUNTRY_ID CHAR(2));
insert into locations values(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
insert into locations values(1500,'2011 Interiors Blvd','99236','South San Franciscon','California','US');
insert into locations values(1700,'2004 Charade Rd','98199','Seattle','Washington','US');
insert into locations values(1800,'460 Bloor St.W.','ON M5S 1X8','Toronto','Ontario','CA');
insert into locations values(2500,'Magdalen Centre,The Oxford Science Park','OX9 OZB','Oxford','Oxford','UK');

--表 regions(区域)
create table regions(REGION_ID NUMBER NOT NULL,REGION_NAME VARCHAR2(25));
insert into regions values(1,'Europe');
insert into regions values(2,'Americas');
insert into regions values(3,'Asia');
insert into regions values(4,'Middle East and Africa');
