drop database if exists foodweb_db;
create database foodweb_db;

drop table if exists foodweb_db.user;
create table foodweb_db.user(
  id int auto_increment primary key comment 'id PK',
  email varchar(255) not null unique comment 'email NN UN',
  firstname varchar(255) not null comment 'firstname NN',
  lastname varchar(255) not null comment 'lastname NN',
  password varchar(255) not null comment 'password NN'
);

select * from foodweb_db.user;
