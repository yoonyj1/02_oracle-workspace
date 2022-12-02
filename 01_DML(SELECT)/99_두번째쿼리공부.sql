---------------------------- QUIZ 1 -------------------------------------------
-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5�� ��ȸ�Ϸ������� ����� ��ȸ�� �ȵ���
-- �̶� �ۼ��� SQL���� �Ʒ��� ����
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- � �������� �ִ���, �ذ�� SQL�� �ۼ�
/*
���� ���� ������ ���� ROWNUM�� �Ű����� ORDER BY ���� ����Ǳ� ������ ���ϴ� ����� ���� �� ����
*/
-- �ذ�� SQL��
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

---------------------------- QUIZ 2 -------------------------------------------
-- �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ���� (�μ��ڵ�, �μ��� �� �޿� ��, �μ��� ��� �޿�, �μ��� �����)
-- �� �� �ۼ��� SQL���� �Ʒ��� ����
SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;
-- � �������� �ִ���, �ذ�� SQL�� �ۼ�
/*
������
1. ��ձ޿��� ��ȸ�ؾ� �ϴ� �� �޿��� �񱳸� �ϰ�����
2. GROUP BY���� ������ �ɱ� ���ؼ� WHERE���� �������
*/
-- �ذ�� SQL��
SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;