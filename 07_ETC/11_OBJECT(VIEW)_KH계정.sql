/*
    < VIEW �� >
    
    SELECT��(������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ䰡 ����)
    �ӽ����̺� ���� ����(������ �����ϴ� ���� �ƴ�) => �׳� �����ֱ��
    �������� ���̺�: ����
    ������ ���̺�: ���� => ��� ������ ���̺�
*/

-- �並 ����� ���� ������ ������ 
-- ������ ������

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- '�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

--------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE VIEW VIEW��
    AS ��������;
*/
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- ���Ѱ� ������ ����

-- �����ڰ������� ���� �� ���Ѻο�
GRANT CREATE VIEW TO KH;

-- ���� �ִ� ���̺��� �ƴ� => ����, �����̺�
SELECT * FROM VW_EMPLOYEE;

-- �Ʒ��� ���� �ƶ�
SELECT * 
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)); -- �ζ��� �� / ������ ��

-- ��� ������ ���� ���̺� -> �������� ���̺��� �����ϰ� ���� ����

-- �ѱ� ���þ� �Ϻ��� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

-- [����]
SELECT *
FROM USER_VIEWS;