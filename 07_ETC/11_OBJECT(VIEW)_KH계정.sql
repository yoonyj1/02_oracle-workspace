/*
    < VIEW �� >
    
    SELECT��(������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ䰡 ����)
    �ӽ����̺� ���� ����(������ �����ϴ� ���� �ƴ�) => �׳� �����ֱ��
    �������� ���̺�: ����
    ������ ���̺�: ���� => ��� ������ ���̺�
*/

-- �並 ����� ���� ������ ������ 
-- ������ ������

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- '�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

--------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE [OR REPLACE] VIEW VIEW��
    AS ��������;
    
    [OR REPLACE]: �� ���� �� ������ �ߺ��� �̸��Ǻ䰡 ���ٸ� ������ �並 �����ϰ�
                           ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 ����(����)�ϴ� �ɼ�
*/
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- ���Ѱ� ������ ����

-- �����ڰ������� ���� �� ���Ѻο�
GRANT CREATE VIEW TO KH;

-- ���� �ִ� ���̺��� �ƴ� => ����, �����̺�
SELECT * FROM VW_EMPLOYEE;

-- �Ʒ��� ���� �ƶ�
SELECT * 
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)); -- �ζ��� �� / ������ ��

-- ��� ������ ���� ���̺� -> �������� ���̺��� �����ϰ� ���� ����

-- �ѱ� ���þ� �Ϻ��� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

-- [����]
SELECT *
FROM USER_VIEWS;

-- ���� VIEW�� �߰��ϰ� ���� ���
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object
-- �̹� �ش� �̸��� ���� �䰡 �ִٰ� �ؼ� �����߻�

--------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
    ���������� SELECT���� �Լ����̳� ���������� ����Ǿ� ���� ���
    �ݵ�� ��Ī�� �����ؾ���
*/

-- �� ����� ���, �̸�, ���޸�, ����, �ٹ���� ��ȸ �� �� �ִ� SELECT���� VIEW(VW_EMP_JOB)�� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
-- ORA-00998: must name this expression with a column alias
-- SELECT���� �Լ����̳� ���������� �ִ� ���� ������ ��Ī�� �ο��ؾ���

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����"
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
SELECT * FROM VW_EMP_JOB; -- ������ �����ϴ� ���̺� x

-- �Ʒ��� ���� ������ε� ��Ī �ο� ����
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����) -- ��, ��� �÷��� ��Ī�� �ο��ؾ���.
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') 
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
-- ������ ������ ������� �̸�, ���޸�
SELECT �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

-- �ٹ������ 20�� �̻� �� ������� ���, �̸�, ���޸�, ����, �ٹ���� ��ȸ
SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �� ����
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
-- ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��� ����
-- �並 ���ؼ� �����ϴ��� ���� �����Ͱ� ����ִ� ���̽����̺� �ݿ���
-- �� �ȵǴ� ��찡 ���� ������ �� ������ ����

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB; -- ������ ���̺�(���� �����Ͱ� ��������� ����)
SELECT * FROM JOB; -- ���̽� ���̺�(���� �����Ͱ� �������)

-- �並 ���ؼ� INSERT
INSERT INTO VW_JOB
VALUES('J8', '����'); -- JOB���̺� ���� �߰���

-- �並 ���ؼ� UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

-- �並 ���ؼ� DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';
--------------------------------------------------------------------------------
/*
    * ��, DML ��ɾ�� ������ �Ұ����� ��찡 �� ����
    1) VIEW�� ���ǵǾ� ���� ���� �÷��� �����Ϸ� �ϴ� ���
    2) VIEW�� ���ǵǾ� ���� ���� �÷� �߿� ���̽����̺� �� NOT NULL ������ �����Ǿ� �ִ� ���
    3) �������� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
    4) �׷��Լ��� GROUP BY ���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������� ���� ���
*/

-- 1) VIEW�� ���ǵǾ� ���� ���� �÷��� �����Ϸ� �ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
    FROM JOB;
    
SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '����');
-- SQL ����: ORA-00904: "JOB_NAME": invalid identifier

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- SQL ����: ORA-00904: "JOB_NAME": invalid identifier

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- SQL ����: ORA-00904: "JOB_NAME": invalid identifier

-- 2) VIEW�� ���ǵǾ� ���� ���� �÷� �߿� ���̽����̺� �� NOT NULL ������ �����Ǿ� �ִ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT
INSERT INTO VW_JOB VALUES('����'); -- ���� ���̽� ���̺� INSERT�� (NULL, '����') �߰�
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE 
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

ROLLBACK;

-- DELETE (�� �����͸� ���� �ִ� �ڽ� �����Ͱ� �����ϱ� ������ ���� ���� / �� ���� �� ���� �ߵ�)
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- ORA-02292: integrity constraint (KH.SYS_C007188) violated - child record found

-- 3) �������� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "����" FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL; -- �����̺�
SELECT * FROM EMPLOYEE; -- �������̺�

-- INSERT
INSERT INTO VW_EMP_SAL VALUES(400, '������', 3000000, 36000000);
-- ORA-01733: virtual column not allowed here
-- EMPLOYEE�� �����̶�� �÷��� ���� ������ �����߻�

-- UPDATE
-- 200�� ����� ������ 8õ��������
UPDATE VW_EMP_SAL
SET ���� = '80000000'
WHERE EMP_ID = 200;
-- ORA-01733: virtual column not allowed here

-- 200�� ����� �޿��� 700��������
UPDATE VW_EMP_SAL
SET SALARY = '7000000'
WHERE EMP_ID = 200; -- ����

SELECT * FROM EMPLOYEE WHERE EMP_ID = 200;

ROLLBACK;

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

SELECT * FROM VW_EMP_SAL;
ROLLBACK;

-- 4) �׷��Լ��� GROUP BY ���� ���Ե� ���
CREATE OR REPLACE VIEW VW_GROUP_DEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "�հ�", FLOOR(AVG(SALARY)) AS "���"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUP_DEPT;

-- INSERT
INSERT INTO VW_GROUP_DEPT VALUES('D3', 8000000, 4000000);
-- ORA-01733: virtual column not allowed here
-- ���� EMPLOYEE�� ���� �÷��� ����

-- UPDATE
UPDATE VW_GROUP_DEPT
SET �հ� = 8000000
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view

-- 5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');
-- ORA-01732: data manipulation operation not legal on this view

-- UPDATE (����) => VIEW�� DISTINCT ������ �ֱ� ������
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';
-- ORA-01732: data manipulation operation not legal on this view

-- 6) JOIN�� �̿��ؼ� ���� ���̺��� ������� ���� ���
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
    
SELECT * FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP VALUES(300, '�����', '������̺�');
-- ORA-01776: cannot modify more than one base table through a join view

-- UPDATE
UPDATE VW_JOINEMP
SET DEPT_TITLE = 'ȸ���'
WHERE EMP_ID = 200;
-- ORA-01779: cannot modify a column which maps to a non key-preserved table