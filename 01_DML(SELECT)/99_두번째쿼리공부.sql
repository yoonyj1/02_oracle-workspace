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