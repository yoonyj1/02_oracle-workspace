/*
    < VIEW 뷰 >
    
    SELECT문(쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술할 필요가 없음)
    임시테이블 같은 존재(실제로 존재하는 것이 아님) => 그냥 보여주기용
    물리적인 테이블: 실제
    논리적인 테이블: 가상 => 뷰는 논리적인 테이블
*/

-- 뷰를 만들기 위한 복잡한 쿼리문 
-- 관리자 페이지

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

--------------------------------------------------------------------------------
/*
    1. VIEW 생성 방법
    
    [표현법]
    CREATE [OR REPLACE] VIEW VIEW명
    AS 서브쿼리;
    
    [OR REPLACE]: 뷰 생성 시 기존에 중복된 이름의뷰가 없다면 새로이 뷰를 생성하고
                           기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
*/
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- 권한과 관련한 오류

-- 관리자계정으로 접속 후 권한부여
GRANT CREATE VIEW TO KH;

-- 실제 있는 테이블이 아님 => 가상, 논리테이블
SELECT * FROM VW_EMPLOYEE;

-- 아래와 같은 맥락
SELECT * 
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)); -- 인라인 뷰 / 위에는 뷰

-- 뷰는 논리적인 가상 테이블 -> 실질적인 테이블을 저장하고 있지 않음

-- 한국 러시아 일본에 근무하는 사원
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

-- [참고]
SELECT *
FROM USER_VIEWS;

-- 만약 VIEW에 추가하고 싶은 경우
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object
-- 이미 해당 이름을 쓰는 뷰가 있다고 해서 에러발생

--------------------------------------------------------------------------------
/*
    * 뷰 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있을 경우
    반드시 별칭을 지정해야함
*/

-- 전 사원의 사번, 이름, 직급명, 성별, 근무년수 조회 할 수 있는 SELECT문을 VIEW(VW_EMP_JOB)로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
-- ORA-00998: must name this expression with a column alias
-- SELECT절에 함수식이나 산술연산식이 있는 경우는 무조건 별칭을 부여해야함

CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별"
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
SELECT * FROM VW_EMP_JOB; -- 실제로 존재하는 테이블 x

-- 아래와 같은 방법으로도 별칭 부여 가능
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수) -- 단, 모든 컬럼에 별칭을 부여해야함.
AS SELECT EMP_ID, EMP_NAME, JOB_NAME
        , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
    
-- 성별이 여자인 사원들의 이름, 직급명
SELECT 이름, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '여';

-- 근무년수가 20년 이상 된 사원들의 사번, 이름, 직급명, 성별, 근무년수 조회
SELECT *
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- 뷰 삭제
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
-- 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용 가능
-- 뷰를 통해서 조작하더라도 실제 데이터가 담겨있는 베이스테이블 반영됨
-- 잘 안되는 경우가 많기 때문에 잘 쓰지는 않음

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB; -- 논리적인 테이블(실제 데이터가 담겨있지는 않음)
SELECT * FROM JOB; -- 베이스 테이블(실제 데이터가 담겨있음)

-- 뷰를 통해서 INSERT
INSERT INTO VW_JOB
VALUES('J8', '인턴'); -- JOB테이블도 값이 추가됨

-- 뷰를 통해서 UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

-- 뷰를 통해서 DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';
--------------------------------------------------------------------------------
/*
    * 단, DML 명령어로 조작이 불가능한 경우가 더 많음
    1) VIEW에 정의되어 있지 않은 컬럼을 조작하려 하는 경우
    2) VIEW에 정의되어 있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 조건이 지정되어 있는 경우
    3) 산술연산식 또는 함수식으로 정의되어 있는 경우
    4) 그룹함수나 GROUP BY 절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 연결시켜 놓은 경우
*/

-- 1) VIEW에 정의되어 있지 않은 컬럼을 조작하려 하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
    FROM JOB;
    
SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '인턴');
-- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
-- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';
-- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier

-- 2) VIEW에 정의되어 있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 조건이 지정되어 있는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT
INSERT INTO VW_JOB VALUES('인턴'); -- 실제 베이스 테이블에 INSERT시 (NULL, '인턴') 추가
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE 
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';

ROLLBACK;

-- DELETE (이 데이터를 쓰고 있는 자식 데이터가 존재하기 때문에 삭제 제한 / 단 없을 시 삭제 잘됨)
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';
-- ORA-02292: integrity constraint (KH.SYS_C007188) violated - child record found

-- 3) 산술연산식 또는 함수식으로 정의되어 있는 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "연봉" FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL; -- 논리테이블
SELECT * FROM EMPLOYEE; -- 물리테이블

-- INSERT
INSERT INTO VW_EMP_SAL VALUES(400, '차은우', 3000000, 36000000);
-- ORA-01733: virtual column not allowed here
-- EMPLOYEE에 연봉이라는 컬럼이 없기 때문에 에러발생

-- UPDATE
-- 200번 사원의 연봉을 8천만원으로
UPDATE VW_EMP_SAL
SET 연봉 = '80000000'
WHERE EMP_ID = 200;
-- ORA-01733: virtual column not allowed here

-- 200번 사원의 급여를 700만원으로
UPDATE VW_EMP_SAL
SET SALARY = '7000000'
WHERE EMP_ID = 200; -- 성공

SELECT * FROM EMPLOYEE WHERE EMP_ID = 200;

ROLLBACK;

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000;

SELECT * FROM VW_EMP_SAL;
ROLLBACK;

-- 4) 그룹함수나 GROUP BY 절이 포함된 경우
CREATE OR REPLACE VIEW VW_GROUP_DEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "합계", FLOOR(AVG(SALARY)) AS "평균"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUP_DEPT;

-- INSERT
INSERT INTO VW_GROUP_DEPT VALUES('D3', 8000000, 4000000);
-- ORA-01733: virtual column not allowed here
-- 실제 EMPLOYEE에 넣을 컬럼이 없음

-- UPDATE
UPDATE VW_GROUP_DEPT
SET 합계 = 8000000
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view

-- 5) DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');
-- ORA-01732: data manipulation operation not legal on this view

-- UPDATE (에러) => VIEW에 DISTINCT 구문이 있기 때문에
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';
-- ORA-01732: data manipulation operation not legal on this view

-- 6) JOIN을 이용해서 여러 테이블을 연결시켜 놓은 경우
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
    
SELECT * FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP VALUES(300, '장원영', '러브다이부');
-- ORA-01776: cannot modify more than one base table through a join view

-- UPDATE
UPDATE VW_JOINEMP
SET DEPT_TITLE = '회계부'
WHERE EMP_ID = 200;
-- ORA-01779: cannot modify a column which maps to a non key-preserved table