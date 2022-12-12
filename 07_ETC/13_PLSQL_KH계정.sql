/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL(���ν���)
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ����(BLOCK ����) + ����ó��
    
    * PL / SQL ����
    - [�����]: DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - �����: BEGIN���� ����, ������ �־����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
    - [����ó����]: EXCEPTION���� ����, ������ �߻� �� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/

-- �����ϰ� ȭ�鿡 HELLO ORACLE ���
SET SERVEROUTPUT ON;
-- ȭ�鿡 ����� �� �� �ְ��ϴ� ��ɹ�(�ѹ��� �����ϸ� ��)

BEGIN
  -- System.out.println("HELLO ORACLE");
  DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-- ���� �������ִ� ������ �ϴ� /

--------------------------------------------------------------------------------

/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ ����)
    �Ϲ�Ÿ�� ����, ���۷���Ÿ�� ����, ROWŸ�� ����
    
    1_1) �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT -> ����� ���� ���] �ڷ��� [:= ��]
                             ����                        �ʱ�ȭ
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
    
BEGIN
    --EID := 800;
    --ENAME := '������';
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI: ' || PI);
    
END;
/
--------------------------------------------------------------------------------
-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
-- [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    
BEGIN
    --EID := '300';
    --ENAME := '������';
    --SAL := 1234567;
    
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL: ' || SAL);
    
END;
/

------------------------------ �ǽ����� ------------------------------------------
/*
    ���۷��� Ÿ�� ������ EID, ENAME, SAL, DTITLE�� �����ϰ�
    �� �ڷ����� EMPLOYEE, DEPARTMENT ���̺���� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� �� ������ ��� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE: ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL: ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE: ' || DTITLE);
    
END;
/
--------------------------------------------------------------------------------
-- 1_3) ROWŸ�� ���� ����
-- ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
-- [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
    
BEGIN
    SELECT * -- ROWTYPE�� ��� �ʼ��� ��� �÷��� ���� ��ƾ���
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    -- DBMS_OUTPUT.PUT_LINE(E); 
    DBMS_OUTPUT.PUT_LINE('�����: ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ�: ' || NVL(E.BONUS, 0));
                                        -- NVL ��밡��
END;
/
--------------------------------------------------------------------------------

/*
    2. BEGIN �����
*/

-- < ���ǹ� >
-- 1) IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է� ���� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: ' || SALARY);
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ���: ' || BONUS * 100 || '%'); 
    
END;
/

-- 2. IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (�� �ڹٿ��� IF-ELSE ��)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ���: ' || BONUS * 100 || '%');
    END IF;
    
END;
/

------------------------------ �ǽ����� ------------------------------------------
-- ���۷���Ÿ���� ����(EID, ENAME, DTITLE, NCODE)
-- �������̺� EMPLOYEE, DEPARTMENT, LOCATION
-- �Ϲ�Ÿ�� ���� TEAM ������10����Ʈ <= '������' OR '�ؿ���'
-- ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
-- NCODE�� ���� KO�� ��� TEAM ������ '������' �ƴ� ��� '�ؿ���'
-- ���, �̸�, �μ�, �Ҽ�(������, �ؿ���)�� ���� ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO' 
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ���: ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ�: ' || TEAM);
  
END;
/