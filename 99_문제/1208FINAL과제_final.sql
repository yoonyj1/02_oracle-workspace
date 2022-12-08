/*3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.*/
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE BOOK_NM LIKE '%_________________________%';

/*4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
        FROM TB_WRITER
        WHERE MOBILE_NO LIKE '019%' AND WRITER_NM LIKE '��%'
        ORDER BY 1)
WHERE ROWNUM = 1;

/*5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
���۰�(��)������ ǥ�õǵ��� �� ��)*/
SELECT COUNT(*) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING(WRITER_NO)
WHERE COMPOSE_TYPE = '�ű�';

/*6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
���°� ��ϵ��� ���� ���� ������ ��)*/

SELECT COMPOSE_TYPE, COUNT(COMPOSE_TYPE)
FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE
HAVING COUNT(COMPOSE_TYPE) >= 300
ORDER BY 2 DESC, 1 ASC;
/*
SELECT  WRITER_NO, COUNT(WRITER_NO)
FROM TB_BOOK_AUTHOR
GROUP BY WRITER_NO
ORDER BY 2 DESC;


SELECT * FROM TB_BOOK_AUTHOR; --2292
SELECT * FROM TB_BOOK; --1738*/

/*7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
        FROM TB_BOOK
        WHERE ISSUE_DATE < SYSDATE
        ORDER BY 2 DESC)
WHERE ROWNUM <= 1;

/*8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� ��
��)*/
SELECT *
FROM (SELECT WRITER_NM AS "�۰� �̸�", COUNT(*) AS "�� ��"
        FROM TB_WRITER
        JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
        GROUP BY WRITER_NM
        ORDER BY 2 DESC)
WHERE ROWNUM <= 3;

/*9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)*/
UPDATE TB_WRITER W
SET REGIST_DATE =  (SELECT MIN(ISSUE_DATE)
                    FROM TB_BOOK
                    JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
                    JOIN TB_WRITER USING(WRITER_NO)
                    WHERE WRITER_NO = W.WRITER_NO
                    );
                    
                    COMMIT;

/*10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
�� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
(Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)*/
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK NOT NULL,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER NOT NULL,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);

COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰���ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '�������';

/*11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)*/
SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

INSERT ALL
INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

DELETE FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

/*12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
/*SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A USING(BOOK_NO)
JOIN TB_WRITER W USING(WRITER_NO)
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');
�߸�ǰ*/

SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK_AUTHOR A
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE COMPOSE_TYPE IN ('����', '����', '��', '����') AND BOOK_NO LIKE '2007%';

/*13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
ǥ�õǵ��� �� ��)*/

/*14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)*/
INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);
COMMIT;

/*15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.*/
SELECT W.WRITER_NM, COUNT(*)
FROM TB_WRITER W
JOIN TB_WRITER R ON(W.WRITER_NM = R.WRITER_NM)
WHERE W.WRITER_NM IN SUBSTR(R.WRITER_NM, 1)
GROUP BY W.WRITER_NM;

SELECT *
FROM (SELECT WRITER_NM, COUNT(*)
        FROM TB_WRITER
        GROUP BY WRITER_NM
        HAVING WRITER_NM IN(SUBSTR(WRITER_NM, 1)));




/*16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)*/
UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

/*17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02%' AND OFFICE_TELNO LIKE '02-___-%';

/*18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
SELECT WRITER_NM, REGIST_DATE
FROM TB_WRITER
WHERE ADD_MONTHS(REGIST_DATE, 372) <= '06/01/01';

/*19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
�������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. */
SELECT BOOK_NM, PRICE, CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
                            ELSE '�ҷ�����'
                            END
FROM TB_BOOK
WHERE STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1;

/*20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
��������,�����ڡ�,�����ڡ��� ǥ���� ��)*/
SELECT B.BOOK_NM AS "������", W.WRITER_NM AS "����", W.WRITER_NM AS "����"
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A ON(B.BOOK_NO = A.BOOK_NO)
JOIN TB_WRITER W ON(A.WRITER_NO = W.WRITER_NO)
WHERE W.WRITER_NM =(SELECT WRITER_NO
                    FROM TB_BOOK_TRANSLATOR
                    WHERE BOOK_NO = '1991081002');
                                
SELECT *
FROM (SELECT B.BOOK_NM AS "������", W.WRITER_NM AS "����", W.WRITER_NM AS "����"
        FROM TB_BOOK
        JOIN TB_BOOK_AUTHOR ON(B.BOOK_NO = A.BOOK_NO)
        JOIN TB_WRITER  ON(A.WRITER_NO = W.WRITER_NO);

SELECT *
FROM TB_BOOK_TRANSLATOR
WHERE BOOK_NO = '1991081002';

SELECT *
FROM TB_WRITER
WHERE WRITER_NO = '647';

SELECT *
FROM TB_BOOK_AUTHOR
WHERE BOOK_NO = '1991081002';

/*21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
������ ǥ�õǵ��� �� ��*/

