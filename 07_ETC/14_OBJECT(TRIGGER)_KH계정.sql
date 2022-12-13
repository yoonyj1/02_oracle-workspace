/*
    < Ʈ���� TRIGGER >
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX) 
    ȸ��Ż�� �� ������ ȸ�� ���̺��� �����͸� DELETE �� �� ��ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���ؾߵȴ�.
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT) �� �� ���� �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾ� �� ��
    
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
      > BEFORE TRIGGER: ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
      > AFTER TRIGGER: ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
       
    - SQL���� ������ �޴� �� �࿡ ���� �з�
      > STATEMENT TRIGGER(���� Ʈ����): �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����   
      > ROW TRIGGER(�� Ʈ����): �ش� SQL�� ������ ������ �Ź� Ʈ���� ����
                              (FOR EACH ROW �ɼ� ����ؾ���)
                              > :OLD - BEFORE UPDATE(���� �� �ڷ�), BEFORE DELETE(���� �� �ڷ�)
                              > :NEW - AFTER INSERT(�߰� �� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
    * Ʈ���� ���� ����
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER        INSERT|UPDATE|DELETE ON ���̺�� 
    [FOR EACH ROW]
    �ڵ����� ������ ����;
        �� DECLARE
                ��������
           BEGIN
                ���೻��(�ش� ���� ������ �̺�Ʈ �߻� �� ���������� (�ڵ�����) ������ ����)
           EXCEPTION
                ����ó������;
           END;
           /
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޽��� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');       
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '�̼���', '111111-1212123', 'D7', 'J7', 'S2', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(501, '�ָ�', '121212-1234567', 'D8', 'J7', 'S2', SYSDATE);

--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� ������ ���� �� ���̺�(TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,               -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,            -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,            -- �귣��
    PRICE NUMBER,                           -- ����
    STOCK NUMBER DEFAULT 0                  -- ������
);

-- ��ǰ��ȣ�� �ߺ��� �ȵǰ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������ 20', '�Ｚ', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������ 14', '����', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 600000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT;

-- 2. ��ǰ�� ����� �� �̷� ���̺�(TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�

CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                           -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,                 -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                                -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                             -- ��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���'))      -- ����(�԰�/���) 
);

-- �̷� ��ȣ�� �Ź� ���ο� ��ȣ�� �߻����Ѽ� �� �� �ְ� �����ִ� ������(SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
-- 200�� ��ǰ�� ������ 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- �ش� Ʈ����� Ŀ��

-- 210�� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');
-- 210�� ��ǰ�� ��� 5 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ ��� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- �Ǽ��� 200�� ��ǰ�� UPDATE

ROLLBACK;

-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ ��� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻� ��
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� ����
/*
    - ��ǰ�� �԰� �� ��� => �ش� ��ǰ�� ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT ��)
    WHERE PCODE = ���� �԰�� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE ��);
    
    - ��ǰ�� ��� �� ��� => �ش� ��ǰ�� ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - �������ȼ���(INSERT�� �ڷ��� AMOUNT ��)
    WHERE PCODE = ���� ���� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE ��);
*/
-- :NEW �����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ����
    IF (:NEW.STATUS = '�԰�')
        THEN 
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- ��ǰ�� ���� ��� => ������ ����
    IF (:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���� ��¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���');

-- 200�� ��ǰ�� ���� ��¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');


--------------------------------------------------------------------------------
-- �л� ���̺� ����
DROP TABLE TB_ABSENCE;
DROP TABLE TB_STU;

-- TB_STU
-- �÷� : �й�, �̸�, ����(M/F), ��ȭ��ȣ, ��������(����Ʈ ����)(����, ����, ����, ����)
-- STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS
CREATE TABLE TB_STU(
    STU_NO NUMBER PRIMARY KEY,
    STU_NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    PHONE VARCHAR2(20),
    STU_STATUS VARCHAR2(10) DEFAULT '����' CHECK(STU_STATUS IN('����', '����', '����', '����'))
);

-- �й������� ����(SEQ_STU_NO)
-- 900������ �����ϰ� (900,901)
CREATE SEQUENCE SEQ_STU_NO
START WITH 900;

-- ������ 5�� �����
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '������', 'M', '010-1234-5678', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '���ٶ�' ,'F', '010-2345-6789', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '�ٶ�', 'M', '010-3456-7890', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '�󸶹�', 'F', '010-4567-8901', DEFAULT);
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '���ٻ�', 'M', '010-5678-9012', DEFAULT);


-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) => DEFAULT 'Y'
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
CREATE TABLE TB_ABSENCE(
    ABS_NO NUMBER PRIMARY KEY,
    STU_NO NUMBER REFERENCES TB_STU ON DELETE CASCADE,
    ABS_DATE DATE,
    ABS_STATUS CHAR(2) DEFAULT 'Y' CHECK(ABS_STATUS IN('Y', 'N'))
);

-- ���� ������ ����
-- 1������ �����ϰ�
CREATE SEQUENCE SEQ_ABS_NO;

-- �л��� ������ ��쿡 ���� ���̺� INSERT ��Ű��
-- �������̺��� ���п��ΰ� Y�� �Ǵ� ��� 
-- �л����̺��� �������θ� �������� �����Ѵ�.
INSERT INTO TB_ABSENCE 
VALUES(SEQ_ABS_NO.NEXTVAL, 904, SYSDATE, DEFAULT);

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 904;
-- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
-- �л����̺��� �������� �������� ����
UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE STU_NO = 904;

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 904;

-- TB_ABSENCE�� INSERT �Ǹ� �ڵ����� �������� �ٲٰ� �ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_STU_01
AFTER INSERT ON TB_ABSENCE
FOR EACH ROW
BEGIN
    UPDATE TB_STU
    SET STU_STATUS = '����'
    WHERE STU_NO = :NEW.STU_NO;
    
END;
/

INSERT INTO TB_ABSENCE
VALUES(SEQ_ABS_NO.NEXTVAL, 902, SYSDATE, DEFAULT);

-- ABS_STATUS = 'N'���� �ٲ�� STU_STATUS = '����'���� �ٲ�� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_STU_02
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
    IF(:NEW.ABS_STATUS = 'N')
    THEN 
        UPDATE TB_STU
        SET STU_STATUS = '����'
        WHERE STU_NO = :NEW.STU_NO;
    END IF;
    
END;
/

UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE STU_NO = 902;

INSERT INTO TB_ABSENCE
VALUES(SEQ_ABS_NO.NEXTVAL, 900, SYSDATE, DEFAULT);

UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE STU_NO = 900;

COMMIT;

-- �л����̺��� �������ΰ� ������ �Ǵ� ���
-- �ش絥���͸� DELETE ó��(���п��� ������ ���е� ����Ʈ) �Ѵ�.
UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 902;

DELETE FROM TB_STU
WHERE STU_NO = 902;


CREATE OR REPLACE TRIGGER TRG_STU_03
AFTER UPDATE ON TB_STU
FOR EACH ROW
BEGIN
    IF (:NEW.STU_STATUS = '����')
    THEN 
    DELETE FROM TB_STU_COPY
    WHERE STU_NO = :NEW.STU_NO;
    
    DELETE FROM TB_ABSENCE
    WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/

DROP TRIGGER TRG_STU_03;

CREATE TABLE TB_STU_COPY
AS SELECT *
    FROM TB_STU;

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 904;