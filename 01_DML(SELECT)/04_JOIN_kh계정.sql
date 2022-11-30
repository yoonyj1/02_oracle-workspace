/*
    < JOIN >
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 데이터를 담고 있음
    
    -- 어떤 사원이 어떤 부서에 속해있는지 궁금한 경우 (코드가 아닌 부서이름으로)
    
    => 관계형 데이터베이스에서 SQL문을 이용한 테이블간의 "관계"를 맺는 방법
    (무작정 다 조회를 해오는게 아닌 각 테이블간 연결고리로써 데이터를 매칭해서 조회해야함)

                    JOIN은 크게 "오라클 전용구문"과 "ANSI 구문" (ANSI == 미국국립표준협회) => 아스키코드표 만드는 곳

*/
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- DEPT_CODE가 연결고리

SELECT *
FROM DEPARTMENT; -- DEPT_ID

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, DEPT_CODE--, DEPT_TITLE  -- 부서명은 EMPLOYEE 테이블에 없음
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, JOB_CODE--, JOB_NAME -- JOB_NAME은 EMPLOYEE에 없음
FROM EMPLOYEE; -- JOB_CODE

SELECT *
FROM JOB; -- JOB_CODE

/*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
        : 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회(일치하지 않는 값은 조회에서 제외)
*/
-->> 오라클 전용구문
-- FROM절에 조회하고자 하는 테이블들을 다 나열(,로 구분)
-- WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함

-- 1. 연결할 두 컬럼명이 다른 경우(EMP: DEPT_CODE, DEP: DEPT_ID)
-- 사번, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하는 값이 없는 행이 조회에서 제외됨
-- DEPT_CODE가 NULL인 사원 조회X, DEPT_ID D3 D4 D7 조회 X => 둘 다 있어야 조회가능

-- 2. 연결할 두 컬럼명이 같은 경우(EMP: JOB_CODE, JOB: JOB_CODE)
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE; -- column ambiguously defined: 컬럼이 애매하게 제시됨

-- 해결방법1. 테이블 명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 해결방법2. 테이블에 별칭 부여해서 이용하는 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
-- FROM절에 기준이 되는 테이블을 하나만 기술한 후 
-- JOIN절에 같이 조회하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건도 같이 기술
-- JOIN USING, JOIN ON

-- 1. 연결할 두 컬럼명이 다른 경우 (EMP: DEPT_CODE, DEP: DEPT_ID)
-- 오직 JOIN ON 구문으로만 가능
-- 사번, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2. 연결할 두 컬럼명이 같은 경우 (EMP: JOB_CODE, JOB: JOB_CODE)
-- JOIN ON, JOIN USING 구문 사용 가능
-- 사번, 사원명, 직급코드, 직급명 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (JOB_CODE = JOB_CODE);

-- 해결방법1. 테이블명 또는 별칭 이용해서 해결
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
-- 해결방법2. JOIN USING 구문 사용 (** 두 컬럼명이 일치할 경우에만 사용가능)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

---------- [ 참고사항 ] ------------
-- 자연조인(NATURAL JOIN): 각 테이블마다 동일한 컬럼이 단 한개만 존재할 경우 => ANSI
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 직급이 대리인 사원의 이름, 직급명, 급여 조회
--> 오라클 전용구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리';

--> ANSI 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리';

SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '대리';

-------------------------------- 실습문제 ----------------------------------------
--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
--> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '인사관리부';

--> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--2. DEPARTMENT와 LOCATION을 참고해서 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
--> 오라클 전용구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

--> ANSI구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);
 
--3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
--> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND BONUS IS NOT NULL;

--> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
--> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE != '총무부';

--> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE != '총무부';