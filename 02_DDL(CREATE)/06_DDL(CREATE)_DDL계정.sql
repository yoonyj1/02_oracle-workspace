-- DDL ����� �����ϰ� ����� Ŀ�ؼ�, ���ҽ� ���� �ο��� ��

/*
    * DDL (DATA DEFINITION LANGUAGE): ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DROP)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ������ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ���� �����ϴ� ��ü(����): ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX),
                               ��Ű��(PACKAGE), Ʈ����(TRIGGER), ���ν���(PROCEDURE), �Լ�(FUNCTION)
                               ���Ǿ�(SYNONYM), �����(USER)
                               
    < CREATE >
    ��ü�� ������ �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺�: ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
             ��� �����͵��� ���̺��� ���ؼ� ����
             (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
             
    [ǥ����]
    CREATE TABLE ���̺��( 
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,            (NUMBER�� DATE�� ũ������ ���� �ʿ����)
        ...                 
    );
    
    * �ڷ���
    - ���� (CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��)) => �ݵ�� ũ������ �ؾ���
     > CHAR: �ִ� 2000����Ʈ���� ���� ����, ������ ���� �ȿ����� ����� / ��������(������ ũ�⺸�� �� ���� ���� ���͵� �������� �������� ä����)
             ������ ���ڼ��� �����͸��� ��� ��� ���(GENDER, YES/NO, Y/N)
     
     > VARCHAR2: �ִ� 4000����Ʈ���� ���� ����, ��������(���� ���� ���� ������ ũ�Ⱑ ������)
                 �� ������ �����Ͱ� ���� �� �𸣴� ��� ���
    
    - ����(NUMBER)
    
    - ��¥(DATE)
    
*/

-- ȸ���� ���� �����͸� ������� MEMBER �����ϱ�
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;
-- ���� �÷��� ��Ÿ�� �߻��ߴٸ� �ٽ� ����� �� �ƴϰ� �����ϰ� �ٽ� ��������

-- [����] ������ ������ �ִ� ���̺���� �ñ��Ҷ�
SELECT * FROM USER_TABLES; --> ���� ������ ������ �ִ� ���̺� ������ �� �� ����
SELECT * FROM USER_TAB_COLUMNS; --> ���� ������ �ִ� ���̺�� �÷��� �� �� ����

--------------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ�(�÷��� ���� ����)
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    
    >> �߸� �ۼ��ؼ� �������� ��� ���� �� �ٽ� �����ϸ� ��
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ'; -- ��Ÿ �߻� ���� ��� �����ؼ� �ٽ� ������ �� ����

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';

-- ���̺� �����ϰ��� �� ��: DROP TABLE ���̺��;
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);


COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ'; -- ��Ÿ �߻� ���� ��� �����ؼ� �ٽ� ������ �� ����
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺� �����͸� �߰���Ű�� ����(DML: INSERT)
-- INSERT INTO ���̺�� VALUES(��1, ��2,....);
SELECT * FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����'); �Է��� �� ���� ������ ���� �߻�
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', 'qwe@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- ��ȿ���� ���� �����Ͱ� ���� ���� -> ������ �ɾ������
--------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    - ������ ���Ἲ ������ �������� ��
    
    * ����: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
    - �ش� �÷��� �ݵ�� ���� �����ؾ� �� ���(��, �ش��÷��� ����� NULL�� ���ͼ��� �ȵǴ� ���)
    - ���� / ���� �� NULL ���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ���(2����) => �÷��������, ���̺������
     * NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ�
*/

-- �÷��������: �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES (1, 'user01', 'pass01', '�����', '��', NULL, NULL);
INSERT INTO MEM_NOTNULL VALUES (2, 'user02', null, 'Ȳ����', '��', null, 'wqe@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ��Ѵ�� ���� �� (NOT NULL �������ǿ� ����)
INSERT INTO MEM_NOTNULL VALUES (2, 'user01', 'pass01', 'Ȳ����', null, null, null);
-- ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �߰��� ��

--------------------------------------------------------------------------------
/*
    * UNIQUE ��������
    �ش� �÷��� �ߺ��� ���������� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ��������
    ���� / ���� �� ������ �ִ� ������ �� �� �ߺ����� ���� ��� ���� �߻�
*/

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --> �÷����� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ���: ��� �÷� ���� �� �������� ���
--                �������� (�÷���)
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007063) violated
-- UNIQUE �������ǿ� ����Ǿ��� -> INSERT ����
--> ���������� �������Ǹ����� �˷���(Ư�� �÷��� � ������ �ִ� �� ���� �˷������� ����)
--> ���� �ľ��ϱ� �����
--> �������� �ο� �� �������Ǹ� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع�����

/*
    * �������� �ο� �� �������Ǹ���� �����ִ� ���
    
    > �÷� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���
    );
    
    > ���̺� ���� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', 'Ȳ����', null, null, null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated
--                                        -> ���� ���� �̸����� ���

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', 'Ȳ����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '�̰���', '��', null, null); -- ���������� ���� ��
--> ������ ��ȿ�� ���� �ƴѰ� ���͵� �� INSERT ��

--------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
    �ش� ���ǿ� �����ϴ� ������ ���� ��� �� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')), -- �÷����� ���
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('��', '��')) -- ���̺��� ���
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '�����', '��', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007073) violated
-- CHECK �������ǿ� ����Ǿ��� ������ �����߻� (GENDER���� '��', '��'�� ������)
-- ���� GENDER �÷��� ������ ���� �ְ��� �Ѵٸ�, CHECK �������ǿ� �����ϴ� ���� �־����
INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', 'Ȳ����', NULL, null, null); -- CHECK ������ �ִ� �÷��� NOT NULL ���������� ������ NULL�� ������

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '�̰���', NULL, null, null);

--------------------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ����� ����)
    
    EX) �й�, ȸ����ȣ, ���(EMP_ID), �μ��ڵ�(DEPT_ID), �����ڵ�(JOB_CODE), �ֹ���ȣ, �����ȣ, ������ȣ,........
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������
    
    * ���ǻ���: �� ���̺� �� ������ �� ���� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷����� ���
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺� ���� ���
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', null);
INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', 'Ȳ����', '��', NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������ǿ� ����)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', 'Ȳ����', '��', NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL�� �������� �� �� (NOT NULL �������ǿ� ����)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', 'Ȳ����', '��', NULL, NULL);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷����� ���
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺� ���� ���
);
-- ORA-02260: table can have only one primary key
-- �⺻Ű�� �ϳ��� ��

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- ��� PRIMARY KEY ���������� �ο��� �� ���� (*����Ű), ���̺��� ��Ŀ����� ����
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�����', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', 'Ȳ����', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�̰���', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(NULL, 'user01', 'pass01', '�̰���', NULL, NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷����� ���� NULL�� ������� ����

-- ����Ű ��� ����(���ϱ�, ���ƿ�, ���� - �� ��� �� �� ���ۿ� �� �� ���� ��)
-- ���ϱ�: �� ��ǰ�� ���� �� ���� ���� �� ����
--      � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_ID, PRODUCT_NAME)
);
SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE
VALUES('user01', '��', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user02', '��', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user01', '��', SYSDATE);