create database student_0616;
use student_0616;


CREATE TABLE student(
        snum INT,
        sname VARCHAR(10),
        major VARCHAR(2),
        lvl VARCHAR(2),
        age INT, primary key(snum));
        
CREATE TABLE faculty(
       fid INT,fname VARCHAR(20),
       deptid INT,
       PRIMARY KEY(fid));
       
CREATE TABLE class(
        cname VARCHAR(20),
        meets_at TIMESTAMP,
        room VARCHAR(10),
        fid INT,
        PRIMARY KEY(cname,fid),
        FOREIGN KEY(fid) REFERENCES faculty(fid));
        
CREATE TABLE enrolled(
        snum INT,
        cname VARCHAR(20),
        PRIMARY KEY(snum,cname),
        FOREIGN KEY(snum) REFERENCES student(snum),
        FOREIGN KEY(cname) REFERENCES class(cname));
        
desc student;
desc faculty;
desc class;
desc  enrolled;

insert into student values (1,'Anirudh','CS','Jr',19);
insert into student values(2,'Rahul','ME','Jr',19);
insert into student values(3,'Lokesh','AE','Sr',22);
insert into student values(4,'Amarnath','IS','Jr',18);
insert into student values(5,'Aditya','CV','Sr',23);
insert into student values(6,'Arun','CV','Sr',23);


insert into faculty values(10,'Ramesh',2002);
insert into faculty values(22,'Suresh',1551);
insert into faculty values(23,'Rohit',2883);
insert into faculty values(24,'Cyril',6947);
insert into faculty values(25,'Mohan',1212);


insert into class values('Biology', '05-12-17 08:30:15', 'R128', 10);
insert into class values('Sociology', '05-12-17 08:30:15', 'R12', 24);
insert into class values('Physics', '06-12-17 08:30:15', 'R2', 10);
insert into class values('Chemistry', '06-12-17 08:30:15', 'R3', 22);
insert into class values('Maths', '07-12-17 08:30:15', 'R4', 23);
insert into class values('Economics', '07-12-17 08:30:15', 'R5', 24);
insert into class values('Electronics', '08-12-17 08:30:15', 'R6', 25);
insert into class values('Human Values', '09-12-17 08:30:15', 'R7', 25);

insert into class values('Sociology', '05-11-17 08:30:15', 'R12', 10);
insert into class values('Chemistry', '06-11-17 08:30:15', 'R3', 10);
insert into class values('Maths', '07-11-17 08:30:15', 'R4', 10);
insert into class values('Economics', '07-11-17 08:30:15', 'R5', 10);
insert into class values('Electronics', '08-11-17 08:30:15', 'R6', 10);
insert into class values('Human Values', '09-11-17 08:30:15', 'R7', 10);

insert into class values('Biology', '05-12-17 08:30:15', 'R128', 24);
insert into class values('Physics', '06-12-17 08:30:15', 'R2', 24);
insert into class values('Chemistry', '06-12-17 08:30:15', 'R3',24);
insert into class values('Maths', '07-12-17 08:30:15', 'R4', 24);
insert into class values('Electronics', '08-12-17 08:30:15', 'R6', 24);
insert into class values('Human Values', '09-12-17 08:30:15', 'R7', 24);



insert into enrolled values(1, 'Biology');
insert into enrolled values(1, 'Physics');
insert into enrolled values(1, 'Maths');
insert into enrolled values(2, 'Chemistry');
insert into enrolled values(2, 'Human Values');
insert into enrolled values(3, 'Economics');
insert into enrolled values(4, 'Electronics');
insert into enrolled values(5, 'Maths');
insert into enrolled values(5, 'Biology');
insert into enrolled values(5, 'Sociology');

select * from student;
select * from faculty;
select * from class;
select * from enrolled;

SELECT DISTINCT S.sname 
FROM student S, class C, enrolled E, faculty F
WHERE S.snum = E.snum AND E.cname = C.cname AND C.fid = F.fid AND
F.fname = 'Suresh' AND S.lvl = 'Jr';

SELECT DISTINCT C.cname 
FROM class C
WHERE C.room = 'R128'
OR C.cname IN (SELECT E.cname
		FROM enrolled E
		GROUP BY E.cname
		HAVING COUNT(*) >= 5);
SELECT DISTINCT S.sname 
FROM student S
WHERE S.snum IN (SELECT E1.snum
			FROM enrolled E1, Enrolled E2, Class C1, Class C2
			WHERE E1.snum = E2.snum AND E1.cname <> E2.cname
			AND E1.cname = C1.cname
			AND E2.cname = C2.cname AND C1.meets_at = C2.meets_at);
            

SELECT F.fname
FROM faculty F WHERE NOT EXISTS(SELECT *
				FROM class C
                            where not exists
                            (SELECT C1.room
                            FROM class C1
                            WHERE C1.fid = F.fid));

                    
SELECT F.fname
FROM faculty F WHERE 5 > (SELECT COUNT(E.snum)
			  FROM class C, enrolled E
                            WHERE C.cname = E.cname
                            AND C.fid = F.fid);

SELECT DISTINCT S.sname 
FROM student S
WHERE S.snum NOT IN(SELECT E.snum
FROM enrolled E);

SELECT S.age,S.lvl
FROM student S 
GROUP BY S.age,S.lvl
HAVING S.lvl IN (SELECT S1.lvl
                   FROM student S1
                   GROUP BY S1.lvl,S1.age
                   HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					  FROM student S2
                                          WHERE S2.age = S1.age
					  GROUP BY S2.lvl,S2.age));
