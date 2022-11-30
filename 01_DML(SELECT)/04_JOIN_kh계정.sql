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

--------------------------------------------------------------------------------
/*
    2. 포괄조인 / 외부조인 (OUTER JOIN)
    두 테이블 간의 조인 시 일치하지 않는 행도 포함시켜서 조회 가능
    단, 반드시 LEFT / RIGHT 지정 해야됨
*/

-- 외부조인과 비교할만한 INNER JOIN 조회해두기
-- 월급주기
-- 사원명, 부서명, 급여, 연봉
-->> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 21명
-- 부서배치가 안된 사원 2명에 대한 정보는 조회되지 않음
-- 부서에 배정된 사원이 없는 부서 같은 경우도 조회 안됨

-- 1. LEFT [OUTER] JOIN: 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN 
-->> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE -- EMPLOYEE에 있는 건 다 나옴
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 23명
-- 부서배치를 받지 않은 2명의 사원정보도 조회 가능

-->> 오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- 2. RIGHT JOIN: 두 테이블 중 오른편에 기술된 테이블 기준으로 JOIN 
-->> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-->> 오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3. FULL [OUTER] JOIN: 두 테이블이 가진 모든 행을 조회할 수 있음(단, ANSI만 가능)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "연봉"
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--------------------------------------------------------------------------------
/*
    3. 자체 조인 (SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우
*/

SELECT * FROM EMPLOYEE;
-- 전체 사원의 사번, 사원명, 부서코드 조회 ==> EMPLOYEE E -- MANAGER_ID
--   & 사수의 사번, 사원명, 부서코드     ==> EMPLOYEE M -- EMP_ID
-->> 오라클 전용 구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
       M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-->> ANSI
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE,
       M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
--------------------------------------------------------------------------------
/*
    < 다중 JOIN >
    2개 이상의 테이블을 가지고 JOIN할 때
*/

-- 사번, 사원명, 부서명, 직급명
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN JOB J USING (JOB_CODE);

-- 사번, 사원명, 부서명, 지역명
-->> 오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;

--> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

------------------------------- 실습문제 -----------------------------------------
-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회(EMP,DEP,LOC,NAT)
-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE);

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여등급에서 받을 수 있는 최대금액
-->> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID 
AND E.JOB_CODE = J.JOB_CODE 
AND D.LOCATION_ID = L.LOCAL_CODE 
AND L.NATIONAL_CODE = N.NATIONAL_CODE 
AND E.SAL_LEVEL = S.SAL_LEVEL;

-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J USING (JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N USING (NATIONAL_CODE)
JOIN SAL_GRADE S USING (SAL_LEVEL);


