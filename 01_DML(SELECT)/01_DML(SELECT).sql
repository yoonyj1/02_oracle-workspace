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

/*
    <���� ������: ||>
    ���� �÷������� ��ġ �ϳ��� �÷��ΰ�ó�� �����ϰų� �÷����� ���ͷ��� ������ �� ����
    System.out.println("num�� ��" + num);
*/

-- ����� �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- �÷����� ���ͷ� ����
-- XXX�� ������ XXX���Դϴ� => ��Ī: �޿�����
SELECT EMP_NAME || '�� ������ ' || SALARY || '�� �Դϴ�' AS "�޿�����"
FROM EMPLOYEE;

/*
    <DISTINCT>
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ���

*/
-- ���� �츮ȸ�翡 � ������ ������� �����ϴ� �� �ñ��� ��
-- EMPLOYEE ���̺��� ���� �ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���� �ڵ� ��ȸ(�ߺ� ����)
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- �ߺ����ŵǾ� 7�ุ ��ȸ��

-- ������� � �μ��� �����ִ� �� �ñ��� ��
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL: ���� �μ���ġ�� �ȵ� ���

/* DISTINCT ���ǻ���
  - SELECT���� �� �ѹ��� ��� ����
    SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
    FROM EMPLOYEE;
    ���� ����
    
    SELECT DISTINCT JOB_CODE, DEPT_CODE
    FROM EMPLOYEE;
    �ߺ� ���ŵǼ� ���
    -- JOB_CODE, DEPT_CODE�� �� ������ ��� �ߺ� �Ǻ�
*/

--------------------------------------------------------------------------------

/*
    <WHERE ��>
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ������ �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �� �� WHERE������ ���ǽ��� ������.
    ���ǽĿ����� �پ��� ������ ��밡��
    
    [ǥ����]
    SELECT �÷�1, �÷�2,...
    FROM ���̺��
    WHERE ���ǽ�;
    
    [�񱳿�����]
    >, <, >=, <=  --> ��Һ�
    =             --> �����
    !=, ^=, <>    --> �������� ������ ��
*/

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ(��� �÷� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ常 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� ���� ��(ENT-YN�÷����� 'N')�� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------- �ǽ� ���� ------------------------------------------
-- 1. �޿� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ� ������) ��ȸ
SELECT EMP_NAME, SALARY || '��' AS "�޿�", HIRE_DATE, SALARY * 12 || '��' AS "����(���ʽ� ������)"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 5000���� �̻� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY || '��' AS "�޿�", SALARY * 12 || '��' AS "����(���ʽ� ������)", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY * 12) >= 50000000;
-- WHERE ���� >= 50000000; ���� > SELECT������ �ۼ��� ��Ī ���Ұ� => ���� ������� ������

-- ���� ���� ����
-- FROM�� -> WHERE�� -> SELECT��

-- 3. �����ڵ尡 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- �μ��ڵ� 'D9'�̸鼭 �޿��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY || '��' AS "SALARY", DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY || '��' AS "SALARY"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- WHERE 3500000 <= SALARY <= 6000000 (X) ���� �߻�

--------------------------------------------------------------------------------

/*
    <BETWEEN A AND B>
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    -> �ش� �÷� ���� A �̻��̰� B ������ ���
*/

-- �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- ���� �������� ���� ����� ��ȸ (350���� �̸�, 600���� �ʰ�)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY < 3500000 OR SALARY > 6000000; ���1 
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000; ���2
WHERE SALARY NOT BETWEEN 3500000 AND 6000000; -- ���3

-- NOT: ������ ������
-- �÷��� �� �Ǵ� BETWEEN �տ� ���� ����

-- �Ի����� '90/01/01' ~ '01/01/01' ��� �÷� ��ȸ(BETWEEN)
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
-- DATE ������ ��� �� ����

--------------------------------------------------------------------------------

/*
    <LIKE>
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴�� �÷� LIKE 'Ư������'
    
    - Ư�� ���� ���� �� '%', '_'�� ���ϵ�ī��� ����� �� ����
    >> '%': 0���� �̻�
     EX) �񱳴���÷� LIKE '����%'      => �񱳴���� �÷����� ���ڷ� "����" �Ǵ� �� ��ȸ
         �񱳴���÷� LIKE '%����'      => �񱳴���� �÷����� ���ڷ� "��"���� �� ��ȸ
         �񱳴���÷� LIKE '%����%'     => �񱳴���� �÷����� ���ڰ� "����"�Ǵ� �� ��ȸ(Ű���� �˻��� ���)
         
    >> '_': 1����    
     EX) �񱳴���÷� LIKE '_����'      => �񱳴���� �÷����� ���� �տ� ������ �ѱ��ڰ� �� ��� ��ȸ
         �񱳴���÷� LIKE '����_'      => �񱳴���� �÷����� ���� �ڿ� ������ �ѱ��ڰ� �� ��� ��ȸ
         �񱳴���÷� LIKE '_����_'     => �񱳴���� �÷����� ���� �յڷ� ������ �ѱ��ڰ� �� ��� ��ȸ
*/

-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��߿� �ϰ� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';
-- ��%: '��'�� �����ϴ� �� ã��
-- %��: '��'�� ������ �� ã��
-- %��%: ��% + %�� + %��%
-- %: ���� �� �������

-- �̸��� ��� ���ڰ� �� �� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';
-- _��_ : ����� '��'�� ���� �� ã��
-- _: �ѱ��ڸ� ��Ÿ�� (_��_: ����� '��'�� ���� 3���� �̸�)

-- ��ȭ��ȣ�� 3��° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';
