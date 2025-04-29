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

DO $$
DECLARE
    ref refcursor;
   	counter INT;
BEGIN
    OPEN ref FOR
        SELECT count(id) as counter
        FROM  students
        WHERE prep_study = 1
          AND grade >= 3; 
    FETCH ref into counter;

    IF counter = 0 THEN
        RAISE NOTICE '-1';
    ELSE
        RAISE NOTICE '%', counter;
    END IF;

    CLOSE ref;
END $$;
-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
    cur CURSOR FOR
        SELECT count(id) as counter
        FROM  students
        WHERE salary = 5
          AND prep_exam = 2;
   	counter INT;
BEGIN
    OPEN cur;

    FETCH cur into counter;

    RAISE NOTICE '%', counter;

    CLOSE cur;
END $$;
-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui
DO $$
DECLARE
    ref_dele refcursor;
    ref_read refcursor;
    tupla RECORD;
BEGIN
    OPEN ref_read FOR
        SELECT *
        FROM  students;

    FETCH ref_read INTO tupla;

    WHILE FOUND LOOP
        IF tupla.mother_edu IS NULL
        OR tupla.father_edu IS NULL
        OR tupla.grade IS NULL
        OR tupla.salary IS NULL
        OR tupla.prep_exam IS NULL
        OR tupla.prep_study IS NULL THEN
            RAISE NOTICE 'Deletendo a linha: %', tupla;
            DELETE FROM students WHERE id = tupla.id; 
        END IF;
        FETCH ref_read INTO tupla;
        EXIT WHEN NOT FOUND;
    END LOOP;

    CLOSE ref_read;

    OPEN ref_read SCROLL FOR
        SELECT *
        FROM  students;

    FETCH LAST FROM ref_read INTO tupla;

    WHILE FOUND LOOP
        RAISE NOTICE '%', tupla;
        FETCH PRIOR FROM ref_read INTO tupla;
    END LOOP;

    CLOSE ref_read;
END $$;
-- ----------------------------------------------------------------