-- ===== CALCULADORA =====
DROP DATABASE IF EXISTS BD_Calculadora;
CREATE DATABASE BD_Calculadora;
USE BD_Calculadora;

DROP PROCEDURE IF EXISTS sp_Calculadora;

DELIMITER //
CREATE PROCEDURE sp_Calculadora(
    v_operacao VARCHAR(1),
    v_num1     DECIMAL(10,2),
    v_num2     DECIMAL(10,2)
)
BEGIN
    IF (v_operacao IS NOT NULL AND v_num1 IS NOT NULL AND v_num2 IS NOT NULL) THEN
        BEGIN
            IF v_operacao = '+' THEN
                SELECT CONCAT(v_num1, ' + ', v_num2, ' = ', v_num1 + v_num2) AS Resultado;

            ELSEIF v_operacao = '-' THEN
                SELECT CONCAT(v_num1, ' - ', v_num2, ' = ', v_num1 - v_num2) AS Resultado;

            ELSEIF v_operacao = '*' THEN
                SELECT CONCAT(v_num1, ' * ', v_num2, ' = ', v_num1 * v_num2) AS Resultado;

            ELSEIF v_operacao = '/' THEN
                BEGIN
                    IF v_num2 = 0 THEN
                        SELECT 'Erro: divisão por zero não é permitida' AS Resultado;
                    ELSE
                        SELECT CONCAT(v_num1, ' / ', v_num2, ' = ', v_num1 / v_num2) AS Resultado;
                    END IF;
                END;

            ELSE
                SELECT 'Operação inválida. Use: + - * /' AS Resultado;
            END IF;
        END;
    ELSE
        SELECT 'Parâmetros inadequados' AS Resultado;
    END IF;
END;
//
DELIMITER ;

-- Testes Calculadora
CALL sp_Calculadora('+', 10, 5);
CALL sp_Calculadora('-', 10, 5);
CALL sp_Calculadora('*', 10, 5);
CALL sp_Calculadora('/', 10, 5);
CALL sp_Calculadora('/', 10, 0);   -- divisão por zero
CALL sp_Calculadora('%', 10, 5);   -- operação inválida

-- ===== MÉDIA DE 4 NOTAS =====
DROP DATABASE IF EXISTS BD_Notas;
CREATE DATABASE BD_Notas;
USE BD_Notas;

DROP PROCEDURE IF EXISTS sp_MediaAluno;

DELIMITER //
CREATE PROCEDURE sp_MediaAluno(
    v_nota1 DECIMAL(4,2),
    v_nota2 DECIMAL(4,2),
    v_nota3 DECIMAL(4,2),
    v_nota4 DECIMAL(4,2)
)
BEGIN
    DECLARE v_media DECIMAL(4,2);

    IF (v_nota1 IS NOT NULL AND v_nota2 IS NOT NULL 
        AND v_nota3 IS NOT NULL AND v_nota4 IS NOT NULL) THEN
        BEGIN
            -- Valida se todas as notas estão entre 0 e 10
            IF (v_nota1 BETWEEN 0 AND 10 AND v_nota2 BETWEEN 0 AND 10
                AND v_nota3 BETWEEN 0 AND 10 AND v_nota4 BETWEEN 0 AND 10) THEN
                BEGIN
                    SET v_media = (v_nota1 + v_nota2 + v_nota3 + v_nota4) / 4;

                    SELECT 
                        v_nota1                          AS Nota_1,
                        v_nota2                          AS Nota_2,
                        v_nota3                          AS Nota_3,
                        v_nota4                          AS Nota_4,
                        v_media                          AS Media_Final,
                        CASE
                            WHEN v_media >= 7 THEN 'Aprovado'
                            WHEN v_media >= 5 THEN 'Recuperação'
                            ELSE                    'Reprovado'
                        END                              AS Situacao;
                END;
            ELSE
                SELECT 'Erro: todas as notas devem estar entre 0 e 10' AS Resultado;
            END IF;
        END;
    ELSE
        SELECT 'Parâmetros inadequados' AS Resultado;
    END IF;
END;
//
DELIMITER ;

-- Testes Média
CALL sp_MediaAluno(8, 7, 9, 6);     -- Aprovado
CALL sp_MediaAluno(5, 4, 6, 5);     -- Recuperação
CALL sp_MediaAluno(2, 3, 1, 4);     -- Reprovado
CALL sp_MediaAluno(5, 11, 7, 8);    -- nota inválida
CALL sp_MediaAluno(NULL, 7, 8, 9);  -- parâmetro nulo