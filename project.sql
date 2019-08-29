-- Joins

--1.
select * 
from invoice inv
join invoice_line invline on invline.invoice_id = inv.invoice_id
where unit_price > .99;

--2.
select i.invoice_date, c.first_name, c.last_name, i.total
from invoice i
join customer c on i.customer_id = c.customer_id;

--3.
select c.first_name, c.last_name, e.first_name, e.last_name
from customer c
join employee e on c.support_rep_id = e.employee_id;

--4.
select al.title, ar.name
from album al
join artist ar on al.artist_id = ar.artist_id;

--5.
select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_id
where p.name = 'Music';

--6.
select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id = 5;

--7.
select t.name, p.name
from track t
join playlist_track pt on t.track_id = pt.track_id
join playlist p on pt.playlist_id = p.playlist_id;

--8.
select t.name, a.title
from track t
join album a on t.album_id = a.album_id
join genre g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';


-- BD.
select t.name, g.name, a.title, ar.name
from playlist p
join playlist_track pt on pt.playlist_id = p.playlist_id
join track t on pt.track_id = t.track_id
join genre g on t.genre_id = g.genre_id
join album a on t.album_id = a.album_id
join artist ar on a.artist_id = ar.artist_id
where p.name = 'Music'

-- Nested Queries

--1.
select *
from invoice
where invoice_id in 
(select invoice_id 
 from invoice_line 
 where unit_price >.99);

--2.
select *
from playlist_track 
where playlist_id in 
(select playlist_id
 from playlist
 where name = 'Music')

--3.
select name
from track
where track_id in 
(select track_id
 from playlist_track
 where playlist_id = 5);

--4.
select *
from track
where genre_id in 
(select genre_id
 from genre
 where name = 'Comedy');

--5.
select *
from track
where album_id in 
(select album_id
 from album
 where title = 'Fireball');

--6.
select *
from track
where album_id in 
(select album_id
 from album
 where artist_id in
(select artist_id
 from artist
 where name = 'Queen'
)
);

-- Updating Rows

--1.
update customer
set fax = null
where fax is not null;

--2.
update customer
set company = 'self'
where company is null;

--3.
update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett';

--4.
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

--5.
update track
set composer = 'The darkness around us'
where genre_id  = 
(select genre_id
 from genre
 where name = 'Metal'
) and composer is null;

--Group By

--1.
select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
group by g.name;

--2.
select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

--3.
select count(name), ar.name
from artist ar
join album al on ar.artist_id = al.artist_id
group by ar.name;

-- Use Distinct

--1.
select distinct composer
from track;

--2.
select distinct billing_postal_code
from invoice;

--3.
select distinct company
from customer;

--Delete Rows

--1.
delete 
from practice_delete
where type = 'bronze';

--2.
delete 
from practice_delete
where type = 'silver';

--3.
delete 
from practice_delete
where value = 150;

-- eComm Sim

create table users
(
    user_id serial primary key,
    name text,
    email text
);

create table products
(
    product_id serial primary key,
    name text,
    price int
);

create table orders
(
    order_id serial primary key,
    product_id int references product(product_id)
);

insert into users
(name,email)
values
('joe', 'joe@joe.com'),
('harry', 'harry@joe.com'),
('larry', 'larry@joe.com');

insert into products
(name, price)
values
('hammer', 5.00),
('nails', .30),
('wrench', 6.00);

insert into orders
(product_id)
values
(1),
(2),
(3);

select *
from orders o
join products p on p.product_id = o.product_id
where order_id = 1;

select *
from orders;

select sum(price)
from orders o
join products p on p.product_id = o.product_id;

alter table orders
add column user_id int references users(user_id);

update orders
set user_id =1
where order_id = 1;

update orders
set user_id =2
where order_id = 2;

update orders
set user_id =3
where order_id = 3;

select * 
from orders
where user_id = 1;

select count(*), u.name
from orders o
join users u on u.user_id = o.user_id
group by u.name;

select sum(price), u.name
from orders o
join users u on u.user_id = o.user_id
join products p on o.product_id = p.product_id
group by u.name;