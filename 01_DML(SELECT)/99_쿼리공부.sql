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
