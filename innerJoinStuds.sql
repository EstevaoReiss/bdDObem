-- ============================================================
-- BANCO DE ESTUDOS - RH
-- Compatível com os exercícios de JOIN da aula
-- MySQL
-- ============================================================

DROP DATABASE IF EXISTS estudos_rh;
CREATE DATABASE estudos_rh;
USE estudos_rh;

-- ============================================================
-- 1. TABELAS
-- ============================================================

CREATE TABLE regioes (
    regiao_id INT PRIMARY KEY,
    regiao_nome VARCHAR(25) NOT NULL
);

CREATE TABLE paises (
    pais_id CHAR(2) PRIMARY KEY,
    pais_nome VARCHAR(40) NOT NULL,
    regiao_id INT NOT NULL,
    CONSTRAINT fk_paises_regioes
        FOREIGN KEY (regiao_id) REFERENCES regioes(regiao_id)
);

CREATE TABLE locais (
    local_id INT PRIMARY KEY,
    endereco VARCHAR(40) NOT NULL,
    cep VARCHAR(12),
    cidade VARCHAR(30) NOT NULL,
    estado VARCHAR(25),
    pais_id CHAR(2) NOT NULL,
    CONSTRAINT fk_locais_paises
        FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

CREATE TABLE cargos (
    cargo_id VARCHAR(10) PRIMARY KEY,
    cargo_desc VARCHAR(35) NOT NULL,
    min_salario FLOAT,
    max_salario FLOAT
);

CREATE TABLE departamentos (
    departamento_id INT PRIMARY KEY,
    departamento_nome VARCHAR(30) NOT NULL,
    gerente_id INT NULL,
    local_id INT NOT NULL,
    CONSTRAINT fk_departamentos_locais
        FOREIGN KEY (local_id) REFERENCES locais(local_id)
);

CREATE TABLE funcionarios (
    funcionario_id INT PRIMARY KEY,
    pre_nome VARCHAR(20) NOT NULL,
    sobre_nome VARCHAR(25) NOT NULL,
email VARCHAR(100),
    fone VARCHAR(20),
    dt_admiss DATETIME,
    cargo VARCHAR(10) NOT NULL,
    salario FLOAT NOT NULL,
    pc_comis FLOAT,
    gerente_id INT NULL,
    departamento_id INT NULL,
    CONSTRAINT fk_funcionarios_cargos
        FOREIGN KEY (cargo) REFERENCES cargos(cargo_id),
    CONSTRAINT fk_funcionarios_departamentos
        FOREIGN KEY (departamento_id)
        REFERENCES departamentos(departamento_id)
);

-- Relacionamento de gerente:
-- Um departamento pode ter como gerente um funcionário.
-- Criamos depois dos funcionários para evitar problema de ordem de inserção.
ALTER TABLE departamentos
ADD CONSTRAINT fk_departamentos_gerente
FOREIGN KEY (gerente_id) REFERENCES funcionarios(funcionario_id);

-- Funcionário pode ter outro funcionário como gerente.
ALTER TABLE funcionarios
ADD CONSTRAINT fk_funcionarios_gerente
FOREIGN KEY (gerente_id) REFERENCES funcionarios(funcionario_id);

-- ============================================================
-- 2. REGIÕES
-- ============================================================

INSERT INTO regioes (regiao_id, regiao_nome) VALUES
(1, 'AMERICAS'),
(2, 'EUROPA'),
(3, 'ASIA'),
(4, 'AFRICA');

-- ============================================================
-- 3. PAÍSES
-- ============================================================

INSERT INTO paises (pais_id, pais_nome, regiao_id) VALUES
('BR', 'Brasil', 1),
('US', 'Estados Unidos', 1),
('CA', 'Canada', 1),
('MX', 'Mexico', 1),
('UK', 'Reino Unido', 2),
('FR', 'Franca', 2),
('DE', 'Alemanha', 2),
('JP', 'Japao', 3);

-- ============================================================
-- 4. LOCAIS
-- ============================================================

INSERT INTO locais
(local_id, endereco, cep, cidade, estado, pais_id)
VALUES
(100, 'Rua Augusta, 100', '01305-000', 'Sao Paulo', 'SP', 'BR'),
(110, 'Avenida Paulista, 1500', '01310-200', 'Sao Paulo', 'SP', 'BR'),
(120, 'Rua XV de Novembro, 200', '80020-310', 'Curitiba', 'PR', 'BR'),
(130, 'Rua das Flores, 500', '30140-000', 'Belo Horizonte', 'MG', 'BR'),
(140, 'Queen Street, 200', 'M5V-2B6', 'Toronto', 'ON', 'CA'),
(150, 'Main Street, 100', '10001', 'New York', 'NY', 'US'),
(160, 'Market Street, 400', '94105', 'San Francisco', 'CA', 'US'),
(170, 'Oxford Street, 50', 'W1D-1BS', 'London', NULL, 'UK'),
(180, 'Rue de Rivoli, 80', '75001', 'Paris', NULL, 'FR');

-- ============================================================
-- 5. CARGOS
-- ============================================================

INSERT INTO cargos
(cargo_id, cargo_desc, min_salario, max_salario)
VALUES
('DEV', 'DESENVOLVEDOR', 2500, 7000),
('ANALISTA', 'ANALISTA DE SISTEMAS', 2500, 6000),
('GERENTE', 'GERENTE DE DEPARTAMENTO', 4000, 10000),
('GER_FIN', 'GERENTE FINANCEIRO', 5000, 12000),
('GER_TI', 'GERENTE DE TECNOLOGIA', 5000, 12000),
('ASSIST', 'ASSISTENTE ADMINISTRATIVO', 1500, 3500),
('RH', 'ANALISTA DE RECURSOS HUMANOS', 2200, 5500),
('VENDEDOR', 'VENDEDOR', 1800, 5000),
('ESTAGIO', 'ESTAGIARIO', 1000, 2000);

-- ============================================================
-- 6. DEPARTAMENTOS
-- gerente_id ficará NULL inicialmente.
-- ============================================================

INSERT INTO departamentos
(departamento_id, departamento_nome, gerente_id, local_id)
VALUES
(10, 'Administracao', NULL, 100),
(20, 'Financeiro', NULL, 110),
(30, 'Recursos Humanos', NULL, 110),
(40, 'Tecnologia', NULL, 150),
(50, 'Vendas', NULL, 140),
(60, 'Marketing', NULL, 160),
(70, 'Juridico', NULL, 170),
(80, 'Pesquisa', NULL, 180),
(90, 'Departamento Vazio', NULL, 120);

-- ============================================================
-- 7. FUNCIONÁRIOS
-- ============================================================

INSERT INTO funcionarios
(funcionario_id, pre_nome, sobre_nome, email, fone, dt_admiss,
 cargo, salario, pc_comis, gerente_id, departamento_id)
VALUES
(1, 'Carlos', 'Silva', 'carlos.silva@empresa.com', '11999990001',
 '2018-02-10', 'GERENTE', 6500, NULL, NULL, 10),

(2, 'Ana', 'Souza', 'ana.souza@empresa.com', '11999990002',
 '2019-05-15', 'ASSIST', 2800, NULL, 1, 10),

(3, 'Bruno', 'Oliveira', 'bruno.oliveira@empresa.com', '11999990003',
 '2020-01-20', 'ANALISTA', 3900, NULL, 1, 20),

(4, 'Mariana', 'Costa', 'mariana.costa@empresa.com', '11999990004',
 '2017-08-12', 'GER_FIN', 8500, NULL, NULL, 20),

(5, 'Gabriel', 'Henrique', 'gabriel.henrique@empresa.com', '11999990005',
 '2021-03-10', 'RH', 3200, NULL, NULL, 30),

(6, 'Juliana', 'Klein', 'juliana.klein@empresa.com', '11999990006',
 '2022-07-01', 'ASSIST', 2100, NULL, 5, 30),

(7, 'Pedro', 'Mendes', 'pedro.mendes@empresa.com', '11999990007',
 '2019-11-22', 'GER_TI', 9000, NULL, NULL, 40),

(8, 'Lucas', 'Pereira', 'lucas.pereira@empresa.com', '11999990008',
 '2023-02-05', 'DEV', 4500, NULL, 7, 40),

(9, 'Fernanda', 'Almeida', 'fernanda.almeida@empresa.com', '11999990009',
 '2020-06-18', 'DEV', 3500, NULL, 7, 40),

(10, 'Rafael', 'Keller', 'rafael.keller@empresa.com', '11999990010',
 '2021-09-30', 'GERENTE', 5500, NULL, NULL, 50),

(11, 'Beatriz', 'Santos', 'beatriz.santos@empresa.com', '11999990011',
 '2022-04-11', 'VENDEDOR', 3000, 5.0, 10, 50),

(12, 'Diego', 'Martins', 'diego.martins@empresa.com', '11999990012',
 '2018-12-03', 'VENDEDOR', 2400, 3.0, 10, 50),

(13, 'Camila', 'Gomes', 'camila.gomes@empresa.com', '11999990013',
 '2020-10-19', 'GERENTE', 6200, NULL, NULL, 60),

(14, 'Thiago', 'Rodrigues', 'thiago.rodrigues@empresa.com', '11999990014',
 '2023-01-09', 'ANALISTA', 3600, NULL, 13, 60),

(15, 'Larissa', 'Fernandes', 'larissa.fernandes@empresa.com', '11999990015',
 '2019-04-25', 'GERENTE', 5800, NULL, NULL, 70),

(16, 'Joao', 'Kowalski', 'joao.kowalski@empresa.com', '11999990016',
 '2021-12-13', 'ANALISTA', 3400, NULL, 15, 70),

(17, 'Paula', 'Nascimento', 'paula.nascimento@empresa.com', '11999990017',
 '2024-01-15', 'ESTAGIO', 1500, NULL, 15, 80),

(18, 'Marcos', 'Torres', 'marcos.torres@empresa.com', '11999990018',
 '2024-05-20', 'DEV', 4000, NULL, 7, NULL);

-- ============================================================
-- 8. ATUALIZAR GERENTES DOS DEPARTAMENTOS
-- ============================================================

UPDATE departamentos
SET gerente_id = 1
WHERE departamento_id = 10;

UPDATE departamentos
SET gerente_id = 4
WHERE departamento_id = 20;

UPDATE departamentos
SET gerente_id = 5
WHERE departamento_id = 30;

UPDATE departamentos
SET gerente_id = 7
WHERE departamento_id = 40;

UPDATE departamentos
SET gerente_id = 10
WHERE departamento_id = 50;

UPDATE departamentos
SET gerente_id = 13
WHERE departamento_id = 60;

UPDATE departamentos
SET gerente_id = 15
WHERE departamento_id = 70;

-- ============================================================
-- 9. CONSULTAS DE CONFERÊNCIA
-- ============================================================

-- Ver bancos
SHOW DATABASES;

-- Ver tabelas
SHOW TABLES;

-- Estrutura das tabelas
DESCRIBE funcionarios;
DESCRIBE departamentos;
DESCRIBE cargos;
DESCRIBE locais;
DESCRIBE paises;
DESCRIBE regioes;

-- Quantidade de registros
SELECT 'funcionarios' AS tabela, COUNT(*) AS quantidade FROM funcionarios
UNION ALL
SELECT 'departamentos', COUNT(*) FROM departamentos
UNION ALL
SELECT 'cargos', COUNT(*) FROM cargos
UNION ALL
SELECT 'locais', COUNT(*) FROM locais
UNION ALL
SELECT 'paises', COUNT(*) FROM paises
UNION ALL
SELECT 'regioes', COUNT(*) FROM regioes;

-- Funcionário sem departamento:
SELECT *
FROM funcionarios
WHERE departamento_id IS NULL;

-- Departamento sem funcionário:
SELECT
    d.departamento_id,
    d.departamento_nome
FROM departamentos d
LEFT JOIN funcionarios f
    ON f.departamento_id = d.departamento_id
WHERE f.funcionario_id IS NULL;
