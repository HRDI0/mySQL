CREATE SCHEMA 숫자연산;

USE 숫자연산;

DROP PROCEDURE IF EXISTS mydata_if;
DELIMITER //
CREATE PROCEDURE mydata_if(IN i INT)
BEGIN
	IF i > 0 THEN
		SELECT '양수입니다.'AS '결과';
	END IF;
        
   IF i < 0 THEN
		SELECT '음수입니다.'AS '결과';
    END IF;
END //
DELIMITER ;

#2. 음수와 양수로 구분하여 출력하는 프로그램을 작성(myData = -1)
CALL mydata_if(-1);
CALL mydata_if(1);

DROP PROCEDURE IF EXISTS mydata_case;
DELIMITER //
CREATE PROCEDURE mydata_case(IN i INT)
BEGIN
CASE
	WHEN i > 0 THEN
		SELECT '양수입니다.' AS '결과';
	WHEN i < 0 THEN
		SELECT '음수입니다.' AS '결과';
	ELSE
		SELECT '0입니다.' AS '결과';
END CASE;
END //
DELIMITER ;

#3. 2번의 코드를 CASE … END CASE 문으로(단, 음수, 양수, 0으로 구분하여 출력).
CALL mydata_case(-1);
CALL mydata_case(1);
CALL mydata_case(0);

DROP PROCEDURE IF EXISTS mydata_sum;
DELIMITER //
CREATE PROCEDURE mydata_sum()
BEGIN
DECLARE i INT;
DECLARE sum INT;
SET i = 12345;
SET sum = 0;

WHILE(i <=67890)DO
	IF(i%1234 = 0) THEN
		SET sum = sum + i;
	END IF;    
    SET i = i + 1;
END WHILE;

SELECT '결과' + sum AS '12345 ~ 67890 중 1234 배수의 합';
END //
DELIMITER ;

#4. WHILE 문을 사용하여 12,345부터 67,890까지의 숫자 중에서 1,234의 배수 합계를 출력하도록 코딩(결과 값은 1,832,490).
CALL mydata_sum();