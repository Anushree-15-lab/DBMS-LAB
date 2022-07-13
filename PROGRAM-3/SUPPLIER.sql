drop database supply;

create database supplier_db;
use supplier_db;
create table SUPPLIERS(sid varchar(20),sname varchar(20),address varchar(30), PRIMARY KEY(sid));
create table PARTS(pid varchar(20),pname varchar(20),color varchar(20), PRIMARY KEY(pid));
drop table SUPPLIERS;
DROP TABLE PARTS;
DROP TABLE CATALOG;

create table CATALOG(sid varchar(20),pid varchar(20),cost real,PRIMARY KEY (pid,sid),FOREIGN KEY(sid) REFERENCES SUPPLIERS(sid),
FOREIGN KEY(pid) REFERENCES PARTS(pid));
desc SUPPLIERS;
desc PARTS;
desc CATALOG;
insert into SUPPLIERS(sid ,sname,address) 
			values ("S0123","Acme Widget","Bengaluru"),
			       ("S0234","Finolex","Bengaluru"),
			       ("S0456","Johnsons","Chennai"),
                   	       ("S0457","Niral","Hyderabad");
                   	       
                   
insert into PARTS
			values ("P0456","Hammer","Red"),
			       ("P0457","Spanner","Red"),
			       ("P0888","Wedge","Green"),
                               ("P0998","Screwdriver","Green"),
                               ("P0999","Brush","Yellow");
                   
insert into CATALOG
			values ("S0123","P0456",3000),
			       ("S0123","P0457",2000),
			       ("S0123","P0888",1000),
			       ("S0123","P0998",1000),
			       ("S0123","P0999",1000),
			       ("S0234","P0456",3100),
			       ("S0234","P0457",2200),
			       ("S0456","P0888",4000),
			       ("S0456","P0999",5000),
			       ("S0457","P0999",4000);
                  
                   
commit;

select DISTINCT P.pname
FROM PARTS P,CATALOG C
WHERE P.pid = C.pid;

SELECT S.sname FROM SUPPLIERS S
WHERE NOT EXISTS 
(SELECT
P.pid FROM PARTS P,CATALOG C
WHERE NOT EXISTS
(SELECT C.pid
    FROM CATALOG C
    WHERE C.SID = S.sid)
    AND C.pid = P.pid
    );
    
SELECT S.sname FROM SUPPLIERS S
WHERE NOT EXISTS 
(SELECT P.pid 
FROM PARTS P,CATALOG C
WHERE NOT EXISTS (SELECT C.pid
    FROM CATALOG C
    WHERE C.SID = S.sid)
    AND C.pid = P.pid
    AND P.color = 'red')
    ;

SELECT P.pname FROM PART P,SUPPLIERS S,CATALOG C
WHERE P.pid = C.pid AND S.sid = C.sid
AND S.sname = 'Acme Widget'
AND NOT EXISTS(SELECT *
		FROM CATALOG C1,SUPPLIERS S1
		WHERE P.pid = C1.pid
		AND C1.sid = S1.sid
		AND s1.sname <> 'Acme Widget');

SELECT C1.sid,c1.cost,c2.sid,c2.cost
FROM CATALOG C1,CATALOG C2
WHERE C1.cost > C2.cost AND
      C1.pid = C2.pid AND
      C1.sid <> C2.sid;
      
SELECT DISTINCT SUPPLIERS.sid
FROM SUPPLIERS,PARTS,CATALOG
WHERE SUPPLIERS.sid = CATALOG.SID
AND PARTS.pid = CATALOG.pid
;
