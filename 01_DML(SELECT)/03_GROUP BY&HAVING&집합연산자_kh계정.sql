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