--TRIGERS--
 
CREATE OR REPLACE trigger colab_id_trigger
  before insert on COLABORADORES for each row
  begin
    select sec_id_colaborador.nextval into :new.id_codcolaborador from dual;
  end;
 
 
 
 
-- FUNCIONES--
 
--PROCEDIENTO INSERTAR NUEVO COLABORADOR
 
CREATE or REPLACE PROCEDURE insertNewColab(
   p_Nombre_Colab    IN colaboradores.nombre%TYPE,
   p_Apellido_Colab  IN colaboradores.apellido%TYPE,
   p_cedula_colab    IN colaboradores.cedula%TYPE,
   p_sexo_colab      IN COLABORADORES.SEXO%TYPE,
   p_fecha_nac       IN colaboradores.fecha_nacimiento%TYPE,
   --p_fecha_Ingre     IN colaboradores.fecha_ingreso%TYPE,
   p_Status_colab    IN colaboradores.status%TYPE,
   p_SalarioM_Colab  IN colaboradores.salario_mensual%TYPE)
IS
intSeqVal number(10);
v_fechaIn date;
BEGIN
   select SEC_ID_COLABORADOR.nextval into intSeqVal from dual;
   select SYSDATE into v_fechaIn from DUAL;
   INSERT into COLABORADORES (id_codcolaborador,nombre,apellido,cedula,sexo,
           fecha_nacimiento,fecha_ingreso,status,salario_mensual)
   VALUES (intSeqVal, p_Nombre_Colab, p_Apellido_Colab, p_cedula_colab, p_sexo_colab,
           to_date(p_fecha_nac,'DD-MON-YY'),v_fechaIn, p_Status_colab, p_SalarioM_Colab);
   COMMIT;
END;
/
 
-- PARAMETROS DEL PROCEDIMIENTO: NOMBRE,APELLIDO,CEDULA,SEXO,FECHA NACIMIENTO,STATUS,SALARIO
EXECUTE insertNewColab('JORGE','DIAZ','7-125-999','M','14-FEB-80','R',8000.00);
 
 
-- BLOQUE ANONIMO: --
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
   IF to_char(CURRENT_DATE, 'dd') = '04' OR to_char(CURRENT_DATE, 'dd') = '30' THEN
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
 
--FUNCION CALCULAR SALARIO
CREATE OR REPLACE FUNCTION Cal_SalarioNeto (
   p_idcolab COLABORADORES.ID_CODCOLABORADOR%TYPE,
   p_salario COLABORADORES.salario_mensuals%TYPE)
 
RETURN BOOLEAN IS
   v_id_colab NUMBER;
   v_CurrentStatus CHAR;
   v_activo CHAR := 'A';
   v_inactivo CHAR := 'R';
   v_ReturnValue BOOLEAN;
BEGIN
-- Obtiene el valor actual y máximo de estudiantes para el cuyo solicitado
   SELECT ID_CODCOLABORADOR, status
   INTO v_id_colab, v_CurrentStatus
   FROM COLABORADORES
   WHERE status = p_status
   AND ID_CODCOLABORADOR = p_idcolab;
-- Si la clase esta mas llena que el porcentaje dado por v_FullPercent , devuelve TRUE. En caso Contrario,FALSE.
IF 
   v_CurrentStatus = v_activo
THEN
   v_ReturnValue := TRUE;
ELSE
   v_ReturnValue := FALSE;
END IF;
   RETURN v_ReturnValue;
END StatusColab;
 
 
 
-- FUNCION ACTIVO, INACTIVO, VACACIONES
CREATE OR REPLACE FUNCTION StatusColab (
   p_idcolab COLABORADORES.ID_CODCOLABORADOR%TYPE,
   p_status COLABORADORES.status%TYPE    )
 
RETURN BOOLEAN IS
   v_id_colab NUMBER;
   v_CurrentStatus CHAR;
   v_activo CHAR := 'A';
   v_inactivo CHAR := 'R';
   v_ReturnValue BOOLEAN;
BEGIN
-- Obtiene el valor actual y máximo de estudiantes para el cuyo solicitado
   SELECT ID_CODCOLABORADOR, status
   INTO v_id_colab, v_CurrentStatus
   FROM COLABORADORES
   WHERE status = p_status
   AND ID_CODCOLABORADOR = p_idcolab;
-- Si la clase esta mas llena que el porcentaje dado por v_FullPercent , devuelve TRUE. En caso Contrario,FALSE.
IF 
   v_CurrentStatus = v_activo
THEN
   v_ReturnValue := TRUE;
ELSE
   v_ReturnValue := FALSE;
END IF;
   RETURN v_ReturnValue;
END StatusColab;
 
BEGIN
   IF
   StatusColab(19,'R')
   THEN
   DBMS_OUTPUT.PUT_LINE('valor existe');
   ELSE
   DBMS_OUTPUT.PUT_LINE('INACTIVO');
   END IF;
   DBMS_OUTPUT.PUT_LINE('valor existe');
END StatusColab;
