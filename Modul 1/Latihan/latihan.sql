#latihan
create schema `mbd_core`;

#membuat tabel customers
create table `customers`(
`customer_id` int not null auto_increment,
`name` varchar(100) not null,
`email` varchar(50) not null,
`phone` varchar(20) default null,
`created_at` timestamp(6) null default null,
primary key(`customer_id`),
unique key `customer_id_UNIQUE` (`customer_id`),
unique key `email_UNIQUE` (`email`)
);

#membuat tabel orders
create table `orders`(
`order_id` int not null auto_increment,
`customer_id` int not null,
`order_date` timestamp(6) not null,
`status` enum('PENDING','PAID','SHIPPED','DELIVERED','CANCELLED') not null,
`total_amount` decimal(12,2) not null default '0.00',
primary key(`order_id`),
unique key `order_id_UNIQUE` (`order_id`),
key `fk_orders_customers_idx` (`customer_id`),
constraint `fk_orders_customer` foreign key (`customer_id`)
references `customers` (`customer_id`)
on delete restrict on update cascade
);

#engine=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
#teks di atas ini(engine...) tidak perlu ditulis tidak apa-apa

#masukkan data ke customers
insert into `customers`
(`name`,`email`,`phone`,`created_at`) values
('Andi', 'andi@example.com', '08120000001', '2025-02-01 10:00:00'),
('Budi', 'budi@example.com', '08120000002', '2025-02-02 11:00:00'),
('Citra', 'citra@example.com', '08120000003', '2025-02-03 12:00:00'),
('Dewi', 'dewi@example.com', '08120000004', '2025-02-04 13:00:00'),
('Eka', 'eka@example.com', '08120000006', '2025-02-04 14:00:00');

#masukkan data ke orders
insert into `orders`
(`customer_id`, `order_date`, `status`, `total_amount`) values
('1', '2025-02-10 09:00:00', 'PAID', '16000'),
('2', '2025-02-11 14:00:00', 'PENDING', '15000'),
('3', '2025-02-12 15:00:00', 'PAID', '60000'),
('4', '2025-02-13 16:00:00', 'CANCELLED', '0'),
('5', '2025-02-14 17:00:00', 'PAID', '25000');


#menampilkan seluruh data pelanggan
select * from customers;

#menampilkan seluruh data orders
select * from orders;

#menampilkan seluruh daftar pesanan beserta nama pelanggan dari tabel orders dan customers
select orders.order_id, customers.name, orders.order_date, orders.status, orders.total_amount
from orders join customers
on orders.customer_id = customers.customer_id;

#menampilkan nilai total_amount tertinggi dari seluruh pesanan yang berstatus PAID
select max(o.total_amount)
from orders o
where o.status = 'PAID';

#mengubah status pesanan dengan order_id = 1 menjadi 'SHIPPED'
update orders
set status = 'SHIPPED'
where order_id=1;

#menghapus data pelanggan yang bernama eka
delete from customers
where name = 'Eka';
#memang eror. wkwk
