CREATE TABLE Customer
(
  clientId int NOT NULL PRIMARY KEY,
  balance int,
  creditLimit int,
  discount int 
);

CREATE TABLE Shipping_address
(
  addressId int NOT NULL PRIMARY KEY,
  house char(50),
  street char(50),
  district char(50),
  city char(50)
);
CREATE TABLE Manufacturer
(
  manufactuerId int NOT NULL PRIMARY KEY,
  phonenumber char(15)
);
CREATE TABLE Item
(
  itemId int NOT NULL PRIMARY KEY,
  description
);
CREATE TABLE Produce
(
  quantity int,
  manufacturerId int,
  itemId int,
);
CREATE TABLE Order 
(
  orderId int NOT NULL PRIMARY KEY,
  orderDate date,
  addressId int
);
CREATE TABLE Place 
(
  customerId int,
  orderId int
);
