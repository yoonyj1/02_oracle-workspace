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
--------------------------------------------------------------------------------
-- ������ ���
-- 1. JOIN ������ Ư¡, ����
-- 2. �Լ� ������ ����
-- ���� �޿� ��ȸ, ���޺��� �λ��ؼ� ��ȸ
-- J7 10%, J6 15%, J5 20%, �������� 5% �λ�
SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "�λ�޿�"
FROM EMPLOYEE
ORDER BY 2;

-- '21/09/28'�� ���� ���ڿ��� ������ '2021-09-28'�� ǥ���غ���
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD') FROM DUAL;

-- '210908'�� ���� ���ڿ��� ������ '2021�� 9�� 8��' ǥ��
SELECT SUBSTR(TO_CHAR(TO_DATE('210908'), 'DL'), 1, 11) FROM DUAL;

SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"��" FMMM"��" DD"��"') FROM DUAL; -- FM�� ����ϸ� 0�� �����

SELECT TO_CHAR(TO_DATE('210908'), 'DL') FROM DUAL;
