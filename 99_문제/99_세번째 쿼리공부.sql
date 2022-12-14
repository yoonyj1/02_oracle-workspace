-- 12/15

-- QUIZ 1
-- CREATE USER TEST IDENTIFIED BY 1234; ����
-- User TEST��(��) �����ƽ��ϴ�.
-- ���� ������ �ϰ� ���� => ����

-- ���� �߻��� ����
-- ������: ���� ������ �ϰ� ���ӱ����� ���� �ʾ���
-- ��ġ����: GRANT CONNECT, RESOURCE TO TEST;

-- QUIZ2 (JOIN)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- ���� �� ���̺��� �ִٴ� �����Ͽ� 
-- �� ���̺� �����ؼ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�Ϸ� ��
-- �� �� ������ SQL��
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
-- "TB_JOB"."JOBNO": invalid identifier �߻�

-- ������: JOBNO���̺��� TB_EMP���� �����ϳ� TB_JOB ���̺��� �������� �ʱ� ������ USING�� ����ϸ� �ȵ�
-- ��ġ
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON(JOBNO = JOBCODE);


-- QUIZ3(JOIN ����)
 �Ʒ��� SQL������ �μ��� �����հ谡 15,000,000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�.
 �� ����� �ùٸ��� �ʴٰ� �� �� �� ���ΰ� ��ġ����
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
--WHERE SALARY > 15000000 -- GROUP BY�� WHERE�� �ƴ� HAVING �̿�
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;


QUIZ 4
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '����1��', 30);
INSERT INTO QUIZ4 VALUES(1, '����2��', 50);
-- �����߻� ����


-- JOIN => DECODE
-- J7�� ����� �޿��� 10% �λ�
-- J6�� ����� �޿��� 15% �λ�

-- '21/09/28' ���ڿ� => '2021-09-28'�� �ٲٱ�

-- '210908' ���ڿ� -> 2021�� 9�� 8�� �� �ٲٱ�

-- �ʱް����� �߱ް����� ��ް�����
-- CASE WHEN
--------------------------------------------------------------------------------
-- ���̺� ���� �����ؼ� ������ Ÿ��(CHAR�� VARCHAR2�� ������): KEYWORD - ��������, ��������
-- ����Ŭ ��ü(SEQUENCE, VIEW) ���� ����
 -- 1. SEQUENCE: �ڵ����� ������ ���� �� �ִ� ���ڸ� �߻������ִ� ��ü
 --               ������ ���ڸ�ŭ �þ�� ������ �� ������ �⺻�����δ� 1�� �����Ѵ�.
 --     [ǥ����] CREATE SEQUENCE ������������ �����ϸ� �߰��� �� �ִ� �ɼ����δ� START WITH, INCREMENT BY, MAXVALUE, MINVALUE, CACHE|NOCACHE ���� ������
 --             NEXTVAL�� ���� ���������� ������ ���� ��ȯ�ϸ�, CURRVAL�� ���������� ����� NEXTVAL�� ���� ��ȯ�Ѵ�.
 -- 2. VIEW: ������ �����̺�� ���� ����ϴ� ������ �����ص� �� �ִ� ��ü
-- �������� -> �ڴʰ� �߰��� �� �ִ� ALTER��
/*PRIMARY KEY: ADD PRIMARY KEY(�÷���)
    FOREIGN KEY: ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)] 
    UNIQUE:      ADD UNIQUE(�÷���)
    CHECK:       ADD CHECK(�÷��� ���� ����) 
    NOT NULL:    MODIFY �÷��� NOT NULL | NULL => NULL���� NULL ���
    */
-- DCL (GRANT, REVOKE)
    -- GRANT�� ������ ������ �ο��ϴ� �������� �ý��� ����, ��ü���� ������ �ο��� �� �ִ�.
    -- REVOKE�� �ο��� ������ ȸ���ϴ� ������ �Ѵ�.
-- COMMIT, ROLLBACK ���� ����
    --1. COMMIT�� DML�� ��� �� ����� Ʈ�������� Ȯ����Ű�� ������ �ϸ�, COMMIT�� �����ν� �����ͺ��̽��� ������ �ȴ�.
    -- 2. ROLLBACK�� DML�� ��� �� ����� Ʈ�����ǿ� �ִ� ���� ����ϴ� ������ �ϸ� ������ COMMIT ���Ŀ� ����� Ʈ�������� �������� ���ư���.
    
----------------------------------------------------------------------------------

/*
1. DBMS�� ����

2. DDL�� ����

3. NUMBER �ڷ����� �� �� �� �ִ���
���� �Ǽ� �� ���ڸ� �� ����

4. CHAR(10) �ǹ�

5. INNER JOIN

6. OUTTER JOIN

7. SUBSTR()

8. ���̺��� ����

9. ResultSet

10. UPPER()

11. MINUS, INTERSECT �ǹ�

12. INITCAP()
 ù ���ڸ� �빮�ڷ� �ٲ��ִ� �Լ�
 
13. TRIM()

14. UNION / UNIONALL ����

15. DECODE() ����

16. CONCAT() <=> ||

17. ROLLUP()

18. RANK OVER() DENSE_RANK OVER()
*/