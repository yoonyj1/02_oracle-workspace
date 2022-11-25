-- 저장 먼저
-------------------------------- QUIZ 1 ----------------------------------------
-- 보너스를 안받지만 부서배치는 안된 사원조회
SELECT *
FROM EMPLOYEE;
-- WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- WHERE BONUS = NULL AND DEPT_CODE != NULL; NULL 값에 대해 정상적으로 비교처리 되지 않음
-- 문제점과 해결방법 기술
-- 문제점: NULL 값을 비교할 때는 =, != 연산자가 아닌 IS NULL, IS NOT NULL을 사용해야함(단순한 비교연산자를 통해 비교할 수 없음)
-- 해결방법: IS NULL, IS NOT NULL 사용해서 비교할 것
-- 조치한 SQL문
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NULL;
