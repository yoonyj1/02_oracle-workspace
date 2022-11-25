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