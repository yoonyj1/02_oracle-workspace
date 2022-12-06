---------------------------- QUIZ 1 -------------------------------------------
-- ROWNUM을 활용해서 급여가 가장 높은 5명 조회하려했으나 제대로 조회가 안됐음
-- 이때 작성된 SQL문이 아래와 같음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- 어떤 문제점이 있는지, 해결된 SQL문 작성
/*
쿼리 실행 순서에 따라 ROWNUM이 매겨지고 ORDER BY 절이 실행되기 때문에 원하는 결과를 얻을 수 없음
*/
-- 해결된 SQL문
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

---------------------------- QUIZ 2 -------------------------------------------
-- 부서별 평균급여가 270만원을 초과하는 부서들에 대해 (부서코드, 부서별 총 급여 합, 부서별 평균 급여, 부서별 사원수)
-- 이 때 작성된 SQL문이 아래와 같음
SELECT DEPT_CODE, SUM(SALARY) AS "총합", FLOOR(AVG(SALARY)) AS "평균", COUNT(*) AS "인원수"
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY 1;
-- 어떤 문제점이 있는지, 해결된 SQL문 작성
/*
문제점
1. 평균급여를 조회해야 하는 데 급여로 비교를 하고있음
2. GROUP BY절에 조건을 걸기 위해서 WHERE절을 사용했음
*/
-- 해결된 SQL문
SELECT DEPT_CODE, SUM(SALARY) AS "총합", FLOOR(AVG(SALARY)) AS "평균", COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;
--------------------------------------------------------------------------------
-- 서술형 대비
-- 1. JOIN 종류별 특징, 역할
-- 2. 함수 종류별 역할
-- 직원 급여 조회, 직급별로 인상해서 조회
-- J7 10%, J6 15%, J5 20%, 나머지는 5% 인상
SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "인상급여"
FROM EMPLOYEE
ORDER BY 2;

-- '21/09/28'와 같은 문자열을 가지고 '2021-09-28'로 표현해보기
SELECT TO_CHAR(TO_DATE('21/09/28'), 'YYYY-MM-DD') FROM DUAL;

-- '210908'와 같은 문자열을 가지고 '2021년 9월 8일' 표현
SELECT SUBSTR(TO_CHAR(TO_DATE('210908'), 'DL'), 1, 11) FROM DUAL;

SELECT TO_CHAR(TO_DATE('210908'), 'YYYY"년" FMMM"월" DD"일"') FROM DUAL; -- FM을 사용하면 0이 사라짐

SELECT TO_CHAR(TO_DATE('210908'), 'DL') FROM DUAL;
