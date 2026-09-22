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


#kurang nomor 8-selesai
