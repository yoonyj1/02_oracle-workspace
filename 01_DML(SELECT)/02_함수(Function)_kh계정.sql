/*
    <�Լ� FUNCTION>
    ���� �� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    - ���� �� �Լ�: N���� ���� �о�鿩�� N���� ������� ����(�� �ึ�� �Լ� ���� ����� ��ȯ)
    - �׷��Լ�: N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ��� ������ ��ȯ)
    
    >> SELECT ���� ������ �Լ��� �׷��Լ� �Բ� ������
        => ������� ������ �ٸ��� ����
        
    >> �Լ����� ����� �� �ִ� ��ġ: SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

/*
    <���� ó�� �Լ�>
    * LENGTH / LENGTHB      => ����� NUMBER Ÿ��
    
    LENGTH(�÷� | '���ڿ���'): �ش� ���ڿ� ���� ���� �� ��ȯ
    LENGTHB(�÷� | '���ڿ���'): �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��' '��' '��' �� ���ڴ� 3BYTE
    ������, ����, Ư������ �� ���ڴ� 1BYTE
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- DUAL: �������̺�(����� ���̺��� ���� �� ���)

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- �� �ึ�� �� ����ǰ� ���� => ���� �� �Լ�

/*
    * INSTR
    ���ڿ��κ��� Ư�������� ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ� ����', ['ã����ġ�� ���۰�', [����]])        => ����� NUMBER Ÿ��
    
    ã�� ��ġ�� ���۰�
    1: �տ������� ã��
    -1: �ڿ������� ã��
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ���� �� ã����ġ�� ���۰� 1(�⺻��) => �տ������� ã��, ������ 1�� �⺻��
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- �ι�° B�� ã�� ����
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_��ġ", INSTR(EMAIL, '@') AS "@ ��ġ"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    *  SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹ��� substring()�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => ����� CHARACTER Ÿ��
     - STRING: ����Ÿ���÷� �Ǵ� '���ڿ�'
     - POSITION: ���ڿ��� ������ ������ġ��
     - LENGTH: ������ ���� ����(���� �� ������)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3') -- ���������� �ڵ� ����ȯ
ORDER BY EMP_NAME;

-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "���̵�"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����]) => ������ �������� ä��
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ����/�����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ� ��ȯ
*/

-- 20��ŭ�� ���� �� EMAIL �÷����� ���������� �����ϰ� ������ �κ��� �������� ä����
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** ������ ��ȸ -> �� ���ڼ�: 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, EMP_NO, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    [ǥ����]
    LTRIM/RTRIM(STRING, ['������ ���ڵ�'])        => ���� �� ���� ����
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('   K H ') FROM DUAL; -- ���ʿ� �ִ� ���� ���� 'K H ' ��ȯ / ���� ã�Ƽ� �����ϰ� ���� �ƴ� ���ڰ� ������ ����
SELECT LTRIM('123123KH123', '123') FROM DUAL; -- 'KH123'���
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL; -- �����ʿ� �ִ� ���� ����

/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    [ǥ����]
    TRIM([[LEADING|TRAILING|BOTH] �����ϰ��� �ϴ� ���ڵ� FROM] STRING )
*/

SELECT TRIM('   K H   ') FROM DUAL; -- ���ʿ� �ִ� �������� �� 'K H'���
-- SELECT TRIM('ZZZZKHZZZZ', 'Z') FROM DUAL; -- ���� �߻�
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- Z ���� �� 'KH' ���
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- ������ Z ���� �� 'KHZZZZ' ���
-- LEADING: �� ���� => LTRIM�� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- �������� Z ���� �� 'ZZZZKH' ���
-- TRAILING: �� ���� => RTRIM�� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- ������ Z ���� �� 'KH' ���
-- BOTH: �� �� ���� => ���� �� �⺻�� 

--------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    [ǥ����]
    LOWER / UPPER / INITCAP(STRING)         => ����� CHARACTER Ÿ��
    
    LOWER: �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹ��� toLowerCase()�� ����)
    UPPER: �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹ��� toUpperCase()�� ����)
    INITCAP: �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;
--------------------------------------------------------------------------------

/*
    * CONCAT
    ���ڿ��� �ΰ� ���޹޾Ƽ� �ϳ��� ��ģ �� ��� ��ȯ
    
    [ǥ����]
    CONCAT(STRING, STRING)      => ����� CHARACTER Ÿ��
*/

SELECT CONCAT('ABC', '���ݸ�') FROM DUAL; -- 'ABC���ݸ�' ��ȯ
SELECT 'ABC' || '���ݸ�' FROM DUAL; -- ����

SELECT CONCAT ('ABC', '���ݸ�', '�԰�ʹ�') FROM DUAL; -- invalid number of arguments �����߻�: ���ڿ� �� ���� ���޹��� �� ����
-- �ذ���: ���Ῥ���� ���
SELECT 'ABC' || '���ݸ�' || '�԰�ʹ�' FROM DUAL;

--------------------------------------------------------------------------------
/*
    * REPLACE
    
    [ǥ����]
    REPLACE(STRING, STR1, STR2)     => ����� CHARACTER Ÿ��
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

/*
SELECT EMP_NAME, EMP_NO, REPLACE(EMP_NO, SUBSTR(EMP_NO, 9, 14), '******')
FROM EMPLOYEE;
*/

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
    <���� ó�� �Լ�>
    
    * ABS: ������ ���밪�� �����ִ� �Լ�
    
    [ǥ����]
    ABS(NUMBER)         => ������� NUMBER Ÿ��
*/    

SELECT ABS(-10) FROM DUAL;

--------------------------------------------------------------------------------
/*
    * MOD: �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    [ǥ����]
    MOD(NUMBER1, NUMBER2)   => ������� NUMBER Ÿ��
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
--------------------------------------------------------------------------------
/*
    * ROUND: �ݿø��� ����� ��ȯ
    
    [ǥ����]
    ROUND(NUMBER, [��ġ])     => ������� NUMBER Ÿ��
    ��ġ ������ 0��° �ڸ����� �ݿø�
*/

SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 5) FROM DUAL; -- ��ġ���� ū ���ڸ� ������ �״�� ��µ�
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;
--------------------------------------------------------------------------------
/*
    * CEIL
    �ø�ó�� ���ִ� �Լ�
    
    [ǥ����]
    CELI(NUMBER)
*/

SELECT CEIL(123.152) FROM DUAL; -- 5 �̻��� �ƴϾ ������ �ø� / ��ġ���� �Ұ�
--------------------------------------------------------------------------------
/*
    * FLOOR
    �Ҽ��� �Ʒ� ����ó�� �ϴ� �Լ�
    
    [ǥ����]
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.152) FROM DUAL;
SELECT FLOOR(123.952) FROM DUAL; -- ������ ���� / ��ġ���� �Ұ�
--------------------------------------------------------------------------------
/*
    * TRUNC (�����ϴ�) **
    ��ġ���� ������ ����ó�� �Լ�
    
    [ǥ����]
    TRUNC(NUMBER, [��ġ])
*/

SELECT TRUNC(123.456) FROM DUAL; -- ��ġ���� ���� ��� FLOOR�� ������
SELECT TRUNC(123.456, 1) FROM DUAL; -- �Ҽ��� �Ʒ� ù° �ڸ����� ǥ��
SELECT TRUNC(123.456, -1) FROM DUAL;
--------------------------------------------------------------------------------
/*
    <��¥ ó�� �Լ�>
*/
-- SYSDATE: �ý��ۿ� �ִ� ��¥ �� �ð� ��ȯ(���� ��¥ �� �ð�)
SELECT SYSDATE FROM DUAL; -- Ŭ���ؼ� Ȯ�� �� �ð��� Ȯ�� ����

-- * MONTHS_BETWEEN(DATE1, DATE2): �� ��¥ ������ ���� �� ��ȯ => ���������� DATE1 - DATE2 �� ������ 30, 31
-- EMPLOYEE���� �����, �ٹ��ϼ�, �ٹ�������
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '��' AS "�ٹ��ϼ�", 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER): Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ��ȯ
-- => ����� DATE Ÿ��
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
-- EMPLOYEE���� �����, �Ի���, �Ի� �� 6������ �� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "�Ի� �� 6����"
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����): Ư����¥ ������ ���� ����� �ش� ������ ��¥�� ��ȯ 
-- => ����� DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
-- 1: �Ͽ��� 2: ������ .... 7: �����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- ����: ������ �ѱ����� ������
-- ����
SELECT * FROM NLS_SESSION_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- ����� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- �ѱ���� ����

-- * LAST_DAY(DATE): �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
-- => ����� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE���� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� ���� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT: Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    EXTRACT(YEAR FROM DATE): �⵵�� ����
    EXTRACT(MONTH FROM DATE): ���� ����
    EXTRACT(DAY FROM DATE): �ϸ� ����
*/

-- �����, �Ի�⵵, �Ի��, �Ի���
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵", EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��", EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY �Ի�⵵, �Ի��, �Ի���;
--------------------------------------------------------------------------------
/*
    <�� ��ȯ �Լ�> =>> �ϱ�*
    
    * TO_CHAR(): ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ
    
    [ǥ����]
    TO_CHAR(����|��¥, [����])    ����� CHARACTER Ÿ��
*/
-- ����Ÿ�� -> ����Ÿ��
SELECT TO_CHAR(1324) FROM DUAL;
SELECT TO_CHAR(1324, '99999') FROM DUAL; -- 5ĭ¥�� ����Ȯ��, ������ ����, ��ĭ����
SELECT TO_CHAR(1324, '00000') FROM DUAL; -- ��ĭ�� 0���� ä��
SELECT TO_CHAR(1324, 'L99999') FROM DUAL; -- ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1324, '$99999') FROM DUAL;
SELECT TO_CHAR(1324, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- ��¥Ÿ�� -> ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- Ŭ���ؼ� Ȯ���غ��� ����Ÿ������ ��ȯ�Ǿ�����(�޷�ǥ�� �ȳ���)
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 12�ð������� �ð���ȯ
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24�ð������� �ð���ȯ
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- EX) 1900�� 02�� 06�� ����
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') -- ���� ���� ������ ���� ""�� ����
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), -- ���� �������� ������ ��ĥ°���� ��ȯ
       TO_CHAR(SYSDATE, 'DD'), -- �� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE, 'D')   -- �� �������� ������ ��ĥ°����
FROM DUAL;

-- ���Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_DATE: ����|���� Ÿ�� �����͸� ��¥Ÿ������ ��ȯ
    
    [ǥ����]
    TO_DATE(����|����, [����])        ����� DATE Ÿ��
*/

SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE('070101') FROM DUAL; -- 0���� �����ϴ� ��쿡�� 70101�� �ν��� => ''�� ��� ����Ÿ������ �����ؼ� ǥ��
SELECT TO_DATE('041030 143000') FROM DUAL; -- �ð����� ���� ���� ��쿡�� ���˱��� ����ؾ���
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 2014��
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098�� => ������ ���� ����� �ݿ���
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- 2014��
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 1998��
-- RR: �ش� ���ڸ� �⵵�� ���� 50���� ũ�� ���� ������ �⵵�� ��ȯ, 50���� ������ ���� ������ �⵵�� ��ȯ
--------------------------------------------------------------------------------
/*
    * TO_NUMBER: ���� Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_NUMBER(����, [����])     => ����� NUMBER Ÿ��
*/
SELECT TO_NUMBER('04270467160') FROM DUAL; -- �� ���� 0�� ���� (���� Ÿ������ ����)

SELECT '10000000' + '500000' FROM DUAL; -- ����Ŭ�� �ڵ�����ȯ�� �� ������
SELECT '10,000,000' + '500,000' FROM DUAL; -- �����߻�(�ȿ� ���ڸ� �־�� �ڵ�����ȯ)
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999') FROM DUAL; -- ���� ����ȯ
--------------------------------------------------------------------------------
/*
    < NULL ó�� �Լ� >
*/
-- ********NVL(�÷�, �ش� �÷����� NULL�� ��� ��ȯ�� ��)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- �� ����� �̸��� ���ʽ� ���� ����
SELECT EMP_NAME, (SALARY + SALARY * BONUS) * 12 || '��' AS "���ʽ� ����"
FROM EMPLOYEE; -- BONUS�� NULL�� ����� NULL�� ��ȯ

SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 || '��' AS "���ʽ� ����"
FROM EMPLOYEE; -- = SALARY * 12