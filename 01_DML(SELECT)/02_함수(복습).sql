/*
************************************ SQL 문자함수 ***********************************

LENGTH(컬럼이름 OR '문자열'): 문자열 값의 글자 수 반환
LENGTHB(컬럼이름 OR '문자열'): 문자열 값의 바이트 수 반환
INSTR(컬럼이름 OR '문자열', '찾을 문자', ['찾을위치의 시작값', [순번]])
- 찾을 위치의 시작값
  1: 앞에서부터 찾음
 -1: 뒤에서부터 찾음
: 찾고싶은 문자를 위치로 반환
SUBSTR(컬럼이름 OR '문자열',  시작위치, [뽑을개수]) : 문자 추출 시 사용
LPAD / RPAD(컬럼이름 OR '문자열', 문자길이, [추가할문자])
LTRIM / RTRIM('문자열', [제거할 문자들]) : 왼/오른쪽 지정한 문자제거
 TRIM([LEADING,TRAILING,BOTH 제거할 문자들] STRING):
 - LEADING: 왼쪽에 제거할 문자들 제거
 - TRAILING: 오른쪽에 제거할 문자들 제거
 - BOTH: 양쪽 제거할 문자 제거
LOWER(STRING): 다 소문자로 변경한 문자열 반환 (자바의 toLowerCase()와 유사)
UPPER(STRING): 다 대문자로 변경한 문자열 반환 (자바의 toUpperCase()와 유사)
INITCAP(STRING): 단어 앞글자마다 대문자로 변경한 문자열 반환
CONCAT(STRING, STRING):  자바 concat()이랑 동일 // 문자 두개만 전달 가능
REPLACE(STRING, STR1, STR2)

************************************ SQL 숫자함수************************************
ABS(NUMBER): 숫자의 절대값을 구해주는 함수
MOD(NUMBER1, NUMBER2):  두 수로 나눈 나머지값을 변환해주는 함수
ROUND(NUMBER, [위치]): 반올림한 결과를 반환
CEIL(NUMBER): 올림처리한 결과 반환
FLOOR(NUMBER): 소수점 아래 버림처리 하는 함수
TRUNC(NUMBER, [위치]): 위치지정 가능한 버림처리 함수

************************************* SQL 날짜함수 ************************************
SYSDATE: 시스템에 있는 날짜 및 시간 반환(현재 날짜 및 시간)
MONTHS_BETWEEN(DATE1, DATE2): 두 날짜 사이의 개월 수 반환
ADD_MONTHS(DATE, NUMBER): 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 반환
NEXT_DAY(DATE, 요일(문자|숫자): 특정날짜 이후의 가장 가까운 해당 요일의 날짜를 반환
LAST_DAY(DATE): 해당 월의 마지막 날짜를 구해서 반환
EXTRACT(YEAR FROM DATE): 년도만 추출
EXTRACT(MONTH FROM DATE): 월만 추출
EXTRACT(DAY FROM DATE): 일만 추출: 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수

*********************************** SQL 형변환 함수 ************************************
TO_CHAR(숫자|날짜, [포맷]): 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환
TO_DATE(숫자|문자, [포맷]): 숫자|문자 타입 데이터를 날짜타입으로 변환
TO_NUMBER(문자,[포맷]): 문자타입을 숫자타입으로 변환
*/

SELECT SYSDATE
FROM DUAL;
-- LENGTH / LENGTHB
SELECT LENGTH('오라클'), LENGTHB('오라클')
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
SELECT REPLACE(EMP_NAME, '하', '허')
FROM EMPLOYEE;

--------------------------------------------------------------------------
-- 숫자처리
SELECT ABS(-123) FROM DUAL;
SELECT MOD(20, 3) FROM DUAL;
SELECT ROUND(145.367, 2) FROM DUAL;
SELECT CEIL(132.222) FROM DUAL;
SELECT FLOOR(132.99) FROM DUAL;
SELECT TRUNC (132.99, 1) FROM DUAL;

---------------------------------------------------------------------------
-- 날짜처리
SELECT EMP_NAME, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

SELECT EMP_NAME, ADD_MONTHS(SYSDATE, 24)
FROM EMPLOYEE;

SELECT NEXT_DAY(SYSDATE, 4) FROM DUAL;

SELECT LAST_DAY(ADD_MONTHS(SYSDATE, 3)) FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) AS "년" FROM DUAL;

---------------------------------------------------------------------------
-- 형변환 함수
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL;
SELECT TO_CHAR(12345, '999,999') FROM DUAL;
SELECT TO_CHAR(12345, 'L999,999') FROM DUAL;
SELECT TO_CHAR(12345, '999,999') FROM DUAL;

SELECT TO_DATE(221128) FROM DUAL;
SELECT TO_DATE(121212, 'YYMMDD') FROM DUAL;
SELECT TO_DATE(151215, 'RRMMDD HHMISS') FROM DUAL;
