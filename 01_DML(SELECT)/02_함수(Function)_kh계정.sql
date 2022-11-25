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