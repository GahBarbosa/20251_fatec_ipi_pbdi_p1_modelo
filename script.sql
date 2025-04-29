-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui

CREATE TABLE STUDENTS(
ID SERIAL PRIMARY KEY, 
MOTHER_EDU INT,
FATHER_EDU INT,
SALARY INT,
GRADE INT,
PREP_STUDY INT,
PREP_EXAM INT
);
-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
    ref REfCURSOR;
    counter INT;
BEGIN
    OPEN ref FOR
        SELECT count(id) as counter
        FROM  students
        WHERE (father_edu = 6 OR mother_edu = 6)
           AND grade >= 3;
    FETCH ref into counter;
    RAISE NOTICE '%', counter;
    

    CLOSE ref;
END $$;

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------