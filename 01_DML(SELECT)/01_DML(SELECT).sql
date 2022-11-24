/*
    < SELECT>
    �����͸� ��ȸ�� �� ���Ǵ� ����
    
    >> RESULT SET: SELECT���� ���� ��ȸ�� �����(��, ��ȸ�� ����� ������ �ǹ�)
    
    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�1[, �÷�2, ...] 
    FROM ���̺��;
    
    * �ݵ�� �����ϴ� �÷����� �����. ���� �÷� ���ԵǸ� ���� �߻�
*/

-- EMPLOYEE ��� ���̺� ��ȸ
-- SELECT EMP_ID, EMP_NAME, EMP_NO,...
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB;

----------------------------- �ǽ����� ------------------------------------------
-- 1. JOB���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    SELECT�� �÷��� �ۼ��κп� ������� ��� ����(RESULT SET�� �������� ��� ��ȸ)
*/

-- EMPLOYEE ���̺��� �����, �޿���ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, ����� ����(�޿�*12)��ȸ
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ� ���Ե� ����((�޿� + ���ʽ� * �޿�)*12) ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE; -- NULL �� ���� ��������� �ϸ� �� ����� NULL
--> ������� ���� �� NULL ���� ������ ��� ������� �� ������� NULL�� ����

-- EMPLOYEE ���̺��� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- * ���ó�¥: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE: �� �� ���� => ������� �±���(�� ������ ���)
-- ���� �������� ����: DATE������ ��/��/��/��/��/�� ���� �ð������� ������ �ϱ� ����
-- �Լ����� �� ������ ��� Ȯ�� ����

--------------------------------------------------------------------------------
/*
    <�÷��� ��Ī �����ϱ�>
    ��� ������ �ϰԵǸ� �÷����� ��������
    �̶� �÷������� ��Ī�� �ο��ؼ� ����ϰ� ��������
    
    [ǥ����]
    1. SELECT �÷��� ��Ī
    2. SELECT �÷��� AS ��Ī
    3. SELECT �÷��� "��Ī"
    4. SELECT �÷��� AS "��Ī" (��õ): �Ϲ������� ���� ��
    => AS�� ���̴� ���ο� ������� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� �ֵ���ǥ("")�� ����ؾ���.
*/    

SELECT EMP_NAME �����, SALARY AS �޿�, SALARY * 12 "����", ((SALARY + BONUS * SALARY) * 12) AS "���ʽ����� ����"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT���� ���ͷ��� �����ϸ� ��ġ ���̺� �� �����ϴ� ������ó�� ��ȸ����
    ��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ���
*/

-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;