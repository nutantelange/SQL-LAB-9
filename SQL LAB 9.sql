create database banks;
use banks;
create table customer(
CustomerID int,
FirstName varchar(50),
LastName varchar(50),
Email varchar(100),
Phone varchar(15)); 

alter table customer add column dateOfBirth date;
alter table customer modify phone varchar(20);


create table Accounts(
AccountID int,
AccountType varchar(20),
Balance decimal(10,2));


create table Transactions(
TransectionID int,
TransectionDate date, 
Amount decimal(10,2),
TransectionType varchar(20));

create table Branches(
BranchId int,
BranchName varchar(100),
BranchAddress varchar(200),
BranchPhone varchar(15));


create table Loans(
LoanID int primary key,
LoanAmount decimal(10,2),
interestRate decimal(5,2),
StartDate Date,
EndDate date);

alter table Branches add constraint primary key(BranchID);
alter table Transactions add constraint primary key (TransectionID);
alter table Accounts add constraint primary key (AccountID);
alter table customer add constraint primary key (CustomerID);


alter table accounts add column customer_id int;
alter table accounts add constraint foreign key(customer_id) references customer(CustomerID);

alter table loans add column customer_id int;
alter table loans add constraint foreign key(customer_id) references customer(CustomerID);


alter table branches add column account_id int;
alter table branches add constraint foreign key(account_id) references accounts(AccountID);

alter table transactions add column account_id int;
alter table transactions add constraint foreign key(account_id) references accounts(AccountID);

insert into customer value(101,"Rahul","Sharma","rahul.sharma@gmail.com",9999999999,19980415);
insert into customer value(102,"Priya1","Patil","priya@gmail.com",9988776655,20000820),
(103,"Amit","Patel","amit.patel@gmail.com",9876500001,19950618),
(104,"sneha","joshi","sneha.joshi@gmail.com",9876500002,19970912),
(105,"Rohan","Kulkarni","rohan.k@gmail.com",9876500003,19931125);
select * from customer;

select * from Loans;
insert into Loans value(301,500000.00,8.50,20250115,20300115,101);
insert into Loans value(302,300000.00,9.25,20250110,20280210,102),
(303,750000.00,8.75,20250320,20230320,103),
(304,250000.00,10.00,20250405,20290405,104),
(305,1000000.00,7.95,20250512,20350512,105);

insert into Accounts value(201,"savings",25000.00,101),(202,"current",40000.00,102),(203,"savings",35000.00,103),(204,"current",60000.00,104),(205,"savings",45000.00,105);

insert into Branches value(1,"Mumbai Branch","Andheri Mumbai",0221111111,default),
(2,"Pune Branch","Shivaji nagar Pune",0202222222,default),
(3,"Nashik Branch","College Road Nashik",0253222222,default),
(4,"Nagpur Branch","Sitabuldi Nagpur",0712333333,default),
(5,"Navi Mumbail Branch","VashiNavi Mumbai",0224444444,default);
select * from Branches;

insert into Transactions value(301,20250510,5000.00,"deposit",201),
(302,20250511,2500.00,"withdraw",202),
(303,20250512,10000.00,"deposit",203),
(304,20250513,3000.00,"withdraw",204),
(305,20250514,7000.00,"deposit",205);

select a.AccountID,a.AccountType,a.Balance,
t.TransectionID,
t.TransectionDate,
t.TransectionType,
t.Amount
from Accounts a 
inner join Transactions t
on a.AccountID = t.account_id;

select * from transactions;
select * from accounts;

select a.AccountID,a.AccountType,a.Balance,
t.TransectionID,
t.TransectionDate,
t.TransectionType,
t.Amount
from Accounts a 
left join Transactions t
on a.AccountID = t.account_id;

select a.AccountID,a.AccountType,a.Balance,
t.TransectionID,
t.TransectionDate,
t.TransectionType,
t.Amount
from Accounts a 
inner join Transactions t
on a.AccountID = t.account_id
where t.TransectionType = "Deposit";

select a.AccountID,a.AccountType,a.Balance,
t.TransectionID,
t.TransectionDate,
t.TransectionType,
t.Amount
from Accounts a 
inner join Transactions t
on a.AccountID = t.account_id
where a.balance >30000
order by a.balance desc;

--- sub query ---

select * from transactions
where Amount > ( select avg(Amount)
from Transactions);

select AccountID,AccountType,Balance,customer_id from Accounts 
where Balance > (select avg(Balance) from Accounts)
order by Balance desc;


select * from accounts
where AccountID in (select AccountID 
from Transactions 
where TransectionType = "Deposit");


select * from accounts
where balance = ( select max(Balance) from accounts);