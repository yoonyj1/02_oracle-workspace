 /*
    * ��������(SUBQUERY)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
 */
 
-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ

-- 1. ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -- D9

-- 2. �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 1, 2�� �ϳ��� ����������
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');
                   
-- ���� �������� ����2
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1. �� ������ ��� �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2. �޿��� 3047662�� �̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- 1, 2�� �ϳ��� ����������
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
--------------------------------------------------------------------------------
/*
    * ���������� ����
    ���������� ������ ������� �� �� ��̳Ŀ� ���� �з�
    
    - ���� �� ��������: ���������� ��ȸ ������� ������ ������ 1���� ��(�� �� �� ��)
    - ���� �� ��������: ���������� ��ȸ ������� ���� ���϶� (���� �� �� ��) => EX) ��������
    - ���� �� ��������: ���������� ��ȸ ������� ���� ���϶� (���� �� �� ��)
    - ���� �� ���� �� ��������: ���������� ��ȸ ������� ���� ��, ���� ���϶�(���� ��, ���� ��)
    
    > ���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶���
*/

/*
    1. ���� �� �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ��� ���� ������ 1���� �� (�� �� �� ��)
    �Ϲ� �� ������ ��밡��(=, !=, >, <, <=, >=...)
*/

-- 1. �� ������ ��ձ޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
-- 2. ���� �޿��� �޴� ����� ���, �̸�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- 3. ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');
            
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- 4. �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
--  1) �μ��� �޿� �� �߿����� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
                      
-- ������ ����� ���� �μ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ��� (��, ������ ����)
-- >> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '������')
AND NOT EMP_NAME = '������';

-- >> ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
AND NOT EMP_NAME = '������';
--------------------------------------------------------------------------------
/*
    2. ���� �� ��������(MULTI ROW SUBQUERY)
    ���������� ������ ������� ���� �� �϶� (�÷��� 1��)
    
    - IN ��������: ���� ���� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ�
    - > ANY ��������: ���� ���� ����� �߿��� "�Ѱ���" Ŭ ���
    - < ANY ��������: ���� ���� ����� �߿��� "�Ѱ���" ���� ���
    
        �񱳴�� > ANY (��1, ��2, ��3)
        �񱳴�� > ��1 OR ��2 OR ��3
    - > ALL ��������: �������� ��� ������� ���� Ŭ ���
    - < ALL ��������: �������� ��� ������� ���� ���� ���
        
        �񱳴�� > ALL (��1, ��2, ��3)
        �񱳴�� > ��1 AND ��2 AND ��3
*/

-- 1. ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�
--   1) ����� �Ǵ� ������ ����� � �������� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');

--   2) J3, J7 ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');


SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('�����', '������')); -- = ��� �� �����߻� => ���� ������ ��ȸ�Ǳ� ����
                   -- ���� ������� ���� �� ���� �� ������ ���������� IN���� �� ��

-- ��� -> �븮 -> ���� -> ���� -> ����..
-- 2. �븮�����ӿ��� �ұ��ϰ� �������� �޿��� �� �ּ� �޿����� ���� �޴� ����(���, �̸�, ����, �޿�)
--  1) ���� ���� ������ ������� �޿���ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '����';

--  2) ������ �븮�鼭 �޿��� ���� ��� �� �߿� �ϳ��� ū ���
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY ('2200000', '2500000', '3760000');

-- �ϳ��� ���������� �ۼ�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME = '����');
                  
-- ���� �� ���������ε� ������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE E, JOB J
              WHERE E.JOB_CODE = J.JOB_CODE
              AND JOB_NAME = '����'); 
              
-- 3) ���� ���޿��� �ұ��ϰ� ���� ������ ������� ��� �޿����ٵ� �� ���� �޴� ������� ���, �����, ���޸�, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY
              FROM EMPLOYEE
              WHERE JOB_NAME = '����');
              
--------------------------------------------------------------------------------
/*
    3. ���� �� ��������
    ������� �� ��������, ������ �÷����� �������� ���
*/

-- 1. ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �Ի���)
--> ���� �� ���������ε� ������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');
                
-- > ���� �� ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������'); -- D5	J5, ���� ���� ���������
                               
-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');
                            
--------------------------------------------------------------------------------
/*
    4. ���� �� ���� �� ��������
    �������� ��ȸ ������� ���� �� ���� ���� ���
*/

-- 1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���,�����, �����ڵ�, �޿�)
--> �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR JOB_CODE = 'J7' AND SALARY = 1380000;              

-- ���������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE)
ORDER BY 3;

-- 2) �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE)
ORDER BY 3;

--------------------------------------------------------------------------------
/*
    5. �ζ��� ��(INLINE - VIEW)
    ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

-- ������� ���, �̸�, ���ʽ� ���� ���� (��Ī: ����), �μ��ڵ� ��ȸ (���ʽ� ���� ���� 3000���� �̻��� ����鸸 ��ȸ, ���ʽ� ���� ������ NULL�� ������ �ʰ�)
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY * NVL(BONUS, 0)) * 12 >= 30000000;

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE;

-- �̰� ��ġ �����ϴ� ���̺�ó�� ����� �� ���� = �ζ��� ��
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;

SELECT EMP_NAME, DEPT_CODE, ���� --, MANAGER_ID�� ���� ��
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;

