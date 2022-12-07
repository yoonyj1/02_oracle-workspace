--�ǽ�����--
-- ó���� DROP���� �� ���� ���� ���̺� �������� �ۼ� => �ܷ�Ű�� �������� �� �ֱ� ������
DROP TABLE TB_RENT;
DROP TABLE TB_MEMBER;
DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;

--�������� ���α׷��� ����� ���� ���̺��� �����
--�̶�, �������ǿ� �̸��� �ο��� ��
-- �� �÷��� �ּ��ޱ�


--1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺�(TB_PUBLISHER)
--�÷�: PUB_NO(���ǻ��ȣ) --�⺻Ű(PUBLISHER_PK)
-- PUB_NAME(���ǻ��) --NOT NULL(PUBLICHSER_NN)
-- PHONE(���ǻ���ȭ��ȣ) --�������� ����

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY, -- NUMBER�� �����ϰ� �Ǹ� 001 �Է��ص� 1�� ����� => 001�� �����ϰ� ������ VARCHAR2�� �����ؾ���
    PUB_NAME VARCHAR2(30) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(15)
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';

--3�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_PUBLISHER
VALUES(001, '������Ʈ', '02-456-7890');
INSERT INTO TB_PUBLISHER
VALUES(002, '�����ݷ�', '031-639-8520');
INSERT INTO TB_PUBLISHER
VALUES(003, '���е���', '02-789-1475');

--2. �����鿡 ���� �����͸� ��� ���� ���� ���̺�(TB_BOOK)
--�÷�: BK_NO(������ȣ) --�⺻Ű(BOOK_PK)
-- BK_TITLE(������) --NOT NULL(BOOK_NN_TITLE)
-- BK_AUTHOR(���ڸ�) --NOT NULL(BOOK_NN_AUTHOR)
-- BK_PRICE(����)
-- BK_STOCK(���) --�⺻�� 1�� ����
-- BK_PUB_NO(���ǻ��ȣ) --�ܷ�Ű(BOOK_FK)(TB_PUBLISHER ���̺��� �����ϵ���)
-- �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽĵ����͵� �����ǵ��� ����

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(60) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(30) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT '1', -- DEFAULT�� �ڷ��� �ٷ� ���� ���;��ϸ�, DEFAULT���� �ڷ����� ��ġ�ؾ���
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER ON DELETE CASCADE -- �ܷ�Ű�� ������ ���� �����ϰ� �Ǵ� �÷��� �ڷ����� ��ġ�ؾ���.
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '���';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';

--5�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_BOOK
VALUES(100, '�븶�� ������ ����', '�� ����', 31500, 200, 001);
INSERT INTO TB_BOOK
VALUES(101, '�� ì�� �Ծ��, �ູ�ϼ���', '����������Ÿ', 20000, 300, 002);
INSERT INTO TB_BOOK
VALUES(102, '������ ����', '�迵��', 12150, 500, 003);
INSERT INTO TB_BOOK
VALUES(103, '��������', 'J.B.��Ű��', 16650, DEFAULT, 003);
INSERT INTO TB_BOOK
VALUES(104, '��� �����', '�輱��', 14400, 1280, 001);
INSERT 
INTO TB_BOOK
        (
          BK_NO
        , BK_TITLE
        , BK_AUTHOR
        )
VALUES
        (
            2
        , '�λ��� ����'
        , '����ö'
        );

SELECT * FROM TB_BOOK;



--3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺�(TB_MEMBER)
--�÷���: MEMBER_NO(ȸ����ȣ) --�⺻Ű(MEMBER_PK)
-- MEMBER_ID(���̵�) --�ߺ�����(MEMBER_UQ)
--MEMBER_PWD(��й�ȣ) NOT NULL(MEMBER_NN_PWD)
--MEMBER_NAME(ȸ����) NOT NULL(MEMBER_NN_NAME)
--GENDER(����) 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)
--ADDRESS(�ּ�)
--PHONE(����ó)
--STATUS(Ż�𿩺�) --�⺻������ 'N' �׸��� 'Y' Ȥ�� 'N'���� �Էµǵ��� ��������(MEMBER_CK_STA)
--ENROLL_DATE(������) --�⺻������ SYSDATE, NOT NULL ����(MEMBER_NN_EN)
--5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(10) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(150),
    PHONE VARCHAR2(15),
    STATUS CHAR(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';

INSERT 
INTO TB_MEMBER
            (
              MEMBER_NO
            , MEMBER_ID
            , MEMBER_PWD
            , MEMBER_NAME
            )
VALUES
            (
                1520
                , 'yoonyj1'
                , '1q2w3e4r!'
                , '������'
            );
            
INSERT
INTO TB_MEMBER
        (
          MEMBER_NO
        , MEMBER_ID
        , MEMBER_PWD
        , MEMBER_NAME
        )
VALUES
        (
          1521
        , 'yoonyj2'
        , '1q2w3e4r!'
        , '������'
        );
        
INSERT INTO TB_MEMBER
VALUES(1523, 'insert01', 'delete1', '�輱��', 'M', '��⵵ ��õ��', '010-4657-8910', 'Y', '22/12/05');

INSERT INTO TB_MEMBER
VALUES(1522, 'delete02', 'insert01', '�ӿ���', 'F', '����Ư����', '010-7985-1218', DEFAULT, DEFAULT); 

INSERT 
INTO TB_MEMBER
        (
              MEMBER_NO
            , MEMBER_ID
            , MEMBER_PWD
            , MEMBER_NAME
       )
VALUES
        (
                1230
            , 'qwer1234'
            , 'unionall'
            , '����ö'
        );


--4. ������ �뿩�� ȸ���� ���� �����͸� ��� ���� �뿩��� ���̺�(TB_RENT)
--�÷�:
--RENT_NO(�뿩��ȣ) --�⺻Ű(RENT_PK)
--RENT_MEM_NO(�뿩ȸ����ȣ) --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼ� ����
--RENT_BOOK_NO(�뿩������ȣ) --�ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼǼ���
--RENT_DATE(�뿩��) --�⺻�� SYSDATE
--���õ����� 3������ �߰��ϱ�
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩������ȣ';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '�뿩��';

INSERT INTO TB_RENT
VALUES(1, 1520, 102, '22/11/22');
INSERT INTO TB_RENT
VALUES(2, 1521, 2, DEFAULT);
INSERT INTO TB_RENT
VALUES(3, 1522, 100, '22/10/10');

--2�� ������ �뿩�� ȸ���� �̸�, ���̵�, �뿩��, �ݳ�������(�뿩��+7)�� ��ȸ�Ͻÿ�.
-- ANSI ����
SELECT MEMBER_NAME, MEMBER_ID, RENT_DATE, RENT_DATE + 7 AS "�ݳ�������"
FROM TB_MEMBER M
JOIN TB_RENT R ON(MEMBER_NO = RENT_MEM_NO)
WHERE RENT_BOOK_NO = '2';

-- ����Ŭ ����
SELECT MEMBER_NAME, MEMBER_ID, RENT_DATE, RENT_DATE + 7 AS "�ݳ�������"
FROM TB_MEMBER, TB_RENT
WHERE MEMBER_NO = RENT_MEM_NO AND RENT_BOOK_NO = '2';
