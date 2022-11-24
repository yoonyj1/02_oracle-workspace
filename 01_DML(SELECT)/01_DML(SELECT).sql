/*
    < SELECT>
    데이터를 조회할 때 사용되는 구문
    
    >> RESULT SET: SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자하는 컬럼1[, 컬럼2, ...] 
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야함. 없는 컬럼 쓰게되면 오류 발생
*/

-- EMPLOYEE 모든 테이블 조회
-- SELECT EMP_ID, EMP_NAME, EMP_NO,...
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

----------------------------- 실습문제 ------------------------------------------
-- 1. JOB테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬럼명 작성부분에 산술연산 기술 가능(RESULT SET에 산술연산된 결과 조회)
*/

-- EMPLOYEE 테이블의 사원명, 급여조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12)조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함된 연봉((급여 + 보너스 * 급여)*12) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + BONUS * SALARY) * 12)
FROM EMPLOYEE; -- NULL 인 값과 산술연산을 하면 그 결과도 NULL
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산 한 결과값도 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- * 오늘날짜: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE: 뺄 수 있음 => 결과값이 맞긴함(일 단위로 출력)
-- 값이 지저분한 이유: DATE형식은 년/월/일/시/분/초 단위 시간정보로 관리를 하기 때문
-- 함수적용 시 정리된 결과 확인 가능

--------------------------------------------------------------------------------
/*
    <컬럼명에 별칭 지정하기>
    산술 연산을 하게되면 컬럼명이 지저분함
    이때 컬럼명으로 별칭을 부여해서 깔끔하게 정리가능
    
    [표현법]
    1. SELECT 컬럼명 별칭
    2. SELECT 컬럼명 AS 별칭
    3. SELECT 컬럼명 "별칭"
    4. SELECT 컬럼명 AS "별칭" (추천): 일반적으로 많이 씀
    => AS를 붙이는 여부에 상관없이 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 쌍따옴표("")로 기술해야함.
*/    

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉", ((SALARY + BONUS * SALARY) * 12) AS "보너스포함 연봉"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT절에 리터럴을 제시하면 마치 테이블 상에 존재하는 데이터처럼 조회가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    <연결 연산자: ||>
    여러 컬럼값들을 마치 하나의 컬럼인것처럼 연결하거나 컬럼값과 리터럴을 연결할 수 있음
    System.out.println("num의 값" + num);
*/

-- 사번과 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴 연결
-- XXX의 월급은 XXX원입니다 => 별칭: 급여정보
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다' AS "급여정보"
FROM EMPLOYEE;

/*
    <DISTINCT>
    컬럼의 중복된 값들을 한 번씩만 표시하고자 할 때 사용

*/
-- 현재 우리회사에 어떤 직급의 사람들이 존재하는 지 궁금할 때
-- EMPLOYEE 테이블의 직급 코드 조회
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 직급 코드 조회(중복 제거)
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 중복제거되어 7행만 조회됨

-- 사원들이 어떤 부서에 속해있는 지 궁금할 때
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL: 아직 부서배치가 안된 사람

/* DISTINCT 유의사항
  - SELECT절에 단 한번만 기술 가능
    SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
    FROM EMPLOYEE;
    구문 오류
    
    SELECT DISTINCT JOB_CODE, DEPT_CODE
    FROM EMPLOYEE;
    중복 제거되서 출력
    -- JOB_CODE, DEPT_CODE를 한 쌍으로 묶어서 중복 판별
*/

--------------------------------------------------------------------------------

/*
    <WHERE 절>
    조회하고자 하는 테이블로부터 특정 조건을 만족하는 데이터만을 조회하고자 할 때 사용
    이 때 WHERE절에는 조건식을 제시함.
    조건식에서는 다양한 연산자 사용가능
    
    [표현법]
    SELECT 컬럼1, 컬럼2,...
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=  --> 대소비교
    =             --> 동등비교
    !=, ^=, <>    --> 동등하지 않은지 비교
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'인 사원들만 조회(모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 테이블에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 재직 중(ENT-YN컬럼값이 'N')인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------- 실습 문제 ------------------------------------------
-- 1. 급여 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함) 조회
SELECT EMP_NAME, SALARY || '원' AS "급여", HIRE_DATE, SALARY * 12 || '원' AS "연봉(보너스 미포함)"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5000만원 이상 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY || '원' AS "급여", SALARY * 12 || '원' AS "연봉(보너스 미포함)", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY * 12) >= 50000000;
-- WHERE 연봉 >= 50000000; 오류 > SELECT절에서 작성된 별칭 사용불가 => 쿼리 실행순서 때문에

-- 쿼리 실행 순서
-- FROM절 -> WHERE절 -> SELECT절

-- 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 부서코드 'D9'이면서 급여가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY || '원' AS "SALARY", DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY || '원' AS "SALARY"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- WHERE 3500000 <= SALARY <= 6000000 (X) 오류 발생

--------------------------------------------------------------------------------

/*
    <BETWEEN A AND B>
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    -> 해당 컬럼 값이 A 이상이고 B 이하인 경우
*/

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 위의 쿼리범위 밖의 사람들 조회 (350만원 미만, 600만원 초과)
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY < 3500000 OR SALARY > 6000000; 방법1 
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000; 방법2
WHERE SALARY NOT BETWEEN 3500000 AND 6000000; -- 방법3

-- NOT: 논리부정 연산자
-- 컬럼명 앞 또는 BETWEEN 앞에 기입 가능

-- 입사일이 '90/01/01' ~ '01/01/01' 모든 컬럼 조회(BETWEEN)
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
-- DATE 형식은 대소 비교 가능

--------------------------------------------------------------------------------

/*
    <LIKE>
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상 컬럼 LIKE '특정패턴'
    
    - 특정 패턴 제시 시 '%', '_'를 와일드카드로 사용할 수 있음
    >> '%': 0글자 이상
     EX) 비교대상컬럼 LIKE '문자%'      => 비교대상의 컬럼값이 문자로 "시작" 되는 것 조회
         비교대상컬럼 LIKE '%문자'      => 비교대상의 컬럼값이 문자로 "끝"나는 것 조회
         비교대상컬럼 LIKE '%문자%'     => 비교대상의 컬럼값이 문자가 "포함"되는 것 조회(키워드 검색에 사용)
         
    >> '_': 1글자    
     EX) 비교대상컬럼 LIKE '_문자'      => 비교대상의 컬럼값이 문자 앞에 무조건 한글자가 올 경우 조회
         비교대상컬럼 LIKE '문자_'      => 비교대상의 컬럼값이 문자 뒤에 무조건 한글자가 올 경우 조회
         비교대상컬럼 LIKE '_문자_'     => 비교대상의 컬럼값이 문자 앞뒤로 무조건 한글자가 올 경우 조회
*/

-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름중에 하가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';
-- 하%: '하'로 시작하는 것 찾음
-- %하: '하'로 끝나는 것 찾음
-- %하%: 하% + %하 + %하%
-- %: 글자 수 상관없음

-- 이름의 가운데 글자가 하 인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';
-- _하_ : 가운데에 '하'가 들어가는 것 찾기
-- _: 한글자를 나타냄 (_하_: 가운데에 '하'가 들어가는 3글자 이름)

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** 특이케이스
-- 이메일 중 _기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- 원하는 결과 도출 X
-- 와일드카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회X
--> 어떤 게 와일드카드이고 어떤 게 데이터 값인지 구분지어야됨
--> 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드카드를 제시하고 나만의 와일드카드를 ESCAPE OPTION으로 등록해야됨

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; -- $말고 다른 문자 사용 해도 됨

-- 위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
-- WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$'; -- 방법 1 
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$'; -- 방법 2
-- NOT은 컬럼명 앞 또는 LIKE 앞에 기입 가능

----------------------------- 실습문제 ------------------------------------------
-- 1. EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 이름에 '하'가 포함되어있고, 급여가 240만원 이상인 사원들의 사원명, 급여 조회 
SELECT EMP_NAME, SALARY || '원' AS "SALARY"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 3. 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 4. DEPARTMENT 테이블에서 해외영업부인 부서들의 부서코드, 부서명
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

--------------------------------------------------------------------------------
/*
    <IS NULL / IS NOT NULL>
    컬럼값에 NULL이 있을 경우 NULL값 비교에 사용되는 연산자
*/

-- 보너스를 받지 않는 사원(보너스의 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
-- WHERE BONUS = NULL; X 아무것도 출력안됨

-- 보너스를 받는 사원(BONUS의 값이 NULL이 아님)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; -- 방법1
-- WHERE NOT BONUS IS NULL; -- 방법2
-- NOT은 컬럼명앞 또는 IS 뒤에서 사용가능

-- 부서배치를 아직 받지 않았지만 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--------------------------------------------------------------------------------
/*
    < IN >
    비교대상 컬럼 값이 내가 제시한 목록중에 일치하는 값이 있는 지 
    
    [표현법]
    비교대상컬럼 IN ('값1', '값2', '값3',.....)
*/

-- 부서코드가 'D6'이거나 'D8'이거나 'D5'인 부서원들의 이름, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그 외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE NOT DEPT_CODE IN ('D6', 'D8', 'D5'); -- 방법1 
-- WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5'); 방법2

--------------------------------------------------------------------------------
/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자
    2. 연결연산자 ||
    3. 비교연산자
    4. IS NULL / LIKE / IN
    5. BETWEEN A AND B
    6. NOT(논리연산자)
    7. AND(논리연산자)
    8. OR(논리연산자)
*/

-- ** OR보다 AND가 먼저 연산이 됨 **
-- 직급코드가 'J7'이거나 'J2'인 사람들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000;
-- AND가 먼저 실행돼서 J2이면서 2000000원이 넘는 사원이 먼저 출력되고 그 외에 급여 상관없이 J7인 사원들도 출력됨
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

------------------------------- 실습 문제 ----------------------------------------
-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 (사원명, 사수사번, 부서코드) 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- 2 

-- 2. 연봉(보너스미포함)이 3000만원 이상이고 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;
-- 7

-- 3. 입사일이 '95/01/01' 이상이고 부서배치를 받은 사원들의 (사번, 사원명, 입사일, 부서코드) 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;
-- 18

-- 4. 급여가 200만원 이상 500만원 이하이고 입사일이 '01/01/01' 이상이고 보너스를 받지 않는 사원들의(사번, 사원명, 급여, 입사일, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NOT NULL;
-- 4

-- 5. 보너스포함연봉이 NULL이 아니고 이름에 '하'가 포함되어있는 사원들의 (사번, 사원명, 급여, 보너스포함연봉) 조회 (별칭부여)
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY + SALARY * BONUS) * 12) AS "보너스포함연봉"
FROM EMPLOYEE
WHERE ((SALARY + SALARY * BONUS) * 12) IS NOT NULL AND EMP_NAME LIKE '%하%';
--2

--끝
