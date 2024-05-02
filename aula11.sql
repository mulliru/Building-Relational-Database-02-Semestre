-- ## CONSULTA ORDENADA ##
-- ASCENDENTE

-- TEXTO (A-Z)
SELECT * FROM MARCA ORDER BY ds_marca ASC;
-- NUMEROS (0-N)
SELECT * FROM MARCA ORDER BY id_marca ASC;
-- DATAS (Menor até a Maior)
SELECT * FROM MODELO ORDER BY ANO ASC;


-- DESCENDENTE 

-- TEXTO (Z até A)
SELECT * FROM MARCA ORDER BY ds_marca DESC;
-- NUMEROS (N-0)
SELECT * FROM MARCA ORDER BY id_marca DESC;
-- DATAS (Maior até a menor)
SELECT * FROM MODELO ORDER BY ANO DESC;

-- CONSULTA AGRUPADA

SELECT ds_modelo FROM MODELO;

-- consulta simples com group by
SELECT ds_modelo FROM MODELO GROUP BY ds_modelo;

-- consulta agrudapa com funções

-- avg - média de todos os veículos
select avg(valor) from modelo;

-- avg com group by - média de veículos por modelo
select avg(valor), ds_modelo from modelo group by ds_modelo;

-- avg com group by - média de veículos por cambio
select avg(valor), cambio from modelo group by cambio;

-- min - obter manor do conjunto

select min(valor) from modelo;

select min(valor), ds_modelo from modelo group by ds_modelo;


-- max - obter manor do conjunto

select max(valor) from modelo;

select max(valor), ds_modelo from modelo group by ds_modelo;

-- count: contagem de linhas
select count(valor) from modelo;

select count(valor), ds_modelo from modelo group by ds_modelo;


-- sum: somar os valores das linhas
select sum(valor) from modelo;

select sum(valor) valor, ds_modelo 
    from modelo 
    group by ds_modelo order by valor asc;
    
-- stdev: desvio padrão

select stddev(valor) from modelo;

select stddev(valor), ds_modelo from modelo group by ds_modelo;

-- HAVING
select AVG(valor), ds_modelo
    FROM modelo 
    group by ds_modelo
    having avg(valor)>20;
    
    
-- EXEMPLO INCORRETO: NÃO É POSSÍVEL CALCULAR A MEDIA ATRAVÉS DO WHERE
select AVG(valor), ds_modelo
    FROM modelo 
    group by ds_modelo
    WHERE avg(valor)>20;    
  
 -- UTILIZANDO APENAS WHERE 
 -- select * from modelo;
 
 select AVG(valor), ds_modelo
    FROM modelo 
    WHERE id_modelo<=5
    group by ds_modelo ;  
    
 -- UTILIZANDO WHERE E HAVING
 
 
 select AVG(valor), ds_modelo
    FROM modelo 
    WHERE id_modelo<=5
    group by ds_modelo       
    having avg(valor)<36