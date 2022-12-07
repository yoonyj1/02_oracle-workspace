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
