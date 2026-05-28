CREATE DATABASE exercicio_resumido;
USE exercicio_resumido;

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    categoria VARCHAR(50)
);

INSERT INTO produtos VALUES 
(1, 'Teclado', 150.00, 'Periféricos'),
(2, 'Monitor', 900.00, 'Hardware'),
(3, 'Mouse', 80.00, 'Periféricos'),
(4, 'Placa Vídeo', 2500.00, 'Hardware');

-- Subconsulta - Seleciona o produto com o maior preço
SELECT nome FROM produtos 
WHERE preco = (SELECT MAX(preco) FROM produtos);