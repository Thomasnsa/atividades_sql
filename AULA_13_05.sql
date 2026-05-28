-- Criar database e tabela para os triggers
CREATE DATABASE IF NOT EXISTS BD_Clientes;
USE BD_Clientes;

CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS log_clientes (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(200),
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===== TRIGGERS BEFORE =====

-- BEFORE INSERT - Converte nome para MAIÚSCULA
DROP TRIGGER IF EXISTS before_insert_cliente;

DELIMITER $$

CREATE TRIGGER before_insert_cliente
BEFORE INSERT
ON clientes
FOR EACH ROW
BEGIN
    SET NEW.nome = UPPER(NEW.nome);
END$$

DELIMITER ;

-- BEFORE UPDATE - Converte nome para MAIÚSCULA
DROP TRIGGER IF EXISTS before_update_cliente;

DELIMITER $$

CREATE TRIGGER before_update_cliente
BEFORE UPDATE
ON clientes
FOR EACH ROW
BEGIN
    SET NEW.nome = UPPER(NEW.nome);
END$$

DELIMITER ;

-- BEFORE DELETE - Bloqueia exclusão
DROP TRIGGER IF EXISTS before_delete_cliente;

DELIMITER $$

CREATE TRIGGER before_delete_cliente
BEFORE DELETE
ON clientes
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Exclusão não permitida';
END$$

DELIMITER ;

-- ===== TRIGGERS AFTER =====

-- AFTER INSERT - Registra inserção
DROP TRIGGER IF EXISTS after_insert_cliente;

DELIMITER $$

CREATE TRIGGER after_insert_cliente
AFTER INSERT
ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes(mensagem)
    VALUES ('Novo cliente inserido');
END$$

DELIMITER ;

-- AFTER UPDATE - Registra atualização
DROP TRIGGER IF EXISTS after_update_cliente;

DELIMITER $$

CREATE TRIGGER after_update_cliente
AFTER UPDATE
ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes(mensagem)
    VALUES ('Cliente atualizado');
END$$

DELIMITER ;

-- AFTER DELETE - Registra exclusão
DROP TRIGGER IF EXISTS after_delete_cliente;

DELIMITER $$

CREATE TRIGGER after_delete_cliente
AFTER DELETE
ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes(mensagem)
    VALUES ('Cliente deletado');
END$$

DELIMITER ;

-- ===== TESTES =====

-- Teste INSERT (nome convertido para maiúscula)
INSERT INTO clientes (nome, email) VALUES ('joão silva', 'joao@email.com');

-- Teste UPDATE (nome convertido para maiúscula)
UPDATE clientes SET nome = 'maria santos' WHERE id = 1;

-- Verificar logs
SELECT * FROM log_clientes;
SELECT * FROM clientes;

-- Teste DELETE (será bloqueado)
-- DELETE FROM clientes WHERE id = 1; -- Isso gerará erro: 'Exclusão não permitida'