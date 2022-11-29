/*
    <GROUP BY ��>
    �׷������ ������ �� �ִ� ���� (�ش� �׷���غ��� ���� �׷��� ���� �� ����)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- ��ü ����� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �μ��� ���ο�
SELECT DEPT_CODE, COUNT(*) -- GROUP BY�� ���� �͵��� ī��Ʈ
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �������
SELECT DEPT_CODE, SUM(SALARY) -- 3
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� ���޺� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, �����޿�, �ִ�޿�
SELECT JOB_CODE, COUNT(*) || '��' AS "�� �����", COUNT(BONUS) || '��' AS "���ʽ� �޴� ��� ��",
       LPAD(SUM(SALARY) || '��', 10) AS "�޿���", ROUND(AVG(SALARY)) || '��' AS "��ձ޿�",
       MIN(SALARY) || '��' AS "�����޿�", MAX(SALARY) || '��' AS "�ִ�޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� �μ��� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, �����޿�, �ִ�޿�
SELECT DEPT_CODE, COUNT(*) || '��' AS "�� �����", COUNT(BONUS) || '��' AS "���ʽ� �޴� ��� ��",
       LPAD(SUM(SALARY) || '��', 10) AS "�޿���", ROUND(AVG(SALARY)) || '��' AS "��ձ޿�",
       MIN(SALARY) || '��' AS "�����޿�", MAX(SALARY) || '��' AS "�ִ�޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

-- GRUOP BY���� �Լ��� ��� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1),'1', '����', '2', '����') AS "����", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY�� ���� �÷� ��� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1 NULLS FIRST;

--------------------------------------------------------------------------------
/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷��Լ����� ������ ������ ������ �� ���)
*/

-- �� �μ��� ��ձ޿� (�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '��' AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

-- �μ����� ��ձ޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '��' AS "��ձ޿�"
FROM EMPLOYEE
-- WHERE ROUND(AVG(SALARY)) >= 3000000 / �׷��Լ� ���� �������� ������ ����(�׷��Լ� ������ �������ý� WHERE�������� �ȵ�)
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '��' AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000
ORDER BY 1 NULLS FIRST;

-- ���޺� �� �޿� ��(��, ���޺� �޿��� ���� 1000���� �̻��� ���޸� ��ȸ) , �÷� �����ڵ�, �޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ �μ��ڵ常 ������ ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
--------------------------------------------------------------------------------
/*
    < SELECT �� �������>
    SELECT * | ��ȸ�ϰ����ϴ� �÷� ��Ī | ����� "��Ī" | �Լ��� AS "��Ī" -- 5
    FROM ��ȸ�ϰ��� �ϴ� ���̺�� -- 1
    WHERE ���ǽ�(�����ڸ� ������ ���) -- 2
    GROUP BY �׷�������� ���� �÷� | �Լ��� -- 3 
    HAVING ���ǽ�(�׷��Լ��� ������ ���) -- 4
    ORDER BY �÷��� | �÷����� | ��Ī [ASC | DESC] [NULLS FIRST / LAST] -- 6
*/