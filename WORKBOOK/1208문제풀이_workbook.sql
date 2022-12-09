----------------------------------DDL-------------------------------------------
/* 1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺���
�ۼ��Ͻÿ�.
���̺� �̸�
TB_CATEGORY
�÷�
NAME, VARCHAR2(10) 
USE_YN, CHAR(1), �⺻���� Y �� ������
*/
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
���̺��̸�
TB_CLASS_TYPE
�÷�
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)*/
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

/*3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������
�˾Ƽ� ������ �̸��� ����Ѵ�.)*/
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

/*4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�*/
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.*/
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20); 
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

/*6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
���� ���·� �����Ѵ�.
(ex. CATEGORY_NAME)*/
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

/*7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
�����Ͻÿ�.
Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )*/
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007279 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007278 TO PK_CLASS_TYPE_NO;

/*8. ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT; */
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;


/*9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )*/
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

/*10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
�� �̸�
VW_�л��Ϲ�����
�÷�
�й�
�л��̸�
�ּ�*/
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS (SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT);
    
GRANT CREATE VIEW TO workbook;

/*11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�. 
�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
�� �̸�
VW_�������
�÷�
�л��̸�
�а��̸�
���������̸�*/
CREATE OR REPLACE VIEW VW_�������
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, NVL(PROFESSOR_NAME, '��������������') AS "��������"
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
    ORDER BY 2;
    
SELECT * FROM VW_�������;

/*12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
�� �̸�
VW_�а����л���
�÷�
DEPARTMENT_NAME
STUDENT_COUNT*/
CREATE VIEW VW_�а����л���
AS (SELECT DEPARTMENT_NAME, COUNT(STUDENT_NO) AS "STUDENT_COUNT"
    FROM TB_DEPARTMENT
    JOIN TB_STUDENT USING(DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME);


/*13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
�̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.*/
SELECT * FROM VW_�л��Ϲ�����;

UPDATE VW_�л��Ϲ�����
SET STUDENT_NAME = '������'
WHERE STUDENT_NO = 'A213046';

ROLLBACK;

/*14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.*/
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT  G.STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT S
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO);
    
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT S
    WITH READ ONLY;


/*15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
�ۼ��غ��ÿ�.
�����ȣ �����̸� ������������(��)
---------- ------------------------------ ----------------
C1753800 �������� 29
C1753400 ���ü�� 23
C2454000 �����۹�������Ư�� 22*/
/*SELECT �����̸�, ������������(��)
FROM (
        SELECT CLASS_NO AS "�����ȣ", CLASS_NAME AS "�����̸�", COUNT(STUDENT_NO) AS "������������(��)"
        FROM TB_CLASS C
        JOIN TB_GRADE G USING(CLASS_NO)
        WHERE TERM_NO LIKE '2009%' OR TERM_NO LIKE '2008%' OR TERM_NO LIKE '2007%'
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY 3 DESC
        );*/
        
/*SELECT V.�����ȣ
     , V.�����̸�
     , V."������������(��)"
  FROM (SELECT C.CLASS_NO �����ȣ
             , C.CLASS_NAME �����̸�
             , COUNT(*) "������������(��)"
          FROM TB_CLASS C
          JOIN (SELECT * FROM TB_GRADE
                WHERE SUBSTR(TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')) G 
                ON(C.CLASS_NO = G.CLASS_NO)
         GROUP BY C.CLASS_NO, C.CLASS_NAME
         ORDER BY 3 DESC) V
 WHERE ROWNUM < 4;
 */         

SELECT *
FROM (SELECT CLASS_NO AS "�����ȣ", CLASS_NAME AS "�����̸�", COUNT(STUDENT_NO) AS "������������(��)"
        FROM TB_CLASS 
        JOIN TB_GRADE USING(CLASS_NO)
        WHERE TERM_NO LIKE '2009%' OR TERM_NO LIKE '2008%' OR TERM_NO LIKE '2007%' OR TERM_NO LIKE '2006%' OR TERM_NO LIKE '2005%' 
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY 3 DESC)
WHERE ROWNUM <= 3;

----------------------------------DML-------------------------------------------
/*1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
��ȣ, �����̸�
------------
01, �����ʼ�
02, ��������
03, �����ʼ�
04, ���缱��
05. ������*/
INSERT INTO TB_CLASS_TYPE VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05', '������');
      
/*2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
���̺��̸�
TB_�л��Ϲ�����
�÷�
�й�
�л��̸�
�ּ�*/
CREATE TABLE TB_�л��Ϲ�����
AS (SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
    FROM TB_STUDENT);
    
/*3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�. 
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
�ۼ��Ͻÿ�)
���̺��̸�
TB_������а�
�÷�
�й�
�л��̸�
����⵵ <= ���ڸ� �⵵�� ǥ��
�����̸�*/
-- ������а� �л����� ������ ��ȸ
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�"
        , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), 'YYYY') AS "����⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001';

-- �������� �̿��ؼ� ���̺� ����
CREATE TABLE TB_������а�
AS (SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�"
        , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), 'YYYY') AS "����⵵"
    FROM TB_STUDENT
    WHERE DEPARTMENT_NO = '001');

/*4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
�ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����)*/
UPDATE TB_DEPARTMENT 
SET CAPACITY = ROUND(CAPACITY * 1.1);

/*5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�
�Ѵ�. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.*/
-- �ڰǿ� ���� ��ȸ
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21' --��⵵ ���ֽ� ������ ����2�� ��65����
WHERE STUDENT_NO = 'A413042';

/*6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
�����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
(��. 830530-2124663 ==> 830530 )*/
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

/*7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
�߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.*/
-- ���а� ����� �й� ��ȸ
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE STUDENT_NAME = '�����';
--A331101

-- ����� 2005�� 1�б� �Ǻλ����� CLAS_NO��ȸ
SELECT TERM_NO, CLASS_NO, CLASS_NAME, POINT
FROM TB_GRADE G
JOIN TB_CLASS C USING(CLASS_NO)
WHERE CLASS_NAME = '�Ǻλ�����' AND STUDENT_NO = 'A331101';
--C3843900

-- ����
UPDATE TB_GRADE
SET POINT = 3.5 --1.5
WHERE STUDENT_NO = 'A331101' AND CLASS_NO = 'C3843900';

/*8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.*/
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                      FROM TB_STUDENT
                      WHERE ABSENCE_YN = 'Y');
                      
                      ROLLBACK;
                      
            