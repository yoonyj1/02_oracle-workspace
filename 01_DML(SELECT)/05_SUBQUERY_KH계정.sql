 /*
    * 서브쿼리(SUBQUERY)
    - 하나의 SQL문 안에 포함된 또다른 SELECT문
    - 메인 SQL문을 위해 보조 역할을 하는 쿼리문
 */
 
-- 간단 서브쿼리 예시1
-- 노옹철 사원과 같은 부서에 속한 사원들 조회

-- 1. 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- D9

-- 2. 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 1, 2를 하나의 쿼리문으로
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');
                   
-- 간단 서브쿼리 예시2
-- 전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회

-- 1. 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 2. 급여가 3047662원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- 1, 2를 하나의 쿼리문으로
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
--------------------------------------------------------------------------------
/*
    * 서브쿼리의 구분
    서브쿼리를 수행한 결과값이 몇 행 몇열이냐에 따라서 분류
    
    - 단일 행 서브쿼리: 서브쿼리의 조회 결과값의 개수가 오로지 1개일 때(한 행 한 열)
    - 다중 행 서브쿼리: 서브쿼리의 조회 결과값이 여러 행일때 (여러 행 한 열) => EX) 동명이인
    - 다중 열 서브쿼리: 서브쿼리의 조회 결과값이 여러 열일때 (여러 열 한 행)
    - 다중 행 다중 열 서브쿼리: 서브쿼리의 조회 결과값이 여러 행, 여러 열일때(여러 행, 여러 열)
    
    > 서브쿼리의 종류가 뭐냐에 따라서 서브쿼리 앞에 붙는 연산자가 달라짐
*/

/*
    1. 단일 행 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과 값이 오로지 1개일 때 (한 행 한 열)
    일반 비교 연산자 사용가능(=, !=, >, <, <=, >=...)
*/

-- 1. 전 직원의 평균급여보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
-- 2. 최저 급여를 받는 사원의 사번, 이름, 급여, 입사일
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- 3. 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');
            
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
-- 4. 부서별 급여합이 가장 큰 부서의 부서코드, 급여 합 조회
--  1) 부서별 급여 합 중에서도 가장 큰 값 하나만 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
                      
-- 전지연 사원과 같은 부서원들의 사번, 사원명, 전화번호, 입사일, 부서명 (단, 전지연 제외)
-- >> 오라클 전용구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '전지연')
AND NOT EMP_NAME = '전지연';

-- >> ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '전지연')
AND NOT EMP_NAME = '전지연';
--------------------------------------------------------------------------------
/*
    2. 다중 행 서브쿼리(MULTI ROW SUBQUERY)
    서브쿼리를 수행한 결과값이 여러 행 일때 (컬럼은 1개)
    
    - IN 서브쿼리: 여러 개의 결과값 중에서 한개라도 일치하는 값이 있다면
    - > ANY 서브쿼리: 여러 개의 결과값 중에서 "한개라도" 클 경우
    - < ANY 서브쿼리: 여러 개의 결과값 중에서 "한개라도" 작을 경우
    
        비교대상 > ANY (값1, 값2, 값3)
        비교대상 > 값1 OR 값2 OR 값3
    - > ALL 서브쿼리: 여러개의 모든 결과값들 보다 클 경우
    - < ALL 서브쿼리: 여러개의 모든 결과값들 보다 작을 경우
        
        비교대상 > ALL (값1, 값2, 값3)
        비교대상 > 값1 AND 값2 AND 값3
*/

-- 1. 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드
--   1) 유재식 또는 윤은해 사원이 어떤 직급인지 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');

--   2) J3, J7 직급인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');


SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('유재식', '윤은해')); -- = 사용 시 에러발생 => 여러 행으로 조회되기 때문
                   -- 만약 결과값이 여러 개 나올 것 같으면 안전빵으로 IN으로 갈 것

-- 사원 -> 대리 -> 과장 -> 차장 -> 부장..
-- 2. 대리직급임에도 불구하고 과장직급 급여들 중 최소 급여보다 많이 받는 직원(사번, 이름, 직급, 급여)
--  1) 먼저 과장 직급인 사원들의 급여조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '과장';

--  2) 직급이 대리면서 급여가 위의 목록 값 중에 하나라도 큰 사원
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY ('2200000', '2500000', '3760000');

-- 하나의 쿼리문으로 작성
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME = '과장');
                  
-- 단일 행 서브쿼리로도 가능함
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE E, JOB J
              WHERE E.JOB_CODE = J.JOB_CODE
              AND JOB_NAME = '과장'); 
              
-- 3) 과장 직급에도 불구하고 차장 직급인 사원들의 모든 급여보다도 더 많이 받는 사원들의 사번, 사원명, 직급명, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY > ALL (SELECT SALARY
              FROM EMPLOYEE
              WHERE JOB_NAME = '차장');
              
--------------------------------------------------------------------------------
/*
    3. 다중 열 서브쿼리
    결과값은 한 행이지만, 나열된 컬럼수가 여러개일 경우
*/

-- 1. 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회(사원명, 부서코드, 직급코드, 입사일)
--> 단일 행 서브쿼리로도 가능함
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '하이유');
                
-- > 다중 열 서브쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '하이유'); -- D5	J5, 순서 개수 맞춰줘야함
                               
-- 박나라 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');
                            
--------------------------------------------------------------------------------
/*
    4. 다중 행 다중 열 서브쿼리
    서브쿼리 조회 결과값이 여러 행 여러 열일 경우
*/

-- 1) 각 직급별 최소급여를 받는 사원 조회(사번,사원명, 직급코드, 급여)
--> 각 직급별 최소급여 조회
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR JOB_CODE = 'J7' AND SALARY = 1380000;              

-- 서브쿼리로 적용
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE)
ORDER BY 3;

-- 2) 각 부서별 최고급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE)
ORDER BY 3;

--------------------------------------------------------------------------------
/*
    5. 인라인 뷰(INLINE - VIEW)
    서브쿼리를 수행한 결과를 마치 테이블처럼 사용
*/

-- 사원들의 사번, 이름, 보너스 포함 연봉 (별칭: 연봉), 부서코드 조회 (보너스 포함 연봉 3000만원 이상인 사원들만 조회, 보너스 포함 연봉이 NULL이 나오지 않게)
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY * NVL(BONUS, 0)) * 12 >= 30000000;

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE;

-- 이걸 마치 존재하는 테이블처럼 사용할 수 있음 = 인라인 뷰
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE)
WHERE 연봉 >= 30000000;

SELECT EMP_NAME, DEPT_CODE, 연봉 --, MANAGER_ID는 오류 남
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE)
WHERE 연봉 >= 30000000;

