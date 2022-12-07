/*
    < DCL: Data Control Language >: ������ ���� ���
    
    �������� �ý��� ���� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ����
    
    >> �ý��� ����: DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    >> ��ü ���� ����: Ư�� ��ü���� ������ �� �ִ� ����
*/

/*
    * �ý��۱��� ����
    - CREATE SESSION: ������ �� �ִ� ����
    - CREATE TABLE: ���̺��� ������ �� �ִ� ����
    - CREATE VIEW: �並 ������ �� �ִ� ����
    - CREATE SEQUENCE: �������� ������ �� �ִ� ����
    ... CONNECT: �Ϻδ� CONNECT �ȿ� �� ���Ե�����
*/

-- 1. �����̸�: SAMPLE PW: SAMPLE
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- ����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

-- 2. ������ ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3-1. CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3-2. TABLE SPACE �Ҵ�
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

----------------------------------------------------------------------------
/*
    * ��ü ���� ���� ����
    Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
    
    ��������        Ư����ü
    SELECT      TABLE, VIEW, SEQUENCE
    INSERT      TABLE, VIEW
    UPDATE      TABLE, VIEW
    DELETE      TABLE, VIEW
    ...
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ����
*/
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

GRANT CONNECT, RESOURCE TO ������;