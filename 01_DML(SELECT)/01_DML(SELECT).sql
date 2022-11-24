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