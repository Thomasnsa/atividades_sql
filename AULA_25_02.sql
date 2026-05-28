DROP DATABASE IF EXISTS loja;
CREATE DATABASE loja;
USE loja;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(100)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO categorias
(id_categoria, nome_categoria)
VALUES
(1, 'Periféricos'),
(2, 'Monitores'),
(3, 'Hardware'),
(4, 'Games'),
(5, 'Celulares'),
(6, 'Notebook'),
(7, 'TV'),
(8, 'Impressora'),
(9, 'Áudio'),
(10, 'Smartwatch');

INSERT INTO produtos
(id_produto, nome_produto, preco, id_categoria)
VALUES
(1, 'Teclado Gamer', 150.00, 1),
(2, 'Mouse RGB', 80.00, 1),
(3, 'Monitor 24', 900.00, 2),
(4, 'Placa de Vídeo', 2500.00, 3),
(5, 'Playstation 5', 4500.00, 4),
(6, 'Iphone 15', 7000.00, 5),
(7, 'Notebook Dell', 3500.00, 6),
(8, 'Smart TV 50', 2800.00, 7),
(9, 'Caixa de Som JBL', 600.00, 9),
(10, 'Apple Watch', 3200.00, 10);

-- INNER JOIN
SELECT * FROM produtos p
INNER JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- LEFT JOIN
SELECT * FROM produtos p
LEFT JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- RIGHT JOIN
SELECT * FROM produtos p
RIGHT JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- ORDER BY ASC
SELECT * FROM produtos
ORDER BY preco;

-- ORDER BY DESC
SELECT * FROM produtos
ORDER BY preco DESC;

-- GROUP BY
SELECT id_categoria, COUNT(*)
FROM produtos
GROUP BY id_categoria;

-- COUNT
SELECT COUNT(*) FROM produtos;