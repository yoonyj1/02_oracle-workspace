-- [Basic SELECT]

-- 1.  �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" 
--���� ǥ���ϵ��� �Ѵ�.
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

-- 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN, 8, 1) = '2';

-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
--�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN '20' AND '30';

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
--������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7.  Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�. 
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
--������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

-- 10. 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ ��������
--�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002 AND ABSENCE_YN = 'N' AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '����';

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--[Additional SELECT - �Լ�]

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
--ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___';

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
--�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
--2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ����������
--����Ѵ�.)
SELECT PROFESSOR_NAME AS "�����̸�", CASE WHEN SUBSTR(PROFESSOR_SSN, 1, 2) >= 50 THEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))
                                         WHEN SUBSTR(PROFESSOR_SSN, 1, 2) < 50 THEN EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(PROFESSOR_SSN, 1, 2))
                                         END AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2;

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
--?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME, 2, 2)
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? �̶�,
--19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) + 1 != 20 AND NOT EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) + 1 = 19;

-- 6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(201225), 'DAY') FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
--�� �� ���� �ǹ��ұ�? �� TO_DATE('99/10/11','RR/MM/DD'),
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
SELECT TO_CHAR(TO_DATE(991011), 'YYYYMMDD') FROM DUAL; -- 1999�� 10�� 11��
SELECT TO_CHAR(TO_DATE(491011), 'YYYYMMDD') FROM DUAL; -- 2049�� 10�� 11��
SELECT TO_CHAR(TO_DATE(991011), 'RRRR') FROM DUAL; -- 1999�� 10�� 11��
SELECT TO_CHAR(TO_DATE(491011), 'RRRR') FROM DUAL; -- 2049�� 10�� 11��

-- 8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
--���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
--�ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178'
GROUP BY SUBSTR(TERM_NO, 1, 3);

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
--��µǵ��� �Ͻÿ�
SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л� ��(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
--�ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
GROUP BY COACH_PROFESSOR_NO
HAVING COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵", ROUND(AVG(POINT), 1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(*) AS "���л� ��"
FROM TB_STUDENT S
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY 1;

SELECT * FROM TB_STUDENT  ORDER BY DEPARTMENT_NO;



-- 14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. � SQL
--������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME AS "�����̸�", COUNT(*) AS "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING NOT COUNT(*) = 1
ORDER BY 1;

-- 15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
--ǥ���Ѵ�.)
SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') AS "�⵵", NVL(SUBSTR(TERM_NO, 5, 2), ' ') AS "�б�", ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4);

-- [Additional SELECT - Option] ------------------------------------------------
--------------------------------------------------------------------------------
-- 1.  �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л� �̸�" , STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�,
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�" 
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '��⵵%' OR STUDENT_ADDRESS LIKE '����%') AND STUDENT_NO LIKE '9%'
ORDER BY 1;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--������ ����)005
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY 2;

-- 5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--�ۼ��غ��ÿ�.
SELECT STUDENT_NO, TO_CHAR(POINT, '99.99')
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO = '200402'
ORDER BY 2 DESC;

-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL
--���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

-- 8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.
/*
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS ON TB_CLASS_PROFESSOR.CLASS_NO = TB_CLASS.CLASS_NO
JOIN TB_PROFESSOR ON TB_CLASS_PROFESSOR.PROFESSOR_NO = TB_CLASS.PROFESSOR_NO;


SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR CP, TB_CLASS C, TB_PROFESSOR P
WHERE C.DEPARTMENT_NO = P.DEPARTMENT_NO AND CP.CLASS_NO = C.CLASS_NO
GROUP BY CLASS_NAME, PROFESSOR_NAME;
*/

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP USING (CLASS_NO)
JOIN TB_PROFESSOR P USING (DEPARTMENT_NO)
GROUP BY CLASS_NAME, PROFESSOR_NAME;
-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
/*
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
INNER JOIN TB_CLASS 
ON TB_CLASS_PROFESSOR. CLASS_NO = TB_CLASS. CLASS_NO;
*/
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP USING (CLASS_NO)
JOIN TB_PROFESSOR P USING (DEPARTMENT_NO)
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
WHERE D.CATEGORY = '�ι���ȸ'
GROUP BY CLASS_NAME, PROFESSOR_NAME;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_PROFESSOR P USING (DEPARTMENT_NO)
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
WHERE D.CATEGORY = '�ι���ȸ'
GROUP BY CLASS_NAME, PROFESSOR_NAME
ORDER BY 1;

-- 10.  �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�",
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
-- �ݿø��Ͽ� ǥ������.)
SELECT S.STUDENT_NO AS "�й�", S.STUDENT_NAME AS "�л� �̸�", ROUND(AVG(POINT),1) AS "��ü ����"
FROM TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
WHERE S.STUDENT_NO = G.STUDENT_NO AND S.DEPARTMENT_NO = D.DEPARTMENT_NO AND D.DEPARTMENT_NAME = '�����а�'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY 1;

-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--��µǵ��� ����.

SELECT D.DEPARTMENT_NAME AS "�а��̸�", S.STUDENT_NAME AS "�л��̸�", P.PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.STUDENT_NO = 'A313047';

-- 12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ�
--SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, TERM_NO AS "TERM_NAME"
FROM TB_GRADE G
JOIN TB_STUDENT S USING (STUDENT_NO)
WHERE G.CLASS_NO = 'C2604100'
AND G.TERM_NO LIKE '2007%';

-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
/*
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
FULL JOIN TB_CLASS_PROFESSOR CP USING (CLASS_NO)
JOIN TB_PROFESSOR P USING (DEPARTMENT_NO)
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
WHERE D.CATEGORY = '��ü��' AND CP.PROFESSOR_NO IS NULL;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
WHERE D.CATEGORY = '��ü��';

SELECT * FROM TB_CLASS ORDER BY CLASS_NAME; --C088900
*/
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS_PROFESSOR P
FULL JOIN TB_CLASS C USING (CLASS_NO)
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
WHERE P.PROFESSOR_NO IS NULL AND D.CATEGORY = '��ü��'
ORDER BY 2, 1;

SELECT * FROM TB_PROFESSOR;

-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����
SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE D.DEPARTMENT_NAME = '���ݾƾ��а�';

-- 15.���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�", DEPARTMENT_NAME AS "�а� �̸�", ROUND(AVG(POINT),1) AS "����"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO)
JOIN TB_GRADE G USING (STUDENT_NO)
WHERE S.ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING ROUND(AVG(POINT),1) >= 4.0
ORDER BY 1;

SELECT STUDENT_NAME, ROUND(AVG(POINT),1)
FROM TB_STUDENT S
JOIN TB_GRADE G USING (STUDENT_NO)
WHERE S.ABSENCE_YN = 'N'
GROUP BY STUDENT_NAME
HAVING ROUND(AVG(POINT),1) >= 4.0;

-- 16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS C
JOIN TB_GRADE G USING(CLASS_NO)
WHERE DEPARTMENT_NO = '034' AND CLASS_TYPE LIKE '����%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
--SQL ���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NAME, S.STUDENT_ADDRESS
FROM TB_STUDENT S, TB_STUDENT T
WHERE S.DEPARTMENT_NO = '038' AND S.DEPARTMENT_NO = T.DEPARTMENT_NO
GROUP BY S.STUDENT_NAME, S.STUDENT_ADDRESS;

-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
--�ۼ��Ͻÿ�

SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT S
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO = '001' AND POINT = (SELECT MAX(POINT) FROM TB_GRADE)
GROUP BY STUDENT_NO, STUDENT_NAME
-- HAVING POINT = (SELECT MAX(POINT) FROM TB_GRADE)
ORDER BY 3 DESC;

SELECT S.STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT S, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO
GROUP BY S.STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                     FROM TB_GRADE);




-- 19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ���
--����.
SELECT DEPARTMENT_NAME AS "�迭�а���", ROUND(AVG(POINT), 1) AS "��������"
FROM TB_DEPARTMENT D, TB_STUDENT S, TB_GRADE G
WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO AND S.STUDENT_NO = G.STUDENT_NO AND D.CATEGORY = '�ڿ�����'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;


SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
 


