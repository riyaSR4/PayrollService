--UC1
Create database payroll_service;
Use payroll_service;

--UC2
Create table employee_payroll(
id int primary key identity(1,1),
name varchar(30),
salary varchar(30),
start_date date 
);

--UC3
Insert into employee_payroll(name,salary,start_date)values('a','1000','2023-05-01');
Insert into employee_payroll(name,salary,start_date)values('b','2000','2023-04-01');
Insert into employee_payroll(name,salary,start_date)values('c','3000','2023-03-01');
Insert into employee_payroll(name,salary,start_date)values('d','4000','2023-02-01');
Insert into employee_payroll(name,salary,start_date)values('e','5000','2023-01-01');

--UC4
Select * from employee_payroll;

--UC5
Select * from employee_payroll where name = 'd';
Select * from employee_payroll where start_date between cast('2023-02-01' as Date) and GETDATE();

--UC6
Alter table employee_payroll
Add gender Char(1)
Update employee_payroll set gender = 'F' where name ='a';
Update employee_payroll set gender = 'M' where name ='b';
Update employee_payroll set gender = 'F' where name ='c';
Update employee_payroll set gender = 'M' where name ='d';
Update employee_payroll set gender = 'F' where name ='e';

--UC7
Select SUM(cast(salary as bigint)) from employee_payroll;
Select AVG(cast(salary as bigint)) from employee_payroll;
Select MIN(cast(salary as bigint)) from employee_payroll;
Select MAX(cast(salary as bigint)) from employee_payroll;
Select gender, count(*) from employee_payroll group by(gender);

--UC8
Alter table employee_payroll
Add phone varchar(10), address varchar(30), department varchar(20)

--UC9
Alter table employee_payroll
Add basic_pay bigint, deductions bigint, taxable_pay bigint, income_tax bigint, net_pay bigint;

--UC10
Insert into employee_payroll(name, salary, start_date, gender, phone, address, department, basic_pay, deductions, taxable_pay, income_tax, net_pay) values
('Terissa', '10000', '2018-01-01', 'F', '1234567899', 'Chennai', 'Sales', '2000', '500', '250', '100', '1000');  
Insert into employee_payroll(name, salary, start_date, gender, phone, address, department, basic_pay, deductions, taxable_pay, income_tax, net_pay) values
('Terissa', '10000', '2018-01-01', 'F', '1234567899', 'Chennai', 'Marketing', '2000', '500', '250', '100', '1000');  

--UC11
Create table salary(
salId int primary key identity(1,1),
salary bigint,
basic_pay bigint,
deductions bigint,
taxable_pay bigint,
income_tax bigint,
net_pay bigint
);

Create table department(
deptId int primary key identity(1,1),
dept_name varchar(20)
);

Create table employee(
id int primary key identity(1,1),
name varchar(30),
start_date date,
phone varchar(10),
address varchar(30),
salId int Foreign Key References Salary(salId)
);

Create  table emp_department_mapping(
id int primary key identity(1,1),
empId int Foreign Key References employee(id),
deptId int Foreign key references Department(deptId)
);

Insert into salary(salary,basic_pay,deductions,taxable_pay,income_tax,net_pay)values('10000','5000','100','50','75','9000');
Select * from salary;
Insert into department(dept_name)values('Sales');
Select * from department;
Insert into employee(name,start_date,phone,address,salId)values('Esha','2023-05-04','1112223334','Kerala','1111');
Select * from employee;
Insert into emp_department_mapping(empId,deptId)values('1','1');
Select * from emp_department_mapping;

Select * from employee inner join salary on employee.salId= salary.salId;

--Stored Procedure
Alter procedure AddEmployee_payroll
(
@name varchar(20),
@salary varchar(20),
@start_date date,
@gender Char(1),
@phone varchar(10), 
@address varchar(30), 
@department varchar(20),
@basic_pay bigint,
@deductions bigint,
@taxable_pay bigint,
@income_tax bigint,
@net_pay bigint
)
As
Begin
Insert into employee_payroll(name,salary,start_date,gender,phone,address,department,basic_pay,deductions,taxable_pay,income_tax,net_pay) 
values(@name,@salary,@start_date,@gender,@phone,@address,@department,@basic_pay,@deductions,@taxable_pay,@income_tax,@net_pay)
End

Create procedure GetAllEmployee_payroll
As
Begin
Select * from employee_payroll
End

Create procedure DeleteEmployee_payroll
(
	@Id int
)
As
Begin
Delete from employee_payroll where Id=@Id;
End

Alter procedure UpdateEmployee_payroll
(
	@Id int,
	@name varchar(20),
    @salary varchar(20),
    @start_date date,
	@gender Char(1),
	@phone varchar(10), 
	@address varchar(30), 
	@department varchar(20),
	@basic_pay bigint,
	@deductions bigint,
	@taxable_pay bigint,
	@income_tax bigint,
	@net_pay bigint
)
As 
Begin
Update employee_payroll set name=@name, salary=@salary, start_date=@start_date, gender = @gender, phone = @phone, address = @address,
department = @department, basic_pay = @basic_pay, deductions = @deductions, taxable_pay = @taxable_pay, income_tax = @income_tax, net_pay = @net_pay
where Id=@Id
End

EXEC GetAllEmployee_payroll;

Select e.*,d.* from employee e,department d where e.Id = d.deptId and e.Id = 1;

