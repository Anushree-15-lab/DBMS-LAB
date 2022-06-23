create database supplier;
use supplier;
 
create table suppliers(
	sid integer PRIMARY KEY,
    sname varchar(20),
    address varchar(50)
);  

create table parts(
	pid integer PRIMARY KEY,
    pname varchar(20),
    color varchar(10)
);

create table catalog(
	sid integer,
    pid integer,
    cost real,
    PRIMARY KEY(sid,pid),
	FOREIGN KEY(sid) REFERENCES suppliers(sid),
    FOREIGN KEY(pid) REFERENCES parts(pid)
);


insert into suppliers(sid,sname,address) values(100,'a','aaa'),(101,'b','bbb'),(102,'c','ccc');
insert into parts(pid,pname,color) values(200,'i','red'),(201,'j','blue'),(202,'k','green');
insert into catalog(sid,pid,cost) values(100,200,5000),(101,202,10000),(102,201,15000),(101,200,5000),(101,201,15000);

/*1.  select pnames who have a supplier.. */
SELECT DISTINCT P.pname
FROM Parts P, Catalog C
WHERE P.pid = C.pid;

/*2. sname of supllier who supply  every part*/
select sname from suppliers
where sid = all (select sid from catalog where group by pid);
