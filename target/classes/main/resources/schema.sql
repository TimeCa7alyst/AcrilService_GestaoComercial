CREATE TABLE Endereco
(
    Id         INTEGER      NOT NULL AUTO_INCREMENT,
    CEP        VARCHAR(8)   NOT NULL,
    Bairro     VARCHAR(250) NOT NULL,
    Estado     VARCHAR(250) NOT NULL,
    Cidade     VARCHAR(250) NOT NULL,
    Logradouro VARCHAR(250) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Cliente
(
    Id              INTEGER      NOT NULL AUTO_INCREMENT,
    Id_Endereco     INTEGER NULL,
    Nome            VARCHAR(250) NOT NULL,
    Tipo            ENUM('CPF', 'CNPJ') NOT NULL,
    Data_Cadastro   DATE         NOT NULL,
    Status_Cliente  ENUM('ATIVO', 'INATIVO') NOT NULL,
    Data_Inativacao DATE,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Endereco) REFERENCES Endereco (Id)
);

CREATE TABLE Email
(
    Id         INTEGER      NOT NULL AUTO_INCREMENT,
    Id_Cliente INTEGER NULL,
    Endereco   VARCHAR(250) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente (Id)
);

CREATE TABLE Orcamento
(
    Id               INTEGER        NOT NULL AUTO_INCREMENT,
    Id_Cliente       INTEGER NULL,
    Data_Criacao     DATE           NOT NULL,
    Data_Validade    DATE           NOT NULL,
    Valor            DECIMAL(16, 2) NOT NULL,
    Desconto         DECIMAL(16, 2) NOT NULL,
    Status_Orcamento ENUM('APROVADO', 'REPROVADO', 'EXPIRADO', 'PENDENTE') NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente (Id)
);

CREATE TABLE Produto
(
    Id    INTEGER        NOT NULL AUTO_INCREMENT,
    Nome  VARCHAR(250)   NOT NULL,
    Valor DECIMAL(16, 2) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Orcamento_Produto
(
    Id_Orcamento INTEGER NOT NULL,
    Id_Produto   INTEGER NOT NULL,
    Quantidade   INTEGER NOT NULL,
    PRIMARY KEY (Id_Orcamento, Id_Produto),
    FOREIGN KEY (Id_Orcamento) REFERENCES Orcamento (Id),
    FOREIGN KEY (Id_Produto) REFERENCES Produto (Id)
);

CREATE TABLE Venda
(
    Id               INTEGER NOT NULL AUTO_INCREMENT,
    Id_Orcamento     INTEGER NULL,
    Data_Criacao     DATE    NOT NULL,
    Status_Pagamento ENUM('APROVADO', 'PENDENTE', 'EXPIRADO', 'CANCELADO') NOT NULL,
    Prazo_Pagamento  DATE    NOT NULL,
    Data_Conclusao   DATE NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Orcamento) REFERENCES Orcamento (Id)
);

CREATE TABLE Avaliacao
(
    Id           INTEGER      NOT NULL AUTO_INCREMENT,
    Id_Venda     INTEGER NULL,
    Titulo       VARCHAR(250) NOT NULL,
    Descricao    VARCHAR(500) NOT NULL,
    Data_Criacao DATE         NOT NULL,
    Nota         DECIMAL(3, 1),
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Venda) REFERENCES Venda (Id)
);

INSERT INTO Endereco (CEP, Bairro, Estado, Cidade, Logradouro)
VALUES ('01001000', 'Sé', 'SP', 'São Paulo', 'Praça da Sé'),
       ('20040002', 'Centro', 'RJ', 'Rio de Janeiro', 'Rua Primeiro de Março'),
       ('30130010', 'Funcionários', 'MG', 'Belo Horizonte', 'Av. Afonso Pena');


INSERT INTO Cliente (Id_Endereco, Nome, Tipo, Data_Cadastro, Status_Cliente)
VALUES (1, 'João da Silva', 'CPF', CURRENT_DATE, 'ATIVO'),
       (2, 'Tech Solutions Ltda', 'CNPJ', CURRENT_DATE, 'ATIVO'),
       (3, 'Maria Oliveira', 'CPF', CURRENT_DATE, 'INATIVO');


INSERT INTO Email (Id_Cliente, Endereco)
VALUES (1, 'joao.silva@email.com'),
       (2, 'contato@techsolutions.com.br'),
       (2, 'financeiro@techsolutions.com.br');


INSERT INTO Produto (Nome, Valor)
VALUES ('Notebook Gamer Dell', 5500.00),
       ('Mouse Sem Fio Logitech', 120.50),
       ('Teclado Mecânico RGB', 350.00),
       ('Monitor Samsung 24"', 899.90),
       ('Cadeira Ergonômica', 1200.00);


INSERT INTO Orcamento (Id_Cliente, Data_Criacao, Data_Validade, Valor, Desconto, Status_Orcamento)
VALUES (1, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 15 DAY), 5620.50, 0.00, 'APROVADO');


INSERT INTO Orcamento_Produto (Id_Orcamento, Id_Produto, Quantidade)
VALUES (1, 1, 1),
       (1, 2, 1);

INSERT INTO Venda (Id_Orcamento, Data_Criacao, Status_Pagamento, Prazo_Pagamento, Data_Conclusao)
VALUES (1, CURRENT_DATE, 'APROVADO', DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY), CURRENT_DATE);

INSERT INTO Avaliacao (Id_Venda, Titulo, Descricao, Data_Criacao, Nota)
VALUES (1, "Muito bom", "Ótima qualidade e atendimento incrível", CURRENT_DATE, 5);