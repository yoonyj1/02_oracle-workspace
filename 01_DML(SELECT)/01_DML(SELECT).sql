/*
    < SELECT>
    데이터를 조회할 때 사용되는 구문
    
    >> RESULT SET: SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자하는 컬럼1[, 컬럼2, ...] 
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야함. 없는 컬럼 쓰게되면 오류 발생
*/

-- EMPLOYEE 모든 테이블 조회
-- SELECT EMP_ID, EMP_NAME, EMP_NO,...
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

----------------------------- 실습문제 ------------------------------------------
-- 1. JOB테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬럼명 작성부분에 산술연산 기술 가능(RESULT SET에 산술연산된 결과 조회)
*/

-- EMPLOYEE 테이블의 사원명, 급여조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12)조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함된 연봉((급여 + 보너스 * 급여)*12) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE; -- NULL 인 값과 산술연산을 하면 그 결과도 NULL
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산 한 결과값도 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- * 오늘날짜: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE: 뺄 수 있음 => 결과값이 맞긴함(일 단위로 출력)
-- 값이 지저분한 이유: DATE형식은 년/월/일/시/분/초 단위 시간정보로 관리를 하기 때문
-- 함수적용 시 정리된 결과 확인 가능

--------------------------------------------------------------------------------
/*
    <컬럼명에 별칭 지정하기>
    산술 연산을 하게되면 컬럼명이 지저분함
    이때 컬럼명으로 별칭을 부여해서 깔끔하게 정리가능
    
    [표현법]
    1. SELECT 컬럼명 별칭
    2. SELECT 컬럼명 AS 별칭
    3. SELECT 컬럼명 "별칭"
    4. SELECT 컬럼명 AS "별칭" (추천): 일반적으로 많이 씀
    => AS를 붙이는 여부에 상관없이 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 쌍따옴표("")로 기술해야함.
*/    

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉", ((SALARY + BONUS * SALARY) * 12) AS "보너스포함 연봉"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT절에 리터럴을 제시하면 마치 테이블 상에 존재하는 데이터처럼 조회가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;