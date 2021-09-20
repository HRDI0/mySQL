CREATE SCHEMA 매상정보;

CREATE TABLE 매상정보.고객 (
고객번호 CHAR(4) NOT NULL, 
이름 VARCHAR(20) NOT NULL, 
거주도시 VARCHAR(20) NOT NULL,
할인율 INT, 
PRIMARY KEY(고객번호) 
);

SELECT * FROM 매상정보. 고객;
INSERT INTO 매상정보. 고객(고객번호, 이름, 거주도시, 할인율) VALUES ('C001', '김민수', '강원', 10);
INSERT INTO 매상정보. 고객(고객번호, 이름, 거주도시, 할인율) VALUES ('C005', '박민지', '충북', 5);
INSERT INTO 매상정보. 고객(고객번호, 이름, 거주도시, 할인율) VALUES ('C003', '이예은', '대전', 15);
INSERT INTO 매상정보. 고객(고객번호, 이름, 거주도시, 할인율) VALUES ('C004', '허성민', '경기', 10);

CREATE TABLE 매상정보.판매자 (
판매자번호 CHAR(4) NOT NULL, 
이름 VARCHAR(20) NOT NULL, 
수수료 VARCHAR(20), 
PRIMARY KEY(판매자번호) 
);

SELECT * FROM 매상정보. 판매자;
INSERT INTO 매상정보. 판매자(판매자번호, 이름, 수수료) VALUES ('S001', '박영호', 5);
INSERT INTO 매상정보. 판매자(판매자번호, 이름, 수수료) VALUES ('S002', '김지영', 3);
INSERT INTO 매상정보. 판매자(판매자번호, 이름, 수수료) VALUES ('S003', '조아영', 7);
INSERT INTO 매상정보. 판매자(판매자번호, 이름, 수수료) VALUES ('S004', '김철수', 7);

CREATE TABLE 매상정보.제품 (
제품번호 CHAR(4) NOT NULL, 
제품명 VARCHAR(20) NOT NULL, 
재고량 INT NOT NULL,
가격 INT NOT NULL,
PRIMARY KEY(제품번호) 
);

SELECT * FROM 매상정보. 제품;
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P001', '휴지', 600, 10000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P002', 'A4용지', 3000, 8000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P003', '한지', 1000, 6000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P004', 'B4용지', 1500, 10000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P005', '이런지', 50, 1000000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P006', '저런지', 50, 1000000);
INSERT INTO 매상정보. 제품(제품번호, 제품명, 재고량, 가격) VALUES ('P007', '한지', 1000, 6000);

CREATE TABLE 매상정보.주문 (
주문번호 CHAR(4) NOT NULL, 
고객번호 CHAR(4) NOT NULL,
제품번호 CHAR(4) NOT NULL,
판매자번호 CHAR(4) NOT NULL,
주문수량 INT NOT NULL,
FOREIGN KEY(고객번호) REFERENCES 매상정보.고객(고객번호),
FOREIGN KEY(제품번호) REFERENCES 매상정보.제품(제품번호),
PRIMARY KEY(주문번호)
);

SELECT * FROM 매상정보. 주문;
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0001','C001','P001', 'S001', 50);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0002','C005','P003', 'S003', 100);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0003','C003','P002', 'S002', 150);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0004','C001','P004', 'S001', 200);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0005','C004','P002', 'S002', 100);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0006','C004','P001', 'S003', 200);
INSERT INTO 매상정보. 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량) VALUES ('0007','C005','P003', 'S004', 300);

#(1) 고객 테이블에 고객번호가 C002, 이름이 채희성, 거주도시가 대전이고, 할인율은 아직 결정되지 않은 고객의 정보를 삽입하는 SQL 문을 작성하시오.
INSERT  INTO  매상정보.고객(고객번호, 이름, 거주도시) VALUES ('C002', '채희성', '대전');
SELECT * FROM 매상정보. 고객;

#(2) 허성민(방지호 대체) 고객의 주문수량을 10% 증가시키는 SQL 문을 작성하시오.
UPDATE 매상정보.주문 SET  주문수량 = 주문수량 * 1.1 WHERE 고객번호  IN (SELECT 고객번호  FROM 매상정보.고객  WHERE 이름 = '허성민');

#3) 재고량이 100개 이하인 제품을 모두 삭제하는 SQL 문을 작성하시오.
DELETE FROM 매상정보.제품 WHERE 재고량 <= 100;

#(4) 가격이 가장 최소인 제품의 제품명을 중복 없이 검색하는 SQL 문을 작성하시오.
SELECT DISTINCT 제품명 FROM 매상정보.제품 WHERE 가격 = (SELECT MIN(가격)  FROM 매상정보.제품);

#(5) 제품명에 '용지' 가 포함된 제품을 주문한 고객의 이름을 검색하는 SQL 문을 작성하시오.
SELECT 이름 FROM 매상정보.고객, 매상정보.제품, 매상정보.주문 WHERE 매상정보.제품.제품명 LIKE '%용지%'  AND 고객.고객번호 = 주문.고객번호  AND 제품.제품번호 = 주문.제품번호;

#(6) 주문수량의 총계가 300개 이상인 고객에 대해 고객별 주문 횟수와 주문수량의 총계를 검색하는 SQL 문을 작성하시오.
SELECT 고객번호, COUNT(주문번호) AS 주문횟수, SUM(주문수량) AS 주문수량총계 FROM 매상정보.주문 GROUP BY 고객번호 HAVING SUM(주문수량) >= 300;