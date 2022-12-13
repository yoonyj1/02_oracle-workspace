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



