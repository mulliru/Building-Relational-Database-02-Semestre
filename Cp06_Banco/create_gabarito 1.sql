'''
iNTEGRANTES DO GRUPO:
KEVEN IKE
PEDRO LUIZ PRADO
MURILLO FERREIRA RAMOS
'''

-- Drop table das tabelas criadas
DROP TABLE IF EXISTS T_RHSTU_AUTENTICA;
DROP TABLE IF EXISTS T_RHSTU_TIPO_CONTATO;
DROP TABLE IF EXISTS T_RHSTU_PACIENTE;
DROP TABLE IF EXISTS T_RHSTU_FUNCIONARIO;
DROP TABLE IF EXISTS T_RHSTU_UNID_HOSPITALAR;
DROP TABLE IF EXISTS T_RHSTU_CONSULTA;
DROP TABLE IF EXISTS T_RHSTU_CONTATO_PACIENTE;
DROP TABLE IF EXISTS T_RHSTU_ENDERECO_PACIENTE;
DROP TABLE IF EXISTS T_RHSTU_FORMA_PAGAMENTO;
DROP TABLE IF EXISTS T_RHSTU_FORMA_CONVENIO;
DROP TABLE IF EXISTS T_RHSTU_FORMA_PIX;
DROP TABLE IF EXISTS T_RHSTU_FOMRA_CARTAO;
DROP TABLE IF EXISTS T_RHSTU_EMAIL_PACIENTE;
DROP TABLE IF EXISTS T_RHSTU_TELEFONE_PACIENTE;
DROP TABLE IF EXISTS T_RHSTU_PLANO_SAUDE;
DROP TABLE IF EXISTS T_RHSTU_PACIENTE_PLANO_SAUDE;


CREATE TABLE T_RHSTU_AUTENTICA(
    id_autentica NUMERIC ,
    login varchar(100),
    senha varchar(100),
    st_login char(1) check(st_login in ('i', 'a')),
    CONSTRAINT T_RHSTU_AUTENTICA_PK PRIMARY KEY (id_autentica)
);

CREATE TABLE T_RHSTU_TIPO_CONTATO (
    id_tipo_contato NUMERIC(5) ,
    nm_tipo_contato VARCHAR(80) NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_TIPO_CONTATO_PK PRIMARY KEY (id_tipo_contato)
);



CREATE TABLE T_RHSTU_PACIENTE (
    id_paciente NUMERIC(9),
    nm_paciente VARCHAR(80) NOT NULL,
    nr_cpf NUMERIC(12) NOT NULL UNIQUE,
    nr_rg VARCHAR(15) UNIQUE,
    dt_nascimento DATE NOT NULL,
    fl_sexo CHAR(1) NOT NULL,
    ds_escolaridade VARCHAR(40) NOT NULL,
    ds_estado_civil VARCHAR(25) NOT NULL,
    tip_grupo_sanguineo VARCHAR(6) NOT NULL,
    nr_altura NUMERIC(3,2) NOT NULL,
    nr_peso NUMERIC(4,1) NOT NULL,
    id_autentica NUMERIC,
     CONSTRAINT T_RHSTU_PACIENTE_PK PRIMARY KEY (id_paciente), 
     CONSTRAINT T_RHSTU_PACIENTE_FK FOREIGN KEY (id_autentica)
         REFERENCES T_RHSTU_AUTENTICA(id_autentica)
);


CREATE TABLE T_RHSTU_FUNCIONARIO(
    id_funcionario NUMERIC,
    nm_funcionario varchar(255),
    fl_sexo char(1),
    ds_escolaridade varchar(40),
    dt_nascimento date,
    id_autentica NUMERIC NOT NULL, 
    CONSTRAINT T_RHSTU_FUNCIONARIO_FK FOREIGN KEY (id_autentica) 
            REFERENCES T_RHSTU_AUTENTICA(id_autentica),
    CONSTRAINT T_RHSTU_FUNCIONARIO_PK PRIMARY KEY (id_funcionario)
);




CREATE TABLE T_RHSTU_UNID_HOSPITALAR(
    id_unid_hospitalar NUMERIC(9),
    razao_social varchar(80) not null,
    nr_logradouro NUMERIC(7),
    ds_complemento_numero varchar(30),
    ds_ponto_referencia varchar(50),
    dt_cadastro date not null,
    st_unid_hospitalar varchar(10) check(st_unid_hospitalar in ('i', 'a')),
    CONSTRAINT T_RHSTU_UNID_HOSPITALAR_PK PRIMARY KEY (id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONSULTA(
    id_consulta NUMERIC ,
    dt_hr_consulta date not null,
    tp_unidade varchar(255) not null,
    tp_modalidade varchar(255),
    id_paciente NUMERIC(9)  not null,
    id_unid_hospitalar NUMERIC(9)  not null,
    tel_central varchar(14),
    CONSTRAINT T_RHSTU_CONSULTA_PK PRIMARY KEY (id_consulta),
    CONSTRAINT T_RHSTU_CONSULTA_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONSULTA_HOSPITLAR_FK FOREIGN KEY (id_unid_hospitalar) 
        REFERENCES T_RHSTU_UNID_HOSPITALAR(id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONTATO_PACIENTE (
    id_contato NUMERIC(9),
    id_paciente NUMERIC(9),
    id_tipo_contato NUMERIC(5)  NOT NULL,
    nm_contato VARCHAR(40) NOT NULL,
    nr_ddi NUMERIC(3),
    nr_ddd NUMERIC(3),
    nr_telefone NUMERIC(10),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_PK PRIMARY KEY(id_paciente, id_contato),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_TIPO_CONTATO_FK FOREIGN KEY (id_tipo_contato) 
        REFERENCES T_RHSTU_TIPO_CONTATO(id_tipo_contato) 
);

CREATE TABLE T_RHSTU_ENDERECO_PACIENTE (
    id_endereco NUMERIC(9),
    id_paciente NUMERIC(9) NOT NULL,
    nr_logradouro NUMERIC(7),
    ds_cidade VARCHAR(100),
    ds_complemento_numero VARCHAR(30),
    ds_ponto_referencia VARCHAR(50),
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_PK PRIMARY KEY( id_endereco),
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_FK FOREIGN KEY (id_paciente)
        REFERENCES T_RHSTU_PACIENTE(id_paciente)
);


-- CONTINUAR CORREÇÃO
CREATE TABLE T_RHSTU_FORMA_PAGAMENTO(
    id_forma_pagamento numeric PRIMARY KEY,
    vl_total numeric not null,
    st_forma_pagamento char(1) not null check(st_forma_pagamento in('i', 'a')),
    id_consulta numeric  REFERENCES T_RHSTU_CONSULTA(id_consulta) not null
);

CREATE TABLE  T_RHSTU_FORMA_CONVENIO(
    id_forma_convenio numeric(9) primary key,
    nr_carteira numeric(10),
    nr_trasacao numeric(10),
    dt_trasacao date,
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FORMA_PIX(
    id_forma_pix numeric(9)  primary key,
    nr_transacao numeric(10),
    dt_transacao date,
    tp_chave varchar(60),
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FOMRA_CARTAO(
    id_forma_cartao numeric(9)  primary key,
    nr_cartao numeric(36),
    nr_transacao numeric(10),
    dt_transacao date,
    tp_bandeira varchar(60),
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_EMAIL_PACIENTE(
    id_email numeric(9) primary key,
    id_paciente numeric(9) not null,
    ds_email varchar(100) not null,
    tp_email varchar(20) not null,
    st_email char(1) not null check(st_email in ('i', 'a')),

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);

CREATE TABLE T_RHSTU_TELEFONE_PACIENTE(
    id_paciente numeric(9),
    id_telefone numeric(9),
    nr_ddi numeric(3) not null,
    nr_ddd numeric(3) not null,
    nr_telefone numeric(10) not null,
    tp_telefone varchar(20) not null,
    st_telefone char(1) not null check(st_telefone in ('i', 'a')),

    primary key(id_paciente, id_telefone),
    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);
    
CREATE TABLE T_RHSTU_PLANO_SAUDE(
    id_plano_saude numeric(5) primary key NOT NULL,
    ds_razao_social varchar(70) not null,
    nm_fantasia_plano_saude varchar(80),
    ds_plano_saude varchar(100) not null,
    nr_cnpj numeric(14) not null,
    nm_contato varchar(30),
    ds_telefone varchar(30),
    dt_inicio date not null,
    dt_fim date
);

CREATE TABLE T_RHSTU_PACIENTE_PLANO_SAUDE(
    id_paciente_ps numeric(10) primary key,
    id_paciente numeric(9) not null ,
    id_plano_saude numeric(5) not null,
    nr_carteira_ps numeric(15),       
    dt_inicio date not null,
    dt_fim date,

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente),
    FOREIGN KEY (id_plano_saude) REFERENCES T_RHSTU_PLANO_SAUDE(id_plano_saude)
);

'''
• REQUIRIDO:
• Duas Inserções de dados em cada Tabela ; 
• Uma Remoção de dados em cada Tabela utilizando o WHERE;
• Uma Atualização Simples para a Tabela T_RHSTU_ENDERECO_PACIENTE utilizando o WHERE; 
• Uma Atualização Simples para a Tabela T_RHSTU_TELEFONE_PACIENTE utilizando o WHERE; 
• Uma Consulta Simples em cada Tabela;
• Duas Consulta Simples utilizando o WHERE (tabela à escolha do grupo)
• Uma Consulta de Junção para a Tabela T_RHSTU_CONSULTA e suas dependências
• Uma Consulta de Junção para a Tabela T_RHSTU_PACIENTES e suas dependências
'''

-- INSERÇÕES DE DADOS em cada Tabela

-- Inserção em T_RHSTU_AUTENTICA
insert into T_RHSTU_AUTENTICA values (1, 'kevenike', '123456', 'i');
insert into T_RHSTU_AUTENTICA values (2, 'pedroprado', '123456', 'i');

-- Inserção em T_RHSTU_TIPO_CONTATO
insert into T_RHSTU_TIPO_CONTATO values (1, 'Celular', '2021-01-01', null);
insert into T_RHSTU_TIPO_CONTATO values (2, 'Residencial', '2021-01-01', null);

-- Inserção em T_RHSTU_PACIENTE
insert into T_RHSTU_PACIENTE values (1, 'Keven Ike', 12345678901, '123456', '1999-01-01', 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.75, 70.0, 1);
insert into T_RHSTU_PACIENTE values (2, 'Pedro Prado', 12345678902, '123457', '1999-01-01', 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.63, 70.0, 2);

-- Inserção em T_RHSTU_FUNCIONARIO
insert into T_RHSTU_FUNCIONARIO values (1, 'Lucas Alcantara', 'M', 'Ensino Superior', '1999-01-01', 1);
insert into T_RHSTU_FUNCIONARIO values (2, 'Larissa Lopes', 'F', 'Ensino Superior', '2005-07-01', 2);

-- Inserção em T_RHSTU_UNID_HOSPITALAR
insert into T_RHSTU_UNID_HOSPITALAR values (1, 'Hospital São Lucas', 123, 'Bloco A', 'Próximo ao Shopping', '2021-01-01', 'i');
insert into T_RHSTU_UNID_HOSPITALAR values (2, 'Hospital Santa Casa', 456, 'Bloco B', 'Próximo ao Mercado', '2021-01-01', 'i');

-- Inserção em T_RHSTU_CONSULTA
insert into T_RHSTU_CONSULTA values (1, '2021-01-01', 'Consulta', 'Presencial', 1, 1, '1234567890');
insert into T_RHSTU_CONSULTA values (2, '2021-01-01', 'Consulta', 'Presencial', 2, 2, '1234567890');

-- Inserção em T_RHSTU_CONTATO_PACIENTE
insert into T_RHSTU_CONTATO_PACIENTE values (1, 1, 1, '11987654321', 55, 11, 987654321);
insert into T_RHSTU_CONTATO_PACIENTE values (2, 2, 2, '1133334444', 55, 11, 33334444);

-- Inserção em T_RHSTU_ENDERECO_PACIENTE
insert into T_RHSTU_ENDERECO_PACIENTE values (1, 1, 123, 'São Paulo', 'Bloco A', 'Próximo ao Shopping', '2021-01-01', null);
insert into T_RHSTU_ENDERECO_PACIENTE values (2, 2, 456, 'São Paulo', 'Bloco B', 'Próximo ao Mercado', '2021-01-01', null);

-- Inserção em T_RHSTU_FORMA_PAGAMENTO
insert into T_RHSTU_FORMA_PAGAMENTO values (1, 100.00, 'i', 1);
insert into T_RHSTU_FORMA_PAGAMENTO values (2, 200.00, 'i', 2);

-- Inserção em T_RHSTU_FORMA_CONVENIO
insert into T_RHSTU_FORMA_CONVENIO values (1, 1234567890, 1234567890, '2021-01-01', '2021-01-01', 1);
insert into T_RHSTU_FORMA_CONVENIO values (2, 1234567890, 1234567890, '2021-01-01', '2021-01-01', 2);

-- Inserção em T_RHSTU_FORMA_PIX
insert into T_RHSTU_FORMA_PIX values (1, 1234567890, '2021-01-01', 'chave1', 1);
insert into T_RHSTU_FORMA_PIX values (2, 1234567890, '2021-01-01', 'chave2', 2);

-- Inserção em T_RHSTU_PLANO_SAUDE
insert into T_RHSTU_PLANO_SAUDE values (1, 'Unimed', 'Unimed', 'Unimed', 12345678901234, 'Unimed', 'Unimed', '2021-01-01', null);
insert into T_RHSTU_PLANO_SAUDE values (2, 'Amil', 'Amil', 'Amil', 12345678901234, 'Amil', 'Amil', '2021-01-01', null);

-- Inserção em T_RHSTU_PACIENTE_PLANO_SAUDE
insert into T_RHSTU_PACIENTE_PLANO_SAUDE values (1, 1, 1, 123456789012345, '2021-01-01', null);
insert into T_RHSTU_PACIENTE_PLANO_SAUDE values (2, 2, 2, 123456789012345, '2021-01-01', null);

-- REMOÇÃO DE DADOS em cada Tabela utilizando o WHERE

-- Remoção de Dados em T_RHSTU_AUTENTICA
delete from T_RHSTU_AUTENTICA where id_autentica = 2;

-- Remoção de Dados em T_RHSTU_TIPO_CONTATO
delete from T_RHSTU_TIPO_CONTATO where id_tipo_contato = 2;

-- Remoção de Dados em T_RHSTU_PACIENTE
delete from T_RHSTU_PACIENTE where id_paciente = 2;

-- Remoção de Dados em T_RHSTU_FUNCIONARIO
delete from T_RHSTU_FUNCIONARIO where id_funcionario = 2;

-- Remoção de Dados em T_RHSTU_UNID_HOSPITALAR
delete from T_RHSTU_UNID_HOSPITALAR where id_unid_hospitalar = 2;

-- Remoção de Dados em T_RHSTU_CONSULTA
delete from T_RHSTU_CONSULTA where id_consulta = 2;

-- Remoção de Dados em T_RHSTU_CONTATO_PACIENTE
delete from T_RHSTU_CONTATO_PACIENTE where id_contato = 2;

-- Remoção de Dados em T_RHSTU_ENDERECO_PACIENTE
delete from T_RHSTU_ENDERECO_PACIENTE where id_endereco = 2;

-- Remoção de Dados em T_RHSTU_FORMA_PAGAMENTO
delete from T_RHSTU_FORMA_PAGAMENTO where id_forma_pagamento = 2;

-- Remoção de Dados em T_RHSTU_FORMA_CONVENIO
delete from T_RHSTU_FORMA_CONVENIO where id_forma_convenio = 2;

-- Remoção de Dados em T_RHSTU_FORMA_PIX
delete from T_RHSTU_FORMA_PIX where id_forma_pix = 2;

-- Remoção de Dados em T_RHSTU_PLANO_SAUDE
delete from T_RHSTU_PLANO_SAUDE where id_plano_saude = 2;

-- Remoção de Dados em T_RHSTU_PACIENTE_PLANO_SAUDE
delete from T_RHSTU_PACIENTE_PLANO_SAUDE where id_paciente_ps = 2;

-- ATUALIZAÇÃO SIMPLES para a Tabela T_RHSTU_ENDERECO_PACIENTE utilizando o WHERE
update T_RHSTU_ENDERECO_PACIENTE set ds_cidade = 'São Paulo' where id_endereco = 1;

-- ATUALIZAÇÃO SIMPLES para a Tabela T_RHSTU_TELEFONE_PACIENTE utilizando o WHERE
update T_RHSTU_TELEFONE_PACIENTE set nr_telefone = 11987654321 where id_paciente = 1;

-- CONSULTA SIMPLES em cada Tabela

-- Consulta em T_RHSTU_AUTENTICA
select * from T_RHSTU_AUTENTICA;

-- Consulta em T_RHSTU_TIPO_CONTATO
select * from T_RHSTU_TIPO_CONTATO;

-- Consulta em T_RHSTU_PACIENTE
select * from T_RHSTU_PACIENTE;

-- Consulta em T_RHSTU_FUNCIONARIO
select * from T_RHSTU_FUNCIONARIO;

-- Consulta em T_RHSTU_UNID_HOSPITALAR
select * from T_RHSTU_UNID_HOSPITALAR;

-- Consulta em T_RHSTU_CONSULTA
select * from T_RHSTU_CONSULTA;

-- Consulta em T_RHSTU_CONTATO_PACIENTE
select * from T_RHSTU_CONTATO_PACIENTE;

-- Consulta em T_RHSTU_ENDERECO_PACIENTE
select * from T_RHSTU_ENDERECO_PACIENTE;

-- Consulta em T_RHSTU_FORMA_PAGAMENTO
select * from T_RHSTU_FORMA_PAGAMENTO;

-- Consulta em T_RHSTU_FORMA_CONVENIO
select * from T_RHSTU_FORMA_CONVENIO;

-- Consulta em T_RHSTU_FORMA_PIX
select * from T_RHSTU_FORMA_PIX;

-- Consulta em T_RHSTU_PLANO_SAUDE
select * from T_RHSTU_PLANO_SAUDE;

-- Consulta em T_RHSTU_PACIENTE_PLANO_SAUDE
select * from T_RHSTU_PACIENTE_PLANO_SAUDE;

-- Duas Consultas utilizando o WHERE (tabela à escolha do grupo)

-- Consulta em T_RHSTU_PLANO_SAUDE utilizando o WHERE
select * from T_RHSTU_PLANO_SAUDE where id_plano_saude = 1;

-- Consulta em T_RHSTU_FORMA_PAGAMENTO utilizando o WHERE
 select * from T_RHSTU_FORMA_PAGAMENTO where id_forma_pagamento = 1;

 -- Uma Consulta de Junção para a Tabela T_RHSTU_CONSULTA e suas dependências
 select * from T_RHSTU_CONSULTA C 
 left join T_RHSTU_PACIENTE P on C.id_paciente = P.id_paciente
 left join T_RHSTU_UNID_HOSPITALAR UH on C.id_unid_hospitalar = UH.id_unid_hospitalar;

-- Uma Consulta de Junção para a Tabela T_RHSTU_PACIENTES e suas dependências
select * from T_RHSTU_PACIENTE P
left join T_RHSTU_CONTATO_PACIENTE CP on P.id_paciente = CP.id_paciente
left join T_RHSTU_ENDERECO_PACIENTE EP on P.id_paciente = EP.id_paciente;














