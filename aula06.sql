create database fiapo;
use fiapo; #para descrever que vamos usar usar a fiap como banco 
Drop table aluno; #apagar a tabela aluno

-- É necessario mencionar o nome do banco de dados (BD) para ser utilizado 

create table aluno(
	ra_aluno int primary key,
    nm_aluno varchar (100),
    dt_nascimento_aluno date,
    st_aluno char(1) check(st_aluno in("a","i"))
);

-- não procedural (é inserido dados em todas as colunas, que seguem a ordem da criação)
	insert into aluno values (1, "murillo", "2000-07-01","a" );
    
    -- procedural (é inserido dados nas colunas mencionadas)
    insert into aluno (ra_aluno,nm_aluno) values (2, 'Douglas');
    
    -- consulta simples (não procedural)
    select * from aluno ;
    
    -- não procedural (atualiza os dados em todas as linhas de uma determinada coluna)
    update aluno set nm_aluno='joão';
    
    -- procedural (atualiza os dados em alguumas linhas de uma determinada coluna)
    update aluno set nm_aluno= "joão lima" where ra_aluno=1;
    
    -- Cenario de erro com insert
    -- 1 colunas a menos (erro code 1136)
    insert into aluno values (1, "francisco", "2000-07-01");
    
    -- chave primaria duplicada (erro code 1062)
    insert into aluno values (1, "francisco", "2000-07-01");