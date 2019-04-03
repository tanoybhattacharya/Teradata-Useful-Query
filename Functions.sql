String functions 

select chr(97) ; ------ returns the unicode code point n as a single character string.
select length ('abc'); -- returns length of the string
select lower ('ABC'); -- moves to lower case
select upper ('abc'); -- moves to upper case
select initcap('teradata learning'); -- captialize initial character of each word of the string
select index('teradata','d'); -- returns first position of character/characters in a string

select index('teradata','z'); -- returns first position of character/characters in a string
select position('d' in 'teradata'); -- returns position of character/characters in a string
select instr('teradata','a',12);  -- searches string for nth occurences of character/charactersbelow are optional parameters for instr.
select substr('teradata',3,4); -- extracts the specified characters from the string
select substring('teradata' from 3 for 4);
select trim('    teradata    '); -- trims from both sides
select otranslate('slice','sl','d');  -- otranslate(source_stringsearch_characters[replace_characters]) -- -- characters 's' is replaced with 'd'   -- and extra character 'l' in from_string is removed from source string


select 'tera' || 'data' ||'is a rdbms'
 
select otranslate('teradata support high volume of data''data''byte'); -- replaces every occurrence of search string with the replace stringif 'replace_string' is not specified then all occurence wicvvll be removed from source string. --- from teradataa 15



Format Options

SEL CAST( CAST( 22.49 AS FORMAT '$bZ99.99' ) AS VARCHAR(30) );
SEL CAST( CAST( 22.49 AS FORMAT 'Z(I)' ) AS VARCHAR(30) );
SEL CAST( CAST( 22.49 AS FORMAT '$Z(I)' ) AS VARCHAR(30) );
select cast(cast (salary as  FORMAT '$  99999,99'  )  as varchar(20)) from empla
 SELECT 13245.55 (FORMAT '99999.999') as DecimalFormat;
 


 