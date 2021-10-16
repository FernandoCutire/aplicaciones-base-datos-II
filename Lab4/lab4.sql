create table colaboradores (
    id_codcolaborador number not null,
    nombre varchar2(25) not null,
    apellido VARCHAR2(25)not NULL,
    cedula varchar2(12) not NULL,
    sexo char not NULL,
    fecha_nacimiento date not NULL,
    fecha_ingreso date not NULL,
    status char not NULL,
    salario_mensual number(15,2) DEFAULT 0,
    constraint n_cedula unique (cedula),
    constraint c_sexo CHECK (sexo in ('F','M')),
    constraint c_status CHECK (status in ('A', 'V', 'R')),
    constraint pk_colab_cod primary key (id_codcolaborador)
);
 
CREATE TABLE salario_quincenal (
    id_salario NUMBER not null,
    id_codcolaborador number not NULL,
    fecha_pago date NOT NULL,
    salario_quincenal number(15,2) DEFAULT 0,
    seguro_social number(15,2) DEFAULT 0,
    seguro_educativo number(15,2) DEFAULT 0,
    salario_neto NUMBER(15,2) DEFAULT 0,
    constraint pk_id_salario primary key (id_salario),
    constraint fk_codcolaborador foreign key (id_codcolaborador) 
        references colaboradores (id_codcolaborador)
);
 
 
Insert into COLABORADORES values (1,'gabriel','diaz','20-53-5198','M',to_date('01-OCT-00','DD-MON-RR'),to_date('01-JAN-21','DD-MON-RR'),'A',5000);
Insert into COLABORADORES values (2,'william','feng','8-977-446','M',to_date('07-OCT-00','DD-MON-RR'),to_date('04-JAN-21','DD-MON-RR'),'A',5000);
Insert into COLABORADORES values (3,'jorge','escobar','2-747-1772','M',to_date('04-AUG-00','DD-MON-RR'),to_date('01-FEB-21','DD-MON-RR'),'A',5000);
Insert into COLABORADORES values (4,'Esperanza','Ordonez','8-972-906','F',to_date('06-JUL-00','DD-MON-RR'),to_date('01-MAY-21','DD-MON-RR'),'A',5000);
Insert into COLABORADORES values (5,'Carol','Santo','8-910-123','F',to_date('14-FEB-21','DD-MON-RR'),to_date('01-JAN-20','DD-MON-RR'),'V',4000);
 
 
DECLARE 
    -- Se declaran las variables de los colaboradores
    v_Id_Colab                      colaboradores.id_codcolaborador%TYPE;
    v_Nombre_Colab                  colaboradores.nombre%TYPE;
    v_Apellido_Colab                colaboradores.apellido%TYPE;
    v_SalarioM_Colab                colaboradores.salario_mensual%TYPE;
    v_Status_colab                  colaboradores.status%TYPE := 'A';
    v_counter BINARY_INTEGER := 1;
 
    CURSOR c_Salarios IS
    SELECT id_codcolaborador, 
    nombre, 
    apellido, 
    salario_mensual
    FROM COLABORADORES
    WHERE status = v_Status_colab;
 
BEGIN
    -- Este código se emplea los días quince y treinta de cada mes. 
    -- Si se quiere probar el código, cambiar los valores a el día en la que usted se encuentra
    -- Por ejemplo: Si usted lo prueba el 6 de octubre, colocar 06 en el date
    -- Ejem: IF to_char(CURRENT_DATE, 'dd') = '06' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
    IF to_char(CURRENT_DATE, 'dd') = '15' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
        OPEN c_Salarios;
        LOOP
        FETCH c_Salarios INTO 
        v_Id_Colab, 
        v_Nombre_Colab, 
        v_Apellido_Colab, 
        v_SalarioM_Colab;
        EXIT
        WHEN c_salarios%NOTFOUND;
        INSERT INTO salario_quincenal (
            id_salario,id_codcolaborador, fecha_pago, salario_quincenal,
            seguro_social, seguro_educativo, salario_neto)
        VALUES (
            v_counter,
            v_Id_Colab,
            SYSDATE(),
            v_SalarioM_Colab/2,
            (v_SalarioM_Colab/2) * 0.0975,
            (v_SalarioM_Colab/2) * 0.0125,
            (v_SalarioM_Colab/2) - (v_SalarioM_Colab/2 * 0.0975) - (v_SalarioM_Colab/2 * 0.0125)
        ); 
        v_counter := v_counter + 1;
        END LOOP;
        CLOSE c_Salarios;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('💣 Error: Hoy no es día de pago.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('💣 Error: Este ID no existe.');
END;
/ 
 
set serveroutput on;
 
 
select * from salario_quincenal;
 
 
CREATE VIEW Salario_Quincenal AS
SELECT c.id_codcolaborador AS codigo, CONCAT(CONCAT(c.nombre, ' ' ) , c.apellido) AS colaborador, c.salario_mensual, sq.salario_quincenal, sq.seguro_social, sq.seguro_educativo, sq.salario_neto AS salario_neto
FROM colaboradores c
INNER JOIN salario_quincenal sq ON c.id_codcolaborador = sq.id_codcolaborador
WHERE status = 'A'
ORDER BY c.id_codcolaborador ASC;