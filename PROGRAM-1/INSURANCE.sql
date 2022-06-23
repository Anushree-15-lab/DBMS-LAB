CREATE DATABASE INSURANC1;
USE INSURANC1;
CREATE TABLE PERSON(
      driver_id varchar(10),
	  First_Name varchar(10),
      address varchar(30),
      PRIMARY KEY(driver_id)
);

CREATE TABLE CAR(
      Reg_no varchar(10),
      model varchar(10),
      year_manufacture INT,
      PRIMARY KEY(Reg_no)
);

CREATE TABLE ACCIDENT(
      report_number  INT,
      date_accident date,
      location varchar(20),
      PRIMARY KEY(report_number)
);

CREATE TABLE OWNS(
      driver_id varchar(10),
      Reg_no varchar(10),
      PRIMARY KEY(driver_id, Reg_no),
      FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
      FOREIGN KEY(Reg_no) REFERENCES CAR(Reg_no)
);

CREATE TABLE PARTICIPATED(
      driver_id varchar(10),
      Reg_no varchar(10),
	  report_number  INT,
      damage_amount INT,
      PRIMARY KEY(report_number),
      FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
      FOREIGN KEY(Reg_no) REFERENCES CAR(Reg_no),
      foreign key(report_number) references ACCIDENT(report_number)
 );     
SELECT * FROM ACCIDENT;
 INSERT INTO PERSON VALUES('DR1','ARAVIND','CHINA'),('DR2','SIDDHARTH','JAPAN'),('DR3','ARADARTH','MEXICO');
 INSERT INTO CAR VALUES('R1','aaa',2002),('R2','bbb',2003),('R3','ccc',2004);
 INSERT INTO ACCIDENT VALUES(111,'2002-09-09','CHINA'),(222,'2008-07-09','JAPAN'),(333,'2002-08-09','MEXICO');
 INSERT INTO ACCIDENT VALUES(444,'2008-09-09','CHINA'),(555,'2002-07-09','JAPAN'),(666,'2002-08-09','MEXICO');
 TRUNCATE TABLE ACCIDENT;
 INSERT INTO OWNS VALUES('DR1','R1'),('DR2','R2'),('DR3','R2');
 INSERT INTO PARTICIPATED VALUES('DR1','R1',111,20000),('DR2','R1',222,30000),('DR3','R1',333,40000);
  INSERT INTO PARTICIPATED VALUES('DR2','R1',555,20000),('DR3','R1',444,30000),('DR1','R1',666,40000);

 UPDATE PARTICIPATED SET damage_amount=25000 WHERE report_number BETWEEN 150 AND 400;

select * from participated;

 SELECT * FROM ACCIDENT WHERE YEAR(date_accident)=2008;
 
 
 
 
 
 SELECT driver_id,count( driver_id) as total
 FROM accident,participated,person
 WHERE accident.report_number = participated.report_number AND participated.driver_id = person.driver_id AND YEAR(accident.date_accident) = 2008;
