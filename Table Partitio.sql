Secondary INDEX

CREATE UNIQUE INDEX (Column/Columns) ON <dbname>.<tablename >;
CREATE INDEX (Column/Columns) ON <dbname>.<tablename >;

Partition Table

CREATE MULTISET TABLE ORDER_Table
(
ORDER_ID  integer NOT NULL,
CUST_ID integer NOT NULL,
ORDER_DATE  date ,
ORDER_AMOUNT integer
)
PRIMARY INDEX (CUST_ID)
PARTITION BY range_n (
ORDER_DATE BETWEEN date '2017-01-01' and '2017-12-31' Each interval '1' Day,
NO range OR  UNKNOWN ) ;

CREATE MULTISET TABLE ORDER_Table (
ORDER_ID  integer NOT NULL,
CUST_ID integer NOT NULL,
ORDER_DATE  date ,
ORDER_AMOUNT integer
)
PRIMARY INDEX (CUST_ID)
PARTITION BY case_n ( 
ORDER_AMOUNT  < 10000 ,
ORDER_AMOUNT  < 20000 ,
ORDER_AMOUNT  < 30000,
NO           CASE     OR        UNKNOWN ) ;

Queries which specify a restrictive condition on the partitioning column  avoid full table scans.
Range queries can be executed on tables without secondary indexes.
The more partitions there are, the greater the potential benefit.


A PI access disadvantage occurs only when the partitioning column is not part of the PI.  
	A query specifying a PI value, but no value for the partitioning column, 
	must look in each partition for that value.
	
A direct join disadvantage occurs when joining a PPI table to a NPPI table with the same PI
 (join disadvantages are discussed in another module).
	If one of the tables is partitioned, the rows wont be ordered the same, and the task, in effect, 
	becomes a set of sub-joins, one for each partition of the PPI table.  
	
The disadvantage is proportional to the number of partitions, with fewer partitions being better than more partitions.


SELECT PARTITION,hire_date FROM tutorial_db.employee;
SELECT * FROM tutorial_db.employee WHERE PARTITION=2;