SELECT * FROM memberTBL;
SELECT memberName, memberAddress From memberTBL;
SELECT * FROM memberTBL WHERE memberName = '토마스';
CREATE TABLE`my testTBL`(id INT);
DROP TABLE `my testtbl`;

CREATE TABLE indexTBL (first_name varchar(14), last_name varchar(16), hire_date date);
INSERT INTO indexTBL
	SELECT first_name, last_name, hire_date
	FROM employees.employees
    LIMIT 500;
SELECT * FROM indexTBL;

SELECT * FROM indexTBL WHERE first_name = 'Mary';

CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);
SELECT * FROM indexTBL WHERE first_name = 'Mary';