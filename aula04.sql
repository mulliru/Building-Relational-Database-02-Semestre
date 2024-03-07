-- AULA 03

CREATE TABLE T_UNV_ALUNO (
    id_aluno integer primary key,
    nm_aluno varchar2(100) not null,
    dt_nascimento date,
    cpf varchar2(15) not null,
    sexo char(1) check (sexo='f' OR sexo='m' OR sexo='i')
);
-- APAGAR A TABELA 
--DROP TABLE T_UNV_ALUNO;

CREATE TABLE T_UNV_PROFESSOR(
  id_professor integer primary key,
  nm_professor varchar2(100) not null
);

CREATE TABLE T_UNV_CURSO(
    id_curso integer primary key,
    nm_curso varchar2(100) not null
);

CREATE TABLE T_UNV_TURMA (
     id_turma integer primary key,
     data_criacao date not null,
     nm_turma varchar2(100) not null,
     situacao char(1) CHECK (situacao='A' OR situacao='I'),
     id_curso integer,
     foreign key (id_curso) REFERENCES T_UNV_CURSO(id_curso)
);

CREATE TABLE T_UNV_DISCIPLINA(
    id_disciplina integer primary key,
    nm_disicplina varchar2(155) not null,
    ementa varchar2(155),
    ref_bibliografica varchar2(155) not null,
    metodologia varchar2(155) not null,
    carga_horaria integer CHECK(carga_horaria>0 AND carga_horaria<200 ),
    modalidade varchar2(155) CHECK(modalidade IN('REMOTO', 'PRESENCIAL', 'SEMI-PRESENCIAL')),
    id_curso integer,
    foreign key (id_curso) references T_UNV_CURSO (id_curso)
);

ALTER TABLE T_UNV_ALUNO
    ADD situacao CHAR(1);
    
ALTER TABLE T_UNV_ALUNO
    ADD CONSTRAINT checar_aluno_sit CHECK(situacao='A' OR situacao='I');
    
Alter TABLE T_UNV_ALUNO
    MODIFY SITUACAO VARCHAR(1) NOT NULL;
    
RENAME T_UNV_ALUNO
    TO T_UNV_ESTUDANTE;
    
ALTER TABLE T_UNV_ESTUDANTE
    RENAME COLUMN SITUACAO TO STATUS;
    
ALTER TABLE T_UNV_ESTUDANTE
    ADD CONSTRAINT checar_aluno_status CHECK(status='A' OR status 'I');
