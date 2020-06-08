CREATE DATABASE aulacursores
GO
USE aulacursores
GO
DROP TABLE curso
DROP TABLE disciplinas
DROP TABLE disciplina_curso
CREATE TABLE curso
(
codigo				INT,
nome				VARCHAR(250),
duracao				INT,
PRIMARY KEY (codigo)
)
GO
CREATE TABLE disciplinas
(
codigo				INT,
nome				VARCHAR(250),
carga_horaria		INT,
PRIMARY KEY (codigo)
)
GO
CREATE TABLE disciplina_curso
(
codigo_disciplina		INT,
codigo_curso			INT,
CONSTRAINT pk_disccurso PRIMARY KEY (codigo_disciplina, codigo_curso),
FOREIGN KEY (codigo_disciplina) REFERENCES disciplinas(codigo),
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo)
)

CREATE FUNCTION fn_infocurso(@cod_curso INT)
RETURNS @tabela TABLE
(
cod_disc			INT,
nome_disc			VARCHAR(250),
carga_horaria_disc	INT,
nome_curso			VARCHAR(250)
)
BEGIN
	DECLARE @cod_disciplina			INT,
			@cod_cur				INT,
			@nome_discip			VARCHAR(250),
			@carga_horaria			INT,
			@nome_curs				VARCHAR(250)
	DECLARE curs_curso CURSOR FOR SELECT DISTINCT codigo_disciplina, codigo_disciplina FROM disciplina_curso WHERE codigo_curso = @cod_curso
	OPEN curs_curso
	FETCH NEXT FROM curs_curso INTO @cod_disciplina, @cod_cur
	SELECT @nome_curs = cs.nome FROM disciplina_curso dc INNER JOIN curso cs ON dc.codigo_curso = cs.codigo WHERE dc.codigo_curso = @cod_curso
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT @nome_discip = disc.nome , @carga_horaria = disc.carga_horaria 
		FROM disciplina_curso dc INNER JOIN	disciplinas disc ON disc.codigo = dc.codigo_disciplina 
		INNER JOIN curso curs ON curs.codigo = dc.codigo_curso WHERE disc.codigo = @cod_disciplina
		INSERT INTO @tabela VALUES
		(@cod_disciplina, @nome_discip, @carga_horaria, @nome_curs)
		FETCH NEXT FROM curs_curso INTO @cod_disciplina, @cod_cur
	END
	CLOSE curs_curso
	DEALLOCATE curs_curso
	RETURN
END

SELECT * FROM fn_infocurso(4)
SELECT * FROM curso
SELECT * FROM disciplinas
SELECT * FROM disciplina_curso
insert into curso Values
 (0,'ADS',2880),
 (1,'Logistica',2880),
 (2,'Polímeros',2880),
 (3,'Comércio Exterior',2600),
 (4,'Gestão Empresarial',2600)
 insert into disciplinas Values
(1,'Algoritmos',80),
(2,'Administração',80),
(3,'Laboratório de Hardware',40),
(4,'Pesquisa Operacional',80),
(5,'Física I',80),
(6,'Físico Química',80),
(7,'Comércio Exterior',80),
(8,'Fundamentos de Marketing',80),
(9,'Informática',40),
(10,'Sistemas de Informação',80)
 insert into disciplina_curso Values
 (1,0),
 (2,0),
 (2,1),
 (2,3),
 (2,4),
 (3,0),
 (4,1),
 (5,2),
  (6,2),
 (7,1),
 (7,3),
 (8,1),
 (8,4),
(9,1),
 (9,3),
 (10,0),
 (10,4)