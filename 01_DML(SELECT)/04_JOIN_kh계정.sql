/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ����
    
    -- � ����� � �μ��� �����ִ��� �ñ��� ��� (�ڵ尡 �ƴ� �μ��̸�����)
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ���
    (������ �� ��ȸ�� �ؿ��°� �ƴ� �� ���̺� ������ν� �����͸� ��Ī�ؼ� ��ȸ�ؾ���)

                    JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ) => �ƽ�Ű�ڵ�ǥ ����� ��

*/
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- DEPT_CODE�� �����

SELECT *
FROM DEPARTMENT; -- DEPT_ID

-- ��ü ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE--, DEPT_TITLE  -- �μ����� EMPLOYEE ���̺� ����
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE--, JOB_NAME -- JOB_NAME�� EMPLOYEE�� ����
FROM EMPLOYEE; -- JOB_CODE

SELECT *
FROM JOB; -- JOB_CODE

/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
        : �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ(��ġ���� �ʴ� ���� ��ȸ���� ����)
*/
-->> ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� �� ����(,�� ����)
-- WHERE���� ��Ī��ų �÷�(�����)�� ���� ������ ������

-- 1. ������ �� �÷����� �ٸ� ���(EMP: DEPT_CODE, DEP: DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ�
-- DEPT_CODE�� NULL�� ��� ��ȸX, DEPT_ID D3 D4 D7 ��ȸ X => �� �� �־�� ��ȸ����

-- 2. ������ �� �÷����� ���� ���(EMP: JOB_CODE, JOB: JOB_CODE)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; -- column ambiguously defined: �÷��� �ָ��ϰ� ���õ�

-- �ذ���1. ���̺� ���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- �ذ���2. ���̺� ��Ī �ο��ؼ� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
-- FROM���� ������ �Ǵ� ���̺��� �ϳ��� ����� �� 
-- JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���� ���
-- JOIN USING, JOIN ON

-- 1. ������ �� �÷����� �ٸ� ��� (EMP: DEPT_CODE, DEP: DEPT_ID)
-- ���� JOIN ON �������θ� ����
-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2. ������ �� �÷����� ���� ��� (EMP: JOB_CODE, JOB: JOB_CODE)
-- JOIN ON, JOIN USING ���� ��� ����
-- ���, �����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);

-- �ذ���1. ���̺�� �Ǵ� ��Ī �̿��ؼ� �ذ�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
-- �ذ���2. JOIN USING ���� ��� (** �� �÷����� ��ġ�� ��쿡�� ��밡��)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

---------- [ ������� ] ------------
-- �ڿ�����(NATURAL JOIN): �� ���̺��� ������ �÷��� �� �Ѱ��� ������ ��� => ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- ������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮';

--> ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '�븮';

-------------------------------- �ǽ����� ----------------------------------------
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '�λ������';

--> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

--2. DEPARTMENT�� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--> ����Ŭ ���뱸��
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

--> ANSI����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);
 
--3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND BONUS IS NOT NULL;

--> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE != '�ѹ���';

--> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';