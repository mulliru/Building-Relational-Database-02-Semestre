
DROP TABLE T_UNIV_ALUNO
DROP TABLE T_UNV_CURSO
DROP TABLE T_UNV_PROFESSOR
DROP TABLE T_UNIV_DISCIPLINA

CREATE TABLE T_UNIV_ALUNO(  
    id_aluno  INTEGER PRIMARY KEY NOT NULL,
    nm_aluno VARCHAR(100) NOT NULL,
    dt_nascimento DATE,
    cpf int (11) NOT NULL unique,                              --Int para deixar como númerico e sem nenhum ponto ou virgula e unique porque ninguém tem cpf igual
    sexo CHAR (1) check(sexo='M' or sexo='F' or sexo='I')
);

CREATE TABLE T_UNV_CURSO(
    id_curso INTEGER PRIMARY KEY NOT NULL,
    nm_curso VARCHAR(100) NOT NULL
);
    
CREATE TABLE  T_UNV_PROFESSOR(
    id_aluno INTEGER PRIMARY KEY NOT NULL,
    nm_professor VARCHAR(200)
);

CREATE TABLE T_UNIV_DISCIPLINA(
    id_disciplina intEGER PRIMARY KEY NOT NULL,
    nm_disciplina VARCHAR(155) NOT NULL,
    ementa VARCHAR (155),
    red_bibliografica VARCHAR (155) NOT NULL,
    metodologia VARCHAR (155), 
    carga_horaria INTEGER CHECK(carga_horaria> 0 AND carga_horaria < 200),
    modalidade CHAR (1) CHECK(modalidade IN ('P','R') ) --P DE PRESENCIAL  E O  R DE REMOTO 
    id_curso_FK INTEGER REFERENCES T_UNV_CURSO (id_curso) -- Chave estrangéria sendo pega da tabela curso, estamos pegando o "ID CURSO"
);

CREATE TABLE T_UNIV_PROFESSOR_DISCIPLINA(
    id_profe_FK VARCHAR(100) REFERENCES T_UNIV_PROFESSOR (id_produto)-- Chave estrangéria sendo pega da tabela professor, estamos pegando o "ID professor"
    id_disciplina_FK intEGER REFERENCES T_UNIV_DISCIPLINA
);
