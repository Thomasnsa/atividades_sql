-- ===== TRIGGER AFTER INSERT =====
CREATE DATABASE IF NOT EXISTS BD_Triggers;
USE BD_Triggers;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE log_usuarios (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    nome VARCHAR(100),
    email VARCHAR(100),
    acao VARCHAR(50),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS after_insert_usuario;

DELIMITER $$

CREATE TRIGGER after_insert_usuario
AFTER INSERT
ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO log_usuarios (usuario_id, nome, email, acao)
    VALUES (NEW.id, NEW.nome, NEW.email, 'INSERÇÃO');
END$$

DELIMITER ;

-- Teste: Inserir um usuário e verificar o log
INSERT INTO usuarios (nome, email)
VALUES ('Maria Oliveira', 'maria@email.com');

SELECT * FROM log_usuarios;

-- ===== TRIGGER BEFORE INSERT (Aumento de Preço) =====
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

DROP TRIGGER IF EXISTS before_insert_produto;

DELIMITER $$

CREATE TRIGGER before_insert_produto
BEFORE INSERT
ON produtos
FOR EACH ROW
BEGIN
    SET NEW.preco = NEW.preco * 1.10;
END$$

DELIMITER ;

-- Teste: Inserir um produto com preço base 100.00 (será 110.00)
INSERT INTO produtos (nome, preco)
VALUES ('Teclado Gamer', 100.00);

SELECT * FROM produtos;

-- ===== TRIGGER BEFORE UPDATE (Aumento de 30%) =====
DROP TRIGGER IF EXISTS before_update_produto;

DELIMITER $$

CREATE TRIGGER before_update_produto
BEFORE UPDATE
ON produtos
FOR EACH ROW
BEGIN
    SET NEW.preco = NEW.preco * 1.30;
END$$

DELIMITER ;

-- Teste: Atualizar o preço (será aumentado em 30%)
-- UPDATE produtos SET preco = 100.00 WHERE id = 1;