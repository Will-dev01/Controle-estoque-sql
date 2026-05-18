create database SuperBompreco;

use SuperBompreco;

create table categorias(
id int auto_increment primary key,
nome varchar(100) not null
);

create table fornecedores(
id int auto_increment primary key,
razao_social varchar(150) not null,
cnpj varchar(18) unique not null
);

create table produtos (
id int auto_increment primary key,
nome varchar(150) not null,
quantidade_atual int default 0,
capacidade_maxima int default 1000,
categoria_id int not null,
foreign key (categoria_id) references categorias(id)
);

create table detalhes_produtos(
produto_id int primary key,
peso_gramas decimal (10,2),
perecivel boolean not null default false,
codigo_barras varchar(50) unique,
foreign key (produto_id) references produtos(id) on delete cascade
);

create table produto_fornecedor(
produto_id int not null,
fornecedor_id int not null,
preco_custo decimal(10,2) not null,
primary key (produto_id, fornecedor_id),
foreign key (produto_id) references produtos(id),
foreign key (fornecedor_id) references fornecedores(id)
);


create table movimentacoes (
id int auto_increment primary key,
produto_id int not null,
tipo enum('Entrada','Saída') not null,
quantidade int not null,
data_moviemntação datetime default current_timestamp,
foreign key (produto_id) references produtos(id)
);

create table alertas_estoque (
id int auto_increment primary key,
produto_id int not null,
mensagem varchar(255) not null,
data_alerta datetime default current_timestamp,
status enum ('Pendente', 'resolvido') default 'Pendente',
foreign key (produto_id) references produtos(id)
);

