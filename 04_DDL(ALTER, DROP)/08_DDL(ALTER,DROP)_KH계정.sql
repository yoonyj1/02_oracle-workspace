/*
    DDL (Data Definition Language): ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
    
    < ALTER >
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    * ������ ����
     1) �÷��� �߰� / ���� / ����
     2) �������� �߰� / ���� -> ������ �Ұ��� (�����ϰ��� �Ѵٸ� ������ �� ���� �߰�)
     3) �÷��� / �������Ǹ� / ���̺�� ����
*/

-- 1) �÷��� �߰� / ���� / ����
-- 1-1) �÷� �߰� (ADD): ADD �÷��� �ڷ��� [DEFAULT �⺻��] [CONSTRAINT �������Ǹ�] ��������
-- DEPT_COPY ���̺� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- ���ο� �÷��� ��������� �⺻������ NULL�� ä����

-- LNAME �÷� �߰�: VARCHAR2(20) / �⺻��: �ѱ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1-2) �÷� ���� (MODIFY)
--> �ڷ��� ����           : MODIFY �÷��� �ٲٰ����ϴ��ڷ���
--> DEFAULT�� ����       : MODIFY �÷��� DEFAULT �ٲٰ����ϴ� �⺻��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUBMER;
-- ���� �߻�: �̹� �����Ͱ� ���ڰ� �ƴ� �͵� �������
-- �����ϴ� �����Ͱ� ����߸� �̷��� �ٲ� �� ����

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- ���� �߻�: �̹� ����ִ� �����Ͱ� 10����Ʈ���� ŭ

-- DEPT_TITLE �÷��� VARCHAR2(50)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- LOCATION_ID �÷��� VARCHAR2(4)�� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- LNAME �÷��� �⺻���� '����'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '����';
-- DEFAULT ���� �ٲ۴ٰ� �ؼ� ������ �߰��� �����Ͱ� �ٲ�� ���� �ƴ�

-- ���� ���� ����
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';
    
-- 1-3) �÷� ���� (DROP COLUMN): DROP COLUMN �����ϰ��� �ϴ� �÷���
-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

-- DEPT_COPY2���� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- ���� ���� �ȵ�
ALTER TABLE DEPT_COPY2
    DROP COLUMN DEPT_ID
    DROP COLUMN DEPT_TITLE;
    
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- �����߻�: �ּ� �Ѱ��� ���̺��� �����ؾ���.

--------------------------------------------------------------------------------
-- 2) �������� �߰� / ����
/*
    2-1) �������� �߰�
    PRIMARY KEY: ADD PRIMARY KEY(�÷���)
    FOREIGN KEY: ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)] 
    UNIQUE:      ADD UNIQUE(�÷���)
    CHECK:       ADD CHECK(�÷��� ���� ����) 
    NOT NULL:    MODIFY �÷��� NOT NULL | NULL => NULL���� NULL ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/

-- DEPT_ID�� PRIMARY KEY �������� �߰� ADD
-- DEPT_TITLE�� UNIQUE �������� �߰� ADD
-- LNAME�� NOT NULL �������� �߰� MODIFY
ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
    
-- 2-2) �������� ����: DROP CONSTRAINT �������Ǹ�
-- NOT NULL�� ������ �ȵǰ� MODIFY NULL�� �����ؾ���

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------

-- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)
-- 3-1) �÷��� ����: RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) �������Ǹ� ����: RENAME CONSTRAINT �������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007254 => DCOPY_DID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007254 TO DCOPY_DID_NN;

-- 3-3) ���̺�� ����: RENAME [�������̺��] TO �ٲ����̺��
-- DEPT_COPY -> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--------------------------------------------------------------------------------
-- ���̺� ����
DROP TABLE DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� �����ϸ� �ȵ�
-- �������1. �ڽ����̺� ���� ������ �� �θ����̺� ����
-- �������2. �θ����̺� ������ �� �������Ǳ��� ���� �����ϴ� ���
--          DROP TABLE ���̺�� CASCADE CONSTRAINT;