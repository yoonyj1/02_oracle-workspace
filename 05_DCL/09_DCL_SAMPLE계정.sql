CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
); 
-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3-1. CREATE TABLE ���� �ޱ�
-- 3-2. TABLE SPACE �Ҵ� �ޱ�

SELECT * FROM TEST;

INSERT INTO TEST VALUES(10, '����');
----------------------------------------------------------------------------
-- KH������ �ִ� EMPLOYEE ���̺� ����
SELECT * FROM KH.EMPLOYEE;
-- ��ȸ ������ ����

INSERT INTO KH.DEPARTMENT
VALUES('D0', 'ȸ���', 'L1');

SELECT * FROM KH.DEPARTMENT;

ROLLBACK;