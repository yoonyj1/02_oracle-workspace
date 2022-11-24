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

/*
    <연결 연산자: ||>
    여러 컬럼값들을 마치 하나의 컬럼인것처럼 연결하거나 컬럼값과 리터럴을 연결할 수 있음
    System.out.println("num의 값" + num);
*/

-- 사번과 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴 연결
-- XXX의 월급은 XXX원입니다 => 별칭: 급여정보
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다' AS "급여정보"
FROM EMPLOYEE;

/*
    <DISTINCT>
    컬럼의 중복된 값들을 한 번씩만 표시하고자 할 때 사용

*/
-- 현재 우리회사에 어떤 직급의 사람들이 존재하는 지 궁금할 때
-- EMPLOYEE 테이블의 직급 코드 조회
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 직급 코드 조회(중복 제거)
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 중복제거되어 7행만 조회됨

-- 사원들이 어떤 부서에 속해있는 지 궁금할 때
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL: 아직 부서배치가 안된 사람

/* DISTINCT 유의사항
  - SELECT절에 단 한번만 기술 가능
    SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
    FROM EMPLOYEE;
    구문 오류
    
    SELECT DISTINCT JOB_CODE, DEPT_CODE
    FROM EMPLOYEE;
    중복 제거되서 출력
    -- JOB_CODE, DEPT_CODE를 한 쌍으로 묶어서 중복 판별
*/

--------------------------------------------------------------------------------

/*
    <WHERE 절>
    조회하고자 하는 테이블로부터 특정 조건을 만족하는 데이터만을 조회하고자 할 때 사용
    이 때 WHERE절에는 조건식을 제시함.
    조건식에서는 다양한 연산자 사용가능
    
    [표현법]
    SELECT 컬럼1, 컬럼2,...
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=  --> 대소비교
    =             --> 동등비교
    !=, ^=, <>    --> 동등하지 않은지 비교
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'인 사원들만 조회(모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 테이블에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 재직 중(ENT-YN컬럼값이 'N')인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------- 실습 문제 ------------------------------------------
-- 1. 급여 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함) 조회
SELECT EMP_NAME, HIRE_DATE, SALARY * 12 AS "연봉(보너스 미포함)"
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. 연봉이 5000만원 이상 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY * 12 AS "연봉(보너스 미포함)", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY * 12) > 50000000;

-- 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';