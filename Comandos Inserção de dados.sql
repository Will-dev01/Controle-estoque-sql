INSERT INTO categorias (nome) VALUES 
('Mercearia Básica'), ('Limpeza'), ('Perfumaria e Higiene'), ('Laticínios'), 
('Açougue'), ('Hortifruti'), ('Padaria'), ('Bebidas Não Alcoólicas'), 
('Bebidas Alcoólicas'), ('Congelados'), ('Frios e Embutidos'), ('Biscoitos e Snacks'), 
('Chocolates e Doces'), ('Massas e Molhos'), ('Cereais e Grãos'), ('Enlatados e Conservas'), 
('Matinais e Chás'), ('Pet Shop'), ('Utilidades Domésticas'), ('Papelaria');

INSERT INTO fornecedores (razao_social, cnpj) VALUES 
('Distribuidora Nordeste S.A.', '01.111.111/0001-01'), ('Laticínios Ceará Ltda', '02.222.222/0001-02'),
('Alimentos do Brasil', '03.333.333/0001-03'), ('Indústria LimpBem', '04.444.444/0001-04'),
('Frigorífico Boi Gordo', '05.555.555/0001-05'), ('Horta & Campo Distribuição', '06.666.666/0001-06'),
('Moinho de Trigo S.A.', '07.777.777/0001-07'), ('Bebidas Refrescantes Ltda', '08.888.888/0001-08'),
('Cervejaria Artesanal', '09.999.999/0001-09'), ('Congelados Polar', '10.101.010/0001-10'),
('Embutidos Saborosos', '11.111.111/0002-11'), ('Snacks & Cia', '12.121.212/0001-12'),
('Fábrica de Doces Alegria', '13.131.313/0001-13'), ('Massas Italianas Ltda', '14.141.414/0001-14'),
('Grãos Nobres', '15.151.515/0001-15'), ('Conservas do Mar', '16.161.616/0001-16'),
('Café Matinal S.A.', '17.171.717/0001-17'), ('Ração & Cia', '18.181.818/0001-18'),
('Plásticos e Utilidades', '19.191.919/0001-19'), ('Distribuidora Escolar', '20.202.020/0001-20');

INSERT INTO produtos (nome, capacidade_maxima, categoria_id) VALUES 
('Arroz Agulhinha 5kg', 1000, 1), ('Feijão Carioca 1kg', 1000, 1), ('Óleo de Soja 900ml', 800, 1),
('Sabão em Pó 1kg', 500, 2), ('Detergente Líquido 500ml', 1200, 2),
('Creme Dental 90g', 800, 3), ('Sabonete em Barra 90g', 1500, 3),
('Leite Integral 1L', 1000, 4), ('Queijo Mussarela 1kg', 300, 4),
('Carne Bovina Acém 1kg', 200, 5), ('Frango Inteiro Congelado', 400, 5),
('Tomate Carmem 1kg', 300, 6), ('Cebola Pera 1kg', 300, 6),
('Pão Francês (Cento)', 200, 7), 
('Refrigerante Cola 2L', 1000, 8), ('Suco de Laranja 1L', 600, 8),
('Cerveja Pilsen Lata 350ml', 2000, 9),
('Pizza Congelada Calabresa', 150, 10),
('Presunto Cozido 1kg', 250, 11),
('Biscoito Recheado Chocolate', 800, 12);

INSERT INTO detalhes_produtos (produto_id, peso_gramas, perecivel, codigo_barras) VALUES 
(1, 5000, FALSE, '7890000000001'), (2, 1000, FALSE, '7890000000002'), (3, 900, FALSE, '7890000000003'),
(4, 1000, FALSE, '7890000000004'), (5, 500, FALSE, '7890000000005'), (6, 90, FALSE, '7890000000006'),
(7, 90, FALSE, '7890000000007'), (8, 1000, TRUE, '7890000000008'), (9, 1000, TRUE, '7890000000009'),
(10, 1000, TRUE, '7890000000010'), (11, 2000, TRUE, '7890000000011'), (12, 1000, TRUE, '7890000000012'),
(13, 1000, TRUE, '7890000000013'), (14, 5000, TRUE, '7890000000014'), (15, 2000, FALSE, '7890000000015'),
(16, 1000, TRUE, '7890000000016'), (17, 350, FALSE, '7890000000017'), (18, 400, TRUE, '7890000000018'),
(19, 1000, TRUE, '7890000000019'), (20, 150, FALSE, '7890000000020');

INSERT INTO produto_fornecedor (produto_id, fornecedor_id, preco_custo) VALUES 
(1, 1, 22.50), (1, 15, 21.90), -- Arroz fornecido por duas empresas
(2, 1, 6.80), (3, 3, 5.50), (4, 4, 8.90), (5, 4, 2.10), 
(6, 3, 3.20), (7, 3, 1.80), 
(8, 2, 4.10), (8, 1, 4.25), -- Leite fornecido por duas empresas
(9, 2, 35.00), (10, 5, 28.90), (11, 5, 12.50), 
(12, 6, 4.50), (13, 6, 3.00), (14, 7, 0.50), 
(15, 8, 7.50), (16, 8, 6.20), (17, 9, 2.80), 
(18, 10, 14.90), (19, 11, 25.00), (20, 12, 2.50),
(20, 13, 2.45), -- Biscoito por duas empresas
(3, 1, 5.60), (4, 19, 9.10);

-- Dando carga inicial em alguns produtos
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (1, 'ENTRADA', 300); -- Arroz: 300
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (8, 'ENTRADA', 500); -- Leite: 500
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (3, 'ENTRADA', 200); -- Óleo: 200

-- Simulando saídas (vendas) pesadas para acionar o alerta (Arroz cap. 1000 -> 10% é 100)
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (1, 'SAIDA', 220);   -- Arroz cai para 80 (ACIONA O ALERTA!)

-- Mais entradas e saídas normais
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (4, 'ENTRADA', 150); -- Sabão: 150
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (8, 'SAIDA', 50);    -- Leite cai para 450
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (17, 'ENTRADA', 800);-- Cerveja: 800
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (17, 'SAIDA', 100);  -- Cerveja cai para 700
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (3, 'ENTRADA', 50);  -- Óleo sobe para 250

-- Outra saída brutal para gerar um segundo alerta (Óleo cap. 800 -> 10% é 80)
INSERT INTO movimentacoes (produto_id, tipo, quantidade) VALUES (3, 'SAIDA', 10);   -- Óleo cai para 70 (ACIONA O ALERTA!)

