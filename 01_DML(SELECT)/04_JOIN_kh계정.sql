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