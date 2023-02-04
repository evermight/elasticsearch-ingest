CREATE TABLE t_order (
  order_id int(11) unsigned not null,
  customer_id int(11) unsigned not null,
  purchase_date date not null
);

CREATE TABLE t_order_item (
  order_id int(11) unsigned not null,
  product_id int(11) unsigned not null
);

CREATE TABLE t_product (
  product_id int(11) unsigned not null,
  name varchar(50) not null,
  price int(11) unsigned not null
);

CREATE TABLE t_customer (
  customer_id int(11) unsigned not null,
  address varchar(50) not null,
  city varchar(50) not null,
  state varchar(50) not null,
  zip int(11) unsigned not null,
  birth_year int(11) unsigned not null
);

CREATE TABLE t_zip_geo (
  zip int(11) unsigned not null,
  point varchar(50) not null
);

LOAD DATA INFILE '/var/lib/mysql/es/order/data.csv'
INTO TABLE t_order
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql/es/order_item/data.csv'
INTO TABLE t_order_item
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql/es/product/data.csv'
INTO TABLE t_product
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql/es/customer/data.csv'
INTO TABLE t_customer
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/var/lib/mysql/es/zip_geo/data.csv'
INTO TABLE t_zip_geo
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
