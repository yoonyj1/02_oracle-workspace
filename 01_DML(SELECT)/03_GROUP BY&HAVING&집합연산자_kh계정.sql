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
SELECT DEPT_CODE, COUNT(EMP_ID)
FROM EMPLOYEE
GROUP BY DEPT_CODE;