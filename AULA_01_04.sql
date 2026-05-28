-- Criar database e tabela usuario para os procedures
CREATE DATABASE IF NOT EXISTS sistema_usuarios;
USE sistema_usuarios;

CREATE TABLE IF NOT EXISTS usuario (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    dt_cadastro DATETIME
);

-- Procedure 1: Lista todos os usuários
DELIMITER //
CREATE PROCEDURE sp_listarUsuario()
BEGIN
    SELECT cpf, nome, email, dt_cadastro
    FROM usuario;
END;
//
DELIMITER ;

-- Procedure 2: Insere um usuário com validação
DELIMITER //
CREATE PROCEDURE sp_insereUsuario(
    v_CPF        CHAR(11),
    v_nome       VARCHAR(100),
    v_email      VARCHAR(100),
    v_dt_cadastro DATETIME
)
BEGIN
    IF (v_CPF IS NOT NULL AND v_nome IS NOT NULL 
        AND v_email IS NOT NULL AND v_dt_cadastro IS NOT NULL) THEN
        BEGIN
            INSERT INTO usuario (cpf, nome, email, dt_cadastro)
            VALUES (v_CPF, v_nome, v_email, v_dt_cadastro);
            SELECT 'Cadastro efetuado com sucesso!' AS resultado;
        END;
    ELSE
        BEGIN
            SELECT 'Parâmetros inadequados' AS resultado;
        END;
    END IF;
END;
//
DELIMITER ;

-- Procedure 3: Busca por CPF ou lista tudo
DELIMITER //
CREATE PROCEDURE sp_consultaUsuario(v_CPF CHAR(11))
BEGIN
    IF (v_CPF IS NOT NULL) THEN
        SELECT cpf, nome, email, dt_cadastro
        FROM usuario
        WHERE cpf = v_CPF;
    ELSE
        SELECT cpf, nome, email, dt_cadastro
        FROM usuario;
    END IF;
END;
//
DELIMITER ;

-- Procedure 4: Deleta por CPF ou todos os registros
DELIMITER //
CREATE PROCEDURE sp_deleteUsuario(v_CPF CHAR(11))
BEGIN
    IF (v_CPF IS NOT NULL) THEN
        DELETE FROM usuario WHERE cpf = v_CPF;
        SELECT 'Usuário deletado com sucesso!' AS resultado;
    ELSE
        DELETE FROM usuario;
        SELECT 'Todos os usuários foram deletados!' AS resultado;
    END IF;
END;
//
DELIMITER ;

-- TESTES (descomente para usar)
-- CALL sp_listarUsuario();
-- CALL sp_insereUsuario('12345678900', 'João Silva', 'joao@email.com', NOW());
-- CALL sp_consultaUsuario('12345678900');
-- CALL sp_deleteUsuario('12345678900');