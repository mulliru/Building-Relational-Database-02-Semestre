
-- LOCADORA 
-- 1 MARCA PODE N MODELOS

-- SEQUENCE (OU SEQUENCIA)
-- CONTADORES AUTOMÁTICOS
CREATE SEQUENCE SEQ_MARCA;
CREATE SEQUENCE SEQ_MODELO;

-- NEXTVAL: PRÓXIMO VALOR
-- CURRVAL: É O VALOR ATUAL

-- DEFAULT é a definição de um valor padrão a ser inserido - caso não seja mencionado no insert
CREATE TABLE MARCA (
    id_marca int DEFAULT SEQ_MARCA.nextval primary key,
    ds_marca varchar(100) not null
);

CREATE TABLE MODELO(
  id_modelo int DEFAULT SEQ_MODELO.nextval primary key,
  ds_modelo varchar(100) not null,
  cor varchar(30),
  ano date,
  cambio varchar(10) CHECK(cambio IN('AUT','MANUAL','SEMI-AUT')),
  categoria varchar(10) CHECK(categoria IN('HATCH','SEDAN','SUV')),
  id_marca int REFERENCES MARCA(id_marca)
);


INSERT INTO MARCA (ds_marca) VALUES ('FIAT');
INSERT INTO MARCA (ds_marca) VALUES ('FORD');
INSERT INTO MARCA (ds_marca) VALUES ('JEEP');

SELECT * FROM MARCA;
SELECT SEQ_MODELO.CURRVAL FROM DUAL;

INSERT INTO MODELO(ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES('UNO','VERDE',to_date('2010','YYYY'), 'MANUAL', 'HATCH',1);
        
INSERT  INTO MODELO(ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES('SIENA','VERMELHO',to_date('2015','YYYY'), 'MANUAL', 'SEDAN',1);

INSERT INTO MODELO(ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES('KA','PRETO',to_date('2018','YYYY'), 'MANUAL', 'HATCH',2);
        
INSERT INTO MODELO(ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES('ECOSPORT','CINZA',to_date('2024','YYYY'), 'AUT', 'SUV',2);

SELECT * FROM MODELO;

-- NÃO EXISTE ESSA MARCA PARA O VEICULO
INSERT INTO MODELO(ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES('C4','CINZA',to_date('2024','YYYY'), 'AUT', 'SUV',4);

INSERT INTO MODELO(id_modelo,ds_modelo, cor, ano, cambio,categoria, id_marca) 
        VALUES(null,'FUSCA','CINZA',to_date('1978','YYYY'), 'AUT', 'SUV',4);


-- ATUALIZAÇÃO NA FK

UPDATE MODELO SET id_marca=4 WHERE id_modelo=5 or id_modelo=6;

-- CROSS JOIN
-- NÃO ESTÁ REALIZANDO JUNÇÃO, APENAS CRUZAMENTO DOS DADOS
SELECT * FROM MARCA, MODELO;

-- EQUI JOIN
SELECT * FROM MARCA, MODELO
WHERE marca.id_marca = modelo.id_marca;

-- alias (ou apelido)
SELECT * FROM MARCA ma, MODELO md
WHERE ma.id_marca = md.id_marca;


delete from marca where id_marca =4;