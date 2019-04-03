sel * from dbc.databases ;
database financial;


sel distinct databasename from dbc.databases  where dbkind = 'd'
select database --- current database
database financial -- change ur default database




add unix tutorial video
--Table Creation 
	CREATE SET TABLE financial.empla , no FALLBACK ,
		 NO BEFORE JOURNAL,
		 NO AFTER JOURNAL,
		 CHECKSUM = DEFAULT,
		 DEFAULT MERGEBLOCKRATIO
		 (
		  id INTEGER,
		  ename VARCHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC,
		  deptid INTEGER,
		  mid INTEGER,
		  salary DECIMAL(10,2))
	PRIMARY INDEX ( id );

	insert into empla (100,'Sanjay',10,,50000);
	insert into empla (10,'Gopi',10,100,10000);
	insert into empla (20,'Sankar',10,100,20000);
	insert into empla (30,'Harish',20,100,20000);
	insert into empla (40,'Ganesh',30,100,40000);


CREATE MULTISET TABLE financial.dept ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      deptid INTEGER,
      dept_name VARCHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC)
PRIMARY INDEX ( deptid );
insert into dept (10,'HR');
insert into dept (20,'IT');
insert into dept (30,'SALES');
insert into dept (40,'FiN');



---Secondary Index tables
create table employee_aug18_usi
(
eid integer,
deptid integer)
unique primary index(eid)
unique index (deptid)

create table employee_aug18_nusi
(
eid integer,
deptid integer)
unique primary index(eid)
  index (deptid)


--UPSERT
update empla 
set deptid = 60 where id =  400
else
insert into empla (400,50,60,'Gopi',20000,100,19)

 
UPDATE empla set deptid =280 where  id =1510
else
insert into empla values(1510,'peter',180,100,10000)

--Coalesce and NullIF
select coalesce ( salary,'Not Salaried' ) from empla;
select salary,nullif ( salary,salary+1 ) from empla;



--CASE statement

sel id,salary, case  
when salary <= 10000 then 'L1'
when salary <= 30000 then'L2'
when salary <= 50000 then 'L3'
when salary <= 100000  then 'Max'
else 'Trainee'
end Salstruct 
from empla;

sel id,salary, case  
when salary<= 10000 then 'Grade 1'
when  salary<= 25000 then'Grade 2'
else 'Non salaried/Higher Salarareid'
end deptname 
from empla;

-- Value Based Case statement 
sel id,deptid, case deptid
when 10 then 'HR'
when 20 then'IT'
when 50 then 'FIN'
when 60 then 'SALES'
else 'UN Categorised'
end deptname 
from empla;

Normal Sub query
select * from  dept  where deptid in (select deptid  from empla)


sel distinct a.* from dept a
inner join 
empla b
on 
a.deptid = b.deptid 
 
Co-relatedSub Query
select *  from empla a
where mid  in  (select b.id from empla b where b.id = a.mid)


sel * from empla a
inner join 
empla b
on b.id = a.mid


--OLAP Queries
 database tpch;
sel *  from ordertbl;
sel o_orderdate,o_totalprice,sum(o_totalprice) over(order by o_orderdate rows unbounded preceding)  from ordertbl;

sel o_orderkey,o_orderdate,o_totalprice,sum(o_totalprice) over(order by o_orderdate rows unbounded preceding)  from ordertbl;
sel o_orderkey,o_orderdate,o_totalprice,sum(o_totalprice) over( partition by o_orderdate order by o_orderdate rows unbounded preceding)  from ordertbl;

sel o_orderkey,o_orderdate,o_totalprice,sum(o_totalprice) over( partition by o_orderdate order by o_orderdate )  from ordertbl;

sel id,deptid,empname,salary,rank() over( partition by deptid	order by salary ) as ranker from empla;

sel id,deptid,empname,salary,row_number () over( partition by deptid	order by salary ) as ranker from empla;

sel id,deptid,empname,salary,dense_rank() over( partition by deptid	order by salary ) as ranker from empla;


 
 
 --EXPLAIN Eamples
explain sel deptid from financial.emplab where deptid =10 ;

explain sel id,age,deptid from financial.emplab group by 1,2,3;

explain sel * from   financial.emplab  a
inner join financial.dept b
on a.deptid=b.deptid;

--duplicated on all amps
Datawarehouse : we are processing  the a

--- eliminaating duplicates records
explain sel * from empla
union sel * from emplab  

--Partition Elimination
explain sel * from tpch.ordertblb  where o_orderdate = '1992-01-01'

explain  sel * from   tpch.ordertbla  where O_ORDERDATE between  '1992-01-01' and '1992-01-10';

 
select partition, count(*)
from tab
group by 1
order by 1



Low Confidence query
explain sel o_orderkey,o_totalprice,sum(o_totalprice) 
over(order by o_orderdate rows unbounded preceding)  from tpch.ordertbl;
   


  
Unique index SI Explain 
create table empla_apr08
( id integer,
deptid integer)
primary  index (id)
unique index (deptid)

create table empla_apr08_nusi
( id integer,
deptid integer)
primary  index (id)
  index (deptid)
  
  

	 explain sel * from empla_apr08 where deptid = 10
--Join INDEX
create join index emplaji as
select id,age,deptid,empname,salary,mid,newid,newfield from  empla primary index(deptid);

create join index emplamji as 
select a.id,a.empname,a.age,b.deptid,b.deptname from empla a
inner join dept b
on a.deptid=b.deptid
 primary index (deptid)
 
create join index empla_dept_ji as 
sel  a.id,a.ename,a.deptid,b.dept_name from empla  a 
inner join dept b
on a.deptid =b.deptid
where a.deptid =10
primary index(deptid);

create   join index empla_order23
as
select id, deptid,ename ,salary,mid from empla primary index (deptid);

create join index empla_salary as 
select deptid,sum(salary) as sumsal  from empla   
group  by deptid;

create join index empla_sal_ji as 
sel deptid, sum(salary)  as sumsal from empla 
group by deptid;

create join index empla_salary10 as 
select deptid,sum(salary) as sumsal  from empla   where deptid = 10
group  by deptid;


--Macro

create macro mac1
as
(
select count(*) from empla;

select count(*) from dept;
); 
--Procedure
create procedure proc1(in idp integer,in deptidp integer, in empnamep varchar(40))
begin
insert into empla (id,deptid,empname)
values(:idp,:deptidp,:empnamep);
end;


create procedure financial.proc_dec3a(in deptidp integer, in empnamep varchar(40))

begin
declare idtemp integer;
select max(id)+1 into :idtemp from financial.empla_dec3 ;
insert into financial.empla_dec3 (id,deptid,ename)
values(:idtemp,:deptidp,:empnamep);
end;


select cast(cast(date as date format 'YY-MM-DD') as char(8)) ;


User  Creation :
CREATE USER testuser_sep23
   FROM dbc
AS
   PASSWORD=********
   permanent=0
       SPOOL=5000000;
	   
	   
Exists
select * from empla where not exists (sel * from dept)
select * from empla where   exists (sel * from dept)

CREATE SET TABLE financial.empla , no FALLBACK ,
		 NO BEFORE JOURNAL,
		 NO AFTER JOURNAL,
		 CHECKSUM = DEFAULT,
		 DEFAULT MERGEBLOCKRATIO
		 (
		  id INTEGER,
		  ename VARCHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC,
		  deptid INTEGER,
		  mid INTEGER,
		  salary DECIMAL(10,2))
PRIMARY INDEX ( id );


alter table  financial.empla , No FALLBACK

Create Database sales
form SYSDB
as
permanent = 400000 BYTES,
spool = 200000 BYTES;


CREATE DATABASE CustomerDB
   FROM DBC  
   AS
   PERM = 10000000; -- 1000 MB


CREATE USER SalesUser
   FROM dbc
AS
   PASSWORD=********
   permanent=0
       SPOOL=5000000;


select name,age,case  
when age <= (select avg(age) from customer as a) then 'Low'
else 'High'
end AgeIndicator 
from Customer;

Update Product 
Set name = ‘New Product’
Where id = 230
Else
Insert into product (230, ‘New Product’);


Select order_id,Customer_id,order_date,order_total, case
when order_total <= 200 then 'Low Range'
when order_total <= 500 then 'Medium Range'
else 'high Range'
from Customer;


Select product_id,product_name, selling_price from 
(Select product_id,product_name, selling_price, row_number  over(partition by id order by selling_price desc) as identifier)
where identifier <= 3


Select product_id,product_name, selling_price, row_number over(partition by SellingDate,id order by selling_price desc)

COLLECT STATISTICS
INDEX (Product_Id) COLUMN (Customer_Id)
ON Orders_Dtl;

COLLECT SUMMARY STATISTICS ON Customer;

















