/*
    <함수 FUNCTION>
    전달 된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
    
    - 단일 행 함수: N개의 값을 읽어들여서 N개의 결과값을 리턴(매 행마다 함수 실행 결과를 반환)
    - 그룹함수: N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수를 실행결과 반환)
    
    >> SELECT 절에 단일행 함수와 그룹함수 함께 사용못함
        => 결과행의 개수가 다르기 때문
        
    >> 함수식을 기술할 수 있는 위치: SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/

/*
    <문자 처리 함수>
    * LENGTH / LENGTHB      => 결과값 NUMBER 타입
    
    LENGTH(컬럼 | '문자열값'): 해당 문자열 값의 글자 수 반환
    LENGTHB(컬럼 | '문자열값'): 해당 문자열 값의 바이트 수 반환
    
    '김' '나' 'ㄱ' 한 글자당 3BYTE
    영문자, 숫자, 특수문자 한 글자당 1BYTE
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- DUAL: 가상테이블(사용할 테이블이 없을 때 사용)

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- 매 행마다 다 실행되고 있음 => 단일 행 함수

/*
    * INSTR
    문자열로부터 특정문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼|'문자열', '찾고자하는 문자', ['찾을위치의 시작값', [순번]])        => 결과값 NUMBER 타입
    
    찾을 위치의 시작값
    1: 앞에서부터 찾음
    -1: 뒤에서부터 찾음
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 생략 시 찾을위치의 시작값 1(기본값) => 앞에서부터 찾음, 순번도 1이 기본값
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 두번째 B를 찾는 구문
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@ 위치"
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    *  SUBSTR
    문자열에서 특정 문자열을 추출해서 반환(자바의 substring()과 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => 결과값 CHARACTER 타입
     - STRING: 문자타입컬럼 또는 '문자열'
     - POSITION: 문자열을 추출할 시작위치값
     - LENGTH: 추출할 문자 개수(생략 시 끝까지)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

-- 여자 사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 남자사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3') -- 내부적으로 자동 형변환
ORDER BY EMP_NAME;

-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "아이디"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자]) => 생략시 공백으로 채움
    문자열에 덧붙이고자 하는 문자를 왼쪽/오른쪽에 덧붙여서 최종 N길이만큼의 문자열 반환
*/

-- 20만큼의 길이 중 EMAIL 컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채워짐
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** 나오게 조회 -> 총 글자수: 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, EMP_NO, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    [표현법]
    LTRIM/RTRIM(STRING, ['제거할 문자들'])        => 생략 시 공백 제거
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/

SELECT LTRIM('   K H ') FROM DUAL; -- 왼쪽에 있는 공백 제거 'K H ' 반환 / 공백 찾아서 제거하고 공백 아닌 문자가 나오면 끝남
SELECT LTRIM('123123KH123', '123') FROM DUAL; -- 'KH123'출력
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL; -- 오른쪽에 있는 숫자 제거

/*
    * TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    
    [표현법]
    TRIM([[LEADING|TRAILING|BOTH] 제거하고자 하는 문자들 FROM] STRING )
*/

SELECT TRIM('   K H   ') FROM DUAL; -- 양쪽에 있는 공백제거 후 'K H'출력
-- SELECT TRIM('ZZZZKHZZZZ', 'Z') FROM DUAL; -- 오류 발생
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- Z 제거 후 'KH' 출력
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- 왼쪽의 Z 제거 후 'KHZZZZ' 출력
-- LEADING: 앞 제거 => LTRIM과 유사
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- 오른쪽의 Z 제거 후 'ZZZZKH' 출력
-- TRAILING: 뒤 제거 => RTRIM과 유사
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- 양쪽의 Z 제거 후 'KH' 출력
-- BOTH: 양 쪽 제거 => 생략 시 기본값 

--------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INITCAP
    
    [표현법]
    LOWER / UPPER / INITCAP(STRING)         => 결과값 CHARACTER 타입
    
    LOWER: 다 소문자로 변경한 문자열 반환 (자바의 toLowerCase()와 유사)
    UPPER: 다 대문자로 변경한 문자열 반환 (자바의 toUpperCase()와 유사)
    INITCAP: 단어 앞글자마다 대문자로 변경한 문자열 반환
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;
--------------------------------------------------------------------------------

/*
    * CONCAT
    문자열을 두개 전달받아서 하나로 합친 후 결과 반환
    
    [표현법]
    CONCAT(STRING, STRING)      => 결과값 CHARACTER 타입
*/

SELECT CONCAT('ABC', '초콜릿') FROM DUAL; -- 'ABC초콜릿' 반환
SELECT 'ABC' || '초콜릿' FROM DUAL; -- 동일

SELECT CONCAT ('ABC', '초콜릿', '먹고싶다') FROM DUAL; -- invalid number of arguments 오류발생: 문자열 두 개만 전달받을 수 있음
-- 해결방법: 연결연산자 사용
SELECT 'ABC' || '초콜릿' || '먹고싶다' FROM DUAL;

--------------------------------------------------------------------------------
/*
    * REPLACE
    
    [표현법]
    REPLACE(STRING, STR1, STR2)     => 결과값 CHARACTER 타입
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
    <숫자 처리 함수>
    
    * ABS: 숫자의 절대값을 구해주는 함수
    
    [표현법]
    ABS(NUMBER)         => 결과값은 NUMBER 타입
*/    

SELECT ABS(-10) FROM DUAL;

--------------------------------------------------------------------------------
/*
    * MOD: 두 수로 나눈 나머지값을 변환해주는 함수
    
    [표현법]
    MOD(NUMBER1, NUMBER2)   => 결과값은 NUMBER 타입
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
--------------------------------------------------------------------------------
/*
    * ROUND: 반올림한 결과를 반환
    
    [표현법]
    ROUND(NUMBER, [위치])     => 결과값은 NUMBER 타입
    위치 생략시 0번째 자리에서 반올림
*/

SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 5) FROM DUAL; -- 위치보다 큰 숫자를 넣으면 그대로 출력됨
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;
--------------------------------------------------------------------------------
/*
    * CEIL
    올림처리 해주는 함수
    
    [표현법]
    CELI(NUMBER)
*/

SELECT CEIL(123.152) FROM DUAL; -- 5 이상이 아니어도 무조건 올림 / 위치지정 불가
--------------------------------------------------------------------------------
/*
    * FLOOR
    소수점 아래 버림처리 하는 함수
    
    [표현법]
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.152) FROM DUAL;
SELECT FLOOR(123.952) FROM DUAL; -- 무조건 버림 / 위치지정 불가
--------------------------------------------------------------------------------
/*
    * TRUNC (절삭하다) **
    위치지정 가능한 버림처리 함수
    
    [표현법]
    TRUNC(NUMBER, [위치])
*/

SELECT TRUNC(123.456) FROM DUAL; -- 위치지정 안할 경우 FLOOR와 동일함
SELECT TRUNC(123.456, 1) FROM DUAL; -- 소수점 아래 첫째 자리까지 표현
SELECT TRUNC(123.456, -1) FROM DUAL;
--------------------------------------------------------------------------------
/*
    <날짜 처리 함수>
*/
-- SYSDATE: 시스템에 있는 날짜 및 시간 반환(현재 날짜 및 시간)
SELECT SYSDATE FROM DUAL; -- 클릭해서 확인 시 시간도 확인 가능

-- * MONTHS_BETWEEN(DATE1, DATE2): 두 날짜 사이의 개월 수 반환 => 내부적으로 DATE1 - DATE2 후 나누기 30, 31
-- EMPLOYEE에서 사원명, 근무일수, 근무개월수
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수", 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER): 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 반환
-- => 결과값 DATE 타입
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
-- EMPLOYEE에서 사원명, 입사일, 입사 후 6개월이 된 날짜
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "입사 후 6개월"
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, 요일(문자|숫자): 특정날짜 이후의 가장 가까운 해당 요일의 날짜를 반환 
-- => 결과값 DATE 타입
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
-- 1: 일요일 2: 월요일 .... 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- 에러: 설정이 한국으로 되있음
-- 언어변경
SELECT * FROM NLS_SESSION_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 영어로 변경
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- 한국어로 변경

-- * LAST_DAY(DATE): 해당 월의 마지막 날짜를 구해서 반환
-- => 결과값 DATE 타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE에서 사원명, 입사일, 입사한 달의 마지막 날짜, 입사한 달의 근무한 일수
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT: 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수
    
    [표현법]
    EXTRACT(YEAR FROM DATE): 년도만 추출
    EXTRACT(MONTH FROM DATE): 월만 추출
    EXTRACT(DAY FROM DATE): 일만 추출
*/

-- 사원명, 입사년도, 입사월, 입사일
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도", EXTRACT(MONTH FROM HIRE_DATE) AS "입사월", EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY 입사년도, 입사월, 입사일;
--------------------------------------------------------------------------------
/*
    <형 변환 함수> =>> 암기*
    
    * TO_CHAR(): 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환
    
    [표현법]
    TO_CHAR(숫자|날짜, [포맷])    결과값 CHARACTER 타입
*/
-- 숫자타입 -> 문자타입
SELECT TO_CHAR(1324) FROM DUAL;
SELECT TO_CHAR(1324, '99999') FROM DUAL; -- 5칸짜리 공간확보, 오른쪽 정렬, 빈칸공백
SELECT TO_CHAR(1324, '00000') FROM DUAL; -- 빈칸을 0으로 채움
SELECT TO_CHAR(1324, 'L99999') FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR(1324, '$99999') FROM DUAL;
SELECT TO_CHAR(1324, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

-- 날짜타입 -> 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 클릭해서 확인해보면 문자타입으로 반환되어있음(달력표시 안나옴)
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 12시간형으로 시간반환
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24시간형으로 시간반환
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- EX) 1900년 02월 06일 형식
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') -- 없는 포맷 제시할 때는 ""로 묶기
FROM EMPLOYEE;

-- 년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 올해 기준으로 오늘이 며칠째인지 반환
       TO_CHAR(SYSDATE, 'DD'), -- 월 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE, 'D')   -- 주 기준으로 오늘이 며칠째인지
FROM DUAL;

-- 요일에 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_DATE: 숫자|문자 타입 데이터를 날짜타입으로 변환
    
    [표현법]
    TO_DATE(숫자|문자, [포맷])        결과값 DATE 타입
*/

SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE('070101') FROM DUAL; -- 0으로 시작하는 경우에는 70101로 인식함 => ''로 묶어서 문자타입으로 변경해서 표현
SELECT TO_DATE('041030 143000') FROM DUAL; -- 시간까지 같이 적는 경우에는 포맷까지 기록해야함
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 2014년
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098년 => 무조건 현재 세기로 반영함
SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- 2014년
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 1998년
-- RR: 해당 두자리 년도의 값이 50보다 크면 이전 세기의 년도로 반환, 50보다 작으면 지금 세기의 년도로 반환
--------------------------------------------------------------------------------
/*
    * TO_NUMBER: 문자 타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    [표현법]
    TO_NUMBER(문자, [포멧])     => 결과값 NUMBER 타입
*/
SELECT TO_NUMBER('04270467160') FROM DUAL; -- 맨 앞의 0이 날라감 (숫자 타입으로 저장)

SELECT '10000000' + '500000' FROM DUAL; -- 오라클은 자동형변환이 잘 돼있음
SELECT '10,000,000' + '500,000' FROM DUAL; -- 오류발생(안에 숫자만 있어야 자동형변환)
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999') FROM DUAL; -- 강제 형변환
--------------------------------------------------------------------------------
/*
    < NULL 처리 함수 >
*/
-- ********NVL(컬럼, 해당 컬럼값이 NULL일 경우 반환할 값)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 전 사원의 이름과 보너스 포함 연봉
SELECT EMP_NAME, (SALARY + SALARY * BONUS) * 12 || '원' AS "보너스 연봉"
FROM EMPLOYEE; -- BONUS가 NULL인 사원은 NULL로 반환

SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 || '원' AS "보너스 연봉"
FROM EMPLOYEE; -- = SALARY * 12