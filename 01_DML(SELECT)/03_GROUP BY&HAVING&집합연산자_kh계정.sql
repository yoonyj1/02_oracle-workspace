/*
    <GROUP BY 절>
    그룹기준을 제시할 수 있는 구문 (해당 그룹기준별로 여러 그룹을 묶을 수 있음)
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서별 총인원
SELECT DEPT_CODE, COUNT(*) -- GROUP BY로 묶인 것들을 카운트
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 실행순서
SELECT DEPT_CODE, SUM(SALARY) -- 3
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE -- 2
ORDER BY DEPT_CODE; -- 4

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 직급별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최대급여
SELECT JOB_CODE, COUNT(*) || '명' AS "총 사원수", COUNT(BONUS) || '명' AS "보너스 받는 사원 수",
       LPAD(SUM(SALARY) || '원', 10) AS "급여합", ROUND(AVG(SALARY)) || '원' AS "평균급여",
       MIN(SALARY) || '원' AS "최저급여", MAX(SALARY) || '원' AS "최대급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 부서별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최대급여
SELECT DEPT_CODE, COUNT(*) || '명' AS "총 사원수", COUNT(BONUS) || '명' AS "보너스 받는 사원 수",
       LPAD(SUM(SALARY) || '원', 10) AS "급여합", ROUND(AVG(SALARY)) || '원' AS "평균급여",
       MIN(SALARY) || '원' AS "최저급여", MAX(SALARY) || '원' AS "최대급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

-- GRUOP BY절에 함수식 기술 가능
SELECT DECODE(SUBSTR(EMP_NO, 8, 1),'1', '남자', '2', '여자') AS "성별", COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- GROUP BY에 여러 컬럼 기술 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1 NULLS FIRST;

--------------------------------------------------------------------------------
/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수식을 가지고 조건을 제시할 때 사용)
*/

-- 각 부서별 평균급여 (부서코드, 평균급여)
SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '원' AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

-- 부서별로 평균급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '원' AS "평균급여"
FROM EMPLOYEE
-- WHERE ROUND(AVG(SALARY)) >= 3000000 / 그룹함수 사용된 곳에서는 허용되지 않음(그룹함수 가지고 조건제시시 WHERE절에서는 안됨)
GROUP BY DEPT_CODE
ORDER BY 1 NULLS FIRST;

SELECT DEPT_CODE, ROUND(AVG(SALARY)) || '원' AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000
ORDER BY 1 NULLS FIRST;

-- 직급별 총 급여 합(단, 직급별 급여의 합이 1000만원 이상인 직급만 조회) , 컬럼 직급코드, 급여합
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서만을 조회 부서코드만 나오게 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
--------------------------------------------------------------------------------
/*
    < SELECT 문 실행순서>
    SELECT * | 조회하고자하는 컬럼 별칭 | 산술식 "별칭" | 함수식 AS "별칭" -- 5
    FROM 조회하고자 하는 테이블명 -- 1
    WHERE 조건식(연산자를 가지고 기술) -- 2
    GROUP BY 그룹기준으로 삼을 컬럼 | 함수식 -- 3 
    HAVING 조건식(그룹함수를 가지고 기술) -- 4
    ORDER BY 컬럼명 | 컬럼순번 | 별칭 [ASC | DESC] [NULLS FIRST / LAST] -- 6
*/
--------------------------------------------------------------------------------
/*
    < 집계함수 >
    그룹별 산출된 결과값에 중간집계를 계산해주는 함수
    
    ROLLUP
    => GROUP BY절에 기술하는 함수
*/

-- 각 직급별 급여합
-- 마지막 행으로 전체 총 급여합까지 조회하고 싶을 경우
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;
--ROLLUP: GROUP BY 통해 묶은 그룹의 중간집계를 계산해주는 함수
--------------------------------------------------------------------------------
/*
    < 집합연산자 == SET OPERATION >
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION: OR | 합집합 (두 쿼리문을 수행한 결과값을 더한 후 중복값은 한번만 더해짐)
    - INTERSECT: AND | 교집합 (두 쿼리문 수행한 결과값에 중복된 결과값)
    - UNION ALL: 합집합 + 교집합(중복값 두 번 표현됨)
    - MINUS: 차집합 (선행 결과에서 후행 결과 값을 뺀 나머지)
*/

-- 1. UNION
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원(사번, 이름, 부서코드, 급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)

-- 동일한 쿼리문 => WHERE절에 OR 써도 해결가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- 2. INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
-- 2개 행(심봉선, 대북혼)
-- 동일한 쿼리문 => WHERE절에 AND 써도 해결가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

--------------------------------------------------------------------------------
-- 집합연산자 유의사항
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY --HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
 -- 각 쿼리문의 SELECT절에 작성되어있는 컬럼과 컬럼의 개수가 동일해야함 ==> 컬럼 개수뿐 아니라 컬럼자리마다 개수, 타입이 동일해야함.
 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
-- ORDER BY EMP_NAME
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY --HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연) 
 -- ORDER BY절은 가장 마지막 쿼리에 작성
--------------------------------------------------------------------------------
-- 3. UNION ALL: 여러개의 쿼리결과를 무조건 다 더함 => 중복값 출력가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)

--------------------------------------------------------------------------------
-- 4. MINUS: 선행 SELECT절에서 후행 SELECT의 결과를 뺀 나머지(차집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개 행(박나라,하이유,김해술,심봉선,윤은해,대북혼)
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8개 행(선동일,송종기,노옹철,유재식,정중하,심봉선,대북혼,전지연)
-- 'D5'에서 SALARY가 300만원 초과인 사원들 제거
-- 같은 쿼리문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;