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

-- ** Ư�����̽�
-- �̸��� �� _�������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- ���ϴ� ��� ���� X
-- ���ϵ�ī��� ���ǰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸX
--> � �� ���ϵ�ī���̰� � �� ������ ������ ��������ߵ�
--> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ�ī�带 �����ϰ� ������ ���ϵ�ī�带 ESCAPE OPTION���� ����ؾߵ�

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; -- $���� �ٸ� ���� ��� �ص� ��

-- ���� ������� �ƴ� �� ���� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
-- WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$'; -- ��� 1 
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$'; -- ��� 2
-- NOT�� �÷��� �� �Ǵ� LIKE �տ� ���� ����

----------------------------- �ǽ����� ------------------------------------------
-- 1. EMPLOYEE ���̺��� �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 2. �̸��� '��'�� ���ԵǾ��ְ�, �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ 
SELECT EMP_NAME, SALARY || '��' AS "SALARY"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;

-- 3. ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 4. DEPARTMENT ���̺��� �ؿܿ������� �μ����� �μ��ڵ�, �μ���
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--------------------------------------------------------------------------------
/*
    <IS NULL / IS NOT NULL>
    �÷����� NULL�� ���� ��� NULL�� �񱳿� ���Ǵ� ������
*/

-- ���ʽ��� ���� �ʴ� ���(���ʽ��� ���� NULL)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
-- WHERE BONUS = NULL; X �ƹ��͵� ��¾ȵ�

-- ���ʽ��� �޴� ���(BONUS�� ���� NULL�� �ƴ�)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; -- ���1
-- WHERE NOT BONUS IS NULL; -- ���2
-- NOT�� �÷���� �Ǵ� IS �ڿ��� ��밡��

-- �μ���ġ�� ���� ���� �ʾ����� ���ʽ��� �޴� ������� �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--------------------------------------------------------------------------------
/*
    < IN >
    �񱳴�� �÷� ���� ���� ������ ����߿� ��ġ�ϴ� ���� �ִ� �� 
    
    [ǥ����]
    �񱳴���÷� IN ('��1', '��2', '��3',.....)
*/

-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� �μ������� �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- �� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE NOT DEPT_CODE IN ('D6', 'D8', 'D5'); -- ���1 
-- WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5'); ���2

--------------------------------------------------------------------------------
/*
    <������ �켱����>
    0. ()
    1. ���������
    2. ���Ῥ���� ||
    3. �񱳿�����
    4. IS NULL / LIKE / IN
    5. BETWEEN A AND B
    6. NOT(��������)
    7. AND(��������)
    8. OR(��������)
*/

-- ** OR���� AND�� ���� ������ �� **
-- �����ڵ尡 'J7'�̰ų� 'J2'�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000;
-- AND�� ���� ����ż� J2�̸鼭 2000000���� �Ѵ� ����� ���� ��µǰ� �� �ܿ� �޿� ������� J7�� ����鵵 ��µ�
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------------- �ǽ� ���� ----------------------------------------
-- 1. ����� ���� �μ���ġ�� ���� ���� ������� (�����, ������, �μ��ڵ�) ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- 2 

-- 2. ����(���ʽ�������)�� 3000���� �̻��̰� ���ʽ��� ���� �ʴ� ������� (���, �����, �޿�, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;
-- 7

-- 3. �Ի����� '95/01/01' �̻��̰� �μ���ġ�� ���� ������� (���, �����, �Ի���, �μ��ڵ�) ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;
-- 18

-- 4. �޿��� 200���� �̻� 500���� �����̰� �Ի����� '01/01/01' �̻��̰� ���ʽ��� ���� �ʴ� �������(���, �����, �޿�, �Ի���, ���ʽ�) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NOT NULL;
-- 4

-- 5. ���ʽ����Կ����� NULL�� �ƴϰ� �̸��� '��'�� ���ԵǾ��ִ� ������� (���, �����, �޿�, ���ʽ����Կ���) ��ȸ (��Ī�ο�)
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY + SALARY * BONUS) * 12) AS "���ʽ����Կ���"
FROM EMPLOYEE
WHERE ((SALARY + SALARY * BONUS) * 12) IS NOT NULL AND EMP_NAME LIKE '%��%';
--2

--��
