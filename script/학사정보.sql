CREATE SCHEMA 학사정보;

CREATE TABLE 학사정보.학생 (
학번 CHAR(9) NOT NULL, 
이름 VARCHAR(20) NOT NULL, 
학년 INT NOT NULL, 
PRIMARY KEY(학번) 
);

SELECT * FROM 학사정보.학생;
INSERT INTO 학사정보.학생 (학번, 이름, 학년) VALUES('201812345', '김지영', 3);
INSERT INTO 학사정보.학생 (학번, 이름, 학년) VALUES('201667890', '박지훈', 3);
INSERT INTO 학사정보.학생 (학번, 이름, 학년) VALUES('201621763', '허성민', 3);
INSERT INTO 학사정보.학생 (학번, 이름, 학년) VALUES('201622222', '이상민', 3);
INSERT INTO 학사정보.학생 (학번, 이름, 학년) VALUES('201633333', '김민지', 3);

CREATE TABLE 학사정보.과목 (
과목번호 VARCHAR(4) NOT NULL, 
과목이름 VARCHAR(20) NOT NULL, 
PRIMARY KEY(과목번호) 
);

SELECT * FROM 학사정보.과목;
INSERT INTO 학사정보.과목 (과목번호, 과목이름) VALUES('A01', 'AAA');
INSERT INTO 학사정보.과목 (과목번호, 과목이름) VALUES('V02', 'VVV');
INSERT INTO 학사정보.과목 (과목번호, 과목이름) VALUES('L03', 'LLL');

CREATE TABLE 학사정보.수강 (
학번 CHAR(9) NOT NULL,
과목번호 VARCHAR(4) NOT NULL,
중간성적 INT NOT NULL, 
기말성적 INT NOT NULL, 
학점 FLOAT NOT NULL,
FOREIGN KEY (학번)  REFERENCES 학사정보.학생(학번),
FOREIGN KEY(과목번호) REFERENCES 학사정보.과목(과목번호)
);

SELECT * FROM 학사정보.수강;
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201812345', 'A01', 51, 55, 3.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201667890', 'V02', 52, 60, 3.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201622222', 'A01', 53, 45, 3.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201812345', 'V02', 74, 65, 3.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201812345', 'L03', 75, 75, 3.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201621763', 'A01', 76, 80, 3.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201621763', 'V02', 97, 95, 4.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201667890', 'L03', 98, 90, 4.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201621763', 'L03', 99, 85, 4.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201667890', 'A01', 41, 35, 2.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201622222', 'V02', 42, 40, 2.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201622222', 'L03', 43, 45, 2.5);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201633333', 'A01', 56, 72, 3.0);
INSERT INTO 학사정보.수강 (학번, 과목번호, 중간성적, 기말성적, 학점) VALUES('201633333', 'V02', 74, 70, 3.5);
SELECT * FROM 학사정보.수강 ORDER BY 학사정보.수강.과목번호 ASC;


#(1) 수강 테이블에서 L로 시작하는 과목의 중간성적이 90점 이상인 학생의 이름과 기말성적을 검색하는 SQL 문을 작성하시오. 
#단, 이름을 기준으로 오름차순 정렬하고, 만약 이름이 같으면 기말성적을 기준으로 내림차순 정렬하시오.
SELECT 이름, 기말성적 FROM 학사정보.학생, 학사정보.수강 
WHERE 학사정보.수강.과목번호 LIKE 'L%' AND 학사정보.수강.중간성적 >= 90 AND 학사정보.학생.학번 = 학사정보.수강.학번
ORDER BY 학사정보.학생.이름 ASC, 학사정보.수강.기말성적 DESC;

#(2) 수강 테이블에서 2명 이상의 학생이 수강하는 과목에 대해 과목별 등록 학생의 수와 중간성적의 평균을 구하는 SQL 문을 작성하시오. 
#이때, 등록한 학생의 총 수는 ‘학생수’로, 중간성적의 평균은 ‘성적평균’으로 속성 이름을 새로 부여하시오.
SELECT 과목번호, COUNT(*) AS 학생수, AVG(중간성적) AS 성적평균 FROM 학사정보.수강 GROUP BY 과목번호 HAVING COUNT(*) >= 2;

#3) 수강 테이블에서 개설된 과목의 수를 검색하는 SQL 문을 작성하시오.
SELECT COUNT(DISTINCT 과목번호) FROM  학사정보.수강;

#4) L03(L001 대체) 과목을 수강하지 않는 학생의 이름과 학년을 검색하는 SQL 문을 작성하시오. 단, IN 연산자를 이용해 작성하시오.
SELECT 이름, 학년 FROM 학사정보.학생 WHERE  학번  NOT  IN (SELECT  학번  FROM 학사정보.수강  WHERE 과목번호 = 'L03');

#(5) L03(L001 대체) 과목을 수강하지 않는 학생의 이름과 학년을 검색하는 SQL 문을 작성하시오. 단, EXISTS 연산자를 이용해 작성하시오.
SELECT 이름, 학년 FROM 학사정보.학생 WHERE NOT EXISTS (SELECT * FROM 학사정보.수강 WHERE 학사정보.수강.과목번호 = 'L03' AND 학사정보.학생.학번 = 학사정보.수강.학번);