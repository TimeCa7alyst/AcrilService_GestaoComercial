DROP DATABASE IF EXISTS sistema_gestao_comercial;

CREATE DATABASE sistema_gestao_comercial
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE sistema_gestao_comercial;


CREATE TABLE Endereco (
                          Id INTEGER NOT NULL AUTO_INCREMENT,
                          CEP VARCHAR(8) NOT NULL,
                          Bairro VARCHAR(250) NOT NULL,
                          Estado VARCHAR(250) NOT NULL,
                          Cidade VARCHAR(250) NOT NULL,
                          Logradouro VARCHAR(250) NOT NULL,
                          PRIMARY KEY(Id)
);

CREATE TABLE Cliente (
                         Id INTEGER NOT NULL AUTO_INCREMENT,
                         Id_Endereco INTEGER NULL,
                         Nome VARCHAR(250) NOT NULL,
                         Tipo ENUM('CPF', 'CNPJ') NOT NULL,
                         Data_Cadastro DATE NOT NULL,
                         Status_Cliente ENUM('ATIVO', 'INATIVO') NOT NULL,
                         Data_Inativacao DATE,
                         PRIMARY KEY(Id),
                         FOREIGN KEY(Id_Endereco) REFERENCES Endereco(Id)
);

CREATE TABLE Email (
                       Id INTEGER NOT NULL AUTO_INCREMENT,
                       Id_Cliente INTEGER NULL,
                       Endereco VARCHAR(250) NOT NULL,
                       PRIMARY KEY(Id),
                       FOREIGN KEY(Id_Cliente) REFERENCES Cliente(Id)
);

CREATE TABLE Orcamento (
                           Id INTEGER NOT NULL AUTO_INCREMENT,
                           Id_Cliente INTEGER NULL,
                           Data_Criacao DATE NOT NULL,
                           Data_Validade DATE NOT NULL,
                           Valor DECIMAL(16,2) NOT NULL,
                           Desconto DECIMAL(16,2) NOT NULL,
                           Status_Orcamento ENUM('APROVADO', 'REPROVADO', 'EXPIRADO', 'PENDENTE') NOT NULL,
                           PRIMARY KEY(Id),
                           FOREIGN KEY(Id_Cliente) REFERENCES Cliente(Id)
);

CREATE TABLE Produto (
                         Id INTEGER NOT NULL AUTO_INCREMENT,
                         Nome VARCHAR(250) NOT NULL,
                         Valor DECIMAL(16,2) NOT NULL,
                         PRIMARY KEY(Id)
);

CREATE TABLE Orcamento_Produto (
                                   Id_Orcamento INTEGER NOT NULL,
                                   Id_Produto INTEGER NOT NULL,
                                   Quantidade INTEGER NOT NULL,
                                   PRIMARY KEY(Id_Orcamento, Id_Produto),
                                   FOREIGN KEY (Id_Orcamento) REFERENCES Orcamento(Id),
                                   FOREIGN KEY (Id_Produto) REFERENCES Produto(Id)
);

CREATE TABLE Venda (
                       Id INTEGER NOT NULL AUTO_INCREMENT,
                       Id_Orcamento INTEGER NULL,
                       Data_Criacao DATE NOT NULL,
                       Status_Pagamento ENUM('APROVADO', 'PENDENTE', 'EXPIRADO', 'CANCELADO') NOT NULL,
                       Prazo_Pagamento DATE NOT NULL,
                       Data_Conclusao DATE NULL,
                       PRIMARY KEY(Id),
                       FOREIGN KEY(Id_Orcamento) REFERENCES Orcamento(Id)
);

CREATE TABLE Avaliacao (
                           Id INTEGER NOT NULL AUTO_INCREMENT,
                           Id_Venda INTEGER NULL,
                           Titulo VARCHAR(250) NOT NULL,
                           Descricao VARCHAR(500) NOT NULL,
                           Data_Criacao DATE NOT NULL,
                           Nota DECIMAL(3, 1),
                           PRIMARY KEY(Id),
                           FOREIGN KEY(Id_Venda) REFERENCES Venda(Id)
);