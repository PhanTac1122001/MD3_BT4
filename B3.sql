create database ss4b1;
use ss4b1;


create table vattu (
	mavt int auto_increment primary key,
    tenvt varchar(100) not null
);
insert into vattu(tenvt) values ('gạch'),
('xi măng'),
('cát'),
('đá'),
('thước');
create table phieuxuat(
	sopx int auto_increment primary key,
    ngayxuat datetime not null
);
insert into phieuxuat (ngayxuat) values (current_date()),
(current_date()),
(current_date()),
(current_date()),
(current_date());
create table phieuxuatchitiet (
	sopx int,
    mavt int,
    primary key(sopx, mavt),
    dongiaxuat double check (dongiaxuat > 0),
    soluongxuat int check(soluongxuat >= 0),
	foreign key (mavt) references vattu (mavt),
	foreign key (sopx) references phieuxuat(sopx)
);
insert into phieuxuatchitiet values (1, 1, 200000, 4),
(2, 1, 1800000, 10),
(3, 3, 400000, 8),
(5, 2, 100000, 3),
(4, 5, 90000, 1);
CREATE TABLE phieunhap (
    sopn INT auto_increment primary key,
    ngaynhap datetime not null
);
insert into phieunhap (ngaynhap) values 
('2024-7-14'),
('2024-7-13'),
('2024-7-12'),
('2024-7-11'),
('2024-7-14');
create table phieunhapchitiet(
	sopn int not null,
    mavt int not null,
    dongianhap double default 1 check( dongianhap > 0),
    soluongnhap int check (soluongnhap >= 0),
    foreign key (mavt) references vattu(mavt),
    foreign key (sopn) references phieunhap(sopn)
);
insert into phieunhapchitiet values (1, 1, 170000, 4),
(2, 1, 1750000, 10),
(3, 3, 360000, 8),
(5, 2, 80000, 3),
(4, 5, 70000, 1);
create table nhacungcap (
	mancc int auto_increment primary key,
    tenncc varchar(255) not null,
    address varchar(255) not null,
    phone varchar(11) unique not null
);
insert into nhacungcap(tenncc, address, phone) values
('Trần Quốc Tuấn', 'Thái Bình', '0987654321'),
('Phan Đình Phùng', 'Hà Nội' , '0987654325'),
('Nguyễn Trãi', 'Hà Nội', '0961036277'),
('Đoàn Linh Tinh', 'Hà Nam', '0968071555'),
('Nguyễn Quốc Anh', 'Hải Phòng', '0968071533');
create table donhangdat(
	sodh int auto_increment primary key,
    mancc int not null,
    foreign key (mancc) references nhacungcap(mancc),
    ngaydh datetime not null
);
insert into donhangdat (mancc, ngaydh) values (1, current_date()),
(2, current_date()),
(3, current_date()),
(5, current_date()),
(4, current_date());
create table chitietdondathang (
	mavt int not null,
    sodh int not null,
    foreign key (mavt) references vattu(mavt),
    foreign key (sodh) references donhangdat(sodh)
);
insert into chitietdondathang  values (1, 2),
(2, 4),
(4, 1),
(2, 5),
(4, 1);


select * from vattu;
select * from phieuxuat;
select * from phieuxuatchitiet;
select * from phieunhap;
select * from phieunhapchitiet;
select * from nhacungcap;
select * from donhangdat;
select * from chitietdondathang;


SELECT tenvt, SUM(soluongxuat) AS totalsold
FROM vattu vt
JOIN phieuxuatchitiet pxct ON vt.mavt = pxct.mavt
GROUP BY vt.ten_vt
ORDER BY totalsold DESC;

select tenvt , SUM(soluongnhap) - SUM(soluongxuat) AS inventory from vattu vt
left join phieunhapchitiet pnct on vt.mavt = pnct.mavt 
left join phieuxuatchitiet pxct on vt.mavt = pxct.mavt
group by vt.tenvt
order by inventory desc;

select tenncc from nhacungcap ncc inner join donhangdat dhd 
on ncc.mancc = dhd.mancc
where dhd.ngaydh between  '2024-01-11' AND '2024-07-18';

select tenvt from vattu vt inner join phieunhapchitiet pnct on vt.mavt = pnct.mavt
inner join phieunhap pn on pnct.sopn = pn.sopn
where pn.ngaynhap between  '2024-01-11' AND '2024-07-18';


select * from vattu vt join phieuxuatchitiet pxct on vt.mavt = pxct.mavt where pxct.soluongxuat > 5;

select * from vattu vt join chitietdondathang ctddh on ctddh.mavt = vt.mavt join donhangdat dhd on dhd.sodh =  ctddh.sodh where ngaydh = '2024-07-18';

select vt.tenvt , sum(pnct.dongianhap) as dongia from vattu vt
join phieunhapchitiet pnct on vt.mavt = pnct.mavt
where pnct.dongianhap > 1200000
group by vt.tenvt;

select vt.tenvt , count(pxct.soluongxuat) as soluong from vattu vt
join phieuxuatchitiet pxct on vt.mavt = pxct.mavt
where pxct.soluongxuat > 5
group by vt.tenvt;

select tenncc , address, phone from nhacungcap ncc
where address = 'Hà Nội'
 and phone LIKE '09%';