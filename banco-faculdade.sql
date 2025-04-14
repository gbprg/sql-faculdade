-- Criação do banco de dados
CREATE DATABASE unifecaf;
USE unifecaf;

-- Tabela CURSO
CREATE TABLE CURSO (
    cod_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao_semestres INT NOT NULL,
    modalidade ENUM('Presencial', 'EAD', 'Híbrido') NOT NULL,
    coordenador INT NULL
);

-- Tabela PROFESSOR
CREATE TABLE PROFESSOR (
    cod_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    titulacao VARCHAR(50) NOT NULL
);

-- Adicionando a FK coordenador na tabela CURSO
ALTER TABLE CURSO
ADD CONSTRAINT fk_coordenador
FOREIGN KEY (coordenador) REFERENCES PROFESSOR(cod_professor);

-- Tabela ALUNO
CREATE TABLE ALUNO (
    cod_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    endereco TEXT NOT NULL,
    cod_curso INT NOT NULL,
    FOREIGN KEY (cod_curso) REFERENCES CURSO(cod_curso)
);

-- Tabela DISCIPLINA
CREATE TABLE DISCIPLINA (
    cod_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    cod_curso INT NOT NULL,
    FOREIGN KEY (cod_curso) REFERENCES CURSO(cod_curso)
);

-- Tabela TURMA
CREATE TABLE TURMA (
    cod_turma INT AUTO_INCREMENT PRIMARY KEY,
    cod_disciplina INT NOT NULL,
    cod_professor INT NOT NULL,
    horario VARCHAR(50) NOT NULL,
    sala VARCHAR(20) NOT NULL,
    semestre INT NOT NULL,
    ano INT NOT NULL,
    FOREIGN KEY (cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina),
    FOREIGN KEY (cod_professor) REFERENCES PROFESSOR(cod_professor)
);

-- Tabela MATRICULA
CREATE TABLE MATRICULA (
    cod_matricula INT AUTO_INCREMENT PRIMARY KEY,
    cod_aluno INT NOT NULL,
    cod_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    status ENUM('Ativa', 'Trancada', 'Cancelada', 'Concluída') DEFAULT 'Ativa',
    FOREIGN KEY (cod_aluno) REFERENCES ALUNO(cod_aluno),
    FOREIGN KEY (cod_turma) REFERENCES TURMA(cod_turma),
    UNIQUE KEY (cod_aluno, cod_turma)
);

-- Tabela NOTA
CREATE TABLE NOTA (
    cod_nota INT AUTO_INCREMENT PRIMARY KEY,
    cod_matricula INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL,
    tipo_avaliacao VARCHAR(50) NOT NULL,
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (cod_matricula) REFERENCES MATRICULA(cod_matricula)
);