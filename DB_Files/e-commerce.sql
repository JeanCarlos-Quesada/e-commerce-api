create database e_commerce;
use e_commerce;

/*Tables*/
create table users(
	identification varchar(10) primary key,
	firstName varchar(50) not null,
	lastName varchar(50) not null,
	phoneOne varchar(12) null,
	phoneTwo varchar(12) null,
	email varchar(50) not null,
	registerDate datetime not null,
	isActive bit not null,
	isEmployee bit not null,
	userName varchar(10) unique not null,
	password varbinary(2000) not null
);

create table employeeRols(
	id int auto_increment primary key,
	rol tinyint not null,
	isActive bit not null,
	employee varchar(10) not null,
    FOREIGN KEY (employee) REFERENCES users(identification)
);

create table categories(
	id int auto_increment primary key,
	name varchar(20) not null
);

create table subCategories(
	id int auto_increment primary key,
	name varchar(20) not null,
	category int not null,
    FOREIGN KEY (category) REFERENCES categories(id)
);

create table products(
	id int auto_increment primary key,
	name varchar(20) not null,
	details varchar(200) not null,
	price decimal(5,2) not null,
	amountInInventory int not null,
	subCategory int not null,
    FOREIGN KEY (subCategory) REFERENCES subCategories(id)
);

create table carts(
	id int auto_increment primary key,
	amountOfProducts int not null,
	price decimal(10,2) not null,
	registerDate datetime not null,
	customer varchar(10) not null,
    FOREIGN KEY (customer) REFERENCES users(identification)
);

create table cartProducts(
	id int auto_increment primary key,
	amount int not null,
	price decimal (10,2) not null,
	cart int not null,
    product int not null,
    FOREIGN KEY (cart) REFERENCES carts(id),
    FOREIGN KEY (product) REFERENCES products(id)
);
call GetAllProducts()
/*Procedures*/
DELIMITER //
create procedure GetAllProducts()
begin
	SELECT P.id, P.name, P.details, P.price, P.amountInInventory, P.subCategory, C.id as 'category'
	FROM products P
	inner join subCategories SC on P.subCategory = SC.id
	inner join categories C on SC.category = C.id;
end//

DELIMITER //
create procedure GetMostPopularProducts()
begin
	CREATE TEMPORARY TABLE mostPopulars (product INT,amount int);

	insert into mostPopulars (
		select CP.product, count(*) as "amount"
		from products P
		inner join cartProducts CP on P.id = CP.product
		group by CP.product, CP.amount
		order by count(*) desc LIMIT 5
    );

	create index tmpTable_mostPopular on mostPopulars(product);

	SELECT P.id, P.name, P.details, P.price, P.amountInInventory, P.subCategory, C.id as 'category'
	FROM products P
	inner join subCategories SC on P.subCategory = SC.id
	inner join categories C on SC.category = C.id
	inner join mostPopulars MP on P.id = MP.product;

	drop table mostPopulars;
end//

DELIMITER //
create procedure GetOneProduct
(
	productID int
)
begin
	SELECT P.id, P.name, P.details, P.price, P.amountInInventory, P.subCategory, C.id as 'category'
	FROM products P
	inner join subCategories SC on P.subCategory = SC.id
	inner join categories C on SC.category = C.id
	where P.id = productID;
end//

DELIMITER //
create procedure Login
(
	userName varchar(10)
)
begin
	SELECT U.identification, U.firstName, U.lastName, U.phoneOne, U.phoneTwo, U.email, U.isEmployee, U.password
	FROM users U
	WHERE U.userName = userName;
end//

insert into categories(name) values ('Sport');
insert into categories(name) values ('Casual');
insert into subCategories(name,category) values ('Futbol',1);
insert into subCategories(name,category) values ('TEST',2);
insert into subCategories(name,category) values ('TEST2',2);
insert into products(name,details,price,amountInInventory,subCategory) values ('TEST','DETAILS',99.99,10,1);
insert into products(name,details,price,amountInInventory,subCategory) values ('TEST','DETAILS',9.99,10,2);
insert into users (identification,firstName,lastName, phoneOne, phoneTwo, email, registerDate, isActive, isEmployee, userName, password) values('208010475','Jean Carlos','Quesada Cascante','87020401',null,'jc.qc1230@gmail.com', NOW(),1,1,'jquesada',1561561);
insert into users (identification,firstName,lastName, phoneOne, phoneTwo, email, registerDate, isActive, isEmployee, userName, password) values('208010476','Jean Carlos','Quesada Cascante','87020401',null,'jc.qc1230@gmail.com', NOW(),1,0,'jquesada2',1561561);
insert into carts (amountOfProducts, price, registerDate, customer) values (2, 109.98,NOW(),'208010475');
insert into cartProducts (amount,price,cart,product) values (1,99.99,1,1);
insert into cartProducts (amount,price,cart,product) values (1,9.99,1,2);




