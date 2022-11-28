/*
************************************ SQL �����Լ� ***********************************

LENGTH(�÷��̸� OR '���ڿ�'): ���ڿ� ���� ���� �� ��ȯ
LENGTHB(�÷��̸� OR '���ڿ�'): ���ڿ� ���� ����Ʈ �� ��ȯ
INSTR(�÷��̸� OR '���ڿ�', 'ã�� ����', ['ã����ġ�� ���۰�', [����]])
- ã�� ��ġ�� ���۰�
  1: �տ������� ã��
 -1: �ڿ������� ã��
: ã����� ���ڸ� ��ġ�� ��ȯ
SUBSTR(�÷��̸� OR '���ڿ�',  ������ġ, [��������]) : ���� ���� �� ���
LPAD / RPAD(�÷��̸� OR '���ڿ�', ���ڱ���, [�߰��ҹ���])
LTRIM / RTRIM('���ڿ�', [������ ���ڵ�]) : ��/������ ������ ��������
 TRIM([LEADING,TRAILING,BOTH ������ ���ڵ�] STRING):
 - LEADING: ���ʿ� ������ ���ڵ� ����
 - TRAILING: �����ʿ� ������ ���ڵ� ����
 - BOTH: ���� ������ ���� ����
LOWER(STRING): �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹ��� toLowerCase()�� ����)
UPPER(STRING): �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹ��� toUpperCase()�� ����)
INITCAP(STRING): �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
CONCAT(STRING, STRING):  �ڹ� concat()�̶� ���� // ���� �ΰ��� ���� ����
REPLACE(STRING, STR1, STR2)

************************************ SQL �����Լ�************************************
ABS(NUMBER): ������ ���밪�� �����ִ� �Լ�
MOD(NUMBER1, NUMBER2):  �� ���� ���� ���������� ��ȯ���ִ� �Լ�
ROUND(NUMBER, [��ġ]): �ݿø��� ����� ��ȯ
CEIL(NUMBER): �ø�ó���� ��� ��ȯ
FLOOR(NUMBER): �Ҽ��� �Ʒ� ����ó�� �ϴ� �Լ�
TRUNC(NUMBER, [��ġ]): ��ġ���� ������ ����ó�� �Լ�

************************************* SQL ��¥�Լ� ************************************
SYSDATE: �ý��ۿ� �ִ� ��¥ �� �ð� ��ȯ(���� ��¥ �� �ð�)
MONTHS_BETWEEN(DATE1, DATE2): �� ��¥ ������ ���� �� ��ȯ
ADD_MONTHS(DATE, NUMBER): Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ��ȯ
NEXT_DAY(DATE, ����(����|����): Ư����¥ ������ ���� ����� �ش� ������ ��¥�� ��ȯ
LAST_DAY(DATE): �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
EXTRACT(YEAR FROM DATE): �⵵�� ����
EXTRACT(MONTH FROM DATE): ���� ����
EXTRACT(DAY FROM DATE): �ϸ� ����: Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�

*********************************** SQL ����ȯ �Լ� ************************************
TO_CHAR(����|��¥, [����]): ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ
TO_DATE(����|����, [����]): ����|���� Ÿ�� �����͸� ��¥Ÿ������ ��ȯ
TO_NUMBER(����,[����]): ����Ÿ���� ����Ÿ������ ��ȯ
*/

SELECT SYSDATE
FROM DUAL;
-- LENGTH / LENGTHB
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR
SELECT INSTR('AAAAAVBBBBBCCCCCE', 'V') FROM DUAL;
SELECT INSTR('AAAAAVBBBBBCCCCCE', 'E') FROM DUAL;
SELECT INSTR('AAAAAVBBBBBCCCCCE', 'V', -1) FROM DUAL;
SELECT INSTR('AAAAAVBBBBBCCCCCE', 'B', 1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_'), INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- SUBSTR
SELECT SUBSTR('ABCDEFG', 3)
FROM DUAL;

SELECT SUBSTR('SGDSHSDHS', 1, 4)
FROM DUAL;

SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-- LPAD, RPAD
SELECT EMP_NAME, LPAD(EMP_NAME, 15)
FROM EMPLOYEE;

-- LTRIM / RTIM
SELECT LTRIM('@@@@@III' ,'@') FROM DUAL;
SELECT RTRIM('QWER13254' ,'12345') FROM DUAL;

-- TRIM
SELECT TRIM(LEADING 'Q' FROM 'QWER123') FROM DUAL;

-- LOWER / UPPER / INITCAP
SELECT LOWER('HI') FROM DUAL;
SELECT UPPER('hi') FROM DUAL;
SELECT INITCAP('QWEGSAY') FROM DUAL;

-- CONCAT
SELECT CONCAT('QWER', '123') FROM DUAL;

-- REPLACE
SELECT REPLACE(EMP_NAME, '��', '��')
FROM EMPLOYEE;

--------------------------------------------------------------------------
-- ����ó��
SELECT ABS(-123) FROM DUAL;
SELECT MOD(20, 3) FROM DUAL;
SELECT ROUND(145.367, 2) FROM DUAL;
SELECT CEIL(132.222) FROM DUAL;
SELECT FLOOR(132.99) FROM DUAL;
SELECT TRUNC (132.99, 1) FROM DUAL;

---------------------------------------------------------------------------
-- ��¥ó��
SELECT EMP_NAME, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

SELECT EMP_NAME, ADD_MONTHS(SYSDATE, 24)
FROM EMPLOYEE;

SELECT NEXT_DAY(SYSDATE, 4) FROM DUAL;

SELECT LAST_DAY(ADD_MONTHS(SYSDATE, 3)) FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) AS "��" FROM DUAL;

---------------------------------------------------------------------------
-- ����ȯ �Լ�
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM DUAL;
SELECT TO_CHAR(12345, '999,999') FROM DUAL;
SELECT TO_CHAR(12345, 'L999,999') FROM DUAL;
SELECT TO_CHAR(12345, '999,999') FROM DUAL;

SELECT TO_DATE(221128) FROM DUAL;
SELECT TO_DATE(121212, 'YYMMDD') FROM DUAL;
SELECT TO_DATE(151215, 'RRMMDD HHMISS') FROM DUAL;
