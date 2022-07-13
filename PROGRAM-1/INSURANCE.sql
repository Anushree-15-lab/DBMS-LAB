create database insurance;
use insurance;


create table PERSON(driver_id varchar(20),dname varchar(20),address varchar(20),
primary key(driver_id)); 
desc PERSON;

create table CAR(regno varchar(20),model varchar(20),cyear int,
primary key(regno));
DESC CAR;

create table ACCIDENT(report_number int,adate date),location varchar(20),
primary key(report_number));
DESC ACCIDENT;

create table OWNS(driver_id varchar(20),regno varchar(20),
foreign key(driver_id) references PERSON(driver_id),
foreign key(regno) references CAR(regno),
primary key(driver_id,regno));
DESC OWNS;

create table PARTICIPATED(driver_id varchar(20),regno varchar(20),report_number int,damage_amount int,
foreign key(driver_id) references PERSON(driver_id),foreign key(regno) references CAR(regno),
foreign key(report_number) references ACCIDENT(report_number),
primary key(driver_id,regno,report_number));
DESC PARTICIPATED;

insert into PERSON values("A01","UDAY","BANGALORE");
COMMIT;
insert into PERSON values("AO2","LOKESH","MYSORE");
COMMIT;
insert into PERSON values("AO3","GAGS","SHIVMOGA");
COMMIT;
insert into PERSON values("AO4","RAKS","RAMNAGAR");
insert into PERSON values("AO5","AMAR","KOTTURU");
COMMIT;
SELECT* FROM PERSON;

insert into CAR values("B01","FIAT",2002);
COMMIT;
insert into CAR values("B02","FORD",2008);
insert into CAR values("B03","MERC",2008);
insert into CAR values("B04","BMW",2005);
insert into CAR values("B05","SKODA",2006);
DELETE FROM CAR WHERE YEAR=null;
SELECT* FROM CAR;

insert into ACCIDENT values("1","2004","GANDHINAGAR");
COMMIT;

insert into ACCIDENT values("2","2008","RAJAJINAGAR");
insert into ACCIDENT VALUES("3","2008","KASTURINAGAR");
insert into ACCIDENT values("4","2008","BTM");

insert into ACCIDENT values("5","2004","NR COLONY");
DELETE FROM ACCIDENT WHERE  LOCATION = "KASTURINAGAR" ;
COMMIT;
SELECT* FROM ACCIDENT;

INSERT INTO OWNS(driver_id,regno)values("A01","B01");
COMMIT;
INSERT INTO OWNS(driver_id,regno)values("AO2","B02");
COMMIT;
INSERT INTO OWNS values("AO3","B03");
INSERT INTO OWNS values("AO4","B04");
INSERT INTO OWNS values("AO5","B05");
SELECT* FROM OWNS;

INSERT INTO PARTICIPATED VALUES("A01","B01",1,20000);
INSERT INTO PARTICIPATED VALUES("AO2","B02",2,24000);
INSERT INTO PARTICIPATED VALUES("AO3","B03",3,26000);
INSERT INTO PARTICIPATED VALUES("AO4","B04",4,28000);
INSERT INTO PARTICIPATED VALUES("AO5","B05",5,29000);
SELECT* FROM PARTICIPATED;

UPDATE PARTICIPATED
 SET damage_amount = 25000
WHERE  regno = 'B02' and participated.REPORT_NO = 2;
commit;

SELECT* FROM PARTICIPATED;

INSERT INTO ACCIDENT  VALUES ('6', 2008-08-30, "BASAVANAGUDI");
select* from accident;

select count(*)as count  from ACCIDENT where adate = "2008";

select * from accident;
