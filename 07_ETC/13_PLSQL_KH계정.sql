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