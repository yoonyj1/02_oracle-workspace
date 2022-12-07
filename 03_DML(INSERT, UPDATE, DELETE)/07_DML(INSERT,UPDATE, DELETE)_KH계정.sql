/*
    DQL (QUERY ������ ���� ���): SELECT
    
    DML (MANIPULATION ������ ���� ���): [SELECT], INSERT, UPDATE, DELETE
    DDL (DEFINITION ������ ���� ���): CREATE, ALTER, DROP
    DCL (CONTROL ������ ���� ���): GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION CONTROL Ʈ������ ���� ���): COMMIT, ROLLBACK
*/

/*
    < DML: DATA MANIPULATION LANGUGAE>
    
    ���̺� ���� ����(INSERT)�ϰų� ����(ALTER)�ϰų� ����(DELETE)�ϴ� ����
*/

/*
    1. INSERT
        ���̺� ���ο� ���� �߰��ϴ� ����
        
        [ǥ����]
        1) INSERT INTO ���̺�� VALUES(��1, ��2...)
           ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
           �÷� ������ ���Ѽ� VALUES�� ���� �����ؾ���
           
           �����ϰ� ���� �������� ��� => not enough value ����
           ���� �� ���� �������� ��� => too many values ����
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE
VALUES(900, '������', '900101-1234567', 'cha_00@kh.or.kr', '01011112221', 
        'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
        
SELECT *
FROM EMPLOYEE;

/*
    2) INSERT INTO ���̺��(�÷���1, �÷���2,...) VALUES (��1, ��2,...);
       ���̺� ���� ������ �÷��� ���� ���� INSERT �� �� ���
       ������ �ȵ� �÷��� �⺻�����δ� NULL�� ��
       => NOT NULL ���������� �� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾ���.
       ��, DEFAULT ���� �ִ� ���� NULL�� �ƴ� DEFAULT ���� ����.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(901, '������', '880101-1234567', 'J2', 'S2', SYSDATE);

SELECT * FROM EMPLOYEE;
-- ENT_YN�� DEFAULT������ ������.

INSERT 
 INTO EMPLOYEE
     (
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , JOB_CODE
     , SAL_LEVEL
     , HIRE_DATE
     ) 
VALUES
    (
           901
        , '������'
        , '880101-1234567'
        , 'J2'
        , 'S2'
        , SYSDATE
        );
--------------------------------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������)
       VALUES�� �� ���� ����ϴ� �� ��ſ� ���������� ��ȸ�� ������� ��°�� INSERT ����
       (������ INSERT ����)
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

/*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���,....)
    INTO ���̺��2 VALUES(�÷���, �÷���,....)
    ��������;
*/
-- �׽�Ʈ�� ���̺� �����
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;
    
SELECT * FROM EMP_MANAGER;

-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- ������ ����ؼ��� �� ���̺� �� INSERT ����
--> 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
-- ���̺� ������ �貸�� ���� �����
CREATE TABLE EMP_OLD 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
    
-- EMP_NEW ������ ������ �����
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 =0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
     [ǥ����]
     INSERT ALL
     WHEN ����1 THEN 
        INTO ���̺�1 VALUES(�÷���, �÷���,...)
     WHEN ����2 THEN
        INTO ���̺�2 VALUES(�÷���, �÷���,...)
     ��������;
*/


INSERT ALL
    WHEN HIRE_DATE < '00/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE > '00/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

--------------------------------------------------------------------------------
/*
    CRUD
    CREATE ���� => INSERT
    READ ��ȸ => SELECT
    UPDATE
    DELETE
    
    3. UPDATE
        ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
        
        [ǥ����]
        UPDATE ���̺��
        SET �÷��� = �ٲܰ�,
            �÷��� = �ٲܰ�,
            ...
                        --> �������� �÷��� ���� ���� ����(,�� �����ؾ��� AND�� �ƴ�)
        [WHERE ����];    --> �����ϰ� �Ǹ� ��ü ���� ��� �����Ͱ� ����ȴ�. => ���� ����� �ؾ���
*/

-- DEPRATMENT ���̺� ���纻 �����
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- 'D9' �ѹ��θ� ������ȹ������ ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��' -- �ѹ���
WHERE DEPT_ID = 'D9'; 

SELECT * FROM DEPT_COPY;

-- ���纻 �����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- 1. ���ö ����� �޿��� 100�������� ����
-- ������ �ּ����� ����ϱ�
-- ������Ʈ �ϱ� ���� SELECT ������ Ȯ���غ���
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '���ö';

UPDATE EMP_SALARY
SET SALARY = 1000000 -- 3700000
WHERE EMP_ID = 202;

-- 2. ������ ����� �޿��� 700�������� �����ϰ�, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000, --8000000
    BONUS = 0.2 --0.3
WHERE EMP_ID = 200;

-- ��ü ����� �޿��� ���� �޿��� 10���� �λ��� �ݾ����� ����(�����ݾ� * 1.1)
SELECT EMP_NAME, SALARY
FROM EMP_SALARY;

UPDATE EMP_SALARY
SET SALARY = (SALARY * 1.1);

-- * UPDATE �� �������� ��밡��
/*
    UPDATE ���̺��
    SET �÷��� = (��������)
    [WHERE ����];
*/

-- ���� ����� �޿�, ���ʽ� ���� ����� ����� �޿��� ���ʽ� ������ ����
SELECT *
FROM EMP_SALARY
WHERE EMP_NAME = '����';

-- ���� �� ��������
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'), -- 1518000
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����') -- NULL
WHERE EMP_NAME = '����';

-- ���� �� ��������
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����') -- 1518000, NULL
WHERE EMP_NAME = '����';

-- ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
-- ASIA �������� �ٹ��ϴ� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS, LOCAL_NAME
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                    FROM EMP_SALARY
                    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');
                
