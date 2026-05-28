DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa;
USE empresa;

-- Criando tabela funcionarios
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(100),
    salario DECIMAL(10,2)
);

-- Inserindo 10 registros
INSERT INTO funcionarios
(id_funcionario, nome, cargo, salario)
VALUES
(1, 'Carlos Silva', 'Analista', 2500.00),
(2, 'Mariana Souza', 'Gerente', 5000.00),
(3, 'Joao Pedro', 'Desenvolvedor', 4000.00),
(4, 'Fernanda Lima', 'RH', 3000.00),
(5, 'Lucas Alves', 'Suporte', 2200.00),
(6, 'Patricia Gomes', 'Financeiro', 3500.00),
(7, 'Ricardo Melo', 'Designer', 2800.00),
(8, 'Amanda Costa', 'Marketing', 3200.00),
(9, 'Felipe Rocha', 'Tester', 2700.00),
(10, 'Juliana Martins', 'Coordenadora', 4500.00);

-- Criando função para calcular aumento
DELIMITER $$

CREATE FUNCTION calcular_aumento (
    salario_func DECIMAL(10,2),
    percentual_de_aumento DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN salario_func + (salario_func * percentual_de_aumento / 100);
END$$

DELIMITER ;

-- Executando função
SELECT calcular_aumento(2500, 10) AS novo_salario;

-- Select chamando a função com todos os funcionários
SELECT
    nome,
    salario,
    calcular_aumento(salario, 10) AS salario_com_aumento
FROM funcionarios;