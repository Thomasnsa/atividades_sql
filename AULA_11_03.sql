-- Usando o database dos exercícios anteriores (exercicio_resumido)
USE exercicio_resumido;

-- Funções Agregadas

SELECT COUNT(*) AS total_produtos
FROM produtos;

SELECT AVG(preco) AS media_precos
FROM produtos;

SELECT MAX(preco) AS maior_preco
FROM produtos;

SELECT MIN(preco) AS menor_preco
FROM produtos;

SELECT SUM(preco) AS soma_precos
FROM produtos;