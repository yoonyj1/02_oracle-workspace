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