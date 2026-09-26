#tugas
#menambahkan 6 tabel baru

#membuat tabel Departments
create table `Departments`(
department_id int primary key auto_increment unique,
name varchar(100) not null unique
);

#membuat tabel pekerja dan ada kolom departement id yang nyambung ke kolom department
create table `Employees`(
emp_id int primary key auto_increment unique,
full_name varchar(150) not null,
department_id int not null,
hired_at date not null,
salary decimal(12,2) not null,
constraint fk_department foreign key(department_id) references departments(department_id)
on update cascade on delete restrict
);


#jika membuat tabel dengan backtick maka bisa mengisi karakter kusus/spesial. jika cuman satu kata, tidak usah tidak apa apa
#membuat tabel suppliers
create table suppliers(
supplier_id int primary key auto_increment unique,
name varchar(150) not null,
contact varchar(150) default null
);

#membuat tabel purchase order
create table purchase_order(
po_id int primary key auto_increment unique,
supplier_id int not null,
po_date date not null,
status enum('DRAFT','SENT','RECEIVED','CANCELLED') not null,
constraint fk_suppliers foreign key(supplier_id) references suppliers(supplier_id)
on update cascade on delete restrict
);

#membuat tabel categories
create table categories (
category_id int primary key auto_increment unique,
name varchar(100) not null unique
);


#membuat tabel products
create table products (
product_id int primary key auto_increment unique,
name varchar(150) not null,
category_id int not null,
price decimal(12,2) not null,
stock int default(0) not null,
created_at timestamp(6) not null,
constraint fk_category foreign key(category_id) references categories(category_id)
on update cascade on delete restrict
);


#tambah data untuk tabel Departments (parent dulu)
insert into departments values
(1, "Sales"),
(2, "Inventory"),
(3, "HR"),
(4, "Finance"),
(5, "IT Support");

#tambah data untuk tabel Employees
insert into employees values
(1, "Rina Setia", 1, "2023-01-10", 6000000),
(2, "Dodi Saput", 2, "2022-09-15", 5500000),
(3, "Sari Anind", 3, "2024-03-20", 5000000),
(4, "Bima Pratama", 4, "2021-07-01", 6500000),
(5, "Lia Kusuma", 5, "2023-11-11", 4800000);

#tambah data untuk tabel Suppliers
insert into suppliers values
(1, "PT Maju Jaya", "maj@sup.com"),
(2, "CV Snack Indo", "snack@sup.com"),
(3, "PT OfficeMart", "office@sup.com"),
(4, "PT TechSource", "tech@sup.com"),
(5, "UD Bersih Sehat", "bersih@sup.com");

#tambah data untuk tabel Purchase Orders
insert into purchase_order values
(1, 1, "2022-09-15", "RECEIVED"),
(2, 2, "2022-09-15", "SENT"),
(3, 3, "2022-09-15", "DRAFT"),
(4, 4, "2022-09-15", "CANCELLED"),
(5, 5, "2022-09-15", "RECEIVED");

#tambah data untuk tabel Categories
insert into categories values
(1, "Beverages"),
(2, "Snack"),
(3, "Stationary"),
(4, "Electronics"),
(5, "Household");

#tambah data untuk tabel Products
insert into products values
(1, "Mineral Water 600ml", 1, 4000, 200, "2025-01-01 08:00:00"),
(2, "Potato Chips 68g", 2, 12000, 150, "2025-01-02 08:00:00"),
(3, "Notebook A5", 3, 15000, 80, "2025-01-03 08:00:00"),
(4, "USB Flash Drive 16GB", 4, 60000, 60, "2025-01-04 08:00:00"),
(5, "Dish Soap 500ml", 5, 10000, 100, "2025-01-01 08:00:00");

#tambahkan data untuk tabel
insert into products values
(6, "Lays 250g", 2, 15000, 10, "2025-01-06 08:00:00");

#tampilkan daftar nama dan email dari seluruh pelanggan yang tersimpan di tabel customers
select name, email from Customers;

#tampilkan daftar nama karyawan beserta nama departemen tempat ia bekerja, menggunakan tabel employees dan departments
select employees.full_name, departments.name
from employees
inner join departments on employees.department_id = departments.department_id;

#hitung jumlah produk per kategori dengan menampilkan nama kategori dan jumlah produk dari tabel products dan categories
select categories.name as nama_kategori, count(products.category_id) as jumlah_produk
from categories
left join products on categories.category_id = products.category_id
group by categories.category_id, categories.name;

#ubah status pesanan pada tabel orders dengan order_id = 3 menjadi "DELIVERED"
update orders
set status = 'DELIVERED'
where order_id = 3;

#hapus data supplier dari tabel suppliers yang tidak memiliki purchase order pada tabel purchase_order
delete from suppliers
where supplier_id not in(
select supplier_id
from purchase_order
);
