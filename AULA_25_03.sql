-- Usando o database dos exercícios anteriores (exercicio_resumido)
USE exercicio_resumido;

-- VIEW utilizando SELECT
CREATE VIEW vw_select_produtos AS
SELECT id, nome, preco
FROM produtos;

SELECT * FROM vw_select_produtos;

-- VIEW utilizando INSERT
CREATE VIEW vw_insert_produtos AS
SELECT id, nome, preco
FROM produtos;

INSERT INTO vw_insert_produtos
(id, nome, preco)
VALUES (5, 'Produto D', 99.90);

-- VIEW utilizando UPDATE
CREATE VIEW vw_update_produtos AS
SELECT id, nome, preco
FROM produtos;

UPDATE vw_update_produtos
SET preco = 150.00
WHERE id = 1;

-- VIEW utilizando DELETE
CREATE VIEW vw_delete_produtos AS
SELECT id, nome
FROM produtos;

DELETE FROM vw_delete_produtos
WHERE id = 2;