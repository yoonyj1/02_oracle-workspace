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