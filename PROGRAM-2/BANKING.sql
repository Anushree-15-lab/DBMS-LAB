show tables;
show databases;
drop database banking;
create database banking1;
use banking1;

 create table Branch(branchname varchar(30),branchcity varchar(30),assests real, primary key(branchname)); 
create table BankAccount(accno integer,branchname varchar(30), balance real ,primary key (accno),foreign key (branchname) references Branch(branchname)); 
create table BankCustomer(customername varchar(30),customerstreet varchar(30),customercity varchar(30),primary key(customername)); 
create table Depositer(customername varchar(30),accno integer,primary key(customername,accno),
foreign key(customername) references BankCustomer(customername), foreign key(accno) references BankAccount(accno)); 
create table Loan (loannumber int,branchname varchar(30),amount real,primary key (loannumber),
 foreign key (branchname) references Branch(branchname)); 
 
 desc Branch;
 desc BankAccount;
 desc BankCustomer;
 desc Depositer;
 desc Loan;
 
 insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
 insert into Branch values('SBI_ResidencyRoad', 'Bangalore',10000);
 insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParlimentRoad','Delhi',10000); 
 insert into Branch values('SBI_Jantarmantare','Delhi',20000);
 
insert into Loan values(2,'SBI_ResidencyRoad',2000); 
 insert into Loan values(1,'SBI_Chamrajpet',1000);
 insert into Loan values(3,'SBI_ShivajiRoad',3000);
  insert into Loan values(4,'SBI_ParlimentRoad',4000);
  insert into Loan values(5,'SBI_Jantarmantare',5000); 

insert into BankAccount values(11, 'SBI_Jantarmantare', 2000);
insert into BankAccount values(1, 'SBI_Chamrajpet', 2000);
insert into BankAccount values(2, 'SBI_ResidencyRoad', 5000);
insert into BankAccount values(8, 'SBI_ResidencyRoad', 4000);
insert into BankAccount values(10, 'SBI_ResidencyRoad', 5000);
insert into BankAccount values(3, 'SBI_ShivajiRoad', 6000);


select * from Branch; 
select * from Loan; 
select * from BankAccount;
select * from bankcustomer;
select * from depositer;

TRUNCATE TABLE Loan;
DELETE FROM BankAccount WHERE branchname='SBi_shivajiRoad';

insert into bankcustomer values("Avinash","Bull_Temple_Road","Bangalore");
 insert into bankcustomer values("Dinesh","Bannergatta","Bangalore");
 insert into bankcustomer values("Mohan","National_clg_Road","Bangalore");
 insert into bankcustomer values("Nikil","Akbar_road","Delhi");
 insert into bankcustomer values("Ravi","prithviraj_Road","Delhi");
 
 insert into depositer values("Avinash",1);
 insert into depositer  values("Dinesh",2);
 insert into depositer  values("Nikil",4);
 insert into depositer  values("Ravi",5);
 insert into depositer  values("Avinash",8);
 insert into depositer  values("Nikil",9);
 insert into depositer  values("Dinesh",10);
 insert into depositer   values("Nikil",11);
 
 select C.customername from BankCustomer C 
 where exists ( 
 select D.customername, count(D.customername) 
 from depositer D, BankAccount BA where 
 D.accno = BA.accno AND C.customername = D.customername AND 
 BA.branchname = 'SBI_ResidencyRoad' group by D. customername having count(D.customername) >=2
); 

select BC.customername from BankCustomer BC where not exists(
	select branchname from Branch where branchcity = 'Delhi'
	and not exists(
    select BA.branchname from Depositer D, BankAccount BA
	where D.accno = BA.accno and BC.customername = D.customername)
);

delete from BankAccount where branchname in( select branchname from Branch where branchcity = 'Bombay' );
select* from BankAccount;
