CREATE SCHEMA 한빛대학;

USE 한빛대학;

CREATE TABLE Professor (
pro_ssn VARCHAR(20) NOT NULL, 
pro_name VARCHAR(20) NOT NULL, 
pro_age INT NOT NULL, 
pro_rank VARCHAR(20) NOT NULL,
speciality VARCHAR(20) NOT NULL,
PRIMARY KEY(pro_ssn),
CHECK(pro_age > 0)
);

INSERT INTO Professor (pro_ssn, pro_name, pro_age, pro_rank, speciality) VALUES('p100', '홍주희', 35, '교수', '데이터베이스');
INSERT INTO Professor (pro_ssn, pro_name, pro_age, pro_rank, speciality) VALUES('p101', '김철수', 60, '교수', '일반화학');
INSERT INTO Professor (pro_ssn, pro_name, pro_age, pro_rank, speciality) VALUES('p102', '정수란', 50, '교수', '신소재공학');
INSERT INTO Professor (pro_ssn, pro_name, pro_age, pro_rank, speciality) VALUES('p103', '윤철현', 42, '교수', '컴퓨터그래픽스');
INSERT INTO Professor (pro_ssn, pro_name, pro_age, pro_rank, speciality) VALUES('p104', '강민수', 38, '교수', '멀티디자인');

SELECT * FROM Professor;

CREATE TABLE Project (
pid VARCHAR(20) NOT NULL, 
sponsor VARCHAR(30) NOT NULL, 
start_date DATE NOT NULL, 
end_date DATE NOT NULL, 
budget INT NOT NULL, 
pro_ssn VARCHAR(20) NOT NULL, 
FOREIGN KEY(pro_ssn) REFERENCES Professor(pro_ssn),
PRIMARY KEY(pid) ,
CHECK(budget > 0)
);

INSERT INTO Project (pid, sponsor, start_date, end_date, budget, pro_ssn) VALUES('a01', 'S', '2020-03-28' , '2021-04-10', 80000000, 'p100');
INSERT INTO Project (pid, sponsor, start_date, end_date, budget, pro_ssn) VALUES('a02', 'L', '2020-07-08' , '2021-12-10', 70000000, 'p101');
INSERT INTO Project (pid, sponsor, start_date, end_date, budget, pro_ssn) VALUES('a03', 'S', '2020-04-20' , '2021-08-02', 100000000, 'p102');
INSERT INTO Project (pid, sponsor, start_date, end_date, budget, pro_ssn) VALUES('a04', 'A', '2020-01-15' , '2021-06-15', 150000000, 'p103');
INSERT INTO Project (pid, sponsor, start_date, end_date, budget, pro_ssn) VALUES('a05', 'G', '2020-07-01' , '2021-12-03', 40000000, 'p104');

SELECT * FROM Project;

CREATE TABLE Dept (
dno VARCHAR(20) NOT NULL, 
dname VARCHAR(20) NOT NULL, 
office VARCHAR(20) NOT NULL,
pro_ssn VARCHAR(20) NOT NULL, 
FOREIGN KEY(pro_ssn) REFERENCES Professor(pro_ssn),
PRIMARY KEY(dno) 
);

INSERT INTO Dept (dno, dname, office, pro_ssn) VALUES('L001', 'Computer_Science', '512' , 'p100');
INSERT INTO Dept (dno, dname, office, pro_ssn) VALUES('L002', 'Chemistry', '309' , 'p101');
INSERT INTO Dept (dno, dname, office, pro_ssn) VALUES('L003', 'Materials Science', '103' , 'p102');
INSERT INTO Dept (dno, dname, office, pro_ssn) VALUES('L004', 'Computer_Grahics', '514' , 'p103');
INSERT INTO Dept (dno, dname, office, pro_ssn) VALUES('L005', 'Multi_Design', '610' , 'p104');

SELECT * FROM Dept;

CREATE TABLE Graduate (
g_ssn VARCHAR(20) NOT NULL, 
g_name VARCHAR(20) NOT NULL, 
g_age INT NOT NULL, 
deg_prog VARCHAR(20) NOT NULL,
dno VARCHAR(20) NOT NULL, 
advisor_ssn VARCHAR(20) DEFAULT NULL,
FOREIGN KEY(advisor_ssn) REFERENCES Graduate(g_ssn),
FOREIGN KEY(dno) REFERENCES Dept(dno),
PRIMARY KEY(g_ssn),
CHECK(g_age > 0) 
);

INSERT INTO Graduate (g_ssn, g_name, g_age, deg_prog, dno) VALUES('G001', '박철민', 29 , '박사', 'L001');
INSERT INTO Graduate (g_ssn, g_name, g_age, deg_prog, dno, advisor_ssn) VALUES('G002', '김정민', 27 , '석사', 'L004', 'G001');
INSERT INTO Graduate (g_ssn, g_name, g_age, deg_prog, dno) VALUES('G003', '김민영', 30 , '박사', 'L005');
INSERT INTO Graduate (g_ssn, g_name, g_age, deg_prog, dno, advisor_ssn) VALUES('G004', '양지수', 27 , '석사', 'L004', 'G001');
INSERT INTO Graduate (g_ssn, g_name, g_age, deg_prog, dno, advisor_ssn) VALUES('G005', '이겅욱', 27 , '석사', 'L005', 'G003');

SELECT * FROM Graduate;

CREATE TABLE work_in (
pro_ssn VARCHAR(20) NOT NULL, 
pid VARCHAR(20) NOT NULL, 
FOREIGN KEY(pro_ssn) REFERENCES Professor(pro_ssn),
FOREIGN KEY(pid) REFERENCES Project(pid),
PRIMARY KEY(pro_ssn,pid)
);
INSERT INTO work_in (pro_ssn, pid) VALUES('p100', 'a01');
INSERT INTO work_in (pro_ssn, pid) VALUES('p101', 'a02');
INSERT INTO work_in (pro_ssn, pid) VALUES('p102', 'a03');
INSERT INTO work_in (pro_ssn, pid) VALUES('p103', 'a04');
INSERT INTO work_in (pro_ssn, pid) VALUES('p104', 'a05');

SELECT * FROM work_in;

CREATE TABLE work_prog (
pro_ssn VARCHAR(20) NOT NULL, 
g_ssn VARCHAR(20) NOT NULL, 
FOREIGN KEY(pro_ssn) REFERENCES Professor(pro_ssn),
FOREIGN KEY(g_ssn) REFERENCES Graduate(g_ssn),
PRIMARY KEY(pro_ssn,g_ssn)
);

INSERT INTO work_prog (pro_ssn, g_ssn) VALUES('p100', 'G001');
INSERT INTO work_prog (pro_ssn, g_ssn) VALUES('p103', 'G002');
INSERT INTO work_prog (pro_ssn, g_ssn) VALUES('p104', 'G003');
INSERT INTO work_prog (pro_ssn, g_ssn) VALUES('p103', 'G004');
INSERT INTO work_prog (pro_ssn, g_ssn) VALUES('p104', 'G005');

SELECT * FROM work_prog;

CREATE TABLE work_dept (
pct_time DOUBLE NOT NULL, 
pro_ssn VARCHAR(20) NOT NULL, 
dno VARCHAR(20) NOT NULL, 
FOREIGN KEY(pro_ssn) REFERENCES Professor(pro_ssn),
FOREIGN KEY(dno) REFERENCES Dept(dno),
PRIMARY KEY(pro_ssn,dno),
CHECK(pct_time > 0)
);

INSERT INTO work_dept (pct_time, pro_ssn, dno) VALUES(100, 'p100', 'L001');
INSERT INTO work_dept (pct_time, pro_ssn, dno) VALUES(95, 'p103', 'L002');
INSERT INTO work_dept (pct_time, pro_ssn, dno) VALUES(90, 'p104', 'L003');
INSERT INTO work_dept (pct_time, pro_ssn, dno) VALUES(95, 'p103', 'L004');
INSERT INTO work_dept (pct_time, pro_ssn, dno) VALUES(100, 'p104', 'L005');

SELECT * FROM work_dept;
