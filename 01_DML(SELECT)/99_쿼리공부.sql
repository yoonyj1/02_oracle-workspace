-- ���� ����
-------------------------------- QUIZ 1 ----------------------------------------
-- ���ʽ��� �ȹ����� �μ���ġ�� �ȵ� �����ȸ
SELECT *
FROM EMPLOYEE;
-- WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- WHERE BONUS = NULL AND DEPT_CODE != NULL; NULL ���� ���� ���������� ��ó�� ���� ����
-- �������� �ذ��� ���
-- ������: NULL ���� ���� ���� =, != �����ڰ� �ƴ� IS NULL, IS NOT NULL�� ����ؾ���(�ܼ��� �񱳿����ڸ� ���� ���� �� ����)
-- �ذ���: IS NULL, IS NOT NULL ����ؼ� ���� ��
-- ��ġ�� SQL��
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NULL;


-------------------------------- QUIZ 2 ----------------------------------------
-- �˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY ���� 200���� �̻��̰� BONUS�� �ְ�, �����̸�, �̸��� �ּҴ� _���� 3���ڸ� �ִ�
-- ����� EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS�� ��ȸ
-- ���������� ��ȸ�� �� �ȴٸ� �������� 2���̾�� ��

-- ���� ������ �����Ű���� �ۼ��� SQL��
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- ���� SQL�� ���� �� ���ϴ� ����� ����� ��ȸ�� ���� ����
-- � �������� �ִ��� ��� ã�Ƽ� �����ϰ� ��ġ�� SQL�� �ۼ�

/*������:
1. AND�� OR���� �켱�� (OR �����ڿ� AND �����ڰ� �����Ǿ� ���� ��� AND �����ڰ� ���� ���� ��, �������� �䱸�� ������ OR�� ���� ����Ǿ����.)
2. SALARY 200���� �̻��̾�� ������ SQL������ �ʰ��� �Է����� (�޿����� ���� �񱳰� �߸� �Ǿ� ����)
3. �̸��� �ּ� ���� 3���ڸ� �ִ� ����� ã������ ESCAPE OPTION�� ����ؾ���
4. ������ ���� �����Ǿ�����
5. ���ʽ��� �޴� ����� ��ȸ�Ϸ��� IS NOT NULL�� ����ؾ���
*/

-- ��ġ�� SQL��
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '_')-1), LENGTH(SUBSTR(EMAIL, 1, INSTR(EMAIL, '_')-1))
FROM EMPLOYEE;

-------------------------------- QUIZ 3 ----------------------------------------
-- [������������] CREATE USER ������, IDENTIFIED BY ��й�ȣ;

-- ������: SCOTT, ��й�ȣ: TIGER ������ �����ϰ� ����
-- �̶� �Ϲ� ����� ������ KH������ �����ؼ� CREATE USER SCOTT; �� �����ϴ� �����߻�

-- ������ 1. ���������� ������ �����ڰ��������� ������
-- ������ 2. ��й�ȣ �Է�X, SQL���� �߸��Ǿ�����

-- ��ġ����1. ������ �������� �����ؾ���.
-- ��ġ����2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- ���� SQL�� ���� �� ������ ���� ������ �Ϸ� ������ ������
-- �ش� ������ ���̺� ���� ���� �ȵ�

-- ������1. ����� ���� ���� �� �ּ����� ���� �ο��� �ȵƴ�

-- ��ġ���� GRANT RESOURCE, CONNECT TO SCOTT;