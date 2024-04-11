DROP TABLE Pedidos;
DROP TABLE Clientes;

CREATE TABLE Clientes (
    id number PRIMARY KEY,
    nome varchar2(255),
    Cidade Varchar2(255)
);

CREATE TABLE Pedidos(
    id number primary key,
    cliente_id number,
    produto varchar2(255),
    FOREIGN KEY (cliente_id)
        REFERENCES Clientes(id)
);

INSERT ALL 
    INTO Clientes (id, nome, Cidade)
        VALUES(1, 'João', 'São Paulo')
   INTO Clientes (id, nome, Cidade) 
        VALUES(2, 'Maria', 'Rio de Janeiro')
    INTO Clientes (id, nome, Cidade) 
        VALUES(3, 'Carlos', 'Belo Horizonte')
    INTO Clientes (id, nome, Cidade) 
        VALUES(4, 'Ana', 'Porto Alegre')
    INTO Clientes (id, nome, Cidade) 
        VALUES(5, 'Rafel', 'Brasilia')
    SELECT * FROM DUAL;
    
INSERT ALL 
    INTO Pedidos VALUES(101,1,'Celular')
    INTO Pedidos VALUES(102,2,'Laptop')
    INTO Pedidos VALUES(103,3,'Tablet')
    INTO Pedidos VALUES(104,1,'TV')
    INTO Pedidos VALUES(105,4,'Geladeira')
    SELECT * FROM DUAL;
    
    INSERT INTO Pedidos (ID, Produto) VALUES (106, 'Notebook');
    
SELECT * FROM Pedidos;

SELECT * FROM Clientes;

-- CROSS JOIN (CRUZAMENTO DE DADOS)
SELECT * FROM Pedidos, Clientes;

-- Equi Join 
SELECT * FROM Pedidos, Clientes
WHERE pedidos.cliente_id = clientes.id;

-- APELIDOS EM TABELAS
    SELECT * FROM Pedidos P, Clientes C
    WHERE P.cliente_id = C.id;
    
-- INNER JOIN
SELECT C.nome, P.id
FROM Pedidos P INNER JOIN Clientes C
ON P.cliente_id = C.id;

-- LEFT JOIN
SELECT C.nome, P.id
FROM Pedidos P LEFT JOIN Clientes C
ON P.cliente_id = C.id;

-- RIGHT JOIN
SELECT C.nome, P.id
FROM Pedidos P RIGHT JOIN Clientes C
ON P.cliente_id = C.id;
