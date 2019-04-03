 .logon 192.168.128.128/dbc,dbc
 
-- Full table scan
explain sel * from financial.empla_aug18_expab;

---PI Search
explain   sel * from tpch.ordertbl where o_orderkey = 20;
explain  sel * from financial.empla_aug18_expa where id = 100
 
 
--------Secondary INDEX
----Unique index SI Explain 
create table empla_apr08
( id integer,
deptid integer)
primary  index (id)
unique index (deptid)

explain sel * from empla_apr08 where deptid = 10;
----Non Unique index SI Explain 
create table empla_apr08_nusi
( id integer,
deptid integer)
primary  index (id)
  index (deptid)
explain sel * from empla_apr08_nusi where deptid = 10;
 
------------ Partition elimination 

explain  sel * from   tpch.ordertbla where O_ORDERDATE between  '1992-01-01' and '1992-01-10';

---------- by traversal of index 
explain sel * from empla_apr08 where deptid = 10;


------------ Null check
explain sel * from empla  where deptid is not null 


 
---------- Eliminating Duplicate rows and sort field
 explain sel * from empla_aug18_expab
 union sel * from empla_aug18_expa;

--- --Merge join 

explain sel *  from   financial.empla  a
inner join  financial.dept b on 
 a.deptid = b.deptid
 where id = 100

 
 --Product JOin 
explain sel *  from   financial.empla  a
 , financial.dept b
  where id <> 100

explain sel * from empla_apr08 a
inner join   dept b
on a.deptid = b.deptid;
 
 ---------- by traversal of index 
 
explain sel  * from customer_name as a
inner join customer as b on a.cust_id = b.cust_id
left join  credit_acct as c on b.cust_id = c.cust_id