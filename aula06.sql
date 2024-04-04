-- Criando um Banco de Dados
CREATE DATABASE FIAP;

-- É necessário mencionar o nome do banco de dados (BD) para ser utilizado
-- utilize o USE ou mencione o nome do BD antes do nome da tabela
-- clicando duas vezes no nome do BD, o MySQL irá selecionar o BD
use fiap;

CREATE TABLE ALUNO (
	ra int primary key,
    nm_aluno varchar(100),
    dt_nascimento date,
    st_aluno char(1) CHECK(st_aluno IN('A','I'))
);

-- Removendo a Tabela
DROP TABLE ALUNO;


-- não procedural (É inserido dados em todas as colunas, que seguem a ordem da criação)
INSERT INTO ALUNO VALUES(1,'Francisco','2000-07-01','A');

-- procedural (É inserido dados nas colunas mencionadas)
INSERT INTO ALUNO (ra,nm_aluno) VALUES (2,'Douglas');

-- consulta simples (Não Procedural) 
SELECT * FROM ALUNO;

-- não procedural (atualiza os dados em todas as linhas de uma determinada coluna)
 UPDATE ALUNO set nm_aluno='João' ;
 
-- procedural (atualiza os dados em algumas linhas de uma determinada coluna)
UPDATE ALUNO set nm_aluno='João Lima' WHERE ra=1;


-- CENÁRIOS DE ERRO COM INSERT
-- 1: COLUNAS A MENOS (ERROR CODE 1136)
INSERT INTO ALUNO VALUES(1,'Francisco','2000-07-01');

-- 2: CHAVE PRIMÁRIA DUPLICADA (ERROR CODE 1062)
INSERT INTO ALUNO VALUES(1,'Francisco','2000-07-01','A');

-- 3: CONSTRAINT CHECK NÃO ATENDE O VALOR PADRÃO (ERROR CODE 4025)
INSERT INTO ALUNO VALUES(1,'Francisco','2000-07-01','S');

-- 4: TIPO DE DADO INCORRETO PARA A COLUNA (ERROR CODE: 1054 E 1366)
INSERT INTO ALUNO VALUES(1,Francisco,'2000-07-01','A');
INSERT INTO ALUNO VALUES('A3','Francisco','2000-07-01','A');

-- auto increment: é um contador automático de numerais em inteiro
CREATE TABLE CONTATO (
	 id_contato int primary key auto_increment,
     ddd int not null,
     nr_telefone int not null,
     ra int ,
     foreign key (ra) REFERENCES ALUNO(ra)
);
-- drop table contato;

INSERT INTO CONTATO VALUES (null, 11,12501122,1);

SELECT * FROM CONTATO;	

-- CENÁRIOS INCORRETOS
-- Coluna com valor vazio (1048) - em razão do NOT NULL
INSERT INTO CONTATO VALUES (null, null,12501122,1);

--
INSERT INTO CONTATO VALUES (null, 11,12501122,5);
