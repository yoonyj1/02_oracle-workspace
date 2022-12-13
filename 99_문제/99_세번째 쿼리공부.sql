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