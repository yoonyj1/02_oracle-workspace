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


-------------------------------- QUIZ 2 ----------------------------------------
-- 검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY 값이 200만원 이상이고 BONUS가 있고, 여자이며, 이메일 주소는 _앞이 3글자만 있는
-- 사원의 EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회
-- 정상적으로 조회가 잘 된다면 실행결과는 2행이어야 함

-- 위의 내용을 실행시키고자 작성한 SQL문
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- 위의 SQL문 실행 시 원하는 결과가 제대로 조회가 되지 않음
-- 어떤 문제점이 있는지 모두 찾아서 서술하고 조치한 SQL문 작성

/*문제점:
1. AND가 OR보다 우선함 (OR 연산자와 AND 연산자가 나열되어 있을 경우 AND 연산자가 먼저 수행 됨, 문제에서 요구한 내용은 OR이 먼저 수행되어야함.)
2. SALARY 200만원 이상이어야 하지만 SQL문에는 초과로 입력했음 (급여값에 대한 비교가 잘못 되어 있음)
3. 이메일 주소 앞이 3글자만 있는 사원을 찾으려면 ESCAPE OPTION을 사용해야함
4. 여자인 조건 생략되어있음
5. 보너스를 받는 사원을 조회하려면 IS NOT NULL을 사용해야함
*/

-- 조치한 SQL문
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '_')-1), LENGTH(SUBSTR(EMAIL, 1, INSTR(EMAIL, '_')-1))
FROM EMPLOYEE;

-------------------------------- QUIZ 3 ----------------------------------------
-- [계정생성구문] CREATE USER 계정명, IDENTIFIED BY 비밀번호;

-- 계정명: SCOTT, 비밀번호: TIGER 계정을 생성하고 싶음
-- 이때 일반 사용자 계정인 KH계정에 접속해서 CREATE USER SCOTT; 로 실행하니 문제발생

-- 문제점 1. 계정생성은 무조건 관리자계정에서만 가능함
-- 문제점 2. 비밀번호 입력X, SQL문이 잘못되어있음

-- 조치내용1. 관리자 계정으로 접속해야함.
-- 조치내용2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL문 실행 후 접속을 만들어서 접속을 하려 했으나 실패함
-- 해당 계정에 테이블 생성 또한 안됨

-- 문제점1. 사용자 계정 생성 후 최소한의 권한 부여가 안됐다

-- 조치내용 GRANT RESOURCE, CONNECT TO SCOTT;