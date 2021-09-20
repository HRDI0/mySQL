CREATE SCHEMA 조직도;
USE 조직도;
CREATE TABLE empTBL (
직원이름 VARCHAR(20) NOT NULL, 
상관이름 VARCHAR(20),
구내번호 VARCHAR(20) NOT NULL,
PRIMARY KEY(직원이름) 
);

DROP PROCEDURE IF EXISTS input_data;
DELIMITER //
CREATE PROCEDURE input_data(
IN 직원 VARCHAR(20),
IN 상관 VARCHAR(20), 
IN 번호 VARCHAR(20))
BEGIN
	SELECT * FROM empTBL;
	INSERT INTO empTBL(직원이름, 상관이름, 구내번호) VALUES (직원, 상관, 번호);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS emp_manager_call;
DELIMITER //
CREATE PROCEDURE emp_manager_call()
BEGIN
	SELECT emp.직원이름 AS '직원', manager.직원이름 AS '직속상관', manager.구내번호 AS '직속상관 연락처' 
    FROM empTBL emp
	LEFT OUTER JOIN empTBL manager
		ON emp.상관이름 = manager.직원이름;
END //
DELIMITER ;

CALL input_data('나사장',NULL,'0000');
CALL input_data('김재무','나사장','2222');
CALL input_data('김부장','김재무','2222-1');
CALL input_data('이부장','김재무','2222-2');
CALL input_data('우대리','이부장','2222-2-1');
CALL input_data('지사원','이부장','2222-2-2');
CALL input_data('이영업','나사장','1111');
CALL input_data('한과장','이영업','1111-1');
CALL input_data('최정보','나사장','3333');
CALL input_data('윤차장','최정보','3333-1');
CALL input_data('이주임','윤차장','3333-1-1');

#1. [표 8-1]의 조직도 테이블(empTBL)에서 다음과 같이 모든 직원의 직속상관과 연락처가 출력되도록 쿼리문을 작성하시오(사장도 출력).
CALL emp_manager_call();