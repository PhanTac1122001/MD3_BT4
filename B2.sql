create database ss4b2;
use ss4b2;

create table customer(
	cid int auto_increment primary key,
    cname varchar(100) not null,
    cage int check (cage > 0)
);
insert into customer (cname, cage) values
('Minh Quan', 10),
('Ngoc Oanh',20),
('Hong Ha', 50);

create table orders(
	oid int auto_increment primary key,
    cid int not null,
    odate datetime not null,
    ototalprice double check (ototalprice > 0),
    foreign key (cid) references customer(cid)
);
insert into orders ( cid, odate, ototalprice) values(1, '2006-3-21', 150000),
(2, '2006-3-23', 200000),
(1, '2006-3-16', 170000);

create table product (
	pid int auto_increment primary key,
    pname varchar(100) not null,
    pprice double check (pprice > 0)
);

insert into product (pname, pprice) values('May giat', 300),
('Tu lanh', 500),
('Dieu hoa', 700),
('Quat', 100),
('Bep dien', 200),
('May hut mui', 500);
	
create table orderdetail (
	oid int not null, 
    foreign key (oid) references orders (oid),
    pid int not null,
    foreign key (pid) references product (pid),
    odqty int check (odqty >= 0)
);
insert into orderdetail (oid, pid, odqty) values (1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);


select * from customer;
select * from orders;
select * from product;
select * from order_detail;

select oid, odate, ototalprice from orders;


SELECT cname, pname, odqty
FROM customer c inner join orders o on c.cid = o.cid inner join orderdetail od on o.oid = od.oid  
inner join product p on od.pid = p.pid order by c.cname, p.pname;

select cname from customer c left join orders o on c.cid = o.cid where o.oid is null;



select odate, ototalprice from 
orders o inner join orderdetail od on o.oid = od.oid
inner join product p on od.pid = p.pid ;


select * from customer c join orders o on c.cid = o.cid where ototalprice > 150000 ;

select * from product p left join orderdetail od on p.pid = od.pid where p.pid = od.pid is null;


SELECT o.oid, COUNT(od.pid) AS numproducts FROM orders o INNER JOIN orderdetail od ON o.oid = od.oid
GROUP BY o.oid HAVING COUNT(od.pid) > 2;

select * from orders o order by o.ototalprice Desc limit 1;

select * from product p order by p.pprice Desc limit 1;

select c.cname, COUNT(od.odqty) AS numberbepdien
from customer c
join orders o on c.cid = o.cid
join orderdetail od on o.oid = od.oid
join product p on od.pid = p.pid
where p.pname = 'Bep dien'
group by c.cname
order by numberbepdien desc
limit 1;