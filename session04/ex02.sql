use session04_ex02;


create table customer(
id int auto_increment primary key,
name varchar(255),
cAge tinyint
);

insert into customer(name,cAge) values('minh quan', 10);
insert into customer(name,cAge) values('ngoc oanh', 20);
insert into customer(name,cAge) values('hong ha', 50);


create table oder(
oId int auto_increment primary key,
cId int, foreign key(cId) references customer(id),
oDate datetime,
oTotalPrice int
);

INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (1, '2006-03-21', 150000);
INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (2, '2006-03-23', 200000);
INSERT INTO oder(cId, oDate, oTotalPrice) VALUES (1, '2006-03-16', 170000);

create table product(
pId int auto_increment primary key,
pName varchar(25),
pPrice int
);

insert into product(pname,pPrice) values ('may giat',300);
insert into product(pname,pPrice) values ('tu lanh',500);
insert into product(pname,pPrice) values ('dieu hoa',700);
insert into product(pname,pPrice) values ('quat',100);
insert into product(pname,pPrice) values ('bep dien',200);
insert into product(pname,pPrice) values ('may hut bui ',500);


create table orderDetail(
oId int, foreign key(oId) references oder(oId),
pId int,foreign key(pId) references product(pId),
odQTY int 
);

insert into orderDetail(oId,pId,odQTY) values(1,1,3);
insert into orderDetail(oId,pId,odQTY) values(1,3,7);
insert into orderDetail(oId,pId,odQTY) values(1,4,2);
insert into orderDetail(oId,pId,odQTY) values(2,1,1);
insert into orderDetail(oId,pId,odQTY) values(3,1,8);
insert into orderDetail(oId,pId,odQTY) values(2,5,4);
insert into orderDetail(oId,pId,odQTY) values(2,3,3);

select * from customer join oder on customer.id = oder.cId where oder.oTotalPrice > 150000 ;
select * from orderdetail right join product on orderdetail.pId = product.pId where orderdetail.pId is null ;

SELECT o.oId, COUNT(DISTINCT od.pId) AS productCount
FROM oder o
JOIN orderDetail od ON o.oId = od.oId
GROUP BY o.oId
HAVING productCount > 2;

SELECT *
FROM oder
ORDER BY oTotalPrice DESC
LIMIT 1;
select * from product order by product.pPrice desc limit 1;


SELECT c.name, SUM(od.odQTY) AS totalQuantity
FROM customer c
JOIN oder o ON c.id = o.cId
JOIN orderDetail od ON o.oId = od.oId
JOIN product p ON od.pId = p.pId
WHERE p.pName = 'bep dien'
GROUP BY c.id, c.name
ORDER BY totalQuantity DESC
LIMIT 1;
