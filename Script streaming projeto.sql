DROP DATABASE IF EXISTS streaming_projeto;
CREATE DATABASE streaming_projeto;
USE streaming_projeto;

-- Criacao das tabelas:
CREATE TABLE USUARIO(
    ID INT PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
    TELEFONE VARCHAR(15),
    DATA_NASC DATE,
	SENHA VARCHAR(50)
);

--DROP TABLE USUARIO;
CREATE TABLE FILME(
	ID INT PRIMARY KEY IDENTITY(1,1),
	TITULO VARCHAR(50),
	SINOPSE VARCHAR(100),
	CLASSE_INDICATIVA CHAR(2),
	DIRETOR VARCHAR(50),
	IDIOMAS VARCHAR(50),
	LEGENDAS VARCHAR(50),
);

--DROP TABLE FILME;
CREATE TABLE SERIES(
	ID INT PRIMARY KEY IDENTITY(1,1),
	TITULO VARCHAR(50),
	SINOPSE VARCHAR(100),
	CLASSE_INDICATIVA VARCHAR(2),
	DIRETOR VARCHAR(50),
	IDIOMAS VARCHAR(50),
	LEGENDAS VARCHAR(50),
	EPISODIOS INT NOT NULL
);

--DROP TABLE SERIES;
CREATE TABLE PERFIL(
	ID INT PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(20),
	ID_USUARIO INT NOT NULL,
	ID_PLANO INT NOT NULL
);

--DROP TABLE PERFIL;
CREATE TABLE BOLETO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	COD_DE_BARRA VARCHAR(100),
	VENCIMENTO DATE,
	ID_USUARIO INT NOT NULL,
	ID_PAGAMENTO INT NOT NULL
);

--DROP TABLE BOLETO;
CREATE TABLE CARTAO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(100),
	NUMERO CHAR(19),
	CPF CHAR(14),
	ID_ENDERECO INT,
	CVC CHAR(3)
);

--DROP TABLE CARTAO;
CREATE TABLE FILME_GENERO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_FILME INT NOT NULL,
	ID_GENERO INT NOT NULL
);

--DROP TABLE FILME_GENERO;
CREATE TABLE SERIES_GENERO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_SERIES INT NOT NULL,
	ID_GENERO INT NOT NULL
);
--DROP TABLE SERIES_GENERO;
CREATE TABLE PLANOS(
	ID INT PRIMARY KEY IDENTITY(1,1),
	VALOR SMALLMONEY,
	QUANT_TELAS INT,
	ID_PAGAMENTO INT
);

--DROP TABLE PLANOS;
CREATE TABLE PAGAMENTO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_CARTAO INT NULL,
	PIX VARCHAR(50) NULL,
	VENCIMENTO DATE NULL,
	BOLETO VARCHAR(100) NULL,
	GIFT_CARD VARCHAR(20) NULL
);

--DROP TABLE PAGAMENTO;
CREATE TABLE ENDERECO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_USUARIO INT NOT NULL,
	LOGRADOURO VARCHAR(100),
	NUMERO VARCHAR(10),
	COMPLEMENTO VARCHAR(20),
	BAIRRO VARCHAR(20),
	CIDADE VARCHAR(20),
	ESTADO VARCHAR(20),
	PAIS VARCHAR(20),
	CEP VARCHAR(9)
);

--DROP TABLE ENDERECO;
CREATE TABLE GENERO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	TIPO VARCHAR(20)
);

--DROP TABLE GENERO;

-- Definicao de relaocao entre as tabelas:
ALTER TABLE ENDERECO
ADD CONSTRAINT FK_ID_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
ALTER TABLE PERFIL
ADD CONSTRAINT FK_ID_USUARIO_PERFIL FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
ALTER TABLE PERFIL
ADD CONSTRAINT FK_ID_PLANO FOREIGN KEY (ID_PLANO) REFERENCES PLANOS (ID)
ALTER TABLE BOLETO
ADD CONSTRAINT FK_ID_USUARIO_BOLETO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
ALTER TABLE BOLETO
ADD CONSTRAINT FK_ID_PAGAMENTO FOREIGN KEY (ID_PAGAMENTO) REFERENCES PAGAMENTO (ID)
ALTER TABLE CARTAO
ADD CONSTRAINT FK_ID_ENDERECO FOREIGN KEY (ID_ENDERECO) REFERENCES ENDERECO (ID)
ALTER TABLE FILME_GENERO
ADD CONSTRAINT FK_ID_FILME FOREIGN KEY (ID_FILME) REFERENCES FILME (ID)
ALTER TABLE FILME_GENERO
ADD CONSTRAINT FK_ID_GENERO_FILME FOREIGN KEY (ID_GENERO) REFERENCES GENERO (ID)
ALTER TABLE SERIES_GENERO
ADD CONSTRAINT FK_ID_SERIES FOREIGN KEY (ID_SERIES) REFERENCES SERIES (ID)
ALTER TABLE SERIES_GENERO
ADD CONSTRAINT FK_ID_GENERO_SERIE FOREIGN KEY (ID_GENERO) REFERENCES GENERO (ID)
ALTER TABLE PLANOS
ADD CONSTRAINT FK_ID_PAGAMENTO_PLANOS FOREIGN KEY (ID_PAGAMENTO) REFERENCES PAGAMENTO (ID)
ALTER TABLE PAGAMENTO
ADD CONSTRAINT FK_ID_CARTAO FOREIGN KEY (ID_CARTAO) REFERENCES CARTAO (ID)

-- Inserts divididos por tabela.

-- Usuarios:
-- Informacoes por ordem: NOME, E-MAIL, No?=MERO DE TELEFONE, DATA DE NASCIMENTO, SENHA
INSERT INTO USUARIO VALUES ('Lucas Zabrowsky', 'lucaszabro@gmail.com', '8399999-9999','1996-11-05', 'Aco')
INSERT INTO USUARIO VALUES ('Pedro Fernando', 'pedroarruda@gmail.com', '8398989-9794','1998-05-23', 'Ferro')
INSERT INTO USUARIO VALUES ('Joao Carlos', 'joaoc1994@gmail.com', '8399797-9797','1994-12-10', 'Titanio')
INSERT INTO USUARIO VALUES ('Glaucio Ferreira', 'glaucioferreira@gmail.com', '8399696-9996','1995-10-09', 'Cobalto')
INSERT INTO USUARIO VALUES ('Juriscleiton Silva', 'juriscleitonsilva@gmail.com', '8399595-9595','1999-08-13', 'Tungstenio')
SELECT * FROM USUARIO;

-- Filmes:
-- Informacoes por ordem: To?=TULO, SINOPSE, CLASSIFICAo?=o?=O INDICATIVA, DIRETOR, IDIOMAS, LEGENDAS
INSERT INTO FILME VALUES ('John Wick', 'Tiros, muitos tiros.', '18','Chad Stahelski', 'pt-BR;en-US', 'pt-BR')
INSERT INTO FILME VALUES ('Avatar', 'Uma galera gigante e azul.', '8','James Cameron', 'pt-BR;en-US', 'pt-BR')
INSERT INTO FILME VALUES ('Harry Potter', 'Bruxos magicos', '10','David Yates', 'pt-BR;en-US', 'pt-BR')
INSERT INTO FILME VALUES ('Pirates of The Caribbean', 'Piratas fedorentos e bo?=bados', '16','Espen Sandberg', 'pt-BR;en-US', 'pt-BR')
INSERT INTO FILME VALUES ('Star Wars', 'Guerras espaciais interplaneto?=rias', '12','Jorge Lucas', 'pt-BR;en-US', 'pt-BR')
SELECT * FROM FILME;

-- Series:
-- Informacoes por ordem: TITULO, SINOPSE, CLASSIFICACAO INDICATIVA, DIRETOR, IDIOMAS, LEGENDAS, EPISODIOS
--DBCC CHECKIDENT (SERIES, RESEED, 0)
INSERT INTO SERIES VALUES ('Vikings', 'A noruega e seus porradeiros a 500 anos atras.', '18','Martin Scorsese', 'pt-BR;en-US', 'pt-BR', 38)
INSERT INTO SERIES VALUES ('The Mandalorian', 'Aventuras baseadas em Star Wars.', '10','Jon Favreau', 'pt-BR;en-US', 'pt-BR', 30)
INSERT INTO SERIES VALUES ('The Walking Dead', 'Experimento deu errado e todo mundo virou zumbi.', '16','Greg Nicotero', 'pt-BR;en-US', 'pt-BR', 100)
INSERT INTO SERIES VALUES ('See', 'O mundo ficou cego.', '18','Francis Lawrence', 'pt-BR;en-US', 'pt-BR', 38)
INSERT INTO SERIES VALUES ('Snowpiercer', 'O mundo congelou e as pessoas vivem em um trem.', '16','Bong Joon-ho', 'pt-BR;en-US', 'pt-BR', 38)
SELECT * FROM SERIES;
--DELETE FROM SERIES;

-- Perfil:
-- Informacoes por ordem: NOME, ID_USUARIO, ID_PLANO
--DBCC CHECKIDENT (PERFIL, RESEED, 0)
INSERT INTO PERFIL VALUES ('Joana', 1, 1)
INSERT INTO PERFIL VALUES ('Joao', 1, 1)
INSERT INTO PERFIL VALUES ('Lucas', 1, 1)
INSERT INTO PERFIL VALUES ('Claudio', 2, 2)
INSERT INTO PERFIL VALUES ('Pedro', 2, 2)
INSERT INTO PERFIL VALUES ('Joao', 3, 3)
INSERT INTO PERFIL VALUES ('Luan', 4, 4)
INSERT INTO PERFIL VALUES ('Glaucio', 4, 4)
INSERT INTO PERFIL VALUES ('Thais', 5, 5)
INSERT INTO PERFIL VALUES ('Juriscleiton', 5, 5)
SELECT * FROM PERFIL;
--DELETE FROM PERFIL;

-- Boleto:
-- Informacoes por ordem: COD_DE_BARRA, VENCIMENTO, ID_USUARIO, ID_PAGAMENTO
INSERT INTO BOLETO VALUES ('9827103456702', '12/31/2023', 5,1)
INSERT INTO BOLETO VALUES ('7634285189004', '12/31/2023', 4,2)
INSERT INTO BOLETO VALUES ('1156439876543', '12/31/2023', 3,3)
INSERT INTO BOLETO VALUES ('8890123456789', '12/31/2023', 2,4)
INSERT INTO BOLETO VALUES ('2210867530901', '12/31/2023', 1,5)
SELECT * FROM BOLETO;

-- Cartao:
-- Informacoes por ordem: NOME, NUMERO, CPF, ID_ENDERECO, CVC
INSERT INTO CARTAO VALUES ('Lucas Zabrowsky F N da Silva', '4949-1070-6454-4654', '194.464.478-20', 1, '959')
INSERT INTO CARTAO VALUES ('Lucas Z F N da Silva', '2989-1970-6854-4694', '194.464.478-20', 1, '780')
INSERT INTO CARTAO VALUES ('Pedro Fernando S V Santos', '3759-5485-7518-7859', '846.735.875-50', 2, '818')
INSERT INTO CARTAO VALUES ('Joao Carlos O R Malheios', '9548-2674-5894-9877', '637.357.950-25', 3, '874')
INSERT INTO CARTAO VALUES ('Glaucio Ferreira R F', '3546-8644-4684-1548', '942.753.573-60', 4, '489')
INSERT INTO CARTAO VALUES ('Juriscleiton Silva F R', '7566-5834-8464-1563', '987.733.495-70', 5, '644')
SELECT * FROM CARTAO;

-- Filmes Genero:
-- Informacoes por ordem: ID_FILME, ID_GENERO
INSERT INTO FILME_GENERO VALUES (1, 1)
INSERT INTO FILME_GENERO VALUES (1, 2)
INSERT INTO FILME_GENERO VALUES (2, 1)
INSERT INTO FILME_GENERO VALUES (2, 2)
INSERT INTO FILME_GENERO VALUES (3, 1)
INSERT INTO FILME_GENERO VALUES (3, 2)
INSERT INTO FILME_GENERO VALUES (4, 1)
INSERT INTO FILME_GENERO VALUES (4, 2)
INSERT INTO FILME_GENERO VALUES (4, 5)
INSERT INTO FILME_GENERO VALUES (5, 1)
INSERT INTO FILME_GENERO VALUES (5, 2)
SELECT * FROM FILME_GENERO;

-- Soeries genero:
-- Informacoes por ordem: ID_SERIES, ID_GENERO
INSERT INTO SERIES_GENERO VALUES (1, 1)
INSERT INTO SERIES_GENERO VALUES (1, 2)
INSERT INTO SERIES_GENERO VALUES (2, 1)
INSERT INTO SERIES_GENERO VALUES (2, 2)
INSERT INTO SERIES_GENERO VALUES (2, 3)
INSERT INTO SERIES_GENERO VALUES (2, 4)
INSERT INTO SERIES_GENERO VALUES (3, 1)
INSERT INTO SERIES_GENERO VALUES (3, 2)
INSERT INTO SERIES_GENERO VALUES (3, 5)
INSERT INTO SERIES_GENERO VALUES (4, 1)
INSERT INTO SERIES_GENERO VALUES (4, 2)
INSERT INTO SERIES_GENERO VALUES (5, 1)
INSERT INTO SERIES_GENERO VALUES (5, 2)
INSERT INTO SERIES_GENERO VALUES (5, 3)
SELECT * FROM SERIES_GENERO;

-- Planos:
-- Informacoes por ordem: VALOR, QUANT_TELAS, ID_PAGAMENTO
--DBCC CHECKIDENT (PLANOS, RESEED, 0)
INSERT INTO PLANOS VALUES ('8.000', 2, 1)
INSERT INTO PLANOS VALUES ('10.000', 3, 2)
INSERT INTO PLANOS VALUES ('15.000', 4, 3)
INSERT INTO PLANOS VALUES ('20.000', 5, 4)
INSERT INTO PLANOS VALUES ('25.000', 6, 5)
SELECT * FROM PLANOS;
--DELETE FROM PLANOS;

-- Pagamento:
-- Informacoes por ordem: ID_CARTAO, PIX, VENCIMENTO, BOLETO, GIFT_CARD
INSERT INTO PAGAMENTO (ID_CARTAO, PIX, Vencimento) VALUES (1, '194.464.478-20', '12/31/2023')
INSERT INTO PAGAMENTO (ID_CARTAO, PIX, Vencimento) VALUES (2, '846.735.875-50', '12/31/2023')
INSERT INTO PAGAMENTO (ID_CARTAO, PIX, Vencimento) VALUES (3, '637.357.950-25', '12/31/2023')
INSERT INTO PAGAMENTO (ID_CARTAO, PIX, Vencimento) VALUES (4, '8399696-9996', '12/31/2023')
INSERT INTO PAGAMENTO (ID_CARTAO, PIX, Vencimento) VALUES (5, '8399595-9595', '12/31/2023')
SELECT * FROM PAGAMENTO;

-- Endereco:
-- Informacoes por ordem: ID_USUARIO, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, PAIS, CEP.
INSERT INTO ENDERECO VALUES (1, 'Av Cabo Branco', '58','Apt301', 'Cabo Branco', 'Joo?=o Pessoa', 'Parao?=ba', 'Brasil', '58040-111')
INSERT INTO ENDERECO VALUES (2, 'Rua Pombal', '600','Apt803', 'Manao?=ra', 'Joao Pessoa', 'Paraiba', 'Brasil', '58045-50')
INSERT INTO ENDERECO VALUES (3, 'Rua dos Estados', '50','Casa azul', 'Bairro Dos Estados', 'Joao Pessoa', 'Paraiba', 'Brasil', '58049-20')
INSERT INTO ENDERECO VALUES (4, 'Rua Celerino Paiva', 'NUMERO','Apt101', 'Tambau', 'Joao Pessoa', 'Parao?=ba', 'Brasil', '58095-10')
INSERT INTO ENDERECO VALUES (5, 'Rua Valdemar Chianca', 'NUMERO','Casa amarela', 'Bessa', 'Joo?=o Pessoa', 'Parao?=ba', 'Brasil', '58039-010')
SELECT * FROM ENDERECO;

-- Genero:
-- Informacoes por ordem: TIPO
INSERT INTO GENERO VALUES ('Acao')
INSERT INTO GENERO VALUES ('Aventura')
INSERT INTO GENERO VALUES ('Drama')
INSERT INTO GENERO VALUES ('Comedia')
INSERT INTO GENERO VALUES ('Terror')
SELECT * FROM GENERO; 