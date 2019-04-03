Date Functions

select	date '2012-08-08' + interval '2' day	; 
select	interval '2' day + interval '3' hour	; 
select	interval '3' year + interval '5' month;	 
select	date '2012-08-08' - interval '2' day;	 
 select current_timestamp + INTERVAL '1' hour;


sel min(calendar_date),max(calendar_date) from  SYS_CALENDAR.CALENDAR
SELECT MONTHS_BETWEEN(DATE'2017-03-01', DATE'2017-01-01'); 
SELECT CURRENT_DATE - CAST('2008-06-06' AS DATE) MONTH(4); -- Gives month between dates

 
SELECT LAST_DAY (DATE);--Select LAST day of Current Month
SELECT DATE;
SELECT CAST(DATE AS VARCHAR(20));
SELECT cast(CAST(DATE AS DATE FORMAT 'Y4M4DD')as  varchar(20));
SELECT cast(CAST(DATE AS DATE FORMAT ‘Y4-MM-DD’)as  varchar(20));
SELECT cast(CAST(DATE AS DATE FORMAT ‘Y4-M4-DD’)as  varchar(20));
SELECT cast(CAST(DATE AS DATE FORMAT ‘Y4-M3-DD’)as  varchar(20));
SELECT cast(CAST(DATE AS DATE FORMAT 'YYDDD')as  varchar(20));
SELECT cast(CAST(DATE+68 AS DATE FORMAT 'Y4-MMM-DD')as  varchar(20));

SELECT DATE + INTERVAL ‘2’ DAY;
SELECT DATE + INTERVAL ‘2’ MONTH;
SELECT DATE + INTERVAL ‘2’ YEAR;
SELECT CAST(DATE AS TIMESTAMP(0));
SELECT add_months(date,-3);
SELECT add_months(date,3);
SELECT EXTRACT(YEAR FROM DATE); --Select YEAR from Date
SELECT EXTRACT(MONTH FROM DATE); --Select MONTH from Date
SELECT EXTRACT(DAY FROM DATE); --Select DAY from Date
SELECT EXTRACT(HOUR FROM TIME);  
SELECT EXTRACT(MINUTE FROM TIME); 
SELECT EXTRACT(SECOND  FROM TIME);  
 