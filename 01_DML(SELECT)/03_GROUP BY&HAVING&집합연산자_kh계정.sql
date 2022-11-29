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
SELECT DEPT_CODE, COUNT(EMP_ID)
FROM EMPLOYEE
GROUP BY DEPT_CODE;