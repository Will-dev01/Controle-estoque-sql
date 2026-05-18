
-- Lista o catálogo básico de produtos, mostrando o nome, o quanto temos no momento e o teto máximo que o estoque suporta.

SELECT nome, quantidade_atual, capacidade_maxima 
FROM produtos;

 -- Filtra especificamente os produtos que estão com o estoque zerado e precisam de reposição imediata.
SELECT nome, quantidade_atual 
FROM produtos 
WHERE quantidade_atual = 0;

-- Gera uma lista telefônica/catálogo de todos os fornecedores cadastrados, organizados em ordem alfabética de A a Z.
SELECT razao_social, cnpj 
FROM fornecedores 
ORDER BY razao_social ASC;

-- Junta a tabela de produtos com a tabela de detalhes_produtos (relacionamento 1:1) para mostrar o nome do produto ao lado do seu código de barras e verificar se ele é perecível.
SELECT p.nome, dp.codigo_barras, dp.perecivel 
FROM produtos p
INNER JOIN detalhes_produtos dp ON p.id = dp.produto_id;

-- Essa consulta mostra o nome do produto, o nome do fornecedor e qual o preço de custo que esse fornecedor específico cobra.
SELECT p.nome AS Produto, f.razao_social AS Fornecedor, pf.preco_custo AS Preco_Custo
FROM produtos p
INNER JOIN produto_fornecedor pf ON p.id = pf.produto_id
INNER JOIN fornecedores f ON pf.fornecedor_id = f.id;

-- Calcula o volume total de mercadorias armazenadas fisicamente no supermercado no momento, somando as quantidades de todos os produtos.
SELECT SUM(quantidade_atual) AS volume_total_estoque 
FROM produtos;


-- Ele conta quantos produtos diferentes estão cadastrados dentro de cada categoria (usamos LEFT JOIN para garantir que até as categorias vazias apareçam com contagem "0").
SELECT c.nome AS Categoria, COUNT(p.id) AS total_produtos_cadastrados
FROM categorias c
LEFT JOIN produtos p ON c.id = p.categoria_id
GROUP BY c.nome;

-- Descobre quais produtos têm uma capacidade máxima definida que é maior do que a média geral de capacidade do supermercado. A subconsulta (SELECT AVG...) roda primeiro para encontrar a média.
SELECT nome, capacidade_maxima 
FROM produtos 
WHERE capacidade_maxima > (SELECT AVG(capacidade_maxima) FROM produtos);

-- Aplica uma operação matemática diretamente no banco para saber o nível de ocupação do estoque. Ela calcula a porcentagem exata de quão cheio está o espaço destinado a cada produto e usa a função ROUND para deixar o resultado com apenas 2 casas decimais.
SELECT nome, 
       quantidade_atual, 
       capacidade_maxima, 
       ROUND((quantidade_atual / capacidade_maxima) * 100, 2) AS percentual_ocupacao_estoque
FROM produtos;


SELECT 
    p.nome, 
    c.nome AS Categoria, 
    f.razao_social, 
    pf.preco_custo 
FROM produtos p 
JOIN categorias c 
    ON p.categoria_id = c.id 
JOIN produto_fornecedor pf 
    ON p.id = pf.produto_id 
JOIN fornecedores f 
    ON pf.fornecedor_id = f.id 
WHERE c.nome = 'Mercearia Básica';


SELECT 
    c.nome, 
    SUM(p.quantidade_atual) AS total_itens 
FROM categorias c 
JOIN produtos p 
    ON c.id = p.categoria_id 
GROUP BY c.nome;



SELECT * FROM produtos p
JOIN produto_fornecedor pf ON p.id = pf.produto_id
WHERE p.categoria_id = 1;

SELECT p.nome, pf.preco_custo
FROM produtos p
INNER JOIN produto_fornecedor pf ON p.id = pf.produto_id
WHERE p.categoria_id = (SELECT id FROM categorias WHERE nome = 'Mercearia Básica');

SELECT * FROM movimentacoes 
WHERE tipo = 'SAIDA' AND quantidade > 100;

